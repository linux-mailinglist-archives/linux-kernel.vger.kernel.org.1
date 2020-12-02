Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A52CC1A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgLBQF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:05:26 -0500
Received: from m12-11.163.com ([220.181.12.11]:33272 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgLBQFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=O/npw76o0ufcvrM12h
        s+GrdXAyvpH9W3tDvavR6Ud6g=; b=ERuAvlWnyd++pzrek4C1fgeis89FnF4V1w
        l+nBO/jYFTAxWCqwHLNaB6X5+4k6qIxbMSj4Xa2zWPqfKRBnXADTCAaFKjIG6XIn
        M+P0mGleLazGu5rZhcqT8kAFS+c6vUamL0b/gVQm3a1lHJBD3ANwEj7XyuNAW1PD
        F1amx8bVE=
Received: from localhost.localdomain (unknown [36.170.33.20])
        by smtp7 (Coremail) with SMTP id C8CowAAHB58Jt8df6eEzBg--.12951S2;
        Wed, 02 Dec 2020 23:47:22 +0800 (CST)
From:   carver4lio@163.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hailong Liu <carver4lio@163.com>,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] mm:remove the unuseful  else after a return
Date:   Wed,  2 Dec 2020 23:47:20 +0800
Message-Id: <20201202154720.115162-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAAHB58Jt8df6eEzBg--.12951S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1xur4fCw43GF1ruw1fCrg_yoWfZFbEkF
        yIvFsrKrs8CFyfGFy2ya42qrZ7A39Y9rsrWF98tr43t345Gr4kXFyDZa1fXrWqvFWxGas8
        Cr1jvFWfuryYyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU-VyDUUUUU==
X-Originating-IP: [36.170.33.20]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/xtbCnwvsnVzmVVedRgABsH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <carver4lio@163.com>

The *else* is not useful after a *return* in __lock_page_or_retry().

Signed-off-by: Hailong Liu<liu.hailong6@zte.com.cn>
---
 mm/filemap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0b2067b3c..55e6ad1b0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1583,19 +1583,19 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 		else
 			wait_on_page_locked(page);
 		return 0;
-	} else {
-		if (flags & FAULT_FLAG_KILLABLE) {
-			int ret;
-
-			ret = __lock_page_killable(page);
-			if (ret) {
-				mmap_read_unlock(mm);
-				return 0;
-			}
-		} else
-			__lock_page(page);
-		return 1;
 	}
+	if (flags & FAULT_FLAG_KILLABLE) {
+		int ret;
+
+		ret = __lock_page_killable(page);
+		if (ret) {
+			mmap_read_unlock(mm);
+			return 0;
+		}
+	} else
+		__lock_page(page);
+	return 1;
+
 }
 
 /**
-- 
2.17.1

