Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107BC2E3EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505128AbgL1Od4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392119AbgL1Odm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:33:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93BA4225AB;
        Mon, 28 Dec 2020 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609166007;
        bh=jVzPh64KOHpk2wtB0i1401+raWRvFMw+qX6VfNWNKVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsrNpcHBGtIt0x6DWFK8BlEvhp9YsDF5iDFpZ5i1B6moNuprAIC7kVq/ZpfewLdrE
         sOi5bEqN/F1siFzTQECaRyUZvdWd/L1ITXxFjRsuxLWhe4A0TialonZ2CmqUdd6KIJ
         gLAkTIUQnY0z1Uua5VRPWYehfhJ4Nfvz2j19Z9v0=
Date:   Mon, 28 Dec 2020 15:11:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, devel@driverdev.osuosl.org,
        Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] staging: rtl8192u: Add null check in
 rtl8192_usb_initendpoints
Message-ID: <X+nngl0/JxETbSjT@kroah.com>
References: <20201226080258.6576-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226080258.6576-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 04:02:56PM +0800, Dinghao Liu wrote:
> There is an allocation for priv->rx_urb[16] has no null check,
> which may lead to a null pointer dereference.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 93676af98629..9fc4adc83d77 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1608,6 +1608,8 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>  		void *oldaddr, *newaddr;
>  
>  		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!priv->rx_urb[16])
> +			return -ENOMEM;
>  		priv->oldaddr = kmalloc(16, GFP_KERNEL);
>  		if (!priv->oldaddr)
>  			return -ENOMEM;

There is a bug here, where the memory is not freed from the alloc urb
call, right?

Anyway, something to fix up in a leter patch, thanks.

greg k-h
