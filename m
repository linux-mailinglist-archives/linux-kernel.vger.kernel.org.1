Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813902669C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgIKUyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:54:25 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:41390
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgIKUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599857664;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=70JxY9k5itTjoN4PvPHT19XpR+FmwDMiqLXF+u/QXNs=;
        b=S0uFTlIAMNeLrNiLT9rmMtLPk/uLDxhQvqgW/fAOE+zKqtKfZwrNt7UGBcue2mGH
        KM2zxf5AHBhLwF/BI5EaalDSdGeVW52FL8FU5tD4iEInHgU9BrKRRfb5yinR6GaFZJr
        SFP8zvYPU4+QinB9mlAqBhFmfzbSfqWaCIpYcTPk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599857664;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=70JxY9k5itTjoN4PvPHT19XpR+FmwDMiqLXF+u/QXNs=;
        b=oVu+E9hC8NS6zl7hr1NR1bTLFCGMPux0ab+WpSBrsZRskfYOPC9JKJHuZqUa4bI0
        djlWqQFHrTPAQ2aGSjrjFZboNFPlDR7bjvB4zf304eoap2fZJgJRAEOALIwUHBH/4Eg
        eo65g640GQvNZBnezMGd5izQp4ARcq1Ix544nU+I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69F01C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v2] cma_alloc(), indefinitely retry allocations for -EBUSY failures
Date:   Fri, 11 Sep 2020 20:54:24 +0000
Message-ID: <010101747ef2a10a-bb03bde7-7852-4d77-8706-cd099ef36004-000000@us-west-2.amazonses.com>
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

