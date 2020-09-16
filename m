Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A850526CC41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgIPUl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:41:29 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:32888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728483AbgIPUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:41:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 85AB7180458CB;
        Wed, 16 Sep 2020 20:41:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1540:1568:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3865:3867:3868:3872:4321:4419:5007:6261:10004:10848:11026:11473:11658:11914:12043:12297:12438:12555:12895:13069:13255:13311:13357:13894:14181:14384:14394:14721:21080:21627:21990:30029:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cakes28_4701f512711c
X-Filterd-Recvd-Size: 1847
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:41:12 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 8/8] drivers core: node: Use a more typical macro definition style for ACCESS_ATTR
Date:   Wed, 16 Sep 2020 13:40:45 -0700
Message-Id: <faf51a671160cf884efa68fb458d3e8a44b1a7a7.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the trailing semicolon from the macro and add it to its uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/node.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index dafe03e82e7c..25dbe36c0cf2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -165,12 +165,12 @@ static ssize_t name##_show(struct device *dev,				\
 	return sysfs_emit(buf, "%u\n",					\
 			  to_access_nodes(dev)->hmem_attrs.name);	\
 }									\
-static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(name)
 
-ACCESS_ATTR(read_bandwidth)
-ACCESS_ATTR(read_latency)
-ACCESS_ATTR(write_bandwidth)
-ACCESS_ATTR(write_latency)
+ACCESS_ATTR(read_bandwidth);
+ACCESS_ATTR(read_latency);
+ACCESS_ATTR(write_bandwidth);
+ACCESS_ATTR(write_latency);
 
 static struct attribute *access_attrs[] = {
 	&dev_attr_read_bandwidth.attr,
-- 
2.26.0

