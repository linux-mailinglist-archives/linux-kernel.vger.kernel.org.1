Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210D028E0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgJNNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgJNNAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:00:12 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D3E2173E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602680411;
        bh=EjQyMXBgmkGopUQIOpSQ0qJ6aFXvAlg6I7g92NkSgMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fLBWb4iDrpBUKe6rxTTtf70Eda3+Q02E2x6UnykIAPRRGz17bipaL0LMokMsx7Hsn
         XSss2EcKy7Wg9vQcmOrQPyfZJj6y+jF9GSwl8qWWWzNNfZBONfVakXBt1e7ETe7WZK
         klZDLKm6mkfNyobaMG16UmAXDuZBsz5C46GdbmMs=
Received: by mail-ed1-f50.google.com with SMTP id p13so3014712edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:00:10 -0700 (PDT)
X-Gm-Message-State: AOAM532sbmVQyygcsbsE+MIKaLiHoJW7CK3aZR6cCmzCw0lN2vjFfVwL
        8S9mU0SZ+3wJLiZsBr85oWRIE+W2YnDi33ETjQ==
X-Google-Smtp-Source: ABdhPJx3leXWo1y/6rJJ+KAWg7Fbkc30MfGqk8ihqIGPrl/962tukEUoCc8WEJHlE62caGzULO47VlzVmHwMP2PHfsk=
X-Received: by 2002:aa7:c3ca:: with SMTP id l10mr5129675edr.72.1602680409031;
 Wed, 14 Oct 2020 06:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201013181924.4143303-1-fparent@baylibre.com> <20201013181924.4143303-2-fparent@baylibre.com>
In-Reply-To: <20201013181924.4143303-2-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 14 Oct 2020 20:59:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY__BrDVBTib1J2GHXw-ppin+_Ody6Kv93ads82ycBG725w@mail.gmail.com>
Message-ID: <CAAOTY__BrDVBTib1J2GHXw-ppin+_Ody6Kv93ads82ycBG725w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/mediatek: mtk_hdmi: add MT8167 support for HDMI
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:19=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add support for HDMI on MT8167. HDMI on MT8167 is similar to
> MT8173/MT2701 execpt for the two registers: SYS_CFG1C and SYS_CFG20

I think you should drop this series. According to Mediatek HDMI
binding document [1], the second parameter of mediatek,syscon-hdmi is
the register offset. I think you could set register offset to 0x800
for mt8167.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt?h=3Dv=
5.9

Regards,
Chun-Kuang.

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> Changelog:
> v2: fix name of pdata structure
>
>  drivers/gpu/drm/mediatek/mtk_hdmi.c      | 7 +++++++
>  drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 57370c036497..484ea9cd654a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1835,9 +1835,16 @@ static struct mtk_hdmi_data mt8173_hdmi_driver_dat=
a =3D {
>         .sys_cfg20 =3D HDMI_SYS_CFG20,
>  };
>
> +static struct mtk_hdmi_data mt8167_hdmi_driver_data =3D {
> +       .sys_cfg1c =3D MT8167_HDMI_SYS_CFG1C,
> +       .sys_cfg20 =3D MT8167_HDMI_SYS_CFG20,
> +};
> +
>  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
>         { .compatible =3D "mediatek,mt8173-hdmi",
>           .data =3D &mt8173_hdmi_driver_data },
> +       { .compatible =3D "mediatek,mt8167-hdmi",
> +         .data =3D &mt8167_hdmi_driver_data },
>         {}
>  };
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/drm/m=
ediatek/mtk_hdmi_regs.h
> index 2050ba45b23a..a0f9c367d7aa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> @@ -195,6 +195,7 @@
>  #define GEN_RGB                                (0 << 7)
>
>  #define HDMI_SYS_CFG1C         0x000
> +#define MT8167_HDMI_SYS_CFG1C  0x800
>  #define HDMI_ON                                BIT(0)
>  #define HDMI_RST                       BIT(1)
>  #define ANLG_ON                                BIT(2)
> @@ -211,6 +212,7 @@
>  #define HTPLG_PIN_SEL_OFF              BIT(30)
>  #define AES_EFUSE_ENABLE               BIT(31)
>  #define HDMI_SYS_CFG20         0x004
> +#define MT8167_HDMI_SYS_CFG20  0x804
>  #define DEEP_COLOR_MODE_MASK           (3 << 1)
>  #define COLOR_8BIT_MODE                        (0 << 1)
>  #define COLOR_10BIT_MODE               (1 << 1)
> --
> 2.28.0
>
