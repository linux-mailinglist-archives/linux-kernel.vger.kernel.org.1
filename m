Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3E21C418
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGKL57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 07:57:59 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:36238 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbgGKL57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:57:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 20BC2837F24C;
        Sat, 11 Jul 2020 11:57:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3867:4321:5007:6642:9010:10004:10400:10848:11026:11658:11914:12043:12114:12296:12297:12438:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: limit75_5f04aa726ed6
X-Filterd-Recvd-Size: 1409
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Jul 2020 11:57:56 +0000 (UTC)
Message-ID: <dab1ba1aa03a8236933cfb7a28937efb0b808f13.camel@perches.com>
Subject: [PATCH] const_structs.checkpatch: Add regulator_ops
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     pihsun@chromium.org, lgirdwood@gmail.com, broonie@kernel.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 Jul 2020 04:57:54 -0700
In-Reply-To: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
References: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator_ops to expected to be const list

Signed-off-by: Joe Perches <joe@perches.com>
---
diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index ac5f1267151d..e9df9cc28a85 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -44,6 +44,7 @@ platform_hibernation_ops
 platform_suspend_ops
 proto_ops
 regmap_access_table
+regulator_ops
 rpc_pipe_ops
 rtc_class_ops
 sd_desc


