Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616C4270FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgISR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 13:26:09 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:38762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgISR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 13:26:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 363F81DEB;
        Sat, 19 Sep 2020 17:26:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3872:4321:5007:7514:7576:7903:10004:10400:10848:11026:11232:11473:11658:11914:12291:12296:12297:12438:12555:12740:12760:12895:13255:13439:14181:14659:14721:21080:21221:21324:21433:21451:21627:21740:21741:21819:21990:30012:30022:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sun72_231127327135
X-Filterd-Recvd-Size: 3279
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Sep 2020 17:26:07 +0000 (UTC)
Message-ID: <ad937bba6ebd306f6e467add90cfd857bb4f2391.camel@perches.com>
Subject: Re: [PATCH] checkpatch: extend author Signed-off-by check for split
 From: header
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 19 Sep 2020 10:26:06 -0700
In-Reply-To: <20200919081225.28624-1-dwaipayanray1@gmail.com>
References: <20200919081225.28624-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-19 at 13:42 +0530, Dwaipayan Ray wrote:
> Checkpatch did not handle cases where the author From: header
> was split into two lines. The author string went empty and
> checkpatch generated a false NO_AUTHOR_SIGN_OFF warning.

It's good to provide an example where the current code
doesn't work.

It likely would be better to do this by searching forward for
any extension lines after a "^From:' rather than searching
backwards as there can be any number of extension lines.

> Support split From: headers in AUTHOR_SIGN_OFF check by adding
> an additional clause to resolve author identity in such cases.
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 504d2e431c60..86975baead22 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1210,6 +1210,16 @@ sub reformat_email {
>  	return format_email($email_name, $email_address);
>  }
>  
> +sub format_author_email {
> +	my ($email, $from) = @_;
> +
> +	$email = encode("utf8", $email) if ($from =~ /=\?utf-8\?/i);
> +	$email =~ s/"//g;
> +	$email = reformat_email($email);
> +
> +	return $email;
> +}
> +
>  sub same_email_addresses {
>  	my ($email1, $email2) = @_;
>  
> @@ -2347,6 +2357,7 @@ sub process {
>  	my $signoff = 0;
>  	my $author = '';
>  	my $authorsignoff = 0;
> +	my $prevheader = '';
>  	my $is_patch = 0;
>  	my $is_binding_patch = -1;
>  	my $in_header_lines = $file ? 0 : 1;
> @@ -2658,12 +2669,21 @@ sub process {
>  			}
>  		}
>  
> +# Check the patch for a split From:
> +		if($prevheader ne '') {
> +			if ($author eq '' && decode("MIME-Header", $prevheader) =~ /^From:\s*(.*)/) {
> +				my $email = $1.$line;
> +				$author = format_author_email($email, $prevheader);
> +			}
> +			$prevheader = '';
> +		}
> +
>  # Check the patch for a From:
>  		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> -			$author = $1;
> -			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> -			$author =~ s/"//g;
> -			$author = reformat_email($author);
> +			$author = format_author_email($1, $line);
> +			if($author eq '') {
> +				$prevheader = $line;
> +			}
>  		}
>  
>  # Check the patch for a signoff:

