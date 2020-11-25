Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25452C42F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgKYPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:32:42 -0500
Received: from z5.mailgun.us ([104.130.96.5]:42361 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbgKYPcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:32:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606318361; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1+TC3IYLJcqS2Bupzdlu7MVB2ra419DrH4Nlfpu0yk8=; b=O9qD/1kqWiNOSDgGZdVy+tckrHL2Uiae8bHQA3JeYtNs5i205PHm01be+Ey7Rj3tgHfN1PjZ
 qjOJAbZsThbiYPd6Rmhky4vTodeSVEBzFoc2+fZ8x1A3++5H3pns0nDu0Gpnx8IYjC09/bnv
 Uh6KxOPGnihkHHaWwbpfXxzCTqI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fbe79117e9d874dfc03d270 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 15:32:33
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D74EC43461; Wed, 25 Nov 2020 15:32:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93090C43460;
        Wed, 25 Nov 2020 15:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93090C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm: cma: improve pr_debug log in cma_release()
Date:   Wed, 25 Nov 2020 21:02:21 +0530
Message-Id: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is required to print 'count' of pages, along with the pages, passed
to cma_release to debug the cases of mismatched count value passed
between cma_alloc() and cma_release() from a code path.

As an example, consider the below scenario:
1) CMA pool size is 4MB and
2) User doing the erroneous step of allocating 2 pages but freeing 1
page in a loop from this CMA pool.
The step 2 causes cma_alloc() to return NULL at one point of time
because of -ENOMEM condition.

And the current pr_debug logs is not giving the info about these types
of allocation patterns because of count value not being printed in
cma_release().

We are printing the count value in the trace logs, just extend the same
to pr_debug logs too.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7..07c904b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -512,7 +512,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 	if (!cma || !pages)
 		return false;
 
-	pr_debug("%s(page %p)\n", __func__, (void *)pages);
+	pr_debug("%s(page %p, count %zu)\n", __func__, (void *)pages, count);
 
 	pfn = page_to_pfn(pages);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

