Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB65C2AA8F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgKHC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 21:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgKHC6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 21:58:31 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDE420874
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 02:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604804310;
        bh=sfNhlZT9sWHAz6wHIE60Y0IGc1gStzzQXPPJyfeVaW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CTT6UkXx7QGP/1Jmi662ReTj0HRqe+ezsLZcpO4VHPY4kUGfY2IP9tOFksIRpUdY/
         ayDtplGACaNEfHObQJOX1oTGFf+NuBOIMobhR40a2hHbLTkpqzacEx/p+6oUjOLOOm
         nKwtPG+a0uJoPo+4YzDifnHTdEjmcfPLYEUSQPN8=
Received: by mail-ej1-f47.google.com with SMTP id o21so7406168ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 18:58:30 -0800 (PST)
X-Gm-Message-State: AOAM530zweDHbWGyLIm65fBOui5eDWfgmoWaf4MOppHQmJj3GJ+g6c8D
        5utrNpETlcMvvxyiRiRB9hfYlZwPktycSiZx/Q==
X-Google-Smtp-Source: ABdhPJxqh/Z+g8ZrVqGhyRSVVYKdQJY+9PddAI8gePCHww4scCiVWGrObsDxgbjea1CTpdbkGoNKkI2KltEkViR5CME=
X-Received: by 2002:a17:906:cc4f:: with SMTP id mm15mr9063951ejb.267.1604804309188;
 Sat, 07 Nov 2020 18:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20201013085512.12857-1-bernard@vivo.com> <CAAOTY__r-2aQLK+oy6uRFnu3xExngBYrSAQ7jCfhWx+Ti0UgFw@mail.gmail.com>
In-Reply-To: <CAAOTY__r-2aQLK+oy6uRFnu3xExngBYrSAQ7jCfhWx+Ti0UgFw@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 8 Nov 2020 10:58:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-EgZuxG=6J2WgO7awAcOePXuH8a6_rHENM7C45m-H7ew@mail.gmail.com>
Message-ID: <CAAOTY_-EgZuxG=6J2WgO7awAcOePXuH8a6_rHENM7C45m-H7ew@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Optimize functions which do not need to return
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bernard:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Bernard Zhao <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:55=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Function mtk_hdmi_aud_set_input always return 0, no need to
> > keep the return value. Functions mtk_hdmi_aud_enable_packet &
> > mtk_hdmi_aud_on_off_hw_ncts are the same, these two functions
> > just call next functions. Maybe it`s a bit better to just call
> > the inner function.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c | 27 +++++++--------------------
> >  1 file changed, 7 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/medi=
atek/mtk_hdmi.c
> > index a97725680d4e..f1d987df0550 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -870,19 +870,8 @@ static void mtk_hdmi_video_set_display_mode(struct=
 mtk_hdmi *hdmi,
> >         mtk_hdmi_hw_msic_setting(hdmi, mode);
> >  }
> >
> > -static int mtk_hdmi_aud_enable_packet(struct mtk_hdmi *hdmi, bool enab=
le)
> > -{
> > -       mtk_hdmi_hw_send_aud_packet(hdmi, enable);
> > -       return 0;
> > -}
> >
> > -static int mtk_hdmi_aud_on_off_hw_ncts(struct mtk_hdmi *hdmi, bool on)
> > -{
> > -       mtk_hdmi_hw_ncts_enable(hdmi, on);
> > -       return 0;
> > -}
> > -
> > -static int mtk_hdmi_aud_set_input(struct mtk_hdmi *hdmi)
> > +static void mtk_hdmi_aud_set_input(struct mtk_hdmi *hdmi)
> >  {
> >         enum hdmi_aud_channel_type chan_type;
> >         u8 chan_count;
> > @@ -912,8 +901,6 @@ static int mtk_hdmi_aud_set_input(struct mtk_hdmi *=
hdmi)
> >         chan_count =3D mtk_hdmi_aud_get_chnl_count(chan_type);
> >         mtk_hdmi_hw_aud_set_i2s_chan_num(hdmi, chan_type, chan_count);
> >         mtk_hdmi_hw_aud_set_input_type(hdmi, hdmi->aud_param.aud_input_=
type);
> > -
> > -       return 0;
> >  }
> >
> >  static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hdmi,
> > @@ -921,7 +908,7 @@ static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hd=
mi,
> >  {
> >         unsigned int sample_rate =3D hdmi->aud_param.codec_params.sampl=
e_rate;
> >
> > -       mtk_hdmi_aud_on_off_hw_ncts(hdmi, false);
> > +       mtk_hdmi_hw_ncts_enable(hdmi, false);
> >         mtk_hdmi_hw_aud_src_disable(hdmi);
> >         mtk_hdmi_clear_bits(hdmi, GRL_CFG2, CFG2_ACLK_INV);
> >
> > @@ -959,7 +946,7 @@ static int mtk_hdmi_aud_output_config(struct mtk_hd=
mi *hdmi,
> >                                       struct drm_display_mode *display_=
mode)
> >  {
> >         mtk_hdmi_hw_aud_mute(hdmi);
> > -       mtk_hdmi_aud_enable_packet(hdmi, false);
> > +       mtk_hdmi_hw_send_aud_packet(hdmi, false);
> >
> >         mtk_hdmi_aud_set_input(hdmi);
> >         mtk_hdmi_aud_set_src(hdmi, display_mode);
> > @@ -968,8 +955,8 @@ static int mtk_hdmi_aud_output_config(struct mtk_hd=
mi *hdmi,
> >
> >         usleep_range(50, 100);
> >
> > -       mtk_hdmi_aud_on_off_hw_ncts(hdmi, true);
> > -       mtk_hdmi_aud_enable_packet(hdmi, true);
> > +       mtk_hdmi_hw_ncts_enable(hdmi, true);
> > +       mtk_hdmi_hw_send_aud_packet(hdmi, true);
> >         mtk_hdmi_hw_aud_unmute(hdmi);
> >         return 0;
> >  }
> > @@ -1097,13 +1084,13 @@ static int mtk_hdmi_output_init(struct mtk_hdmi=
 *hdmi)
> >
> >  static void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
> >  {
> > -       mtk_hdmi_aud_enable_packet(hdmi, true);
> > +       mtk_hdmi_hw_send_aud_packet(hdmi, true);
> >         hdmi->audio_enable =3D true;
> >  }
> >
> >  static void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
> >  {
> > -       mtk_hdmi_aud_enable_packet(hdmi, false);
> > +       mtk_hdmi_hw_send_aud_packet(hdmi, false);
> >         hdmi->audio_enable =3D false;
> >  }
> >
> > --
> > 2.28.0
> >
