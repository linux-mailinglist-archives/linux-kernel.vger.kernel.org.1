Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318F328AE32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgJLGR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:17:26 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:58742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgJLGR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:17:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 22A8D5C0;
        Mon, 12 Oct 2020 06:17:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6120:7514:10004:10400:11026:11232:11658:11914:12296:12297:12663:12679:12740:12760:12895:13019:13161:13229:13439:14181:14659:14721:21080:21221:21451:21627:21990:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: love65_0b0cd1e271f8
X-Filterd-Recvd-Size: 4046
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 06:17:24 +0000 (UTC)
Message-ID: <63053585d41ff81cdaad6cb727eb83d81207041a.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: add shebang check to EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 11 Oct 2020 23:17:23 -0700
In-Reply-To: <20201012054943.1196031-1-ujjwalkumar0501@gmail.com>
References: <20201012054943.1196031-1-ujjwalkumar0501@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-12 at 11:19 +0530, Ujjwal Kumar wrote:
> checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
> files. The script leverages filename extensions and its path in
> the repository to decide whether to allow execute permissions on
> the file or not.
> 
> Based on current check conditions, a perl script file having
> execute permissions, without '.pl' extension in its filename
> and not belonging to 'scripts/' directory is reported as ERROR
> which is a false-positive.
> 
> Adding a shebang check along with current conditions will make
> the check more generalised and improve checkpatch reports.
> To do so, without breaking the core design decision of checkpatch,
> we can fetch the first line from the patch itself and match it for
> a shebang pattern.
> 
> There can be cases where the first line is not part of the patch.

For instance: a patch that only changes permissions
without changing any of the file content.

> 
> In that case there may be a false-positive report but in the end we
> will have less false-positives as we will be handling some of the
> unhandled cases.

> Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
> ---
> Apologies, I forgot to include linux-kernel@vger.kernel.org so I'm
> now resending.
> 
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -1795,6 +1795,23 @@ sub get_stat_here {
>  	return $herectx;
>  }

First some style trivia:

> +sub get_shebang {
> +	my ($linenr, $realfile) = @_;
> +	my $rawline = "";
> +	my $shebang = "";
> +
> +	$rawline = raw_line($linenr, 3);
> +	if (defined $rawline &&
> +		$rawline =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {

alignment to open parenthesis please

> +		if (defined $1 && $1 == 1) {
> +			$shebang = raw_line($linenr, 4);
> +			$shebang = substr $shebang, 1;

parentheses around substr please.

> +		}
> +	}
> +
> +	return $shebang;
> +}

And some real notes:

$realfile isn't used in this function so there doesn't
seem to be a reason to have it as an function argument.

> +
>  sub cat_vet {
>  	my ($vet) = @_;
>  	my ($res, $coded);
> @@ -2680,7 +2697,9 @@ sub process {
>  # Check for incorrect file permissions
>  		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {

probably better here to use a capture group for the permissions

		if ($line =~ /^new (?:file )?mode (\d+)$/) {
			my $mode = substr($1, -3);

>  			my $permhere = $here . "FILE: $realfile\n";
> +			my $shebang = get_shebang($linenr, $realfile);
>  			if ($realfile !~ m@scripts/@ &&

Maybe remove the $realfile directory test as
there are many source files that are not scripts
in this directory and its subdirectories.

> +			    $shebang !~ /^#!\s*(\/\w)+.*/ &&

unnecessary capture group

and add

			   $mode =~ /[1357]/ &&

>  			    $realfile !~ /\.(py|pl|awk|sh)$/) {

No need for a a capture group here either. (existing defect)

>  				ERROR("EXECUTE_PERMISSIONS",
>  				      "do not set execute permissions for source files\n" . $permhere);



