Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC56271567
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgITPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 11:34:49 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:37072 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgITPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 11:34:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 21A1818224D65;
        Sun, 20 Sep 2020 15:34:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3871:3872:3874:4321:4362:5007:7903:10004:10400:10848:11026:11232:11658:11914:12297:12555:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:21080:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: honey69_4f0ffd72713d
X-Filterd-Recvd-Size: 1750
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Sep 2020 15:34:47 +0000 (UTC)
Message-ID: <cca15cb7889f25ab010300a3e7e55dd63478c1fc.camel@perches.com>
Subject: Re: outside repository fatal error
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
Date:   Sun, 20 Sep 2020 08:34:46 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009201346560.2966@hadrien>
References: <alpine.DEB.2.22.394.2009201346560.2966@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-20 at 13:53 +0200, Julia Lawall wrote:
> The commit bcf4271d4bc3 ("checkpatch: allow not using -f with files that
> are in git") in linux-next seems to cause checkpatch to fail on a file
> containing a patch if that file is not in the directory containing the
> Linux kernel.

Thanks for the report.

> Is that intentional?

No.  It doesn't really fail, it just emits a fatal
warning from git.

I believe this makes it better by silencing the error.
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3e474072aa90..469f8e7456df 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -981,7 +981,7 @@ sub git_is_single_file {
 
 	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
 
-	my $output = `${git_command} ls-files -- $filename`;
+	my $output = `${git_command} ls-files -- $filename 2>/dev/null`;
 	my $count = $output =~ tr/\n//;
 	return $count eq 1 && $output =~ m{^${filename}$};
 }



