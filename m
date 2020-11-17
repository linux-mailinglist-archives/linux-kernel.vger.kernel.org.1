Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624D2B5B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKQIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:54:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:54:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so22286913wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJNDblWPfJcMPax/ShMWRSk4LiBhCAShu7n9VV+CwDc=;
        b=0vmNgY5u5213uHwl7B14l+StQ5XzMnrHfXxRrSq1r/p8/7tlxAzVinkznyomQDeJ45
         C9nzOq4bWFT94lwK0SQWqW34+Lg8Rp+YSgaf9zIDnRkev9zjyMie8WT5Wl2h8caMv4k7
         7IA/t04+utCPHQPpHjSW8Qz5BVb9HQONYQBf+Zxro2cy9L2wTUp2o6XC3LTpvwvHHQq6
         tj6tfWgoq88g4QRYh+xfJu2ZCp2y7/7qcILNFjzeaWgMAA7MyW+NaL8pa0vx/uhhI9CP
         olMWe7HsJBgykSfczk3czTVPXh+v0F8MW7SmE+UJ0QBAjJoSsSP6zwzwNdrEEScGL3vd
         10wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SJNDblWPfJcMPax/ShMWRSk4LiBhCAShu7n9VV+CwDc=;
        b=L3fVxWwsYJ9bP13vIvtSn8HsEGVaccqXIB9rYRzpXorsFtHjxVgE+8H3cWQL59z4gR
         Nsg/MwLOeXHQEgcNDjcbqguDI51W50+1i59J5JCAGnuEw6AGgLaXIzQ/RVqf2XSL+Q58
         U1SzuDtzvaDuBCYBSg5OZh7xcKpsDZ6cZR2l/nYpFRjM6tmRzV5vSiPglp10Hk/q0sR4
         DvQkLZeJTeRsx0+zZ3X3Wd9xDqu/MG0hOFYTOfkgd/YHIBhcLfTOLvvAFg2LQUk7HAYc
         85UqJ8eQFAuOdNceZd0XaxWkTWlXbyuewA09Xiar7Iq+Ypj7xTVKKqKkvzmRg4RV1hss
         tL/w==
X-Gm-Message-State: AOAM5302ipKZCjZMqT4jHBVs1Tv6HD3H3luCBP2rwIkkcTuawV36FaG7
        jdZj5M1DAfZnd2RYttWuABAc00gFlK7ej6WD
X-Google-Smtp-Source: ABdhPJyLqMtL4fV2UrcN1zMaWmEWQktfKi57GbleZ4Ka+DZs/x+qF2LiShGJsNaZGLEEx2wAcv6+2w==
X-Received: by 2002:adf:e551:: with SMTP id z17mr24210995wrm.374.1605603242019;
        Tue, 17 Nov 2020 00:54:02 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26? ([2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26])
        by smtp.gmail.com with ESMTPSA id g23sm2561986wmh.21.2020.11.17.00.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 00:54:01 -0800 (PST)
Subject: Re: [PATCH 2/4] drm/meson: Unbind all connectors on module removal
To:     Marc Zyngier <maz@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201116200744.495826-1-maz@kernel.org>
 <20201116200744.495826-3-maz@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <56a8ea19-fb89-8430-032d-774c89a66ae7@baylibre.com>
