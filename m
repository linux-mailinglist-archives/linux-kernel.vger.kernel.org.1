Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A62E3EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505149AbgL1OeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392125AbgL1OeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC9AA207B2;
        Mon, 28 Dec 2020 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609166004;
        bh=I7jE2I7TX/Q5cSqr3uhksj+C5kruZK3oQbMMN0vdYTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1PysX0zkEXB/sW3+NakL6CHUzPnahHsftu92tAXe3t8f8JTCr2qN5Ji5ahBOc2NZn
         RhujTxGj/zgz3AjTAE6DORux7+PfXjd4/7cZwa7C47cE60DmoMUtmVJHyeos9bRMgK
         BQWyttwj1E/N4HJWo2RTzoBLI50FfiCWf6k2pBHU=
Date:   Mon, 28 Dec 2020 15:09:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel West <daniel.west.dev@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        insafonov@gmail.com, gustavoars@kernel.org,
        andrealmeidap1996@gmail.com, linux-kernel@vger.kernel.org,
        yepeilin.cs@gmail.com
Subject: Re: [PATCH 8455/8455] staging: rtl8188eu: core: fixed a comment
 format issue.
Message-ID: <X+nnAwy/a7mZlmeL@kroah.com>
References: <20201219224312.380126-1-daniel.west.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219224312.380126-1-daniel.west.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 02:43:12PM -0800, Daniel West wrote:
> Fixed a checkpatch warning:
> 
> WARNING: Block comments use * on subsequent lines
>  #4595: FILE: drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4595:
> +/****************************************************************************
> +
> 
> The code is full of comments like this. Should the coding style
> be inforced here, even when there is a logic to the way the code
> was broken up?
> 
> Signed-off-by: Daniel West <daniel.west.dev@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 8794907a39f4..adf2788a416f 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -4591,11 +4591,10 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
>  	}
>  }
>  
> -/****************************************************************************
> -
> -Following are the functions for the timer handlers
> -
> -*****************************************************************************/
> +/*
> + *
> + *Following are the functions for the timer handlers
> + */

Does that look correct?  Make it all one line please.

thanks,

greg k-h
