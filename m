Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE642A2141
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgKAUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 15:13:10 -0500
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:36580 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727279AbgKAUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:13:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 83CE918224D76;
        Sun,  1 Nov 2020 20:13:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2895:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:5007:6119:6261:9592:10004:11026:11473:11658:11914:12043:12296:12297:12438:12555:12895:13069:13311:13357:13894:14181:14384:14394:14721:21080:21627:21990:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: dog73_2e0c98d272aa
X-Filterd-Recvd-Size: 2268
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 20:13:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use sysfs_emit_at
Date:   Sun,  1 Nov 2020 12:12:51 -0800
Message-Id: <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1604261483.git.joe@perches.com>
References: <cover.1604261483.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the function to use sysfs_emit_at while neatening the uses
of sprintf and overwriting the last space char with a newline.

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/shmem.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5009d783d954..294ba0017a0f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4024,7 +4024,7 @@ int __init shmem_init(void)
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
 static ssize_t shmem_enabled_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
+				  struct kobj_attribute *attr, char *buf)
 {
 	static const int values[] = {
 		SHMEM_HUGE_ALWAYS,
@@ -4034,16 +4034,19 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
 		SHMEM_HUGE_DENY,
 		SHMEM_HUGE_FORCE,
 	};
-	int i, count;
-
-	for (i = 0, count = 0; i < ARRAY_SIZE(values); i++) {
-		const char *fmt = shmem_huge == values[i] ? "[%s] " : "%s ";
+	int len = 0;
+	int i;
 
-		count += sprintf(buf + count, fmt,
-				shmem_format_huge(values[i]));
+	for (i = 0; i < ARRAY_SIZE(values); i++) {
+		len += sysfs_emit_at(buf, len,
+				     shmem_huge == values[i] ? "%s[%s]" : "%s%s",
+				     i ? " " : "",
+				     shmem_format_huge(values[i]));
 	}
-	buf[count - 1] = '\n';
-	return count;
+
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
 }
 
 static ssize_t shmem_enabled_store(struct kobject *kobj,
-- 
2.26.0

