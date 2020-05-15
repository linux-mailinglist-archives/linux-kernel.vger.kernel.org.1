Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFC1D4DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgEOMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 08:31:13 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:49356 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbgEOMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:31:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6142F182CED5B;
        Fri, 15 May 2020 12:31:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 64,4,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2332:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3872:3874:4321:5007:6299:7903:10004:10400:10848:11026:11232:11658:11914:12296:12297:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14659:14721:21060:21067:21080:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: elbow04_7edc9eac87751
X-Filterd-Recvd-Size: 1930
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 12:31:11 +0000 (UTC)
Message-ID: <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com>
Subject: Re: get_maintainer.pl: unexpected behaviour for path/to//file
From:   Joe Perches <joe@perches.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 05:31:10 -0700
In-Reply-To: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
References: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-15 at 11:52 +0100, Emil Velikov wrote:
> Hi Joe,
> 
> Recently I've noticed that get_maintainer behaves differently if there
> is a double, sequential, forward slash in the path.
> 
> AFAICT there should be no distinction between the two. Or at least many
> existing applications and scripts consider them one and the same.
> 
> I've tried fixing this, although my perl isn't quite up-to scratch.
> Is this some weird bug or some intended feature?

Not really an intended feature.
The code counts slashes for directory depth.

I suppose it might be simpler to do this:
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6d973f3685f9..eaaf9373dbcf 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -538,6 +538,7 @@ foreach my $file (@ARGV) {
 	} elsif (!(-f $file)) {
 	    die "$P: file '${file}' not found\n";
 	}
+	$file =~ s@//@/@g;	# compress file double slashes
     }
     if ($from_filename || ($file ne "&STDIN" && vcs_file_exists($file))) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path

