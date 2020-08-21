Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464A24DF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHUSFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:05:08 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:48354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgHUSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:05:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B3AE71801A4D9;
        Fri, 21 Aug 2020 18:05:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3653:3865:3868:3872:3874:4419:4605:5007:6691:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:14777:21080:21433:21505:21627:21819:30022:30054:30070:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boot46_2f0fb7c2703b
X-Filterd-Recvd-Size: 2124
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 18:05:04 +0000 (UTC)
Message-ID: <2bacb0a9c06fbb6d56a43bf930e808c74243c908.camel@perches.com>
Subject: [PATCH V2] get_maintainer: Exclude MAINTAINERS file(s) from
 --git-fallback
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Aug 2020 11:05:03 -0700
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

Exclude MAINTAINERS file(s) from --git-fallback searches so the unlucky
individuals that update the files the most are not shown by default.

Signed-off-by: Joe Perches <joe@perches.com>
---

V2:

Remove --git and --git-blame from the exclusion.
Someone who _really_ wants that info should get it.

 scripts/get_maintainer.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..7ea461dc208e 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -954,8 +954,10 @@ sub get_maintainers {
 
     foreach my $file (@files) {
 	if ($email &&
-	    ($email_git || ($email_git_fallback &&
-			    !$exact_pattern_match_hash{$file}))) {
+	    ($email_git ||
+	     ($email_git_fallback &&
+	      $file !~ /MAINTAINERS$/ &&
+	      !$exact_pattern_match_hash{$file}))) {
 	    vcs_file_signoffs($file);
 	}
 	if ($email && $email_git_blame) {


