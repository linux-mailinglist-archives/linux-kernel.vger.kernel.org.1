Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60828E457
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgJNQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgJNQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:25:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E06C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:25:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j8so687244ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OpuOO6D91mmbQ9GlyYetQ2VYN7QKr3fAvLutvyHptN8=;
        b=UUDfcWPeTFYlJ87g3Xdwe6UiHA7mT7G/O8FYr4Mc9M6lMK/a5ajiX/ceXjuaRFaeWW
         oKAZbcoRnTj9E967DtOFDjRHFKqXvj9PN2Gya73tJmCVpsH2115gYwyVMjGTstL4I7ge
         N863IIblMkRjkOmw+nhxXc04O7CIYjb6qc0JbAz09chwqE8RPXkfGplwwVpX5FPSHfw6
         FBn7MxrJynSIGa/qflQt/wO3fC8eJ0Fi2BuRiwbfj6JCu+5cPGFzgU7BjhwDx6A5XAMH
         5rjhbv8bVFp/leQXrVxjvTVrUC2FeEfmoKSvrXr+XevHWb9amteIaJ7Tydi9fv9v2q1D
         75tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OpuOO6D91mmbQ9GlyYetQ2VYN7QKr3fAvLutvyHptN8=;
        b=eU+qPodG6SjF9yDR9OvRy7WN+oiYnMxnKpgzB0hc1Tm9iHXJIK2kwSrZBrugeDuGUE
         uv/KWmn0lpFZpNkSoCFzy10XsGcgQruWJPxpnpC58RmfPRvBdVXv3RzeLt+Gwfu4PWuH
         2D9hXn3qEAR3GpVJKAh/5QDrfe83HsIzyEsjw93+/h6IpTxUHgWQKnn3zuUZ+Y4cHqQ6
         R6L/k/QxwLiBw8qnFP/2oapvyyXYwuC0IaGtMJfFRkUE75iiCjDjNMTPjXTjgf66N7bL
         a9dyImpti6Xp+d4S3zvfslRQFRfe8yTSZUpIfoQB/dCTopuMZCjSNnHvIUQkZVNtSz1t
         N33A==
X-Gm-Message-State: AOAM532aC1D8byC9y2gOyzZZonC3obBTPQZVW3PMTdBC9fOVj5R+2i21
        PgGBXaEfVUDnBfaCzxldRUO/2/h7tQMjAnQYKrv9QQ==
X-Google-Smtp-Source: ABdhPJy6XKdNrS2/9EHHkdStb2c3MKpSkize9amrN9N/B/qwi8cb5F2DQO0H/tJN+2k3hZ85+ZkqCjit7PQ7KBcZ4qE=
X-Received: by 2002:a92:8404:: with SMTP id l4mr4828056ild.134.1602692744338;
 Wed, 14 Oct 2020 09:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201013181924.4143303-1-fparent@baylibre.com>
 <20201013181924.4143303-2-fparent@baylibre.com> <CAAOTY__BrDVBTib1J2GHXw-ppin+_Ody6Kv93ads82ycBG725w@mail.gmail.com>
In-Reply-To: <CAAOTY__BrDVBTib1J2GHXw-ppin+_Ody6Kv93ads82ycBG725w@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 14 Oct 2020 18:25:33 +0200
Message-ID: <CAOwMV_wskn9RiWsX44xL8CFTX-3coS9+bXaJxK8y4eBBOr0z_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/mediatek: mtk_hdmi: add MT8167 support for HDMI
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On Wed, Oct 14, 2020 at 3:00 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Fabien:
>
> Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:19=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Add support for HDMI on MT8167. HDMI on MT8167 is similar to
> > MT8173/MT2701 execpt for the two registers: SYS_CFG1C and SYS_CFG20
>
> I think you should drop this series. According to Mediatek HDMI
> binding document [1], the second parameter of mediatek,syscon-hdmi is
> the register offset. I think you could set register offset to 0x800
> for mt8167.
Ok, thank you. I will try it.

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt?h=
=3Dv5.9
>
> Regards,
> Chun-Kuang.
>
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >
> > Changelog:
> > v2: fix name of pdata structure
> >
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c      | 7 +++++++
> >  drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 2 ++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/medi=
atek/mtk_hdmi.c
> > index 57370c036497..484ea9cd654a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -1835,9 +1835,16 @@ static struct mtk_hdmi_data mt8173_hdmi_driver_d=
ata =3D {
> >         .sys_cfg20 =3D HDMI_SYS_CFG20,
> >  };
> >
> > +static struct mtk_hdmi_data mt8167_hdmi_driver_data =3D {
> > +       .sys_cfg1c =3D MT8167_HDMI_SYS_CFG1C,
> > +       .sys_cfg20 =3D MT8167_HDMI_SYS_CFG20,
> > +};
> > +
> >  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
> >         { .compatible =3D "mediatek,mt8173-hdmi",
> >           .data =3D &mt8173_hdmi_driver_data },
> > +       { .compatible =3D "mediatek,mt8167-hdmi",
> > +         .data =3D &mt8167_hdmi_driver_data },
> >         {}
> >  };
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/drm=
/mediatek/mtk_hdmi_regs.h
> > index 2050ba45b23a..a0f9c367d7aa 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> > @@ -195,6 +195,7 @@
> >  #define GEN_RGB                                (0 << 7)
> >
> >  #define HDMI_SYS_CFG1C         0x000
> > +#define MT8167_HDMI_SYS_CFG1C  0x800
> >  #define HDMI_ON                                BIT(0)
> >  #define HDMI_RST                       BIT(1)
> >  #define ANLG_ON                                BIT(2)
> > @@ -211,6 +212,7 @@
> >  #define HTPLG_PIN_SEL_OFF              BIT(30)
> >  #define AES_EFUSE_ENABLE               BIT(31)
> >  #define HDMI_SYS_CFG20         0x004
> > +#define MT8167_HDMI_SYS_CFG20  0x804
> >  #define DEEP_COLOR_MODE_MASK           (3 << 1)
> >  #define COLOR_8BIT_MODE                        (0 << 1)
> >  #define COLOR_10BIT_MODE               (1 << 1)
> > --
> > 2.28.0
> >
