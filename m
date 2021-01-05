Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604922EA521
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbhAEGDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbhAEGDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:03:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FCD2229C4;
        Tue,  5 Jan 2021 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609826570;
        bh=MwFJp67565S4WcESb+k1N1SF5psKpjSDfGOeokQMdX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEIOrjNFBP0UyE4fRLM6Td1P96BdJewfj2mlkdyugu0LMyC7qB9bk/gp11KpU52q2
         R1TlV63ok4bMwZt0d7flO3OSr1c35bt4ZEkdYvtM0dfk8lchYa8+YYY2PnWQt3ftyD
         L4K0Gdp6XQfq9beovv1NfSyuQy62W9ECsBcXzmOM=
Date:   Tue, 5 Jan 2021 07:02:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     nsaenzjulienne@suse.de, bcm-kernel-feedback-list@broadcom.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] staging: vc04_services: use DEFINE_MUTEX() for
 mutex lock
Message-ID: <X/QBBTBwz12mrQrM@kroah.com>
References: <20210105020547.19042-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105020547.19042-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 10:05:47AM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_connected.c     | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> index 79b75efa6868..938307f39b9c 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> @@ -12,15 +12,13 @@ static   int                        g_connected;
>  static   int                        g_num_deferred_callbacks;
>  static   VCHIQ_CONNECTED_CALLBACK_T g_deferred_callback[MAX_CALLBACKS];
>  static   int                        g_once_init;
> -static   struct mutex               g_connected_mutex;
> +static   DEFINE_MUTEX(g_connected_mutex);
>  
>  /* Function to initialize our lock */
>  static void connected_init(void)
>  {
> -	if (!g_once_init) {
> -		mutex_init(&g_connected_mutex);
> +	if (!g_once_init)
>  		g_once_init = 1;
> -	}

Why do you still need g_once_init now?

