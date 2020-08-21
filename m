Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9064D24DEAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHURkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 13:40:20 -0400
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:50468 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgHURkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:40:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D9A8B182CED2A;
        Fri, 21 Aug 2020 17:40:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 80,6,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2332:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3351:3653:3865:3868:3874:4321:5007:7903:10004:10400:10848:11026:11658:11914:12043:12109:12296:12297:12438:12555:12760:12986:13019:13069:13255:13311:13357:13439:14181:14394:14659:14721:14777:21080:21433:21505:21627:21819:30022:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: pen21_4a135492703b
X-Filterd-Recvd-Size: 1840
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 17:40:16 +0000 (UTC)
Message-ID: <1787fba7e252f053ef321b349f3bac39a8cdf503.camel@perches.com>
Subject: [PATCH] get_maintainer: Exclude MAINTAINERS file(s) from
 --git-fallback and --git-blame
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Aug 2020 10:40:15 -0700
In-Reply-To: <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
References: <20200821154848.GI7871@localhost.localdomain>
         <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS files generally have no specific maintainer but are updated
by individuals for subsystems all over the source tree.

Exclude MAINTAINERS file(s) from --git-fallback and --git-blame searches
so the unlucky individuals that update the files the most are not shown.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..4d5196a11329 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -953,6 +953,7 @@ sub get_maintainers {
     }
 
     foreach my $file (@files) {
+	next if ($file =~ /MAINTAINERS$/);
 	if ($email &&
 	    ($email_git || ($email_git_fallback &&
 			    !$exact_pattern_match_hash{$file}))) {



