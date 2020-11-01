Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4052A213F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgKAUNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 15:13:04 -0500
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:51224 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727118AbgKAUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:13:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 893F3181D302B;
        Sun,  1 Nov 2020 20:13:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1543:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3354:3865:3866:3867:3874:4605:5007:6261:8603:10004:10848:11026:11473:11658:11914:12043:12291:12296:12297:12438:12555:12679:12683:12895:13255:13894:14110:14181:14394:14721:21080:21433:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thing54_260ce59272aa
X-Filterd-Recvd-Size: 4577
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 20:13:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm: huge_memory: Convert remaining use of sprintf to sysfs_emit and neatening
Date:   Sun,  1 Nov 2020 12:12:49 -0800
Message-Id: <f473c28fea9303d411776d1daaaed01cbce147bf.1604261483.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1604261483.git.joe@perches.com>
References: <cover.1604261483.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the only use of sprintf with struct kobject * that the cocci
script could not convert.

Miscellanea:

o Neaten the uses of a constant string with sysfs_emit to use a const
  char * to reduce overall object size

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/huge_memory.c | 52 +++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 44826bf3d9ff..0436ecb2326c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -163,12 +163,17 @@ static struct shrinker huge_zero_page_shrinker = {
 static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
 {
+	const char *output;
+
 	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
-		return sysfs_emit(buf, "[always] madvise never\n");
-	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return sysfs_emit(buf, "always [madvise] never\n");
+		output = "[always] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always [madvise] never";
 	else
-		return sysfs_emit(buf, "always madvise [never]\n");
+		output = "always madvise [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static ssize_t enabled_store(struct kobject *kobj,
@@ -200,11 +205,11 @@ static struct kobj_attribute enabled_attr =
 	__ATTR(enabled, 0644, enabled_show, enabled_store);
 
 ssize_t single_hugepage_flag_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf,
-				enum transparent_hugepage_flag flag)
+				  struct kobj_attribute *attr, char *buf,
+				  enum transparent_hugepage_flag flag)
 {
-	return sprintf(buf, "%d\n",
-		       !!test_bit(flag, &transparent_hugepage_flags));
+	return sysfs_emit(buf, "%d\n",
+			  !!test_bit(flag, &transparent_hugepage_flags));
 }
 
 ssize_t single_hugepage_flag_store(struct kobject *kobj,
@@ -232,19 +237,24 @@ ssize_t single_hugepage_flag_store(struct kobject *kobj,
 static ssize_t defrag_show(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)
 {
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return sysfs_emit(buf,
-				  "[always] defer defer+madvise madvise never\n");
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return sysfs_emit(buf,
-				  "always [defer] defer+madvise madvise never\n");
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return sysfs_emit(buf,
-				  "always defer [defer+madvise] madvise never\n");
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return sysfs_emit(buf,
-				  "always defer defer+madvise [madvise] never\n");
-	return sysfs_emit(buf, "always defer defer+madvise madvise [never]\n");
+	const char *output;
+
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
+		     &transparent_hugepage_flags))
+		output = "[always] defer defer+madvise madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always [defer] defer+madvise madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always defer [defer+madvise] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always defer defer+madvise [madvise] never";
+	else
+		output = "always defer defer+madvise madvise [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static ssize_t defrag_store(struct kobject *kobj,
-- 
2.26.0

