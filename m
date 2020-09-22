Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0D2274AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVVKQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 17:10:16 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45759 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIVVKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:10:16 -0400
Received: by mail-ua1-f66.google.com with SMTP id q26so5924874uaa.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y3bqfEWtFeqz84XjleRuAjyIAbuP49WihE9gT5z0Xpk=;
        b=nqBjHH+hQYRASRVr8h0Va25uDOFbpW4o7QOk7gUQSt455GyvE+5DyeVj9lE04EK3sG
         +QgEKawNYeCxgAyd3xnPYw2DfzGfqKeaptE9fvHeHL7yZAv2c76GDNmcgvOMIeSWYMAI
         Pf6sT1kpI/fl/Ph4p9iZW4smYAUu2lhsdqQ/h1ZOal5D7R7V+SakAXJBIUPu/aHcj/6P
         zpPESVA+6fw7u5Eaqj9q7+5cUzmcaKuzJOBrSr1edB20PqAnSECqDzdFFB6fs/OVPesU
         YluBufIVAfi/5V5slyCTnPfVRyhfBOgo5QSCMzrpTOPvdF63wmk6hjSBA2zsvAbqJCP8
         wU8Q==
X-Gm-Message-State: AOAM531Qj0m5l7SeD8wSD+T6k+a1qlGOv+Nzk3l4nsOR7RSVOleSRiaa
        nNnWuARRHqI6/6icrfIvZXr1DK4YoxTyje9lRRw=
X-Google-Smtp-Source: ABdhPJwf458xGexI6j9rzdx76r+ZgU0CiTh4q+ebSzA/OSJtbqpD6+k8+n46tHaIl1obplPxHctYUXzksc5F574jzus=
X-Received: by 2002:a9f:24d4:: with SMTP id 78mr4744540uar.47.1600809014913;
 Tue, 22 Sep 2020 14:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200922210510.156220-1-lyude@redhat.com>
In-Reply-To: <20200922210510.156220-1-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 22 Sep 2020 17:10:03 -0400
Message-ID: <CAKb7UvhAb0wFd9Qi1FGJ=TAYZJ9DYXL6XXMfnG49xEO=a9TuYg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in nv50_dp_mode_valid()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we use 6bpc on arbitrary DP monitors, or is there a capability for
it? Maybe only use 6bpc if display_info.bpc == 6 and otherwise use 8?

On Tue, Sep 22, 2020 at 5:06 PM Lyude Paul <lyude@redhat.com> wrote:
>
> While I thought I had this correct (since it actually did reject modes
> like I expected during testing), Ville Syrjala from Intel pointed out
> that the logic here isn't correct. max_clock refers to the max symbol
> rate supported by the encoder, so limiting clock to ds_clock using max()
> doesn't make sense. Additionally, we want to check against 6bpc for the
> time being since that's the minimum possible bpc here, not the reported
> bpc from the connector. See:
>
> https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html
>
> For more info.
>
> So, let's rewrite this using Ville's advice.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock limits for mode validation")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index 7b640e05bd4cd..24c81e423d349 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector *connector,
>                    const struct drm_display_mode *mode,
>                    unsigned *out_clock)
>  {
> -       const unsigned min_clock = 25000;
> -       unsigned max_clock, ds_clock, clock;
> +       const unsigned int min_clock = 25000;
> +       unsigned int max_clock, ds_clock, clock;
> +       const u8 bpp = 18; /* 6 bpc */
>         enum drm_mode_status ret;
>
>         if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
>                 return MODE_NO_INTERLACE;
>
>         max_clock = outp->dp.link_nr * outp->dp.link_bw;
> -       ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
> -                                                 outp->dp.downstream_ports);
> -       if (ds_clock)
> -               max_clock = min(max_clock, ds_clock);
> -
> -       clock = mode->clock * (connector->display_info.bpc * 3) / 10;
> -       ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> -                                           &clock);
> +       clock = mode->clock * bpp / 8;
> +       if (clock > max_clock)
> +               return MODE_CLOCK_HIGH;
> +
> +       ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp->dp.downstream_ports);
> +       if (ds_clock && mode->clock > ds_clock)
> +               return MODE_CLOCK_HIGH;
> +
> +       ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock, &clock);
>         if (out_clock)
>                 *out_clock = clock;
> +
>         return ret;
>  }
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
