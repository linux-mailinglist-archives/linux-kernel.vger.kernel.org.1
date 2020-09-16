Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05126CC44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgIPUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:41:42 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:42628 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgIPUlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:41:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E92942C0C;
        Wed, 16 Sep 2020 20:41:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3165:3352:3865:3866:3868:3871:4321:5007:6119:6261:7974:8603:9010:9036:9592:10004:10848:11026:11658:11914:12043:12114:12296:12297:12438:12555:12895:13069:13255:13311:13357:13894:14181:14384:14394:14721:21080:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: spot53_410849c2711c
X-Filterd-Recvd-Size: 2680
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:41:10 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 7/8] drivers core: Use sysfs_emit for shared_cpu_map_show and shared_cpu_list_show
Date:   Wed, 16 Sep 2020 13:40:44 -0700
Message-Id: <80457b467ab6cde13a173cfd8a4f49cd8467a7fd.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not indirect the bitmap printing of these shared_cpu show functions by
using cpumap_print_to_pagebuf/bitmap_print_to_pagebuf.

Use the more typical style with the vsnprintf %*pb and %*pbl extensions
directly so there is no possible mixup about the use of offset_in_page(buf)
by bitmap_print_to_pagebuf.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/cacheinfo.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 4946647bd985..bfc095956dd1 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -380,24 +380,22 @@ static ssize_t size_show(struct device *dev,
 	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
 }
 
-static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
+static ssize_t shared_cpu_map_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 	const struct cpumask *mask = &this_leaf->shared_cpu_map;
 
-	return cpumap_print_to_pagebuf(list, buf, mask);
-}
-
-static ssize_t shared_cpu_map_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return shared_cpumap_show_func(dev, false, buf);
+	return sysfs_emit(buf, "%*pb\n", nr_cpu_ids, mask);
 }
 
 static ssize_t shared_cpu_list_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	return shared_cpumap_show_func(dev, true, buf);
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+	const struct cpumask *mask = &this_leaf->shared_cpu_map;
+
+	return sysfs_emit(buf, "%*pbl\n", nr_cpu_ids, mask);
 }
 
 static ssize_t type_show(struct device *dev,
-- 
2.26.0

