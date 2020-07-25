Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3722D6F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGYLFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 07:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgGYLFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:05:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9B3206C1;
        Sat, 25 Jul 2020 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595675130;
        bh=7vlb1HHPpldNtaNTZpRtZTb1tg4MXxIayT7+Jy7ak/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqudBdMhr3YiRRCeXhrGK43HI2oCCVeKBYsXTf0hhHhBC5itNI9dE4Gc+OrK8GNNI
         v/Q3hg/dmQ4CFILSais2+tIlZwfIwgoMhlqSmAFTfnnxljc1WKV3fvl1dq8IMlYMCk
         8Abjk/t7W242/z0pZP4qyB43WFv5UfWjHzihRjS8=
Date:   Sat, 25 Jul 2020 13:05:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Merwin Trever Ferrao <merwintf@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Fix one coding style issue
Message-ID: <20200725110526.GA396778@kroah.com>
References: <20200725103008.7261-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725103008.7261-1-anant.thazhemadam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 04:00:03PM +0530, Anant Thazhemadam wrote:
> The coding style issue that raised an error (upon checking against
> checkpatch.pl) has been fixed.

You are not saying what issue was fixed.

Also, your subject line needs to be fixed, please see the link provided
by the bot previously for what to do.

> Exactly one coding style issue has been fixed; as required by Task 10
> of the Eudyptula Challenge.

We don't care why you are doing this work, no need to put that in the
changelog.

> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_security.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
> index 21f6652dd69f..dc22ee9c24ad 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_security.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_security.c
> @@ -718,7 +718,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  				res = _FAIL;
>  			}
>  		} else {
> -			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n",__func__));
> +			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
> +				 ("%s: stainfo==NULL!!!\n", __func__)
> +				);

Very odd line breaks, this now looks worse than before :(

thanks,

greg k-h
