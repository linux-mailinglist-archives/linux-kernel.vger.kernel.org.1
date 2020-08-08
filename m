Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF523F859
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgHHReg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 13:34:36 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:54000 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbgHHReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 13:34:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 25F30182244FF;
        Sat,  8 Aug 2020 17:34:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:7903:9010:9025:10004:10400:10429:10430:10431:10848:11232:11658:11914:12043:12050:12219:12297:12555:12663:12740:12760:12895:12986:13069:13072:13311:13357:13439:14096:14097:14181:14659:14721:14777:19903:19997:21063:21080:21094:21323:21433:21451:21611:21627:21811:21819:30003:30022:30029:30054:30062:30070:30074:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: fifth29_370365026fca
X-Filterd-Recvd-Size: 2511
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat,  8 Aug 2020 17:34:34 +0000 (UTC)
Message-ID: <841240882e8b21aa069d8ca863a67d5d407cda30.camel@perches.com>
Subject: Re: [PATCH] mailmap: Update comments for with format and more
 detalis
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Sat, 08 Aug 2020 10:34:33 -0700
In-Reply-To: <202008080013.58EBD83@keescook>
References: <202008080013.58EBD83@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-08 at 00:14 -0700, Kees Cook wrote:
> Without having first read the git-shortlog man-page first, the format
> of .mailmap may not be immediately obvious. Add comments with pointers
> to the man-page, along with other details.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'm adding this to my earlier .mailmap update series:
> https://lore.kernel.org/lkml/20200730183702.702552-1-keescook@chromium.org/
> ---
>  .mailmap | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6c1c04a63b18..3a991e19928c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -2,11 +2,16 @@
>  # This list is used by git-shortlog

and scripts/get_maintainer.pl

Today, this list is primarily used not for
messed up email addresses.  It's mostly used
to map no longer in-use email addresses to
current email address.

>  to fix a few botched name translations
>  # in the git archive, either because the author's full name was messed up
>  # and/or not always written the same way, making contributions from the
> -# same person appearing not to be so or badly displayed.
> +# same person appearing not to be so or badly displayed. Also allows for
> +# old email addresses to map to new email addresses.
>  #
> +# For format details, see "MAPPING AUTHORS" in "man git-shortlog".
> +#
> +# Please keep this list dictionary sorted.
> +#
> +# This comment is parsed by git-shortlog:
>  # repo-abbrev: /pub/scm/linux/kernel/git/
>  #
> -
>  Aaron Durbin <adurbin@google.com>
>  Adam Oldham <oldhamca@gmail.com>
>  Adam Radford <aradford@gmail.com>
> -- 
> 2.25.1
> 
> 

