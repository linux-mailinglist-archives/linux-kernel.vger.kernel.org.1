Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35E1246E08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgHQRUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 13:20:20 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:33934 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729074AbgHQQTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:19:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 29081181D3043;
        Mon, 17 Aug 2020 16:19:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 80,6,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2197:2198:2199:2200:2332:2393:2553:2559:2562:2687:2828:3138:3139:3140:3141:3142:3167:3355:3622:3653:3865:3866:3867:3868:3870:3871:3873:4250:4321:4605:5007:6691:7875:7903:8957:9121:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13439:14181:14659:14721:21080:21220:21221:21451:21499:21505:21627:30029:30054:30062:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: uncle37_070a0fc27018
X-Filterd-Recvd-Size: 3720
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 16:19:45 +0000 (UTC)
Message-ID: <6fafe0235cd6fc2da133ad5892395ba7abf10076.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add --kconfig-prefix
From:   Joe Perches <joe@perches.com>
To:     Jerome Forissier <jerome@forissier.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 17 Aug 2020 09:19:44 -0700
In-Reply-To: <20200817153320.102777-1-jerome@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
         <20200817153320.102777-1-jerome@forissier.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-17 at 17:33 +0200, Jerome Forissier wrote:
> Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
> environment variable. Out-of-tree projects may therefore use Kconfig
> with a different prefix, or they may use a custom configuration tool
> which does not use the CONFIG_ prefix at all. Such projects may still
> want to adhere to the Linux kernel coding style and run checkpatch.pl.
> To make this possible, add the --kconfig-prefix command line option.
> 
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  scripts/checkpatch.pl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> v2:
> - Use a command-line/.checkpatch.conf option instead of the _CONFIG
>   environment variable.
> - Changed the patch subject (was: "checkpatch: get CONFIG_ prefix from
>   the environment").

Seems sensible enough but I have a readability caveat with the
use of _ as the last character of the variable name.

I think all the $CONFIG_ uses should be ${CONFIG_}.

And you might want to mention the out-of-tree project in the
commit log.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
>  # git output parsing needs US English output, so first set backtick child process LANGUAGE
>  my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>  my $tabsize = 8;
> +my $CONFIG_ = "CONFIG_";
>  
>  sub help {
>  	my ($exitcode) = @_;
> @@ -127,6 +128,8 @@ Options:
>    --typedefsfile             Read additional types from this file
>    --color[=WHEN]             Use colors 'always', 'never', or only when output
>                               is a terminal ('auto'). Default is 'auto'.
> +  --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
> +                             $CONFIG_)
>    -h, --help, --version      display this help and exit
>  
>  When FILE is - read standard input.
> @@ -235,6 +238,7 @@ GetOptions(
>  	'color=s'	=> \$color,
>  	'no-color'	=> \$color,	#keep old behaviors of -nocolor
>  	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
> +	'kconfig-prefix=s'	=> \$CONFIG_,

\${CONFIG_}

>  	'h|help'	=> \$help,
>  	'version'	=> \$help
>  ) or help(1);
> @@ -6528,16 +6532,16 @@ sub process {
>  		}
>  
>  # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
> -		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
> +		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^$CONFIG_/) {
>  			WARN("IS_ENABLED_CONFIG",
> -			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
> +			     "IS_ENABLED($1) is normally used as IS_ENABLED($CONFIG_$1)\n" . $herecurr);

${CONFIG_} etc...


