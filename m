Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF32B5B27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKQImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgKQImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:42:45 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:42:44 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so1528066wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=INVepkInhsjBHSvjvAvny9URQAKXqQU8PTJjrdyilLg=;
        b=TZQDVLDqGyhoKFtvLeWZ9D6JvfFDVq4YVlcxXgVDbox+jB0SsBAUuhzq4kxSLDZLx7
         tA+VgCtW1erqoJIc8z07yw3lm6p8aZlF55+CU1a7SzZKEte8obieZnLXPaDlPWhdMJ0T
         Bz7aMyMAkSstYfbqY8YRK0KEK1Hpk+DQlDbvnl78N4YGpH6p33GTCcEdYX2FRd1u/6ea
         7BYX2gQh2juy/3g7glEG9oyJOHulags6Aoj+YnqU8fr0YPt3p9UY/4jeRTV1x3TF2cOD
         Qxda6iNjGPjBT6bKBIWqkOT/jfZoXTNaIyZFygEK6H1052iF37L+TESdmQwARohUr/63
         7bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=INVepkInhsjBHSvjvAvny9URQAKXqQU8PTJjrdyilLg=;
        b=bgtlGlKCi9AM0yqAtAG/QUxVwxq11KdCdzp6GFfpNKqtLfdBy+v1k9bd1DAHLzg7C7
         733lMZgkXiTTAf5UEsrAAeUOcrCSiRZvJLZhcJazedp9a93vkUNfcAtxaLTRRSYQgbIp
         JoOuFtTOi7jjhlZAzSfqmiEaRQNdRMO+vDF0Q8368BAHCtSkDDezuFnjJ6UZNhsZ4ioF
         C/qSLVhXnVfxUtmTFq9iIH9GEeq3yVUbdf7HsfS+nWGg/aRoGzvYcdCFRWJNmFlqTLQh
         2+z3+bdSY77ZD0wlVLLIOwqvLnPyUhFsh0xS34kjAvVEtKhapBAgN7YHJl4yu5dO0PIs
         2wTQ==
X-Gm-Message-State: AOAM530GzwcnTStwOEYbCFsfgslj9aUKr1eHT4amTi+x6DJjEoHJCwDI
        js9nDg/S+RMJYPDkBDZy2iwiaw==
X-Google-Smtp-Source: ABdhPJyNVLesnBzBLGwI8R/r91IU6DQIR0oUVG7aPWGO4TNkn9RRrKNJU7HvQjW4Pp8LVhnPffCnxg==
X-Received: by 2002:a1c:6284:: with SMTP id w126mr3140057wmb.145.1605602563687;
        Tue, 17 Nov 2020 00:42:43 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id o17sm2471180wmd.34.2020.11.17.00.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:42:42 -0800 (PST)
Date:   Tue, 17 Nov 2020 08:42:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 01/43] drm/radeon/atombios_encoders: Move
 'radeon_atom_get_tv_timings()'s prototype into shared location
Message-ID: <20201117084241.GC1869941@dell>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
 <20201116173005.1825880-2-lee.jones@linaro.org>
 <CADnq5_NnPiySfPv4Jgk4j8rvzxYkoVxRBGUAjdQJW_tL2RuTBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NnPiySfPv4Jgk4j8rvzxYkoVxRBGUAjdQJW_tL2RuTBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Alex Deucher wrote:

> On Mon, Nov 16, 2020 at 12:30 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/radeon/radeon_atombios.c:1791:6: warning: no previous prototype for ‘radeon_atom_get_tv_timings’ [-Wmissing-prototypes]
> >  1791 | bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied.  Thanks!

Superstar!  Thanks Alex.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
