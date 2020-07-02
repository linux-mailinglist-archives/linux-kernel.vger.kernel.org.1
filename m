Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD01211BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 08:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGBGWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 02:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgGBGWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:22:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4E6208FE;
        Thu,  2 Jul 2020 06:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593670960;
        bh=qUQS9WYY2oyPoyjWnwNnXzFofBRbxf66JWC23zR+dmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eD3QrVuRFDGGm+yneWPwxxH3MDozAE/nJv3qw1VtkUU4u1TFVfHL6nKN8bh3AFjZl
         HvxdAyLmRcyg69neowIqz7aPtdSKdO0/V3g8josGClm/nT5ueqPrM5O0s3ctiX/VIu
         3KZC5qesHo1FikB0Z2VT+rMdufrMDcRnp7gYx7Ik=
Date:   Thu, 2 Jul 2020 08:19:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: include: rtw_cmd.h: fixed a blank
 space coding style issue.
Message-ID: <20200702061942.GA935451@kroah.com>
References: <20200702045004.5wp7fnzw5pg4yov5@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702045004.5wp7fnzw5pg4yov5@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:50:04AM -0400, B K Karthik wrote:
> add blank spaces for improved code readability.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/rtl8188eu/include/rtw_cmd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/include/rtw_cmd.h b/drivers/staging/rtl8188eu/include/rtw_cmd.h
> index fa5e212fc9e0..002a797c6d0a 100644
> --- a/drivers/staging/rtl8188eu/include/rtw_cmd.h
> +++ b/drivers/staging/rtl8188eu/include/rtw_cmd.h
> @@ -115,7 +115,7 @@ struct	setopmode_parm {
>   */
> 
>  #define RTW_SSID_SCAN_AMOUNT 9 /*  for WEXT_CSCAN_AMOUNT 9 */
> -#define RTW_CHANNEL_SCAN_AMOUNT (14+37)
> +#define RTW_CHANNEL_SCAN_AMOUNT (14 + 37)
>  struct sitesurvey_parm {
>  	int scan_mode;	/* active: 1, passive: 0 */
>  	u8 ssid_num;

You sent 8 patches, some of them duplicates (I think), with no sense of
what order to apply these in.

Please resend them all as a patch series, properly numbered, so that I
have a chance to figure this out, I have dropped all of your patches
from my review queue.

thanks,

greg k-h

