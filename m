Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A02B5AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKQI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:29:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4483C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:29:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so2396091wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0AoYHW7lMZzkTQ6BnvkiA74s9JiSHbIiy02gKpfefxk=;
        b=ouKgk1yasb8tfHmx4anuX+qm2kqIPUj4/8c6jf4bkP4LeF8hOAvtGE5WWDQ65ml129
         5YMClxsCnewFUtABCONGd/7eKMO8g3PiQ2HohthbTvxswPTMcDHfLEL74D9m0CrkFybr
         gOx9fKxx1G+L2v/9x109RHOMtbc3oJrwlrHhRCJxMJ7H8RRB5XTdzrGFz0YEBvWXeqQf
         /uFQItOjN4UEbjdZltBmKVkBR/Y9/cwCWMdOpecekpZ4yyhYQKDNlOg6tK3Y0xENxPOX
         bGyHTV4zLQ5SMeA7PrCG7lpTopRg9YGWRN9EDgIq2P37DduwtmnXsMMl9wrZZCd57g3I
         QE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0AoYHW7lMZzkTQ6BnvkiA74s9JiSHbIiy02gKpfefxk=;
        b=OfyoX656CB2vLoSoHT5g4N/YrHlAenhpAlKrTWtJ09Dmone2Dy8Ib/erfq8lQPwpQn
         /oJzPnpz1V4viwCfB0zNtgMQb4KkwfaqOvp1+tX+elGENdt1+A3J+LMbheQr3LGSmfFP
         GvypFS28kXzF7w1/GZzQdiUSd6f+/3n49H9u6UgfOY1KSovrIEEesBgIW5VFsUEDgCxS
         /TjRARCiDnTNd/iYEBB6WvsfDzFWsNHxWqqtf8x4+XF75x9d+cxL1+3NiDUXdJ0yt/q5
         WGyaxDQs1GRFzQbdK7lqQrns+JCpScq6i+q89af7hWD+GRNKRuflERGuszRvoLHhH660
         vITg==
X-Gm-Message-State: AOAM531qJh/kZq2H4H3q3WmzO14ER5HvlFb+MEDReFfwkP4Pibjos1Ol
        I9iKkxdIJU+VbAZJ7sDJrHk5gw==
X-Google-Smtp-Source: ABdhPJw8DTAOsUr5WU8Vpd+v0a+yBmTCtwLVBO7SW0hLGXW07nvSR0O4uxCMpwl6vZZg8UEpdLJJzQ==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr2938223wmf.76.1605601797569;
        Tue, 17 Nov 2020 00:29:57 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t74sm2523552wmt.8.2020.11.17.00.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:29:56 -0800 (PST)
Date:   Tue, 17 Nov 2020 08:29:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 29/42] drm/selftests/test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201117082955.GA1869941@dell>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-30-lee.jones@linaro.org>
 <2dad68f011c7cd8a7c3754457c192f9dc2f504ed.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dad68f011c7cd8a7c3754457c192f9dc2f504ed.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Lyude Paul wrote:

> Huh-could have sworn I had reviewed this one already.
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Yes, you're right.

It was masked by the discussion with Ville.  Apologies.

> On Mon, 2020-11-16 at 17:40 +0000, Lee Jones wrote:V
> > The stack is too full.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function
> > ‘sideband_msg_req_encode_decode’:
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the
> > frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: David Francis <David.Francis@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../drm/selftests/test-drm_dp_mst_helper.c    | 31 ++++++++++++-------
> >  1 file changed, 20 insertions(+), 11 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
