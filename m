Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68FC28E4C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbgJNQri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbgJNQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:47:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046C3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:47:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so6073008ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+iJ8voxUfch6P7wdEAm2+D41sOm6IW7HJo1t/j7JMv8=;
        b=ssyOmFkX4SKgdjYHndfa4OBDZjnWFp5tCczf6RLNExa7dhzGxFxhOWADqXVpauAMTv
         T/s2ry2iCyF2FuWHVXebCqmQsO5DBx49noshXeombaMyQz25iMN5RQtJ13tKZsWVcRle
         sEs/ZA/akUA/kkrCHd9dcmNoyDCXm5c968+ivVaofB80fHWWZj8lgNZvheMIjhEur2nt
         XaPDT5v+qA1qRPBh1fOoMJq7lpu8i1yPoBjZ33ZHg5CoAdtUfYJzf/m23wjl3suq5kSN
         lyoRNS+rPlSkO4tQzPxmHHleyhkktRh1Yok2ieH5OMVb4JAmSaxqTLCl1QrXJCPXpSjW
         SshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+iJ8voxUfch6P7wdEAm2+D41sOm6IW7HJo1t/j7JMv8=;
        b=VqII+daBfhJBbQR+U/2J2SnCbowcSIXaqmlEixkgqnLtYavc5y0XIz0BY4V1CA6TLB
         OCdTTFzqRKA7VilDvZJrUjOpEyoMYmUbrUrFgm6w7wlPhkt79QNfKqfkRmHqxr8TLKG9
         tzXl65DAFZjkZM7KmgsAAl57SF7D+xF7jS2GHswDHXeXtZukNTJ/kVUvs07rTGGRCJhy
         jQf5iq79ySfPT/sOzoatAy2mHOQr8zwa7+4cmbgNecA/5dL2yhj0JrQKZuuDL8xxkRB4
         qJ3WnKQvrwPhz2nG1lHrpsTEKJXKRyTVi7hJfFlK2f7kJBnNV6kHsBS8G1IN1wYoOvap
         EmuA==
X-Gm-Message-State: AOAM532+/mz+/lTSvYbSCmhzokc5Wm26mHTIuXGhAwQ4BhhtAiUIKmKT
        dLqa1N6tAHsjBLqZ9bH6n+uiH5GwbyCp7Sf8bB10kg==
X-Google-Smtp-Source: ABdhPJy9vgAGYpXdpv0uf2hp1SXdndgC51mZLSAjGXH1Gg6X3SROo0oXi4LSM/YqHR5iN6uSqOAlNay7qymDiLUx49c=
X-Received: by 2002:a92:c5af:: with SMTP id r15mr41169ilt.88.1602694053274;
 Wed, 14 Oct 2020 09:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201013181924.4143303-1-fparent@baylibre.com>
 <20201013181924.4143303-2-fparent@baylibre.com> <CAAOTY__BrDVBTib1J2GHXw-ppin+_Ody6Kv93ads82ycBG725w@mail.gmail.com>
 <CAOwMV_wskn9RiWsX44xL8CFTX-3coS9+bXaJxK8y4eBBOr0z_Q@mail.gmail.com>
In-Reply-To: <CAOwMV_wskn9RiWsX44xL8CFTX-3coS9+bXaJxK8y4eBBOr0z_Q@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 14 Oct 2020 18:47:22 +0200
Message-ID: <CAOwMV_wpsh=c0r7U-FM6ffz_Sq3HD9PJKoDv+auyhV2ER8_pVA@mail.gmail.com>
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

On Wed, Oct 14, 2020 at 6:25 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Hi Chun-Kuang,
>
> On Wed, Oct 14, 2020 at 3:00 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> w=
rote:
> >
> > Hi, Fabien:
> >
> > Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=88=
14=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > Add support for HDMI on MT8167. HDMI on MT8167 is similar to
> > > MT8173/MT2701 execpt for the two registers: SYS_CFG1C and SYS_CFG20
> >
> > I think you should drop this series. According to Mediatek HDMI
> > binding document [1], the second parameter of mediatek,syscon-hdmi is
> > the register offset. I think you could set register offset to 0x800
> > for mt8167.
> Ok, thank you. I will try it.

Thanks, it works. Dropping this series.

>
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt?h=
=3Dv5.9
> >
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > ---
> > >
> > > Changelog:
> > > v2: fix name of pdata structure
> > >
> > >  drivers/gpu/drm/mediatek/mtk_hdmi.c      | 7 +++++++
> > >  drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 2 ++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/me=
diatek/mtk_hdmi.c
> > > index 57370c036497..484ea9cd654a 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > @@ -1835,9 +1835,16 @@ static struct mtk_hdmi_data mt8173_hdmi_driver=
_data =3D {
> > >         .sys_cfg20 =3D HDMI_SYS_CFG20,
> > >  };
> > >
> > > +static struct mtk_hdmi_data mt8167_hdmi_driver_data =3D {
> > > +       .sys_cfg1c =3D MT8167_HDMI_SYS_CFG1C,
> > > +       .sys_cfg20 =3D MT8167_HDMI_SYS_CFG20,
> > > +};
> > > +
> > >  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
> > >         { .compatible =3D "mediatek,mt8173-hdmi",
> > >           .data =3D &mt8173_hdmi_driver_data },
> > > +       { .compatible =3D "mediatek,mt8167-hdmi",
> > > +         .data =3D &mt8167_hdmi_driver_data },
> > >         {}
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/d=
rm/mediatek/mtk_hdmi_regs.h
> > > index 2050ba45b23a..a0f9c367d7aa 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> > > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> > > @@ -195,6 +195,7 @@
> > >  #define GEN_RGB                                (0 << 7)
> > >
> > >  #define HDMI_SYS_CFG1C         0x000
> > > +#define MT8167_HDMI_SYS_CFG1C  0x800
> > >  #define HDMI_ON                                BIT(0)
> > >  #define HDMI_RST                       BIT(1)
> > >  #define ANLG_ON                                BIT(2)
> > > @@ -211,6 +212,7 @@
> > >  #define HTPLG_PIN_SEL_OFF              BIT(30)
> > >  #define AES_EFUSE_ENABLE               BIT(31)
> > >  #define HDMI_SYS_CFG20         0x004
> > > +#define MT8167_HDMI_SYS_CFG20  0x804
> > >  #define DEEP_COLOR_MODE_MASK           (3 << 1)
> > >  #define COLOR_8BIT_MODE                        (0 << 1)
> > >  #define COLOR_10BIT_MODE               (1 << 1)
> > > --
> > > 2.28.0
> > >
