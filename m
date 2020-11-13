Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8F2B233A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMSCE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Nov 2020 13:02:04 -0500
Received: from mailoutvs27.siol.net ([185.57.226.218]:52306 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgKMSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:02:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id D905E521624;
        Fri, 13 Nov 2020 19:02:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ibErSGJqCdUh; Fri, 13 Nov 2020 19:02:00 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 8A966521623;
        Fri, 13 Nov 2020 19:02:00 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id AE2D4521626;
        Fri, 13 Nov 2020 19:01:59 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wangxiongfeng2@huawei.com,
        chenzhou10@huawei.com
Subject: Re: [PATCH] drm/sun4i: dw-hdmi: fix error return code in sun8i_dw_hdmi_bind()
Date:   Fri, 13 Nov 2020 19:01:59 +0100
Message-ID: <6119042.uhm7frSX9h@jernej-laptop>
In-Reply-To: <1605186891-47282-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1605186891-47282-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for the patch.

Dne četrtek, 12. november 2020 ob 14:14:51 CET je Xiongfeng Wang napisal(a):
> Fix to return a negative error code from the error handling case instead
> of 0 in function sun8i_dw_hdmi_bind().
> 
> Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index d4c0804..f010fe8 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -208,6 +208,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct
> device *master, phy_node = of_parse_phandle(dev->of_node, "phys", 0);
>  	if (!phy_node) {
>  		dev_err(dev, "Can't found PHY phandle\n");
> +		ret = -ENODEV;

That should be EINVAL because DT node doesn't have mandatory property.

With that fixed, you can add:
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

>  		goto err_disable_clk_tmds;
>  	}




