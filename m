Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED2224B05C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHTHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 03:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgHTHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:49:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD8062076E;
        Thu, 20 Aug 2020 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597909752;
        bh=VINLwS3DBjghohvueceeLnHG2G40JRtPDdK6W1zz2MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvHATzEchtfziuqRwibKGmT2Pe3qxv2LBDdYEhnfFaUe31O+UlnlTUzKQXX1XCWe/
         /XO9uk1XnOE8+hvmilJoLLvMedmH/mzJ3avUmH/KYhCn4u0PTc9Me7lg2GPH7gV0a2
         5sllFoN/fTZJFF2MS0DgS5AY43cjoTtJj10+cgGw=
Date:   Thu, 20 Aug 2020 09:49:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sven Schneider <s.schneider@arkona-technologies.de>
Subject: Re: [PATCH RESEND] lib/fonts: add font 6x8 for oled display
Message-ID: <20200820074932.GA3834397@kroah.com>
References: <20200820074214.30214-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820074214.30214-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:42:14AM +0200, Sascha Hauer wrote:
> From: Sven Schneider <s.schneider@arkona-technologies.de>
> 
> This font is derived from lib/fonts/font_6x10.c and is useful for small OLED
> displays.
> ---
> 

No signed-off-by: line?  :(

Always use scripts/checkpatch.pl on your patch to find stuff like this,
and other errors that this patch has.

> Hi All,
> 
> I am not sure any new fonts are desired in the kernel. If yes, please consider
> for inclusion, otherwise some "go away, there are enough fonts in the kernel
> already" would be nice as well so I can stop trying getting it in :)
> 
> Sascha
> 
>  include/linux/font.h |    4 +-
>  lib/fonts/Kconfig    |    7 +
>  lib/fonts/Makefile   |    1 +
>  lib/fonts/font_6x8.c | 2575 ++++++++++++++++++++++++++++++++++++++++++
>  lib/fonts/fonts.c    |    3 +
>  5 files changed, 2589 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 include/linux/font.h

You changed a .h file to be executable???

> diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
> index e7258d8c252b2..760f2e6893bdb 100644
> --- a/lib/fonts/fonts.c
> +++ b/lib/fonts/fonts.c
> @@ -57,6 +57,9 @@ static const struct font_desc *fonts[] = {
>  #ifdef CONFIG_FONT_TER16x32
>  	&font_ter_16x32,
>  #endif
> +#ifdef CONFIG_FONT_6x8
> +    &font_6x8,

Tabs please.

As for "do we take new fonts?", sure, why not?

thanks,

greg k-h
