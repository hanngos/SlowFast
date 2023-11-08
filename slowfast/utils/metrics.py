#!/usr/bin/env python3
# Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.

"""Functions for computing metrics."""

import torch
from torchmetrics.classification import F1Score, Accuracy, Precision, Recall, AUROC, Specificity


def topks_correct(preds, labels, ks):
    """
    Given the predictions, labels, and a list of top-k values, compute the
    number of correct predictions for each top-k value.

    Args:
        preds (array): array of predictions. Dimension is batchsize
            N x ClassNum.
        labels (array): array of labels. Dimension is batchsize N.
        ks (list): list of top-k values. For example, ks = [1, 5] correspods
            to top-1 and top-5.

    Returns:
        topks_correct (list): list of numbers, where the `i`-th entry
            corresponds to the number of top-`ks[i]` correct predictions.
    """
    assert preds.size(0) == labels.size(
        0
    ), "Batch dim of predictions and labels must match"
    # Find the top max_k predictions for each sample
    _top_max_k_vals, top_max_k_inds = torch.topk(
        preds, max(ks), dim=1, largest=True, sorted=True
    )
    # (batch_size, max_k) -> (max_k, batch_size).
    top_max_k_inds = top_max_k_inds.t()
    # (batch_size, ) -> (max_k, batch_size).
    rep_max_k_labels = labels.view(1, -1).expand_as(top_max_k_inds)
    # (i, j) = 1 if top i-th prediction for the j-th sample is correct.
    top_max_k_correct = top_max_k_inds.eq(rep_max_k_labels)
    # Compute the number of topk correct predictions for each k.
    topks_correct = [top_max_k_correct[:k, :].float().sum() for k in ks]
    return topks_correct


def topk_errors(preds, labels, ks):
    """
    Computes the top-k error for each k.
    Args:
        preds (array): array of predictions. Dimension is N.
        labels (array): array of labels. Dimension is N.
        ks (list): list of ks to calculate the top accuracies.
    """
    num_topks_correct = topks_correct(preds, labels, ks)
    return [(1.0 - x / preds.size(0)) * 100.0 for x in num_topks_correct]


def topk_accuracies(preds, labels, ks):
    """
    Computes the top-k accuracy for each k.
    Args:
        preds (array): array of predictions. Dimension is N.
        labels (array): array of labels. Dimension is N.
        ks (list): list of ks to calculate the top accuracies.
    """
    num_topks_correct = topks_correct(preds, labels, ks)
    return [(x / preds.size(0)) * 100.0 for x in num_topks_correct]

def convert_to_binary(preds, labels):
    preds = [0 if x[0] > x[1] else 1 for x in preds]
    preds = torch.Tensor(preds)
    assert preds.size(0) == labels.size(
        0
    ), "Batch dim of predictions and labels must match"
    return preds

def calculate_metrics(preds, labels):
    auc = AUROC(task="multiclass", num_classes=2)
    _auc = "AUC: {:.{prec}f}".format(auc(preds, labels) * 100, prec=2)
    preds = convert_to_binary(preds, labels)
    
    f1 = F1Score(task="binary", num_classes=2)
    acc = Accuracy(task="binary", num_classes=2)
    prec = Precision(task="binary", num_classes=2)
    rec = Recall(task="binary", num_classes=2)
    spc = Specificity(task="binary", num_classes=2)
    
    _f1 = "F1: {:.{prec}f}".format(f1(preds, labels) * 100, prec=2)
    _acc = "Acc: {:.{prec}f}".format(acc(preds, labels) * 100, prec=2)
    _prec = "Precision: {:.{prec}f}".format(prec(preds, labels) * 100, prec=2)
    _rec = "Recall: {:.{prec}f}".format(rec(preds, labels) * 100, prec=2)
    _fa = "False alarm: {:.{prec}f}".format((1-spc(preds, labels)) * 100, prec=2)
    _ma = "Missing alarm: {:.{prec}f}".format((1-rec(preds, labels)) * 100, prec=2)
    samples = "Number of samples: {}".format(preds.size(0))
    
    return _f1, _acc, _prec, _rec, _auc, _fa, _ma, samples
    
