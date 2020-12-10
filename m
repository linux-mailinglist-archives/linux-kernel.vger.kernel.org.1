Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB06D2D5342
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgLJF01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:26:27 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:42478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgLJF0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:26:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CDDFC182CED34;
        Thu, 10 Dec 2020 05:25:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:2829:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:4022:4321:5007:6119:7903:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12295:12297:12555:12740:12895:12986:13069:13071:13311:13357:13439:13846:13894:14180:14181:14659:14721:14777:19904:19999:21060:21080:21221:21627:21881:21939:30012:30026:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: page55_1912e53273f5
X-Filterd-Recvd-Size: 2444
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Dec 2020 05:25:40 +0000 (UTC)
Message-ID: <aea0efa93c17e431205eeb932a73efa7e21598a3.camel@perches.com>
Subject: Re: checkpatch
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Dec 2020 21:25:37 -0800
In-Reply-To: <87zh2mzw3h.fsf@nanos.tec.linutronix.de>
References: <87zh2mzw3h.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-09 at 19:13 +0100, Thomas Gleixner wrote:
> Joe,

Hi Thomas.

> the below made it through my filters for some reason so I actually
> looked and immediately wondered why checkpatch.pl did not identify this
> as pure garbage.
> 
>  Original mail is here: lore.kernel.org/r/69cb540a-09d5-4956-b062-071ccded7090@web.de
> 
> Can you have a look please? Adding brackets in the middle of the code
> for absolutely no reason is wrong to begin with and then not indenting
> the enclosed code makes it even worse.

Well, maybe something like this, but there are probably some
drawbacks with initializations.
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..057be2cfe118 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4047,6 +4047,25 @@ sub process {
 			}
 		}
 
+# Check open brace and any possible statement indentation
+		if (defined($stat) &&
+		    $stat =~ /^\+([ \t]+)\{[ \t]*\n/) {
+			if (substr($stat, pos($stat), length($1)+1) !~ /^$1\s/) {
+				my $cnt = statement_rawlines($stat);
+				my $herectx = get_stat_here($linenr, $cnt, $here);
+				my @array = split(/\n/, $herectx);
+				$cnt = 0;
+				$herectx = "";
+				foreach my $aline (@array) {
+					$herectx .= $aline . "\n";
+					$cnt++ if ($aline =~ /^\+/);
+					last if ($cnt >= 2);
+				}
+				WARN("OPEN_BRACE",
+				     "A line with only an open brace should start an indented block\n" . $herectx);
+			}
+		}
+
 # Check relative indent for conditionals and blocks.
 		if ($line =~ /\b(?:(?:if|while|for|(?:[a-z_]+|)for_each[a-z_]+)\s*\(|(?:do|else)\b)/ && $line !~ /^.\s*#/ && $line !~ /\}\s*while\s*/) {
 			($stat, $cond, $line_nr_next, $remain_next, $off_next) =


