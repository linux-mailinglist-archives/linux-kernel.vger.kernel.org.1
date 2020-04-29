Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7921BE93D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD2U41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 16:56:27 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:38046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2U41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:56:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2A4F33D13;
        Wed, 29 Apr 2020 20:56:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:983:988:989:1208:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3867:4250:5007:6299:6642:7903:8603:10004:10400:10848:11026:11658:11914:12297:12438:12555:12679:12760:13069:13095:13311:13357:13439:14181:14394:14659:14721:21080:21433:21451:21505:21627:30054:30062:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: town34_724d5c9ce7815
X-Filterd-Recvd-Size: 1767
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 20:56:25 +0000 (UTC)
Message-ID: <3dc7bdaa58490f5906efc11a4d6113e42a087723.camel@perches.com>
Subject: [PATCH] checkpatch: Disallow --git and --file/--fix
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Apr 2020 13:56:24 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow these options to be combined.

Miscellanea:

o Add missing $P: to some die("reason message") output

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e4af60..4a5c6bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -246,6 +246,8 @@ list_types(0) if ($list_types);
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
+die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
+
 my $exit = 0;
 
 my $perl_version_ok = 1;
@@ -269,11 +271,11 @@ if ($color =~ /^[01]$/) {
 } elsif ($color =~ /^auto$/i) {
 	$color = (-t STDOUT);
 } else {
-	die "Invalid color mode: $color\n";
+	die "$P: Invalid color mode: $color\n";
 }
 
 # skip TAB size 1 to avoid additional checks on $tabsize - 1
-die "Invalid TAB size: $tabsize\n" if ($tabsize < 2);
+die "$P: Invalid TAB size: $tabsize\n" if ($tabsize < 2);
 
 sub hash_save_array_words {
 	my ($hashRef, $arrayRef) = @_;


