Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0615A2467FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgHQOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 10:09:15 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:59942 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbgHQOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:09:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C3524100E7B46;
        Mon, 17 Aug 2020 14:09:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2687:2828:2895:3138:3139:3140:3141:3142:3167:3354:3622:3653:3865:3866:3867:3868:3871:4321:5007:6691:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:13439:14181:14659:14721:21080:21221:21451:21499:21505:21627:21990:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: light01_621803827017
X-Filterd-Recvd-Size: 3351
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 14:09:08 +0000 (UTC)
Message-ID: <12f2214fbfbea24f831461c1896b0954ca672976.camel@perches.com>
Subject: Re: [PATCH] checkpatch: get CONFIG_ prefix from the environment
From:   Joe Perches <joe@perches.com>
To:     Jerome Forissier <jerome@forissier.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Aug 2020 07:09:07 -0700
In-Reply-To: <20200817095056.31001-1-jerome@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-17 at 11:50 +0200, Jerome Forissier wrote:
> Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
> environment variable. Out-of-tree projects may therefore use Kconfig
> with a different prefix, or they may use a custom configuration tool
> which does not use the CONFIG_ prefix at all. Such projects may still
> want to adhere to the Linux kernel coding style and run checkpatch.pl.
> To make this possible, update checkpatch to use the value of $CONFIG_
> if defined or "CONFIG_" otherwise.
> 
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  scripts/checkpatch.pl | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2cbeae6d9aee..2cf750175a71 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
>  # git output parsing needs US English output, so first set backtick child process LANGUAGE
>  my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>  my $tabsize = 8;
> +my $CONFIG_ = $ENV{"CONFIG_"} || "CONFIG_";

I'm not a big fan of environment variable being
used to control program behavior.

Maybe add something to .checkpatch.conf instead.

>  sub help {
>  	my ($exitcode) = @_;
> @@ -6528,16 +6529,16 @@ sub process {
>  		}
>  
>  # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
> -		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
> +		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^$CONFIG_/) {
>  			WARN("IS_ENABLED_CONFIG",
> -			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
> +			     "IS_ENABLED($1) is normally used as IS_ENABLED($CONFIG_$1)\n" . $herecurr);
>  		}
>  
>  # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
> -		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
> +		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)($CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
>  			my $config = $1;
>  			if (WARN("PREFER_IS_ENABLED",
> -				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
> +				 "Prefer IS_ENABLED(<FOO>) to $CONFIG_<FOO> || $CONFIG_<FOO>_MODULE\n" . $herecurr) &&
>  			    $fix) {
>  				$fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
>  			}

