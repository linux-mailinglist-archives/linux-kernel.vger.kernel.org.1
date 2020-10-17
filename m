Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3F29101D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436746AbgJQG1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbgJQG1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:27:21 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C086E2076D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 02:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602903071;
        bh=Gr3nGfsG3c90q2Jwo99IVkvbuKxMDLVUT2x1M7u1RTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T534dyX6m9WKLTAbNTVOnQhq0+weumEhQjaOBlZkhrWmittJHHYXDdn8hyUQ04ziZ
         BGt460aru1rdqAmm46s6j5tkWcQaN5bg1ihZIklRR2nxxLB6SbrKxf1j6TU58n4hUK
         ilYxSyUdtGH4UTzFMV0+wkQzOazSvEScg0vs0SGM=
Received: by mail-ed1-f49.google.com with SMTP id t21so4648797eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 19:51:10 -0700 (PDT)
X-Gm-Message-State: AOAM532d3pnT9429dM+YKG1sEHp7mx90NokssHmAxdfEPQBs73SnrDvg
        2ArwFt3OMwQI9fNFB+1Btes+cVGz5BP4GQMrEg==
X-Google-Smtp-Source: ABdhPJzeeOBiHIseq3aPT99tDKtn0oB87/Hc2OKRlRnxhLG7z3kaKy7+YvcHp12bFQwqGIaU7F6JOvPhv/BF8Tg2oPo=
X-Received: by 2002:a05:6402:c12:: with SMTP id co18mr7225456edb.162.1602903069286;
 Fri, 16 Oct 2020 19:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201013085512.12857-1-bernard@vivo.com>
In-Reply-To: <20201013085512.12857-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 17 Oct 2020 10:50:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY__r-2aQLK+oy6uRFnu3xExngBYrSAQ7jCfhWx+Ti0UgFw@mail.gmail.com>
Message-ID: <CAAOTY__r-2aQLK+oy6uRFnu3xExngBYrSAQ7jCfhWx+Ti0UgFw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Optimize functions which do not need to return
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Bernard Zhao <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Function mtk_hdmi_aud_set_input always return 0, no need to
> keep the return value. Functions mtk_hdmi_aud_enable_packet &
> mtk_hdmi_aud_on_off_hw_ncts are the same, these two functions
> just call next functions. Maybe it`s a bit better to just call
> the inner function.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index a97725680d4e..f1d987df0550 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -870,19 +870,8 @@ static void mtk_hdmi_video_set_display_mode(struct m=
tk_hdmi *hdmi,
>         mtk_hdmi_hw_msic_setting(hdmi, mode);
>  }
>
> -static int mtk_hdmi_aud_enable_packet(struct mtk_hdmi *hdmi, bool enable=
)
> -{
> -       mtk_hdmi_hw_send_aud_packet(hdmi, enable);
> -       return 0;
> -}
>
> -static int mtk_hdmi_aud_on_off_hw_ncts(struct mtk_hdmi *hdmi, bool on)
> -{
> -       mtk_hdmi_hw_ncts_enable(hdmi, on);
> -       return 0;
> -}
> -
> -static int mtk_hdmi_aud_set_input(struct mtk_hdmi *hdmi)
> +static void mtk_hdmi_aud_set_input(struct mtk_hdmi *hdmi)
>  {
>         enum hdmi_aud_channel_type chan_type;
>         u8 chan_count;
> @@ -912,8 +901,6 @@ static int mtk_hdmi_aud_set_input(struct mtk_hdmi *hd=
mi)
>         chan_count =3D mtk_hdmi_aud_get_chnl_count(chan_type);
>         mtk_hdmi_hw_aud_set_i2s_chan_num(hdmi, chan_type, chan_count);
>         mtk_hdmi_hw_aud_set_input_type(hdmi, hdmi->aud_param.aud_input_ty=
pe);
> -
> -       return 0;
>  }
>
>  static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hdmi,
> @@ -921,7 +908,7 @@ static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hdmi=
,
>  {
>         unsigned int sample_rate =3D hdmi->aud_param.codec_params.sample_=
rate;
>
> -       mtk_hdmi_aud_on_off_hw_ncts(hdmi, false);
> +       mtk_hdmi_hw_ncts_enable(hdmi, false);
>         mtk_hdmi_hw_aud_src_disable(hdmi);
>         mtk_hdmi_clear_bits(hdmi, GRL_CFG2, CFG2_ACLK_INV);
>
> @@ -959,7 +946,7 @@ static int mtk_hdmi_aud_output_config(struct mtk_hdmi=
 *hdmi,
>                                       struct drm_display_mode *display_mo=
de)
>  {
>         mtk_hdmi_hw_aud_mute(hdmi);
> -       mtk_hdmi_aud_enable_packet(hdmi, false);
> +       mtk_hdmi_hw_send_aud_packet(hdmi, false);
>
>         mtk_hdmi_aud_set_input(hdmi);
>         mtk_hdmi_aud_set_src(hdmi, display_mode);
> @@ -968,8 +955,8 @@ static int mtk_hdmi_aud_output_config(struct mtk_hdmi=
 *hdmi,
>
>         usleep_range(50, 100);
>
> -       mtk_hdmi_aud_on_off_hw_ncts(hdmi, true);
> -       mtk_hdmi_aud_enable_packet(hdmi, true);
> +       mtk_hdmi_hw_ncts_enable(hdmi, true);
> +       mtk_hdmi_hw_send_aud_packet(hdmi, true);
>         mtk_hdmi_hw_aud_unmute(hdmi);
>         return 0;
>  }
> @@ -1097,13 +1084,13 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *=
hdmi)
>
>  static void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
>  {
> -       mtk_hdmi_aud_enable_packet(hdmi, true);
> +       mtk_hdmi_hw_send_aud_packet(hdmi, true);
>         hdmi->audio_enable =3D true;
>  }
>
>  static void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
>  {
> -       mtk_hdmi_aud_enable_packet(hdmi, false);
> +       mtk_hdmi_hw_send_aud_packet(hdmi, false);
>         hdmi->audio_enable =3D false;
>  }
>
> --
> 2.28.0
>
