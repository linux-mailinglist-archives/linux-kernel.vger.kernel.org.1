Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC620435B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgFVWL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:11:27 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:48118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727018AbgFVWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:11:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F1C8B837F24C;
        Mon, 22 Jun 2020 22:11:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2731:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:4321:5007:7875:7903:9010:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:19904:19999:21080:21324:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bird05_4200e1f26e36
X-Filterd-Recvd-Size: 2763
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 22:11:24 +0000 (UTC)
Message-ID: <fe60cadc38d430f38ff8cb3d1ca9c1f44260b59d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use $root/.git when seeding camel case
From:   Joe Perches <joe@perches.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 22 Jun 2020 15:11:23 -0700
In-Reply-To: <20200622215834.2858106-1-jacob.e.keller@intel.com>
References: <20200622215834.2858106-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 14:58 -0700, Jacob Keller wrote:
> When seeding the camel case file, checkpatch.pl uses the $root directory
> in order to find the acceptable list of allowed camel case words.
> 
> However, if the current directory is a git repository, checkpatch.pl
> attempts to seed using the local git directory.
> 
> This is problematic if checkpatch.pl is passed a --root and is being run
> from within another git repository. Rather than seeding from the
> provided root tree, checkpatch.pl will seed using the local files. If
> the current git repository isn't a kernel tree, this can lead to
> unexpected warnings about camel case issues.
> 
> Always honor the $root parameter when seeding camelcase files by using
> "$root/.git" and changing directory to the $root before invoking git.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -919,8 +919,8 @@ sub seed_camelcase_includes {
>  
>  	$camelcase_seeded = 1;
>  
> -	if (-e ".git") {
> -		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
> +	if (-e "$root/.git") {
> +		my $git_last_include_commit = `cd $root && ${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
>  		chomp $git_last_include_commit;
>  		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
>  	} else {
> @@ -947,9 +947,10 @@ sub seed_camelcase_includes {
>  		return;
>  	}
>  
> -	if (-e ".git") {
> -		$files = `${git_command} ls-files "include/*.h"`;
> +	if (-e "$root/.git") {
> +		$files = `cd $root && ${git_command} ls-files "include/*.h"`;
>  		@include_files = split('\n', $files);
> +		@include_files = map("$root/$_", @include_files);
>  	}
>  
>  	foreach my $file (@include_files) {

checkpatch has 4 uses of ${git_command}

Maybe git_command should be changed instead.

I wonder how this interacts with the GIT_DIR environment variable.


