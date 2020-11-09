Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCF2AC094
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgKIQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:13:48 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B97C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:13:48 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so5900752wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PAQxzNvuqtCZjWn4XGCR7pwV/vojuqMxwGF9fuE2BTE=;
        b=HZkrn5bF9w6Z5TD3p+k1YpNDcXlvukLRKhdwRqMP/+xoZb0teMrCQc+SLlEN+Fv08s
         AWjb7oR5/OsCmu8g7CIuGEdoTv7ahaCSR2VPqIQjwVPahtEF6279h4og1KtCzEz+x35s
         nhNk3kInxjd/T9sePgn3rQ+fvWJAhOpfyz+ef37xFeQ3M9evDupplT51B37Eg1dLqKhM
         Yp2T3iPGEGrtpKY8GiC1oxqSqtz8LL/KKxb7RPB+rao1o1S23NvGZ1r/nLp8WFpGt/JW
         BougQLu8YUMnoOi9C0miCoH1whg4D/9+kiemQ9yasW7VuL9QdPQt1/o9m6NRVoii2A2r
         f+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PAQxzNvuqtCZjWn4XGCR7pwV/vojuqMxwGF9fuE2BTE=;
        b=aMYzOTFDViJAs3t+aVPKp2Hv9g0yKWahoNEVHWEnfbWsb1lgH+/CzSodKUSNHG2ahP
         L2OuWuF/6PihKnIqMC44SJRBfD1REDAZ3s+ffCJGKReFjPLdszToKyKVF4dxjqw9+gB8
         3xkH+9MNjjnrNUR0aGBySO5QxjIU3eZLD2oqXBPABPZ+qw+iPAXKBtqbXnLlt2K+Mrb1
         M7SN2ZehYKiPFH/D/pFDrprLHD8eifU0HUW/dvI1PCCsTESCZ0UnRpvd/pYhxScSNlpX
         cjldyHi2syxTek9PohS2HBFJC58WHQV20u+wc/n/aOjos2JwNAuwNDS/Sjdtjdkle1V6
         qz/g==
X-Gm-Message-State: AOAM530J4MUK3SqBT6DiScDyh/s+S0wSvFoEfqk6zvAGtAIEgVbXsPDu
        UsHN8dMOxv4QHawBe7h69QvPtQ==
X-Google-Smtp-Source: ABdhPJzrTBdOQZWQKKC4cWvmWMBZZiowJs0Fb5tDz96/JoW9fF+o8i8iZiROszQGLFpp91znLB3R1g==
X-Received: by 2002:adf:8bce:: with SMTP id w14mr18342271wra.242.1604938426974;
        Mon, 09 Nov 2020 08:13:46 -0800 (PST)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g17sm13965748wrw.37.2020.11.09.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:13:46 -0800 (PST)
Date:   Mon, 9 Nov 2020 16:13:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201109161344.GY2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-15-lee.jones@linaro.org>
 <20201109151937.GF6112@intel.com>
 <20201109161258.GX2063125@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109161258.GX2063125@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Lee Jones wrote:

> On Mon, 09 Nov 2020, Ville Syrjälä wrote:
> 
> > On Thu, Nov 05, 2020 at 02:45:12PM +0000, Lee Jones wrote:
> > > The stack is too full.
> > > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
> > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > 
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: David Francis <David.Francis@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > index 1d696ec001cff..0a539456f6864 100644
> > > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> > >  static bool
> > >  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
> > >  {
> > > -	struct drm_dp_sideband_msg_req_body out = {0};
> > > +	struct drm_dp_sideband_msg_req_body *out;
> > 
> > How big is it? And why is it that big?
> 
> It's a struct of a union of structs.
> 
> And it's all allocated on the stack.  Bad news!

FYI, I have a v2 of this patch.  Just waiting to send it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
