Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DB22DFCC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGZPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 11:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGZPCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:02:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B0E2065F;
        Sun, 26 Jul 2020 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595775767;
        bh=f3y4+0LTpamybnhtv3IjlJLojrpbCyRtRcCbDJsbJck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoDzpgFXVa63BwD6myxZjyYjnSp819WnkLpTTmaFPnG9qXuOfZcqlIbbkmIU378l2
         mnpQTke+lH6n2C5eIPSjBhuk5z2TFLZLaWQxo1p2XQUQ66k5fx8CdMEh7S5cvHr/3d
         WSI5KB9gzuFXzoEy7PtKfTJzGRxI7UI9K5OW2krg=
Date:   Sun, 26 Jul 2020 17:02:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: include: Further clean up
 function declarations
Message-ID: <20200726150244.GD452766@kroah.com>
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-3-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726142013.2891-3-aditya.jainadityajain.jain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 07:50:12PM +0530, Aditya Jain wrote:
> Cleaning up messy multiline function declarations in hal_phy_cfg.h
> 
> This patch is a continuation of patch "Clean up function declarations"

This should be merged with that patch, no reason to make it separate.

> 
> Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
> ---
>  .../staging/rtl8723bs/include/hal_phy_cfg.h   | 56 ++++++-------------
>  1 file changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> index 3cec06e9f359..2b059c9c7851 100644
> --- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> @@ -46,49 +46,25 @@ s32 PHY_MACConfig8723B(struct adapter *padapter);
>  void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
>  			 u8 RFPath, u8 Rate);
>  
> -u8
> -PHY_GetTxPowerIndex(
> -struct adapter *padapter,
> -u8 			RFPath,
> -u8 			Rate,
> -enum CHANNEL_WIDTH		BandWidth,
> -u8 			Channel
> -	);
> -
> -void
> -PHY_GetTxPowerLevel8723B(
> -struct adapter *Adapter,
> -	s32 *powerlevel
> -	);
> -
> -void
> -PHY_SetTxPowerLevel8723B(
> -struct adapter *Adapter,
> -u8 	channel
> -	);
> -
> -void
> -PHY_SetBWMode8723B(
> -struct adapter *Adapter,
> -enum CHANNEL_WIDTH			Bandwidth,	/*  20M or 40M */
> -unsigned char 			Offset		/*  Upper, Lower, or Don't care */
> -);
> +u8 PHY_GetTxPowerIndex(struct adapter *padapter, u8 RFPath, u8 Rate,
> +			enum CHANNEL_WIDTH BandWidth, u8 Channel);
> +
> +void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
> +
> +void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
>  
> -void
> -PHY_SwChnl8723B(/*  Call after initialization */
> -struct adapter *Adapter,
> -u8 channel
> -	);
> -
> -void
> -PHY_SetSwChnlBWMode8723B(
> -struct adapter *Adapter,
> -u8 			channel,
> -enum CHANNEL_WIDTH		Bandwidth,
> -u8 			Offset40,
> -u8 			Offset80
> +void PHY_SetBWMode8723B(struct adapter *Adapter,
> +			enum CHANNEL_WIDTH Bandwidth,	/*  20M or 40M */
> +			unsigned char Offset	/*  Upper, Lower, or Don't care */

Those comments should go at the top of the function declaration, in
kernel doc format.

thanks

greg k-h
