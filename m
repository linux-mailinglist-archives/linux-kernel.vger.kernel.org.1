Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60E52B2FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKNSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:50:41 -0500
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:47044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbgKNSuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:50:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1240618224D7B;
        Sat, 14 Nov 2020 18:50:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:968:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3870:3872:4321:5007:6261:7903:10004:10848:11026:11473:11658:11914:12043:12296:12297:12438:12555:12895:12986:13069:13161:13229:13311:13357:13894:14181:14384:14394:14664:14721:21080:21433:21451:21627:21990:30029:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: blow38_1e01d4427319
X-Filterd-Recvd-Size: 2258
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Nov 2020 18:50:35 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] mm:backing-dev: Use sysfs_emit in macro defining functions
Date:   Sat, 14 Nov 2020 10:50:24 -0800
Message-Id: <45ec6cfc177d743f9c0ebaf35e43969dce43af42.1605376435.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1605376435.git.joe@perches.com>
References: <cover.1605376435.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cocci script used in commit bdacbb8d04f ("mm: Use sysfs_emit
for struct kobject * uses") does not convert the name##_show macro
because the macro uses concatenation via ##.

Convert it by hand.

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/backing-dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 408d5051d05b..e33797579338 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -150,11 +150,11 @@ static ssize_t read_ahead_kb_store(struct device *dev,
 
 #define BDI_SHOW(name, expr)						\
 static ssize_t name##_show(struct device *dev,				\
-			   struct device_attribute *attr, char *page)	\
+			   struct device_attribute *attr, char *buf)	\
 {									\
 	struct backing_dev_info *bdi = dev_get_drvdata(dev);		\
 									\
-	return snprintf(page, PAGE_SIZE-1, "%lld\n", (long long)expr);	\
+	return sysfs_emit(buf, "%lld\n", (long long)expr);		\
 }									\
 static DEVICE_ATTR_RW(name);
 
@@ -200,11 +200,11 @@ BDI_SHOW(max_ratio, bdi->max_ratio)
 
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
-					  char *page)
+					  char *buf)
 {
 	dev_warn_once(dev,
 		"the stable_pages_required attribute has been removed. Use the stable_writes queue attribute instead.\n");
-	return snprintf(page, PAGE_SIZE-1, "%d\n", 0);
+	return sysfs_emit(buf, "%d\n", 0);
 }
 static DEVICE_ATTR_RO(stable_pages_required);
 
-- 
2.26.0

