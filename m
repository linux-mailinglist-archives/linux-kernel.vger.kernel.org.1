Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668E121490F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 00:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGDWoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 18:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgGDWoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 18:44:37 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D6B208D5
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593902676;
        bh=HGgSGquftIEg+O3/L960Fq3DtgWEkOJkDhrJBDZ15I0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qphErv5n9g0GvoBYXQMXIxdFmSYJv9MRdqzYgkgOW6kCBxJuVcZ5LoAaMkQRCChIS
         cgW3VjMz/lnfDZeoerPe4KwpW7I2miJo9oO3mbgh2P/3wV1Byaei14mzz40N7AebKa
         wF+KCjp/Aa8EPSfXv+LKssogIOAOjlUwAgissddI=
Received: by mail-ej1-f43.google.com with SMTP id n26so24499496ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 15:44:36 -0700 (PDT)
X-Gm-Message-State: AOAM531nkzXiXWBFmB+KscaqX1KHt9qjGyWXB5LqfvHs7N1RImGUX5MC
        1Qq5HWEGeYJCzbRCrEjJZRcvBVUhg3DHvlwSiA==
X-Google-Smtp-Source: ABdhPJyGI56CJJUopDRfi2PrXRe3yWPzbIO1JJLs8s76xIF7oTwpZgYAInIO0RajCi/gzZAVRX1ZkGSFDc4OfwrwIMs=
X-Received: by 2002:a17:906:1044:: with SMTP id j4mr37065923ejj.187.1593902674921;
 Sat, 04 Jul 2020 15:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200519094115.2448092-1-enric.balletbo@collabora.com> <CAAOTY_-uyJiBEDNDv8OvGD6MT6jx-jiH1hM4kc6d1v9f2a525g@mail.gmail.com>
In-Reply-To: <CAAOTY_-uyJiBEDNDv8OvGD6MT6jx-jiH1hM4kc6d1v9f2a525g@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 06:44:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9TA=DVm3Bx8o6HyuPeNGH49oN2nhxYfOVkimDj9Zn1wA@mail.gmail.com>
Message-ID: <CAAOTY_9TA=DVm3Bx8o6HyuPeNGH49oN2nhxYfOVkimDj9Zn1wA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi: Remove debug messages for
 function calls
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:13=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Enric:
>
> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B45=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:41=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > Equivalent information can be nowadays obtained using function tracer
> >
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c            | 12 +-----------
> >  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  4 ----
> >  2 files changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/medi=
atek/mtk_hdmi.c
> > index b0555a7cb3b4..172d67294435 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -1634,8 +1634,6 @@ static int mtk_hdmi_audio_startup(struct device *=
dev, void *data)
> >  {
> >         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> >
> > -       dev_dbg(dev, "%s\n", __func__);
> > -
> >         mtk_hdmi_audio_enable(hdmi);
> >
> >         return 0;
> > @@ -1645,8 +1643,6 @@ static void mtk_hdmi_audio_shutdown(struct device=
 *dev, void *data)
> >  {
> >         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> >
> > -       dev_dbg(dev, "%s\n", __func__);
> > -
> >         mtk_hdmi_audio_disable(hdmi);
> >  }
> >
> > @@ -1655,8 +1651,6 @@ mtk_hdmi_audio_digital_mute(struct device *dev, v=
oid *data, bool enable)
> >  {
> >         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> >
> > -       dev_dbg(dev, "%s(%d)\n", __func__, enable);
> > -
> >         if (enable)
> >                 mtk_hdmi_hw_aud_mute(hdmi);
> >         else
> > @@ -1669,8 +1663,6 @@ static int mtk_hdmi_audio_get_eld(struct device *=
dev, void *data, uint8_t *buf,
> >  {
> >         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> >
> > -       dev_dbg(dev, "%s\n", __func__);
> > -
> >         memcpy(buf, hdmi->conn.eld, min(sizeof(hdmi->conn.eld), len));
> >
> >         return 0;
> > @@ -1770,7 +1762,6 @@ static int mtk_drm_hdmi_probe(struct platform_dev=
ice *pdev)
> >                 goto err_bridge_remove;
> >         }
> >
> > -       dev_dbg(dev, "mediatek hdmi probe success\n");
> >         return 0;
> >
> >  err_bridge_remove:
> > @@ -1793,7 +1784,7 @@ static int mtk_hdmi_suspend(struct device *dev)
> >         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> >
> >         mtk_hdmi_clk_disable_audio(hdmi);
> > -       dev_dbg(dev, "hdmi suspend success!\n");
> > +
> >         return 0;
> >  }
> >
> > @@ -1808,7 +1799,6 @@ static int mtk_hdmi_resume(struct device *dev)
> >                 return ret;
> >         }
> >
> > -       dev_dbg(dev, "hdmi resume success!\n");
> >         return 0;
> >  }
> >  #endif
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/g=
pu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > index b55f51675205..1c3575372230 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > @@ -159,8 +159,6 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
> >  {
> >         struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
> >
> > -       dev_dbg(hdmi_phy->dev, "%s\n", __func__);
> > -
> >         mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_AUTOK_=
EN);
> >         mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_PLL_POSDIV=
);
> >         mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON3, RG_HDMITX_MHLCK_EN=
);
> > @@ -178,8 +176,6 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *h=
w)
> >  {
> >         struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
> >
> > -       dev_dbg(hdmi_phy->dev, "%s\n", __func__);
> > -
> >         mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_TXDI=
V_EN);
> >         mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_BIAS=
_LPF_EN);
> >         usleep_range(100, 150);
> > --
> > 2.26.2
> >
