Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F192C0CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgKWODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:03:55 -0500
Received: from z5.mailgun.us ([104.130.96.5]:17520 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbgKWODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:03:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606140234; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GMDPBCCMonm9madELgXD+35QPE+dhBMWpkpv8t4h7ZA=; b=k5ktkvWdU98jXksASkC571QgqoOWgxGTmQTWN7QDDBKbPXxcTG/TUlhfoC0DSMkaQiaBHRMz
 o9VFbxUJy927OVWnMG77PAUFViLOwzJw/rASbYkRj1jjk/EG5TJZZGnVOaP9iu2XaGXNS551
 pP743baMHHNcddL4mvYNX9nKvr4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbbc1471b731a5d9c1996fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 14:03:51
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF37EC43464; Mon, 23 Nov 2020 14:03:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11605C433C6;
        Mon, 23 Nov 2020 14:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11605C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm: memory_hotplug: put migration failure information under DEBUG_VM
Date:   Mon, 23 Nov 2020 19:33:16 +0530
Message-Id: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pages are failed to get isolate or migrate, the page owner
information along with page info is dumped. If there are continuous
failures in migration(say page is pinned) or isolation, the log buffer
is simply getting flooded with the page owner information. As most of
the times page info is sufficient to know the causes for failures of
migration or isolation, place the page owner information under DEBUG_VM.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/memory_hotplug.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63b2e46..f48f30d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1326,7 +1326,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		} else {
 			pr_warn("failed to isolate pfn %lx\n", pfn);
-			dump_page(page, "isolation failed");
+			__dump_page(page, "isolation failed");
+#if defined(CONFIG_DEBUG_VM)
+			dump_page_owner(page);
+#endif
 		}
 		put_page(page);
 	}
@@ -1357,7 +1360,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
 				       page_to_pfn(page), ret);
-				dump_page(page, "migration failure");
+				__dump_page(page, "migration failure");
+#if defined(CONFIG_DEBUG_VM)
+				dump_page_owner(page);
+#endif
 			}
 			putback_movable_pages(&source);
 		}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

