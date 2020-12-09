Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD42D3774
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgLIAQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLIAQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:16:03 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568A0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 16:15:23 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so22959wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 16:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljBtQolw/fSCvWvCfsGfzj3Tx3q5ClxzHfhBpA/Uyt4=;
        b=CLJf6yIL6mEMOL3978I4oWSOnMEU4fVaokClcSl2zOqxLVG1V/nYnHLHoWCpP9xav6
         Hq8VfudGPyr9P/BYzKoOH7m9hpOAVHIVX0VpMic9bjjC4r2byOOTJlsgeHcskELJZ6T7
         OPiPtlelUCoDP99rGEmRtYINu+Pnj6hKLYtec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ljBtQolw/fSCvWvCfsGfzj3Tx3q5ClxzHfhBpA/Uyt4=;
        b=UokvFv+cCulx4k4YAyQ4sg7e6m0HUsYFHDR9FIWFi4tY8R+cdJjEowSaHGZIQeaqNA
         1KHjvEbuktKrF3aAfOknSUi7mXrfFZuyr9kD31ujpercuEj7ShyiuEmsGjUXbkFVHzwr
         LsUBqq/pOBfk92omgk+ioSaiHoP/rcZjo6bU7jut0/nFH+FFaufRy8icHDedivVhRsAJ
         rq2hZBYkQrHVOZ/VoUJ6Z7HACRiy0PnsRZzJlOQUlAig+2Dzi8/QIE/hE3jZ61gKOks8
         PLEOseATv75oDIGK35AqbFLVjHL44/XkG+rpqU/O6q6neXWCmkULR/U2mP70F/Rm8vSZ
         DcXw==
X-Gm-Message-State: AOAM530xGLETmC0K6ewWzQGXLre14O6c7/UCEAKTANvEVHIN6T1qTwBB
        JfaQM/3XEcycataPNnZ+uKprnQ==
X-Google-Smtp-Source: ABdhPJwj/NmhwyAG8fYm8zoidilZCfCdaOIrJXec5sWPcHC/ofGkvo3LjPuyR9ELahcTOAhVHSIqWg==
X-Received: by 2002:a1c:df85:: with SMTP id w127mr20297wmg.166.1607472922065;
        Tue, 08 Dec 2020 16:15:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h15sm913327wrw.15.2020.12.08.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 16:15:21 -0800 (PST)
Date:   Wed, 9 Dec 2020 01:15:19 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm/hisilicon 0/3] support reading resolutions from EDID
Message-ID: <20201209001519.GG401619@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        tzimmermann@suse.de, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1607045326-47771-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607045326-47771-1-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:28:33AM +0800, Tian Tao wrote:
> patch #1 add a new file to implements i2c adapters, #2 read the
> resolution from the edid, if that fails, set the resolution to fixed.
> patch #3 update the destroy callback function to release the i2c adapters.
> 
> Tian Tao (3):
>   drm/hisilicon: Support i2c driver algorithms for bit-shift adapters
>   drm/hisilicon: Features to support reading resolutions from EDID
>   drm/hisilicon: Releasing Resources in the Destroy callback Function

Just fyi, something with your patch submission got mangled. This one
doesn't seem to have any follow-up patches, the previous one had a
selection of unrelated bugfixes.
-Daniel

> 
>  drivers/gpu/drm/hisilicon/hibmc/Makefile         |  2 +-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  | 21 ++++-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c  | 98 ++++++++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 45 +++++++++--
>  4 files changed, 157 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> 
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
