Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770B21A6C15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgDMShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 14:37:55 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:60034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgDMShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:37:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A0AFA1803A578;
        Mon, 13 Apr 2020 18:37:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2894:2911:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:4321:4425:5007:6119:7576:7903:10004:10400:11232:11658:11914:12048:12050:12297:12555:12663:12679:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bit72_a7e9b323bd4e
X-Filterd-Recvd-Size: 2199
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 18:37:51 +0000 (UTC)
Message-ID: <7e51e6c66c87bc6e466d688fa13ab75213706a06.camel@perches.com>
Subject: Re: [RESEND PATCH] MAINTAINERS: add an entry for kfifo
From:   Joe Perches <joe@perches.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 13 Apr 2020 11:35:44 -0700
In-Reply-To: <20200413104250.26683-1-brgl@bgdev.pl>
References: <20200413104250.26683-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 12:42 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Kfifo has been written by Stefani Seibold and she's implicitly expected to
> Ack any changes to it.  She's not however officially listed as kfifo
> maintainer which leads to delays in patch review.  This patch proposes to
> add an explicit entry for kfifo to MAINTAINERS file.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> I'm not sure why this patch hasn't made it into v5.7 - it's been in next
> for weeks now. :(
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..f0f30b2cafa4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9412,6 +9412,13 @@ F:	include/linux/keyctl.h
>  F:	include/uapi/linux/keyctl.h
>  F:	security/keys/
>  
> +KFIFO
> +M:	Stefani Seibold <stefani@seibold.net>
> +S:	Maintained
> +F:	lib/kfifo.c
> +F:	include/linux/kfifo.h
> +F:	samples/kfifo/
> +

trivia:

F: entries are now all sorted alphabetically.

Maybe switch the include and lib entries?



