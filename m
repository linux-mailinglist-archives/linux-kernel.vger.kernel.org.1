Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB524282790
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgJDASc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 20:18:32 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:42968 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgJDAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 20:18:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 55179100E7B40;
        Sun,  4 Oct 2020 00:18:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3867:3872:4385:4605:5007:6261:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12895:13069:13161:13229:13311:13357:13894:14096:14181:14384:14394:14721:21080:21611:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: error38_2901c78271b1
X-Filterd-Recvd-Size: 2620
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Oct 2020 00:18:26 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Dan Carpenter <dan.carpenter@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm/zswap: Make struct kernel_param_ops definitions const
Date:   Sat,  3 Oct 2020 17:18:09 -0700
Message-Id: <1791535ee0b00f4a5c68cc4a8adada06593ad8f1.1601770305.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1601770305.git.joe@perches.com>
References: <cover.1601770305.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These should be const, so make it so.

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fbb782924ccc..1eced701b3bd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -81,7 +81,7 @@ static bool zswap_pool_reached_full;
 static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
 				   const struct kernel_param *);
-static struct kernel_param_ops zswap_enabled_param_ops = {
+static const struct kernel_param_ops zswap_enabled_param_ops = {
 	.set =		zswap_enabled_param_set,
 	.get =		param_get_bool,
 };
@@ -91,7 +91,7 @@ module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
 static char *zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
 static int zswap_compressor_param_set(const char *,
 				      const struct kernel_param *);
-static struct kernel_param_ops zswap_compressor_param_ops = {
+static const struct kernel_param_ops zswap_compressor_param_ops = {
 	.set =		zswap_compressor_param_set,
 	.get =		param_get_charp,
 	.free =		param_free_charp,
@@ -102,7 +102,7 @@ module_param_cb(compressor, &zswap_compressor_param_ops,
 /* Compressed storage zpool to use */
 static char *zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
 static int zswap_zpool_param_set(const char *, const struct kernel_param *);
-static struct kernel_param_ops zswap_zpool_param_ops = {
+static const struct kernel_param_ops zswap_zpool_param_ops = {
 	.set =		zswap_zpool_param_set,
 	.get =		param_get_charp,
 	.free =		param_free_charp,
-- 
2.26.0

