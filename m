Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045F81BBD93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD1M1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 08:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgD1M1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:27:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91611206A1;
        Tue, 28 Apr 2020 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588076859;
        bh=BeIUDCXaNXk1/Yn8iTjQgqj/5yEqrbdPmtej63GXm1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHRuYQheEnBePJ+i2yQhOYn6qiYFasj9ywN29ygmR8phOQrrEtSK97c+65r6dgsUc
         Jm63dEhk46Heqde1AxRHmuiePxa4PxRj293F2Wy1V0RSTuPLfUPiSYObnyewrGzoBP
         lJguJJ9QcgbvyHLoyGpcuNymJ9x5WfMHT6a4mavA=
Date:   Tue, 28 Apr 2020 14:27:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     wambui.karugax@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 1/7] staging: rtl8723bs: os_dep: remove set but not used
 'uintRet'
Message-ID: <20200428122736.GA1253850@kroah.com>
References: <20200427032342.27211-1-yanaijie@huawei.com>
 <20200427032342.27211-2-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427032342.27211-2-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:23:36AM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2564:22: warning:
> variable ‘uintRet’ set but not used [-Wunused-but-set-variable]
>          unsigned int uintRet = 0;
>                       ^~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 5059b874080e..902ac8169948 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -2561,14 +2561,16 @@ static int rtw_wps_start(struct net_device *dev,
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct iw_point *pdata = &wrqu->data;
>  	u32   u32wps_start = 0;
> -        unsigned int uintRet = 0;
>  
>  	if ((true == padapter->bDriverStopped) || (true == padapter->bSurpriseRemoved) || (NULL == pdata)) {
>  		ret = -EINVAL;
>  		goto exit;
>  	}
>  
> -	uintRet = copy_from_user((void *)&u32wps_start, pdata->pointer, 4);
> +	if (copy_from_user((void *)&u32wps_start, pdata->pointer, 4)) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}

This also fixes the issue of copy_from_user not being checked, nice!

greg k-h
