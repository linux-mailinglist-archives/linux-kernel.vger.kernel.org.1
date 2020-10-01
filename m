Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6701D280513
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgJARZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:25:08 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:42024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732096AbgJARZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:25:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B6BF3180A7FE4;
        Thu,  1 Oct 2020 17:25:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2560:2563:2682:2685:2828:2859:2902:2903:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:4605:5007:6119:7514:7903:7974:9010:9025:10004:10400:10848:11026:11232:11233:11473:11657:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13439:14181:14659:14721:21080:21325:21451:21627:21811:21939:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fruit04_06039822719d
X-Filterd-Recvd-Size: 3799
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 17:25:05 +0000 (UTC)
Message-ID: <c5e3b0067f32bc16f90390c51162b47f257935ac.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix multi-statement macro checks for while
 blocks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, Andy Whitcroft <apw@canonical.com>
Date:   Thu, 01 Oct 2020 10:25:04 -0700
In-Reply-To: <20201001171903.312021-1-dwaipayanray1@gmail.com>
References: <20201001171903.312021-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-01 at 22:49 +0530, Dwaipayan Ray wrote:
> Checkpatch.pl doesn't have a check for excluding while (...) {...}
> blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.
> 
> For example, running checkpatch.pl on the file mm/maccess.c in the
> kernel generates the following error:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)  \
> +       while (len >= sizeof(type)) {                                   \
> +               __get_kernel_nofault(dst, src, type, err_label);        \
> +               dst += sizeof(type);                                    \
> +               src += sizeof(type);                                    \
> +               len -= sizeof(type);                                    \
> +       }
> 
> The error is misleading for this case. Enclosing it in parentheses
> doesn't make any sense.
> 
> Checkpatch already has an exception list for such common macro types.
> Added a new exception for while (...) {...} style blocks to the same.
> 
> In addition, the brace flatten logic was modified by changing the
> substitution characters from "1" to "1u". This was done to ensure that
> macros in the form "#define foo(bar) while(bar){bar--;}" were also
> correctly procecssed.
> 
> Link: https://lore.kernel.org/linux-kernel-mentees/dc985938aa3986702815a0bd68dfca8a03c85447.camel@perches.com/
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Thanks.  Andrew, can you pick this up please?

> ---
>  scripts/checkpatch.pl | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9e65d21456f1..31624bbb342e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5299,9 +5299,9 @@ sub process {
>  			$dstat =~ s/\s*$//s;
>  
>  			# Flatten any parentheses and braces
> -			while ($dstat =~ s/\([^\(\)]*\)/1/ ||
> -			       $dstat =~ s/\{[^\{\}]*\}/1/ ||
> -			       $dstat =~ s/.\[[^\[\]]*\]/1/)
> +			while ($dstat =~ s/\([^\(\)]*\)/1u/ ||
> +			       $dstat =~ s/\{[^\{\}]*\}/1u/ ||
> +			       $dstat =~ s/.\[[^\[\]]*\]/1u/)
>  			{
>  			}
>  
> @@ -5342,6 +5342,7 @@ sub process {
>  			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
>  			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
>  			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
> +			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
>  			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
>  			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
>  			    $dstat !~ /^do\s*{/ &&					# do {...

