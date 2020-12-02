Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463B62CC5FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbgLBSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:55:08 -0500
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:48634 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387828AbgLBSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:55:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BB1771800CA77;
        Wed,  2 Dec 2020 18:54:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1544:1593:1594:1605:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2693:2731:2828:2908:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:4321:4605:4641:5007:6119:6120:7514:7875:7903:8784:10004:10848:11232:11233:11658:11914:12043:12262:12295:12297:12346:12438:12555:12679:12740:12895:13095:13439:13894:13972:14096:14097:14181:14659:14721:21080:21365:21433:21451:21611:21627:21740:21939:30003:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:12,LUA_SUMMARY:none
X-HE-Tag: scarf55_4906404273b5
X-Filterd-Recvd-Size: 4847
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 18:54:25 +0000 (UTC)
Message-ID: <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: correctly detect lines of help text
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Wed, 02 Dec 2020 10:54:24 -0800
In-Reply-To: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
References: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-02 at 19:27 +0100, Nicolai Fischer wrote:
> Currently, checkpatch uses keywords to determine the end
> of a Kconfig help message which leads to false positives:
> 
> 1) if a line of the help text starts with any of the keywords, e.g. if:
> 
> +config FOO
> +	help
> +	  help text
> +	  if condition
> +	  previous line causes warning
> +	  last line.
> 
> 2) if the help attribute is not specified last, checkpatch counts
> other attributes like depends on towards the line count:
> 
> +config FOO
> +	help
> +	bool "no help message, but passes checkpatch"
> +	default n
> +	depends on SYSFS
> +	depends on MULTIUSER

Perhaps it'd be better to create a new warning when the help text
block is not the last block of the config section.  Maybe warn when
a blank line or endif is not the separator to the next keyword.
Maybe warn when the next line after help is not indented 2 more
spaces than the help line.

> This patch fixes this behavior by using the indentation to determine
> the end of the help message.

This probably won't work, see below:

> The code responsible for counting the lines of the help message
> seems overly complicated and we could rewrite it entirely
> in order to be more clear and compact if requested.

Yes please.

> This could potentially be addressed in the warning message,
> though we are happy for any input on this.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3234,6 +3234,7 @@ sub process {
>  			my $f;
>  			my $is_start = 0;
>  			my $is_end = 0;
> +			my $help_indent;
>  			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
>  				$f = $lines[$ln - 1];
>  				$cnt-- if ($lines[$ln - 1] !~ /^-/);
> @@ -3245,7 +3246,12 @@ sub process {
>  				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
>  					$is_start = 1;
>  				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {

I believe all the '---help---' lines have been converted to just 'help'
so the '(?:---)?' bits here could be removed.

See:

commit 22a4ac026c15eba961883ed8466cb341e0447de1
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed Jun 17 12:02:20 2020 +0900

    Revert "checkpatch: kconfig: prefer 'help' over '---help---'"
    
    This reverts commit 84af7a6194e493fae312a2b7fa5a3b51f76d9282.
    
    The conversion is done.
    
    Cc: Ulf Magnusson <ulfalizer@gmail.com>
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

> @@ -3253,14 +3259,13 @@ sub process {
>  				$f =~ s/^\s+//;
>  				next if ($f =~ /^$/);
>  
> 
> -				# This only checks context lines in the patch
> -				# and so hopefully shouldn't trigger false
> -				# positives, even though some of these are
> -				# common words in help texts
> -				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
> -						  if|endif|menu|endmenu|source)\b/x) {
> -					$is_end = 1;
> -					last;
> +				# Help text ends if a line has a smaller indentation
> +				# than the first line of the message
> +				if (defined $help_indent) {
> +					if ($lines[$ln - 1] !~ /^\+$help_indent\S+/) {
> +						$is_end = 1;
> +						last;
> +					}

Indentation can vary in the help blocks.  For instance:

arch/Kconfig:   help
arch/Kconfig-     Functions will have the stack-protector canary logic added in>
arch/Kconfig-     of the following conditions:
arch/Kconfig-
arch/Kconfig-     - local variable's address used as part of the right hand sid>
arch/Kconfig-       assignment or function argument
arch/Kconfig-     - local variable is an array (or union containing an array),
arch/Kconfig-       regardless of array type or length
arch/Kconfig-     - uses register local variables
arch/Kconfig-

This doesn't allow blank lines for multi-paragraph help text either.

I think keyword parsing is necessary and some false positives are
inevitable as the parsing logic in a line-by-line analyzer will
always be incomplete.


