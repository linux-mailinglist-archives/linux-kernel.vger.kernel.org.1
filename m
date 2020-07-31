Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E68234945
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgGaQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:35:49 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:36684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728898AbgGaQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:35:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E9B06180A7FDA;
        Fri, 31 Jul 2020 16:35:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 87,8,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:247:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:2902:3138:3139:3140:3141:3142:3353:3450:3622:3865:3867:3868:3870:3871:3872:4321:4605:5007:6119:6691:7903:8957:10004:10400:10848:11232:11658:11914:12294:12297:12555:12740:12760:12895:13069:13146:13184:13229:13230:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21939:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: dogs56_551834026f85
X-Filterd-Recvd-Size: 2396
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 16:35:44 +0000 (UTC)
Message-ID: <4e30e2df7bec0fedf1a29f7825fbb4c12593eac9.camel@perches.com>
Subject: Re: [PATCH] vim: linux-kernel: Increase columns highlighting to 100+
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 09:35:42 -0700
In-Reply-To: <20200731163301.GA8004@embeddedor>
References: <20200731163301.GA8004@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-31 at 11:33 -0500, Gustavo A. R. Silva wrote:
> Increase columns highlighting to 100+ once the 80-column warning has
> been deprecated in the Linux kernel[1].
> 
> [1] commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  plugin/linuxsty.vim | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
> index 6f7e331..c42ce72 100644
> --- a/plugin/linuxsty.vim
> +++ b/plugin/linuxsty.vim
> @@ -62,7 +62,7 @@ function s:LinuxFormatting()
>      setlocal tabstop=8
>      setlocal shiftwidth=8
>      setlocal softtabstop=8
> -    setlocal textwidth=80
> +    setlocal textwidth=100

This is not a good change.
80 columns is still _preferred_.

It's just checkpatch will not emit a warning
for lines longer than 80 columns but will
for lines longer than 100 columns.

checkpatch will also not emit a warning on
file checking at all.


>      setlocal noexpandtab
>  
>      setlocal cindent
> @@ -80,7 +80,7 @@ function s:LinuxHighlighting()
>      highlight default link LinuxError ErrorMsg
>  
>      syn match LinuxError / \+\ze\t/     " spaces before tab
> -    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/ " virtual column 81 and more
> +    syn match LinuxError /\%>100v[^()\{\}\[\]<>]\+/ " virtual column 101 and more
>  
>      " Highlight trailing whitespace, unless we're in insert mode and the
>      " cursor's placed right after the whitespace. This prevents us from having