Date:   Tue, 17 Nov 2020 09:53:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116200744.495826-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 21:07, Marc Zyngier wrote:
> Removing the meson DRM module results in the following splats:
> 
> [   42.689228] WARNING: CPU: 0 PID: 572 at drivers/gpu/drm/drm_irq.c:192 drm_irq_uninstall+0x130/0x160 [drm]
> [...]
> [   42.812820] Hardware name:  , BIOS 2021.01-rc2-00012-gde865f7ee1 11/16/2020
> [   42.819723] pstate: 80400089 (Nzcv daIf +PAN -UAO -TCO BTYPE=--)
> [   42.825737] pc : drm_irq_uninstall+0x130/0x160 [drm]
> [   42.830647] lr : drm_irq_uninstall+0xc4/0x160 [drm]
> [...]
> [   42.917614] Call trace:
> [   42.920086]  drm_irq_uninstall+0x130/0x160 [drm]
> [   42.924612]  meson_drv_unbind+0x68/0xa4 [meson_drm]
> [   42.929436]  component_del+0xc0/0x180
> [   42.933058]  meson_dw_hdmi_remove+0x28/0x40 [meson_dw_hdmi]
> [   42.938576]  platform_drv_remove+0x38/0x60
> [   42.942628]  __device_release_driver+0x190/0x23c
> [   42.947198]  driver_detach+0xcc/0x160
> [   42.950822]  bus_remove_driver+0x68/0xe0
> [   42.954702]  driver_unregister+0x3c/0x6c
> [   42.958583]  platform_driver_unregister+0x20/0x2c
> [   42.963243]  meson_dw_hdmi_platform_driver_exit+0x18/0x4a8 [meson_dw_hdmi]
> [   42.970057]  __arm64_sys_delete_module+0x1bc/0x294
> [   42.974801]  el0_svc_common.constprop.0+0x80/0x240
> [   42.979542]  do_el0_svc+0x30/0xa0
> [   42.982821]  el0_svc+0x18/0x50
> [   42.985839]  el0_sync_handler+0x198/0x404
> [   42.989806]  el0_sync+0x158/0x180
> 
> immediatelly followed by
> 
> [   43.002296] WARNING: CPU: 0 PID: 572 at drivers/gpu/drm/drm_mode_config.c:504 drm_mode_config_cleanup+0x2a8/0x304 [drm]
> [...]
> [   43.128150] Hardware name:  , BIOS 2021.01-rc2-00012-gde865f7ee1 11/16/2020
> [   43.135052] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> [   43.141062] pc : drm_mode_config_cleanup+0x2a8/0x304 [drm]
> [   43.146492] lr : drm_mode_config_cleanup+0xac/0x304 [drm]
> [...]
> [   43.233979] Call trace:
> [   43.236451]  drm_mode_config_cleanup+0x2a8/0x304 [drm]
> [   43.241538]  drm_mode_config_init_release+0x1c/0x2c [drm]
> [   43.246886]  drm_managed_release+0xa8/0x120 [drm]
> [   43.251543]  drm_dev_put+0x94/0xc0 [drm]
> [   43.255380]  meson_drv_unbind+0x78/0xa4 [meson_drm]
> [   43.260204]  component_del+0xc0/0x180
> [   43.263829]  meson_dw_hdmi_remove+0x28/0x40 [meson_dw_hdmi]
> [   43.269344]  platform_drv_remove+0x38/0x60
> [   43.273398]  __device_release_driver+0x190/0x23c
> [   43.277967]  driver_detach+0xcc/0x160
> [   43.281590]  bus_remove_driver+0x68/0xe0
> [   43.285471]  driver_unregister+0x3c/0x6c
> [   43.289352]  platform_driver_unregister+0x20/0x2c
> [   43.294011]  meson_dw_hdmi_platform_driver_exit+0x18/0x4a8 [meson_dw_hdmi]
> [   43.300826]  __arm64_sys_delete_module+0x1bc/0x294
> [   43.305570]  el0_svc_common.constprop.0+0x80/0x240
> [   43.310312]  do_el0_svc+0x30/0xa0
> [   43.313590]  el0_svc+0x18/0x50
> [   43.316608]  el0_sync_handler+0x198/0x404
> [   43.320574]  el0_sync+0x158/0x180
> [   43.323852] ---[ end trace d796a3072dab01da ]---
> [   43.328561] [drm:drm_mode_config_cleanup [drm]] *ERROR* connector HDMI-A-1 leaked!
> 
> both triggered by the fact that the HDMI subsystem is still active,
> and the DRM removal doesn't result in the connectors being torn down.
> 
> Call drm_atomic_helper_shutdown() and component_unbind_all() to safely
> tear the module down.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Fixes: 2d8f92897ad8 ("drm/meson: Uninstall IRQ handler")

> ---
>  drivers/gpu/drm/meson/meson_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 324fa489f1c4..3d1de9cbb1c8 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -390,8 +390,10 @@ static void meson_drv_unbind(struct device *dev)
>  	}
>  
>  	drm_dev_unregister(drm);
> -	drm_irq_uninstall(drm);
>  	drm_kms_helper_poll_fini(drm);
> +	drm_atomic_helper_shutdown(drm);
> +	component_unbind_all(dev, drm);
> +	drm_irq_uninstall(drm);
>  	drm_dev_put(drm);
>  
>  	if (priv->afbcd.ops) {
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
