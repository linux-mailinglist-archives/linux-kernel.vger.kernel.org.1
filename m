Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22A266988
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKU2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:28:39 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:57730
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbgIKU2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599856117;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=70JxY9k5itTjoN4PvPHT19XpR+FmwDMiqLXF+u/QXNs=;
        b=SkcJTE3oqXG/fqGygHe3jj7ohCZnRNhjIOIk90Gg7m6kQOeB7kGHM2gwO3bp7mzN
        FBNczkJW6cI5Yt8dbkuiyKGnKL3d2PoHXWChRr82DgxnC1YzGnSPP2JyHRB7l7G5mGH
        GyRhkaLnA+yiyOeS9yDCFFaYAYdZUYMZtyL+Mz8E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599856117;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=70JxY9k5itTjoN4PvPHT19XpR+FmwDMiqLXF+u/QXNs=;
        b=a/NpNliqtchuDArAGGMcABM8lvx+Gvs95ZmshXe8wHFJ0GJBRut9LoCF31yRGmwu
        ggqM2xMemTLPm6qRmmqqMXBbd783K3RTruFiFCBVaAQ1FJyVnEA0timu3c80VQ0jLxV
        8pkIriauc+ZDkFmpXYt8Bm+0zRlu6XpTQeYwXKYM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7124CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v2] cma_alloc(), indefinitely retry allocations for -EBUSY failures
Date:   Fri, 11 Sep 2020 20:28:37 +0000
Message-ID: <010101747edb063a-d155fcf2-c8bd-433b-8548-154e4457e37c-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.11-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH v2] cma_alloc(), indefinitely retry allocations for -EBUSY failures

On mobile devices, failure to allocate from a CMA area constitutes a
functional failure.  Sometimes during CMA allocations, we have observed
that pages in a CMA area allocated through alloc_pages(), that we're trying
to migrate away to make room for a CMA allocation, are temporarily pinned.
This temporary pinning can occur when a process that owns the pinned page
is being forked (the example is explained further in the commit text), or it is
exiting.  This patch addresses this issue by indefinitely retrying allocations
that fail due to a return of -EBUSY.

** This change log was re-sent due to threading issues **

Change log: 

v1: We were performing retries of the allocation a fixed number of times.
Andrew Morton disliked this, as it didn't guarantee that the allocation would
succeed.

https://lkml.org/lkml/2020/8/5/1096
https://lkml.org/lkml/2020/8/21/1490

v2: To address this concern, we switched to retrying indefinitely, as opposed to
doing to retrying  the allocation a limited number of times.

Chris Goldsworthy (1):
  mm: cma: indefinitely retry allocations in cma_alloc

 mm/cma.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

