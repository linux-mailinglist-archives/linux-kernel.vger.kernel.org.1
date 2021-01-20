Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C942FDC11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbhATVsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727422AbhATVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611177509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kjJlp6FdVA9uxAySlO3UPh/uVbynND8DNbuJI+VRNY=;
        b=Q1uwYkl/oUKyxlX+uHWs+K59lb4tbeR11Cl3TcKK3Rv+pZJWIcY539bD9WyTxjlAzjgl2P
        8jJXLzMMxWZPZrxywp/JIyr6AT5Gml8RSHcRJDa01WL6NfnIH8/onwCc27d/4PqNDUCSDx
        hoPWRvePPnLGyi8UDn0C4UJPsm8bfQU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-nMwpvT9kNXqnlwLzPa48Fw-1; Wed, 20 Jan 2021 16:18:27 -0500
X-MC-Unique: nMwpvT9kNXqnlwLzPa48Fw-1
Received: by mail-ej1-f71.google.com with SMTP id h18so4603075ejx.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kjJlp6FdVA9uxAySlO3UPh/uVbynND8DNbuJI+VRNY=;
        b=W8ntMtMCgHnJMEECEL/mOzF9o6+8bf2N3Ywz+2Uae3wfx3p56wOU5hDaxMC4uH4HcY
         xLDO2v0aysHtsukilEhgEJeCKZb6w3T559Et6blj//1gRx3trYW82I76yUV66jqlxa45
         djnX8XPGyybebMH/A6E99BgksFoO1EUDYzGOl2K1ZSHTSrqrj+mTd5GVjQRF7qi4+jww
         v61ctDVo32m4fizXAB+ZvSYTFUaYGRRf8WmHFsRJiLbtPpHw0P/G3ciVn21iS3C8M5dC
         cM9acUcsQH/oGS91f+c2MrpqWbule/1k5IkCel9qRmnNp1VeMWhJDu0uk7d6Ts28nQyS
         ZFxg==
X-Gm-Message-State: AOAM530rmkxRr19RSaK1mMnYiNzogvNLncRCh7lCXX01v4PmU6Tc71/B
        1j+Nxq2vJI5cIEpQbqsL4yo+MkGe1qavEkR7jaYKS8H4d9bx82rt+ncazY+HLnEpTviV2MNgSbR
        9ujvMb0A8DsbmUJfKlokSN1vS
X-Received: by 2002:a50:fe86:: with SMTP id d6mr8768144edt.80.1611177506319;
        Wed, 20 Jan 2021 13:18:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6HVFKfWlbDM8Gljn38zmsL6LdxfrwprLpPGtAFfdwyIkw5E06rHjWywKMI4IcPNHPG+Ju4w==
X-Received: by 2002:a50:fe86:: with SMTP id d6mr8768137edt.80.1611177506197;
        Wed, 20 Jan 2021 13:18:26 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id re19sm1331223ejb.111.2021.01.20.13.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:18:25 -0800 (PST)
Subject: Re: [PATCH] drm: Added orientation quirk for OneGX1 Pro
To:     Jared Baldridge <jrb@expunge.us>, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <41288ccb-1012-486b-81c1-a24c31850c91@www.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4810e001-9239-5798-c48d-cb59a6802d92@redhat.com>
Date:   Wed, 20 Jan 2021 22:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <41288ccb-1012-486b-81c1-a24c31850c91@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/21 9:56 PM, Jared Baldridge wrote:
> The OneGX1 Pro has a fairly unique combination of generic strings,
> but we additionally match on the BIOS date just to be safe.
> 
> Signed-off-by: Jared Baldridge <jrb@expunge.us>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will push this to drm-misc-next right away.

Regards,

Hans

> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 58f5dc2f6dd5..f6bdec7fa925 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -84,6 +84,13 @@ static const struct drm_dmi_panel_orientation_data itworks_tw891 = {
>         .orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data onegx1_pro = {
> +       .width = 1200,
> +       .height = 1920,
> +       .bios_dates = (const char * const []){ "12/17/2020", NULL },
> +       .orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
>  static const struct drm_dmi_panel_orientation_data lcd720x1280_rightside_up = {
>         .width = 720,
>         .height = 1280,
> @@ -211,6 +218,13 @@ static const struct dmi_system_id orientation_data[] = {
>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad D330-10IGM"),
>                 },
>                 .driver_data = (void *)&lcd1200x1920_rightside_up,
> +       }, {    /* OneGX1 Pro */
> +               .matches = {
> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SYSTEM_MANUFACTURER"),
> +                 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SYSTEM_PRODUCT_NAME"),
> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Default string"),
> +               },
> +               .driver_data = (void *)&onegx1_pro,
>         }, {    /* VIOS LTH17 */
>                 .matches = {
>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
> 

