Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72F2A9DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgKFT0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgKFT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:26:00 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D05C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 11:25:59 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so2452531wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oQqOi+A4tLPYWRL1oJ0iRRtcnq5xRUgXBaCx3oxm6Mc=;
        b=xfZsl5/dkWztOXLjW8Z1+VZJ10XJyXN1acAI6i1GV1PP4DtP+z0n39q2Gce/Jy6Sb3
         P6A5m+SX7xW7DxPo6yFSIy6BhqyDaf3qtGPqZxLo9Fo81KP2ZgSXFm93fox3FA3Duv6D
         BdeldgklgzhHhjdgDlhjorxFLqRo31JDhEr9hBkw1rKgTCH0Z3Z4n6gSGxvwGupzGMEb
         8/pa8dLZP0bxFrs6u6r2AXcNGnVtmCeSbQ5B5hQZMB7+Q9ItIkhyaalzVKc8rFr+2mJ8
         uxNDxpVx4uLgmjyzDg90XRByqSn2c/+0MRT8RkG+7AnsYILl7tfkGL4FpL99jCL0UByH
         qpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oQqOi+A4tLPYWRL1oJ0iRRtcnq5xRUgXBaCx3oxm6Mc=;
        b=mslqDQbBg3RXxR6o/vMfw/fyBMSi2kRHGRk+33/8Y3CygOBDHwM0ApYjmIn7rKqJKH
         CgqaCXoALpP0ZrkoGltPDNhop/yQ1Ux3f4G6QG2V/tmQJASQMHuVGErNSTtY/jcf4ADv
         AXe2RtirVaMB4yfuk/rPUbYvrcPY9EfvN7qr742y8e0iGVjibhQUgC3RLbrrJYISl+LG
         HMDC0l+U8eBvCMM+zxVwoCyMolK2el7dSg8hKY+UoyfCozh73xZC02HidrZ2sE7uafWT
         Ou9BqTRQ/rlf+n781ibo1SKO5F9M6DSI3nqKsOyuha98PjailPVkS54I9k0T4PQ/q3k0
         i8Fg==
X-Gm-Message-State: AOAM533IlfSIQreAl1m11l9fKaW7bCIR4a1t8WBpfxn0srYMyUeUzEqs
        ZE5XJmgoADizsfgpLC9z7UnlWw==
X-Google-Smtp-Source: ABdhPJwe9QX4YmziR+H+zBejdrT0V/r/zN9gfGoV6udLJS1x0zOF7QsEqCXySIOmnZgHt7Yg4+jtrw==
X-Received: by 2002:adf:e551:: with SMTP id z17mr4420567wrm.374.1604690758694;
        Fri, 06 Nov 2020 11:25:58 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id g23sm3725133wmh.21.2020.11.06.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:25:58 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:25:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201106192556.GO2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-15-lee.jones@linaro.org>
 <bf216efdf7eea393d6ce5244f7b7a8970c23c235.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf216efdf7eea393d6ce5244f7b7a8970c23c235.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Lyude Paul wrote:

> On Thu, 2020-11-05 at 14:45 +0000, Lee Jones wrote:
> > The stack is too full.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function
> > ‘sideband_msg_req_encode_decode’:
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame
> > size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: David Francis <David.Francis@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > index 1d696ec001cff..0a539456f6864 100644
> > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct
> > drm_dp_sideband_msg_req_body *in,
> >  static bool
> >  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
> >  {
> > -       struct drm_dp_sideband_msg_req_body out = {0};
> > +       struct drm_dp_sideband_msg_req_body *out;
> >         struct drm_printer p = drm_err_printer(PREFIX_STR);
> >         struct drm_dp_sideband_msg_tx txmsg;
> >         int i, ret;
> > +       bool result = true;
> > +
> > +       out = kzalloc(sizeof(*out), GFP_KERNEL);
> > 
> 
> You're missing a NULL check here

You're right.  School-boy error!  Will fix.

> >         drm_dp_encode_sideband_req(in, &txmsg);

Wow, what are all these?

What mailer are you using?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
