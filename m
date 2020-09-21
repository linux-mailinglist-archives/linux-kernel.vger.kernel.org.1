Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20FB2726CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIUOR3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:17:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679BDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:17:28 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKMd5-0000fA-4c; Mon, 21 Sep 2020 16:17:19 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKMcu-0001GY-Vp; Mon, 21 Sep 2020 16:17:08 +0200
Message-ID: <339d90457a08694b24df09afa62cfa0dd185f76b.camel@pengutronix.de>
Subject: Re: [PATCH -next] drm/panfrost: simplify the return expression of
 cz_ih_hw_init()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Sep 2020 16:17:08 +0200
In-Reply-To: <20200921131019.91558-1-miaoqinglang@huawei.com>
References: <20200921131019.91558-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-21 at 21:10 +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index e68967338..ea8d31863 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -18,19 +18,13 @@
>  
>  static int panfrost_reset_init(struct panfrost_device *pfdev)
>  {
> -	int err;
> -
>  	pfdev->rstc = devm_reset_control_array_get(pfdev->dev, false, true);
>  	if (IS_ERR(pfdev->rstc)) {
>  		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
>  		return PTR_ERR(pfdev->rstc);
>  	}
>  
> -	err = reset_control_deassert(pfdev->rstc);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return reset_control_deassert(pfdev->rstc);
>  }
>  
>  static void panfrost_reset_fini(struct panfrost_device *pfdev)

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
