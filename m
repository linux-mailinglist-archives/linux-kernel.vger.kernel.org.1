Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667182AC11A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgKIQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgKIQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:40:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1244C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:40:09 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so9373167wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vFzYMDoCTE/7BuMCxuGj//okAPwk1hzD+o6O8Pb/N54=;
        b=dd0LRhluqfhRIc5sOEgklGW7/QhdZrNm2GO5aSXtWNRBkuaWyLPKaVOW1cQduxqCOp
         mNMNnwHgXBnaesTROkdep44nv2PxqszfcCb+7JEjKWeXGPDsq/ZB0ZfJRRRdFeo+evIF
         aCGcLuZJm2bPqF70hviQm2EN0UAx0obDEFmy87NX8lWciOSQ8poliSMf1zxeyVbu2BXt
         XlZ/QBDF0O0njojWJjgWSMGzCOJI+MtVU/bcGrZ0e8Ykd+9oQs7/JuU187Dw9ku6Xk+I
         OKv3MpxHmXhjWLvGJ3gNqrtZ/KgzW3rGpF13J3zRN165/lQDETRVChL92a5TllgM3Hf4
         QRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vFzYMDoCTE/7BuMCxuGj//okAPwk1hzD+o6O8Pb/N54=;
        b=jAJ3M3y02wmEtHlgprnd+wp07SlhPJOHDjp0Pgjbzzfw59f7ozAPoTRdV6WSmz7y0i
         4s0OcY9ge2fp8wZiMUQYNYvLeG1dlxSttjAVjAskubfzvOIqLG63tXSzxu6ljDNmiW30
         vWEyel+sZjIqQbi0bUmcytcav/dH4WtSPhse6iXNL9AsZPSUSGaRGf3uQgla59ArR61t
         WOd+1k0vVBknKesTLD4BwQ6jbo2K2wQ/Vu/8h9UqNKYplNI2Kq2/8jA9uloxUqn/jDss
         UDlRSyTEqwWYi9COG8f2j+yLybDm2ubWi9PUF3IKQG97lXZzeAAlOc+KPW4s4Jip0lZR
         loPA==
X-Gm-Message-State: AOAM532vCvL9AaMdi9PiOJ0VtzoyTIA4QdlQxkk0AlgMMORjshPr0ieS
        g0GtXdZ9AZi97K6B6AAfSvBHFw==
X-Google-Smtp-Source: ABdhPJzi2iHSBIfHhM1EAq/pMbkMQftrIzRJgLBNavLLlp93wooaq4GPyuJieZUH4V9f0WvGGG8wdA==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr18164369wrt.23.1604940008605;
        Mon, 09 Nov 2020 08:40:08 -0800 (PST)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id n14sm14137815wrt.8.2020.11.09.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:40:08 -0800 (PST)
Date:   Mon, 9 Nov 2020 16:40:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201109164004.GZ2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-15-lee.jones@linaro.org>
 <20201109151937.GF6112@intel.com>
 <20201109161258.GX2063125@dell>
 <20201109162015.GH6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109162015.GH6112@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Ville Syrjälä wrote:

> On Mon, Nov 09, 2020 at 04:12:58PM +0000, Lee Jones wrote:
> > On Mon, 09 Nov 2020, Ville Syrjälä wrote:
> > 
> > > On Thu, Nov 05, 2020 at 02:45:12PM +0000, Lee Jones wrote:
> > > > The stack is too full.
> > > > 
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
> > > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > 
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: David Francis <David.Francis@amd.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
> > > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > index 1d696ec001cff..0a539456f6864 100644
> > > > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> > > >  static bool
> > > >  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
> > > >  {
> > > > -	struct drm_dp_sideband_msg_req_body out = {0};
> > > > +	struct drm_dp_sideband_msg_req_body *out;
> > > 
> > > How big is it? And why is it that big?
> > 
> > It's a struct of a union of structs.
> > 
> > And it's all allocated on the stack.  Bad news!
> 
> That doesn't answer my questions.

It answers the second question.

The answer to the first question you can `grep` for yourself. ;)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
