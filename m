Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3219129D796
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbgJ1WZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:25:53 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:59086 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733000AbgJ1WZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:49 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 4AE1B8123FE7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 04:47:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7439712C7;
        Wed, 28 Oct 2020 04:47:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3865:3867:4385:5007:7809:10004:10400:10848:11232:11657:11658:11914:12043:12297:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21451:21627:30012:30054:30064:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: cake37_14124cd27282
X-Filterd-Recvd-Size: 1359
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Oct 2020 04:47:00 +0000 (UTC)
Message-ID: <045b88eda9265867df0a1f318a992350f84e09fb.camel@perches.com>
Subject: [PATCH] MAINTAINERS: Update AMD POWERPLAY pattern
From:   Joe Perches <joe@perches.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Oct 2020 21:46:59 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e098bc9612c2 ("drm/amd/pm: optimize the power related source code layout")
moved the directory, update the F: file pattern to match.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 18aee48c4ffb..8c36722b130f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -934,7 +934,7 @@ M:	Evan Quan <evan.quan@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git git://people.freedesktop.org/~agd5f/linux
-F:	drivers/gpu/drm/amd/powerplay/
+F:	drivers/gpu/drm/amd/pm/powerplay/
 
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Brijesh Singh <brijeshkumar.singh@amd.com>


