Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6882D3314
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLHURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:17:43 -0500
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:55884 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725910AbgLHUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:16:42 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 83FDF18015308
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 18:58:55 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2F26F181D3030;
        Tue,  8 Dec 2020 18:58:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2559:2562:2691:2692:2693:2828:2895:2908:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:6120:7903:9010:9108:10004:10400:10848:11026:11232:11658:11783:11914:12043:12297:12346:12438:12740:12895:13019:13141:13161:13215:13229:13230:13439:13894:14181:14659:14721:21080:21433:21451:21627:21939:30003:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: pull34_06175f1273e9
X-Filterd-Recvd-Size: 4582
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Dec 2020 18:58:11 +0000 (UTC)
Message-ID: <776550b7fac3870e65e903f0d8cb917dec58f7c2.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: rewrite Kconfig parsing
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Tue, 08 Dec 2020 10:58:10 -0800
In-Reply-To: <97fb4ba0-68b3-8faf-1d98-e4990b2e63e3@fau.de>
References: <a07d684c-37ea-b589-c4b1-489e88b5caa5@fau.de>
         <97fb4ba0-68b3-8faf-1d98-e4990b2e63e3@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-08 at 18:18 +0100, Nicolai Fischer wrote:
> Checkpatch currently only warns if the help text is too short.
> To determine this the diff gets parsed for keywords starting
> a new entry, but several kinds of false positives can occur with
> the current implementation, especially when the config
> is not well formatted.
> 
> This patch makes the parsing more robust and includes
> new warnings if:
> 1) the help attribute is not specified last
> 2) there is no blank line or endif before the next keyword
> 3) the help text is not indented 2 spaces more than
>    the attribute itself.
> 
> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
> ---
> 
> This patch rewrites most of the Kconfig parsing to address
> the issues mentioned in the first RFC:
> 
> 1) search for 'help' instead of '---help---'
> > I believe all the '---help---' lines have been converted to just 'help'
> > so the '(?:---)?' bits here could be removed
> 
> 2) create new warnings:
> > Perhaps it'd be better to create a new warning when the help text
> > block is not the last block of the config section.  Maybe warn when
> > a blank line or endif is not the separator to the next keyword.
> > Maybe warn when the next line after help is not indented 2 more
> > spaces than the help line.
> 
> 3) fix handling of blank lines and rely on keywords for end of help text
> > This doesn't allow blank lines for multi-paragraph help text either.
> > 
> > I think keyword parsing is necessary and some false positives are
> > inevitable as the parsing logic in a line-by-line analyzer will
> > always be incomplete.
> 
> 
> It has occurred to us, that kconfig-language.rst does not explicitly
> specify that the help text should be the last attribute, although
> this is the defacto convention. Now that checkpatch actively checks
> for this, we should probably update the documentation accordingly.

Generally process is either to update documentation along with
with a checkpatch change or to update documentation first.

Also checkpatch isn't necessarily the best tool for this.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> -# check for Kconfig help text having a real description
> +# Check if Kconfig is well formatted. Warn if help text:
> +# 1) is shorter than $min_conf_desc_length lines
> +# 2) is not specified last
> +# 3) and next keyword are not separated by a blank line or endif
> +# 4) is not indented correctly
>  # Only applies when adding the entry originally, after that we do not have
>  # sufficient context to determine whether it is indeed long enough.
>  		if ($realfile =~ /Kconfig/ &&

[]

> +				my $l = $line;
> +				$l =~ s/^$help_indent//;
> +				if ($l =~ /^(?:bool|tristate|string|hex|int|prompt|default|
> +					depends\ on|select|imply|visible\ if|range|option)\b/x) {

I think this is overly fragile.
These keywords are not required to be at the same indent as help.

Also as specified in scripts/kconfig/lexer.h, the kconfig specification
has more keywords than the list above.

In general, checkpatch does not have to be the tool of choice for
verifying everything.

For instance, checkpatch has a trivial check for MAINTAINERS entry
ordering, but there is a complete tool called parse-maintainers.pl
that verifies alphabetic section ordering.

I think most of what you seem to be attempting should be in a new
tool that completely understands Kconfig parsing.

I suggest instead of updating checkpatch, the scripts/kconfig/
content be updated to do these things.



