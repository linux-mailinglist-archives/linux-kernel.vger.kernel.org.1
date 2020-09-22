Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357AA274AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVVO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600809295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf4ET5A6pTrj1XKJ2ODwFO2BG7xSVsbhE8JSNbeonVk=;
        b=JDYhT6m/bXKaQVp0T2rv6XSCQlWs3l6MfivpJrqhOuAOR4PPT4FuePSPl3jURwdUfPmijn
        LH3a3qU282MeEUSesr2P/Q067yVelpNM4gKSZ6tI1ACr6A5xEfUyvE9kuLgf/bDeOf/Dxq
        2PbPFJ9rsbueW1wZR2IYCa6A+YiSCJU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-w6HKsRpeMBGWG-8b4ymiSQ-1; Tue, 22 Sep 2020 17:14:51 -0400
X-MC-Unique: w6HKsRpeMBGWG-8b4ymiSQ-1
Received: by mail-qt1-f198.google.com with SMTP id b39so17392260qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mf4ET5A6pTrj1XKJ2ODwFO2BG7xSVsbhE8JSNbeonVk=;
        b=WuHRBywz3TcMhkYBT2/G51zdbvZc3qwhgGV71fA8fcSCKxNTLdujReD8FFdAj5dUZl
         0XSh9RUd4zqnwAQHzeQz3t5d7GzF8ywwTAj1Cv9dmT6yiRVZfMIS0MvjyutRd5PX4hO/
         QjHjVM+A7QmyClAV/W37R+72GGlzd3y0KvX8k2HwYhpjY6f++GvuYI1bfRicqjynlbpl
         MMprpMNEpsfu3uauQWZ+6okV6EeweTJdfzIELA/xNF5pQJQRzw0YUW4X1gRveIgyMK0Q
         BRaoAVugoXRj31nkJHHMYQFAxSZPIptIlWAKWdCdrIZ2KLFIJmNdRum+DYzLzY5JiT06
         +7Vw==
X-Gm-Message-State: AOAM532E5jdFxhDC6jEyeHanFmvhe7YQlOZ42/Fu/0BaCaLk6pPvZ8Yk
        HAxATrB9GGb9F46Fi7K57OYmsdPabkbzqdz3i9mK6255oUE7ba9mY0HKi1Q40ehXViyEFrc0L/O
        2vVln/vw4/XygiQ7AjatCKV7W
X-Received: by 2002:a0c:e904:: with SMTP id a4mr7914302qvo.24.1600809290655;
        Tue, 22 Sep 2020 14:14:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv6gSFioEwHgineyjomjrnvy/onWXozophZU2EmPW55rL8svms5nqe+QTj+1TwMznKFQcpaA==
X-Received: by 2002:a0c:e904:: with SMTP id a4mr7914282qvo.24.1600809290396;
        Tue, 22 Sep 2020 14:14:50 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id d22sm6495452qkj.93.2020.09.22.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:14:49 -0700 (PDT)
Message-ID: <7b10668ee337e531b14705ebecb1f6c1004728d6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in
 nv50_dp_mode_valid()
From:   Lyude Paul <lyude@redhat.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 22 Sep 2020 17:14:48 -0400
In-Reply-To: <CAKb7UvhAb0wFd9Qi1FGJ=TAYZJ9DYXL6XXMfnG49xEO=a9TuYg@mail.gmail.com>
References: <20200922210510.156220-1-lyude@redhat.com>
         <CAKb7UvhAb0wFd9Qi1FGJ=TAYZJ9DYXL6XXMfnG49xEO=a9TuYg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-22 at 17:10 -0400, Ilia Mirkin wrote:
> Can we use 6bpc on arbitrary DP monitors, or is there a capability for
> it? Maybe only use 6bpc if display_info.bpc == 6 and otherwise use 8?

I don't think that display_info.bpc actually implies a minimum bpc, only a
maximum bpc iirc (Ville would know the answer to this one). The other thing to
note here is that we want to assume the lowest possible bpc here since we're
only concerned if the mode passed to ->mode_valid can be set under -any-
conditions (including those that require lowering the bpc beyond it's maximum
value), so we definitely do want to always use 6bpc here even once we get
support for optimizing the bpc based on the available display bandwidth.
> 
> On Tue, Sep 22, 2020 at 5:06 PM Lyude Paul <lyude@redhat.com> wrote:
> > While I thought I had this correct (since it actually did reject modes
> > like I expected during testing), Ville Syrjala from Intel pointed out
> > that the logic here isn't correct. max_clock refers to the max symbol
> > rate supported by the encoder, so limiting clock to ds_clock using max()
> > doesn't make sense. Additionally, we want to check against 6bpc for the
> > time being since that's the minimum possible bpc here, not the reported
> > bpc from the connector. See:
> > 
> > https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html
> > 
> > For more info.
> > 
> > So, let's rewrite this using Ville's advice.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock
> > limits for mode validation")
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > index 7b640e05bd4cd..24c81e423d349 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > @@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector *connector,
> >                    const struct drm_display_mode *mode,
> >                    unsigned *out_clock)
> >  {
> > -       const unsigned min_clock = 25000;
> > -       unsigned max_clock, ds_clock, clock;
> > +       const unsigned int min_clock = 25000;
> > +       unsigned int max_clock, ds_clock, clock;
> > +       const u8 bpp = 18; /* 6 bpc */
> >         enum drm_mode_status ret;
> > 
> >         if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp-
> > >caps.dp_interlace)
> >                 return MODE_NO_INTERLACE;
> > 
> >         max_clock = outp->dp.link_nr * outp->dp.link_bw;
> > -       ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
> > -                                                 outp-
> > >dp.downstream_ports);
> > -       if (ds_clock)
> > -               max_clock = min(max_clock, ds_clock);
> > -
> > -       clock = mode->clock * (connector->display_info.bpc * 3) / 10;
> > -       ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> > -                                           &clock);
> > +       clock = mode->clock * bpp / 8;
> > +       if (clock > max_clock)
> > +               return MODE_CLOCK_HIGH;
> > +
> > +       ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp-
> > >dp.downstream_ports);
> > +       if (ds_clock && mode->clock > ds_clock)
> > +               return MODE_CLOCK_HIGH;
> > +
> > +       ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> > &clock);
> >         if (out_clock)
> >                 *out_clock = clock;
> > +
> >         return ret;
> >  }
> > --
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

