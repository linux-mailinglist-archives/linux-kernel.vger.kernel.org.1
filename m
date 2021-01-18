Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E772FA751
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407026AbhARRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:20:10 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:49252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406531AbhARRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:20:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AE7458384366;
        Mon, 18 Jan 2021 17:19:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:7652:7903:8531:8907:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12297:12438:12555:12663:12760:12986:13069:13095:13181:13229:13311:13357:13439:14181:14394:14659:14721:14777:21080:21212:21221:21433:21627:21660:21819:30022:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: pet14_23036e32754b
X-Filterd-Recvd-Size: 2639
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jan 2021 17:19:19 +0000 (UTC)
Message-ID: <ecefe8dcb93fe7028311b69dd297ba52224233d4.camel@perches.com>
Subject: [PATCH] checkpatch: Improve TYPECAST_INT_CONSTANT test message
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dgilbert@interlog.com, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Jan 2021 09:19:18 -0800
In-Reply-To: <b9861410-f23d-62aa-cdc9-9e2918359a86@interlog.com>
References: <f11f2ee7-a909-6ab7-f5a8-67a46e11c1e5@interlog.com>
         <63178794d14d12f28ccf87707f420ba97b90f6fd.camel@perches.com>
         <b9861410-f23d-62aa-cdc9-9e2918359a86@interlog.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the TYPECAST_INT_CONSTANT test by showing the suggested
conversion for various type of uses like (unsigned int)1 to 1U.

Signed-off-by: Joe Perches <joe@perches.com>
---

Douglas Gilbert sent me a private email (and in that email said he
'loves to hate checkpatch' ;) complaining that checkpatch warned on the
use of the cast of '(unsigned int)1' so make it more obvious why the
message is emitted by always showing the suggested conversion.

 scripts/checkpatch.pl | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 016115a62a9f..4f8494527139 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6527,18 +6527,18 @@ sub process {
 		if ($line =~ /(\(\s*$C90_int_types\s*\)\s*)($Constant)\b/) {
 			my $cast = $1;
 			my $const = $2;
+			my $suffix = "";
+			my $newconst = $const;
+			$newconst =~ s/${Int_type}$//;
+			$suffix .= 'U' if ($cast =~ /\bunsigned\b/);
+			if ($cast =~ /\blong\s+long\b/) {
+			    $suffix .= 'LL';
+			} elsif ($cast =~ /\blong\b/) {
+			    $suffix .= 'L';
+			}
 			if (WARN("TYPECAST_INT_CONSTANT",
-				 "Unnecessary typecast of c90 int constant\n" . $herecurr) &&
+				 "Unnecessary typecast of c90 int constant - '$cast$const' could be '$const$suffix'\n" . $herecurr) &&
 			    $fix) {
-				my $suffix = "";
-				my $newconst = $const;
-				$newconst =~ s/${Int_type}$//;
-				$suffix .= 'U' if ($cast =~ /\bunsigned\b/);
-				if ($cast =~ /\blong\s+long\b/) {
-					$suffix .= 'LL';
-				} elsif ($cast =~ /\blong\b/) {
-					$suffix .= 'L';
-				}
 				$fixed[$fixlinenr] =~ s/\Q$cast\E$const\b/$newconst$suffix/;
 			}
 		}


