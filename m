Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F682B2FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKNSum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:50:42 -0500
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:47052 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbgKNSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:50:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 731FE18223825;
        Sat, 14 Nov 2020 18:50:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2895:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3870:4321:5007:6119:6261:9389:9592:10004:10848:11026:11473:11658:11914:12043:12296:12297:12438:12555:12679:12895:13069:13132:13231:13311:13357:13894:14181:14384:14394:14721:21080:21627:21984:21990:30054:30069:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sack02_220720a27319
X-Filterd-Recvd-Size: 2430
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Nov 2020 18:50:36 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] mm: shmem: Convert shmem_enabled_show to use sysfs_emit_at
Date:   Sat, 14 Nov 2020 10:50:25 -0800
Message-Id: <b612a93825e5ea330cb68d2e8b516e9687a06cc6.1605376435.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1605376435.git.joe@perches.com>
References: <cover.1605376435.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the function to use sysfs_emit_at while neatening the uses of
sprintf and overwriting the last space char with a newline to avoid
possible output buffer overflow.

Miscellanea:

o in shmem_enabled_show, the removal of the indirected use of fmt
  allows __printf verification

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/shmem.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 028f4596fc16..48bafe10c6c2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4047,7 +4047,7 @@ int __init shmem_init(void)
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
 static ssize_t shmem_enabled_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
+				  struct kobj_attribute *attr, char *buf)
 {
 	static const int values[] = {
 		SHMEM_HUGE_ALWAYS,
@@ -4057,16 +4057,19 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
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

