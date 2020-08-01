Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B223532D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHAQF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 12:05:26 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:54724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgHAQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:05:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B786C180A7FD8;
        Sat,  1 Aug 2020 16:05:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:152:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2827:2898:3138:3139:3140:3141:3142:3353:3653:3865:3868:3872:4321:5007:7903:9592:10004:10400:10848:11232:11658:11783:11914:12043:12297:12555:12740:12895:13894:14181:14394:14659:14721:21080:21324:21611:21627:21740:21741:21990:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: vest79_370b0cd26f8d
X-Filterd-Recvd-Size: 2994
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 16:05:23 +0000 (UTC)
Message-ID: <7e25090c79f6a69d502ab8219863300790192fe2.camel@perches.com>
Subject: [PATCH] checkpatch: Remove missing switch/case break test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Cambda Zhu <cambda@linux.alibaba.com>
Date:   Sat, 01 Aug 2020 09:05:22 -0700
In-Reply-To: <46F62293-BC9E-4428-94BD-186B0E3D3A5E@linux.alibaba.com>
References: <46F62293-BC9E-4428-94BD-186B0E3D3A5E@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test doesn't work well and newer compilers are much better
at emitting this warning.

Signed-off-by: Joe Perches <joe@perches.com>
---
> 在 2020年8月1日，02:05，Joe Perches <joe@perches.com> 写道：
> > ﻿On Wed, 2020-07-29 at 20:59 +0800, Cambda Zhu wrote:
> > > The checkpatch.pl only searches 3 previous lines when finding missing
> > > switch/case break, and macros are treated as normal statements. If the
> > > cases are surrounded with CONFIG, checkpatch.pl may report false
> > > warnings. For example:
> > 
> > Likely this test should be removed altogether as
> > it's never really worked well and now compilers
> > find this and emit warnings.

 scripts/checkpatch.pl | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cc5542cc234f..4aa1d9d5e62c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6541,31 +6541,6 @@ sub process {
 			}
 		}
 
-# check for case / default statements not preceded by break/fallthrough/switch
-		if ($line =~ /^.\s*(?:case\s+(?:$Ident|$Constant)\s*|default):/) {
-			my $has_break = 0;
-			my $has_statement = 0;
-			my $count = 0;
-			my $prevline = $linenr;
-			while ($prevline > 1 && ($file || $count < 3) && !$has_break) {
-				$prevline--;
-				my $rline = $rawlines[$prevline - 1];
-				my $fline = $lines[$prevline - 1];
-				last if ($fline =~ /^\@\@/);
-				next if ($fline =~ /^\-/);
-				next if ($fline =~ /^.(?:\s*(?:case\s+(?:$Ident|$Constant)[\s$;]*|default):[\s$;]*)*$/);
-				$has_break = 1 if ($rline =~ /fall[\s_-]*(through|thru)/i);
-				next if ($fline =~ /^.[\s$;]*$/);
-				$has_statement = 1;
-				$count++;
-				$has_break = 1 if ($fline =~ /\bswitch\b|\b(?:break\s*;[\s$;]*$|exit\s*\(\b|return\b|goto\b|continue\b)/);
-			}
-			if (!$has_break && $has_statement) {
-				WARN("MISSING_BREAK",
-				     "Possible switch case/default not preceded by break or fallthrough comment\n" . $herecurr);
-			}
-		}
-
 # check for /* fallthrough */ like comment, prefer fallthrough;
 		my @fallthroughs = (
 			'fallthrough',


