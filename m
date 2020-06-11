Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7481F6447
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFKJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 05:07:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52030 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKJHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:07:36 -0400
Received: from p5b127c64.dip0.t-ipconnect.de ([91.18.124.100] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jjJBP-0006kB-00; Thu, 11 Jun 2020 11:07:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: Re: [PATCH 2/2] panfrost: Add compatible string for bifrost
Date:   Thu, 11 Jun 2020 11:07:34 +0200
Message-ID: <27448390.BSe2yKeW7e@phil>
In-Reply-To: <20200611085900.49740-2-tomeu.vizoso@collabora.com>
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com> <20200611085900.49740-2-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Juni 2020, 10:58:44 CEST schrieb Tomeu Vizoso:
> Mesa now supports some Bifrost devices, so enable it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 882fecc33fdb..8ff8e140f91e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -677,6 +677,7 @@ static const struct of_device_id dt_match[] = {
>  	{ .compatible = "arm,mali-t830", .data = &default_data, },
>  	{ .compatible = "arm,mali-t860", .data = &default_data, },
>  	{ .compatible = "arm,mali-t880", .data = &default_data, },
> +	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);

on a PX30-board (sibling of rk3326) with a 720x1280 panel and
glmark2 running all tests

Tested-by: Heiko Stuebner <heiko@sntech.de>

and as this is the generic compatible from the binding:

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


