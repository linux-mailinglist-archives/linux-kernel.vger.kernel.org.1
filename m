Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B608623CE22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgHESQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 14:16:24 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:57264 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728631AbgHESOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:14:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BA88F173085A;
        Wed,  5 Aug 2020 18:14:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:2899:2904:3138:3139:3140:3141:3142:3351:3868:3870:4321:5007:6119:10004:10400:10848:11658:11914:12043:12297:12555:12760:13069:13311:13357:13439:14096:14097:14181:14394:14659:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pen53_200df7926fb1
X-Filterd-Recvd-Size: 1809
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Aug 2020 18:14:39 +0000 (UTC)
Message-ID: <91ea17761845500f161ab343ea6e3415d3564d7b.camel@perches.com>
Subject: [PATCH] spelling.txt: Remove some duplicate entries
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Aug 2020 11:14:38 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found when Colin King fixed a typo for falied/failed
and a git grep showed 2 entries in this file.

Signed-off-by: Joe Perches <joe@perches.com>
---

 scripts/spelling.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f253681e7e2a..b703e4fd51e8 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -596,7 +596,6 @@ extenstion||extension
 extracter||extractor
 faied||failed
 faield||failed
-falied||failed
 faild||failed
 failded||failed
 failer||failure
@@ -793,7 +792,6 @@ interrup||interrupt
 interrups||interrupts
 interruptted||interrupted
 interupted||interrupted
-interupt||interrupt
 intial||initial
 intialisation||initialisation
 intialised||initialised
@@ -968,7 +966,6 @@ occurd||occurred
 occured||occurred
 occurence||occurrence
 occure||occurred
-occured||occurred
 occuring||occurring
 offser||offset
 offet||offset
@@ -1437,7 +1434,6 @@ udpate||update
 uesd||used
 uknown||unknown
 usccess||success
-usupported||unsupported
 uncommited||uncommitted
 uncompatible||incompatible
 unconditionaly||unconditionally


