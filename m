Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1102067D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbgFWXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 19:02:40 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:44348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387769AbgFWXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:02:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8B736180336E5;
        Tue, 23 Jun 2020 23:02:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3870:3871:4250:4321:4605:5007:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12049:12291:12297:12555:12679:12760:12986:13019:13439:14096:14097:14181:14394:14659:14721:21080:21221:21324:21433:21451:21627:21740:21741:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: steel65_3104c2626e3f
X-Filterd-Recvd-Size: 2917
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 23:02:35 +0000 (UTC)
Message-ID: <9bc7c782516f37948f202deba511bc95ed279bbd.camel@perches.com>
Subject: [PATCH] checkpatch: Add --fix option for ASSIGN_IN_IF
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Date:   Tue, 23 Jun 2020 16:02:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a --fix option for 2 types of single-line assignment in if statements

	if ((foo = bar(...)) < BAZ) {
expands to:
	foo = bar(..);
	if (foo < BAZ) {
and
	if ((foo = bar(...)) {
expands to:
	foo = bar(...);
	if (foo) {

if statements with assignments spanning multiple lines are
not converted with the --fix option.

if statements with additional logic are also not converted.

e.g.:	if ((foo = bar(...)) & BAZ == BAZ) {

Signed-off-by: Joe Perches <joe@perches.com>
---

Maybe coccinelle could do more complete conversions, but this
seems to work OK for most uses.

 scripts/checkpatch.pl | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b06093777fd8..396dc8721d4e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5052,8 +5052,30 @@ sub process {
 			my ($s, $c) = ($stat, $cond);
 
 			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
-				ERROR("ASSIGN_IN_IF",
-				      "do not use assignment in if condition\n" . $herecurr);
+				if (ERROR("ASSIGN_IN_IF",
+					  "do not use assignment in if condition\n" . $herecurr) &&
+				    $fix && $perl_version_ok) {
+					if ($rawline =~ /^\+(\s+)if\s*\(\s*(\!)?\s*\(\s*(($Lval)\s*=\s*$LvalOrFunc)\s*\)\s*(?:($Compare)\s*($FuncArg))?\s*\)\s*(\{)?\s*$/) {
+						my $space = $1;
+						my $not = $2;
+						my $statement = $3;
+						my $assigned = $4;
+						my $test = $8;
+						my $against = $9;
+						my $brace = $15;
+						fix_delete_line($fixlinenr, $rawline);
+						fix_insert_line($fixlinenr, "$space$statement;");
+						my $newline = "${space}if (";
+						$newline .= '!' if defined($not);
+						$newline .= '(' if (defined $not && defined($test) && defined($against));
+						$newline .= "$assigned";
+						$newline .= " $test $against" if (defined($test) && defined($against));
+						$newline .= ')' if (defined $not && defined($test) && defined($against));
+						$newline .= ')';
+						$newline .= " {" if (defined($brace));
+						fix_insert_line($fixlinenr + 1, $newline);
+					}
+				}
 			}
 
 			# Find out what is on the end of the line after the



