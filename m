Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E452AC1EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgKIRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:18:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:18:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so5130638wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pupQObYmQEtHTXVN7G7VurpDOLGGYw2zG5xqU4Y7meA=;
        b=Rgu23x6Wa5spdDHboUtOo7j/CazI9cyGc5s5MjjvOIiGx49lA7jsVIybw8c9300iEl
         IHbNRpcF/glLYizIlMVmP73hLsvF7kiqYx+WlSCwJkiT4BwVDFBOLKFmQtl6XpPBHbjS
         6vW2c66R3+hEMIe2mRWcg8mvI+LPkyqQzex245p9wJGAnTWuHBb95AUrr9b6cxYB/2wU
         jrdwFa8Zy1PNeRg4cf8GZr/+sfnVRtOHVzoeSl6EvtNWdQLjFwE+4WuUTrZjK1NAqtGx
         vOmdXnMP+gxGR3v4EdZJ6zuEqbMqDdsQnoiM7xFUAiQPYpjH+/P1XkmmU5jxvKKgUcC0
         TG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pupQObYmQEtHTXVN7G7VurpDOLGGYw2zG5xqU4Y7meA=;
        b=IC+SQf4i2r2oj0tVAku+p6hRPjn6k7EwUXrvgufUK2GdvCZ3Nml+Fffw7L1eVbrHFr
         FKlGwJFyg33ZA3aFEuOdRCrmN4ljYgbc/INuAjm1bTf2jMmJYJLxKAKjJoW6O3Df1bQ4
         kCs/DNBhvn1wKPtNnEwKsff2Xlw3zee2qESneYKLhL0TiHND/qZlml11J+voANN5iPj2
         BnTLc0GzOiPHouu4B4XECURMf8W1YajKRzaHnWncaZYf8Es5qWHFzEihiazVlQkYrYiB
         qgiqhabPKMOWq1jeU8vTI9PjE7MS7ds4fieaJ1vkYndS5/aHRKxRhBly9cgB6iXhfbvR
         aGEg==
X-Gm-Message-State: AOAM5322PPsgSkWG/h0dcrpByn1yPFnmayHaMjhBCmoC/EGMOTTTmaAL
        nJdoDCq3RaVaxFxZN9u8Qh+SafsTOYeNabCw
X-Google-Smtp-Source: ABdhPJxVpcnhhKw4+HYsJ4c7hCat9vFVLF5ci5YzUbDbVnH7wGQHjAINH4wGbFi2Tru601OdJ/MOCg==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr19713270wrs.27.1604942280560;
        Mon, 09 Nov 2020 09:18:00 -0800 (PST)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id n123sm55069wmn.38.2020.11.09.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:17:59 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:17:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201109171756.GA2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-15-lee.jones@linaro.org>
 <20201109151937.GF6112@intel.com>
 <20201109161258.GX2063125@dell>
 <20201109162015.GH6112@intel.com>
 <20201109164004.GZ2063125@dell>
 <20201109170324.GJ6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109170324.GJ6112@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Ville Syrjälä wrote:

> On Mon, Nov 09, 2020 at 04:40:04PM +0000, Lee Jones wrote:
> > On Mon, 09 Nov 2020, Ville Syrjälä wrote:
> > 
> > > On Mon, Nov 09, 2020 at 04:12:58PM +0000, Lee Jones wrote:
> > > > On Mon, 09 Nov 2020, Ville Syrjälä wrote:
> > > > 
> > > > > On Thu, Nov 05, 2020 at 02:45:12PM +0000, Lee Jones wrote:
> > > > > > The stack is too full.
> > > > > > 
> > > > > > Fixes the following W=1 kernel build warning(s):
> > > > > > 
> > > > > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
> > > > > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > > > 
> > > > > > Cc: David Airlie <airlied@linux.ie>
> > > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > > > Cc: David Francis <David.Francis@amd.com>
> > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
> > > > > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > > index 1d696ec001cff..0a539456f6864 100644
> > > > > > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > > @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> > > > > >  static bool
> > > > > >  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
> > > > > >  {
> > > > > > -	struct drm_dp_sideband_msg_req_body out = {0};
> > > > > > +	struct drm_dp_sideband_msg_req_body *out;
> > > > > 
> > > > > How big is it? And why is it that big?
> > > > 
> > > > It's a struct of a union of structs.
> > > > 
> > > > And it's all allocated on the stack.  Bad news!
> > > 
> > > That doesn't answer my questions.
> > 
> > It answers the second question.
> 
> Not really. A combination of structs and unions could be
> pretty much any size.
> 
> > 
> > The answer to the first question you can `grep` for yourself. ;)
> 
> I would rather run pahole on it. But why would you require
> reviewers to jump through such extra hoops when you could
> just put that information into the commit message? With that
> anyone could review this without having to do a lot of extra
> work.

Because the exact numbers aren't all that relevant.

Before the patch is applied, the local variables take the frame size
over the accepted threshold.  The patch brings the size back down to
an accepted level.

I'm not actually aware of the exact numbers, but you can see by taking
a quick look that 'struct drm_dp_sideband_msg_req_body' is large
enough to make a significant improvement once shifted onto the heap.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
