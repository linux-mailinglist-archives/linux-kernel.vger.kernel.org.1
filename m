Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A612AC092
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgKIQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:13:02 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:13:02 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so9274776wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8oYNPs7w2/EjOECIoZ9B9wqcB23zpJY9uTwhUzFm9nc=;
        b=TGkGYjkrU/ZSFOiudjN6HPEiyavpORnj47D2O97PHBS2RfhWzGY4N2LIevKBua2ELm
         SC+SxjLBhKB0ZfFHsI03aClpLTtkg1vB6YdOCKHzM8p1OHu71LGApBlmaNsfavoy6xrm
         ZaxGvDOrPYxwob2I2i6RhEVoH20fyMQxZcJXJSZBlvwTnSdodz/jU/g3ALeZRW/eSIeN
         CoJcZ4pLEt93iqD0FSsdnytSFnlmlXyQ3AEbYXl+tNHj5/n8ss0BnuwOKXxZJPO6nMX9
         tcsApkdAo5UO709ET5ShnRMk1dNWxfJf1Lt6ylp4hIHxYbUNcU1CHTektiM7WXNBTzER
         EUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8oYNPs7w2/EjOECIoZ9B9wqcB23zpJY9uTwhUzFm9nc=;
        b=P2dI7csCN2eEvBGqCa5AeyTEKTlGsHN9t5Nd78e6dXjeGix+rbZFBJqJrlkmOYj/DE
         BSCyenkV5ymAV46H7wJPB/+cCawRFmnbkBgumd5PM62ZOqpQ4G+PKDC7Kvx8POPvRvX9
         EqtRsxkxS0zL+LIm9Osu48CNT6JkqPcLlCARhF2d8yJ4hnVVdEnMNFOHuI9urCtvgP1o
         uIRNSjzS/uI2KhFBVqaAEG3TyBXUwJoCdBSyd+gaodsMUGzgGHByKKO4KviJkbV7ivbm
         9Y+n+YJgTjwWuGwAOd5hyvY8fAkPuPECH3Gj/NwA0vsN6FmAdvojzQjUQzrg0+bUCQ2m
         PIDw==
X-Gm-Message-State: AOAM530QpKtlEwg8UGe5Y8VPHgxRWGj8fqJ6ha/60RCFtk2E+TqWnDrc
        FQMhTOfAj6loqNwOmmKTLcWYAA==
X-Google-Smtp-Source: ABdhPJzUvDyBZZ+ARYrz71v28PSz+z2eeKcayyARzkxJA3CZpbdef/sjlMSuhqPi+Lu21gb0N0uoaw==
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr12142617wrp.2.1604938380824;
        Mon, 09 Nov 2020 08:13:00 -0800 (PST)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g20sm6210956wmh.20.2020.11.09.08.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:13:00 -0800 (PST)
Date:   Mon, 9 Nov 2020 16:12:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201109161258.GX2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-15-lee.jones@linaro.org>
 <20201109151937.GF6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109151937.GF6112@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Ville Syrjälä wrote:

> On Thu, Nov 05, 2020 at 02:45:12PM +0000, Lee Jones wrote:
> > The stack is too full.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: David Francis <David.Francis@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > index 1d696ec001cff..0a539456f6864 100644
> > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> >  static bool
> >  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
> >  {
> > -	struct drm_dp_sideband_msg_req_body out = {0};
> > +	struct drm_dp_sideband_msg_req_body *out;
> 
> How big is it? And why is it that big?

It's a struct of a union of structs.

And it's all allocated on the stack.  Bad news!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
