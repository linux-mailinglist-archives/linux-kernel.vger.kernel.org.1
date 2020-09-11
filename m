Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25E12669CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgIKUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:54:32 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:43402
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgIKUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599857670;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=3WsGh4k1/vDYdpwChY4cQkQgPgI0Dix7ehSHrqOmbLg=;
        b=iY3Fx+L+SYoInI3Mb7lKMd4qY/mZLVDsuV/gwu/zaQDgza3E23QgwZWm+0us7CLs
        FvX8AkDN1Ho2lQiYPYIHsfvATuXUBXA2CXVvEmZVI+/Wwrmi9aH7M8homsgauNh7aqK
        H2vkHflsOFyup1dzeqcyaUHAAgLOpOEFlDxwS3uI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599857670;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=3WsGh4k1/vDYdpwChY4cQkQgPgI0Dix7ehSHrqOmbLg=;
        b=Nj/aRsbYvvLIy7hpnpcSCKt3wHOxDqnbjO582/6WVqm/kTF943rehGiMdPWj2TMa
        Ndz8q+loIJ461sPS211lbZq4GFbyw0qBn5kZcY1atwMm+V274dIJCCdB/ffWCnr3ner
        fsfcxQhQTs5rhfmrjKTB1XYp/EurmTg1it2m2Nus=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00046C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
Subject: [PATCH v2] mm: cma: indefinitely retry allocations in cma_alloc
Date:   Fri, 11 Sep 2020 20:54:30 +0000
Message-ID: <010101747ef2b8fc-a5e44a5a-dcf4-4828-a1d4-a099df63f2df-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599857630-23714-1-git-send-email-cgoldswo@codeaurora.org>
References: <1599857630-23714-1-git-send-email-cgoldswo@codeaurora.org>
X-SES-Outgoing: 2020.09.11-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMA allocations will fail if 'pinned' pages are in a CMA area, since we
cannot migrate pinned pages. The _refcount of a struct page being greater
than _mapcount for that page can cause pinning for anonymous pages.  This
is because try_to_unmap(), which (1) is called in the CMA allocation path,
and (2) decrements both _refcount and _mapcount for a page, will stop
unmapping a page from VMAs once the _mapcount for a page reaches 0.  This
implies that after try_to_unmap() has finished successfully for a page
where _recount > _mapcount, that _refcount will be greater than 0.  Later
in the CMA allocation path in migrate_page_move_mapping(), we will have one
more reference count than intended for anonymous pages, meaning the
allocation will fail for that page.

One example of where _refcount can be greater than _mapcount for a page we
would not expect to be pinned is inside of copy_one_pte(), which is called
during a fork. For ptes for which pte_present(pte) == true, copy_one_pte()
will increment the _refcount field followed by the  _mapcount field of a
page. If the process doing copy_one_pte() is context switched out after
incrementing _refcount but before incrementing _mapcount, then the page
will be temporarily pinned.

So, inside of cma_alloc(), instead of giving up when alloc_contig_range()
returns -EBUSY after having scanned a whole CMA-region bitmap, perform
retries indefinitely, with sleeps, to give the system an opportunity to
unpin any pinned pages.

Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Co-developed-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
---
 mm/cma.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7..90bb505 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -32,6 +32,7 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/delay.h>
 #include <trace/events/cma.h>
 
 #include "cma.h"
@@ -442,8 +443,28 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
 		if (bitmap_no >= bitmap_maxno) {
-			mutex_unlock(&cma->lock);
-			break;
+			if (ret == -EBUSY) {
+				mutex_unlock(&cma->lock);
+
+				/*
+				 * Page may be momentarily pinned by some other
+				 * process which has been scheduled out, e.g.
+				 * in exit path, during unmap call, or process
+				 * fork and so cannot be freed there. Sleep
+				 * for 100ms and retry the allocation.
+				 */
+				start = 0;
+				ret = -ENOMEM;
+				msleep(100);
+				continue;
+			} else {
+				/*
+				 * ret == -ENOMEM - all bits in cma->bitmap are
+				 * set, so we break accordingly.
+				 */
+				mutex_unlock(&cma->lock);
+				break;
+			}
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
 		/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

