Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F12F67E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbhANRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbhANRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:41:20 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D363FC061574;
        Thu, 14 Jan 2021 09:40:39 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x5so5917944otp.9;
        Thu, 14 Jan 2021 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIKbuTpzfW3yd3CewvFIKKZzMyKcmxzXmITP6uJRNoQ=;
        b=RW8yunez+93efe/TW5NSL/34M/gxLz1QB79WnnEb18heEr5OxZ3liQt/d5A3Eilmcg
         mWpwkMI2SVIYghs1p3SB6pFfuryDjLBquX454/zfVdLSGZvE96U259ONEFy/n1mTeI4U
         uNVW/jjo3FiRy0jHwxD9OE16AU2bu8FsoIfCbekPdvwngU6tNzML4/js1ucATWJSrxIp
         l2WCcXJi5Qd4v3jOBlpHDkZ4L1RGstctOZwCLlTm/HrMC0LnbuymeDTKq7OfLQ1Z1/9N
         nNUtmMa5MrmcKnE0EA5oeIWIApRl6Y/X2CwmutbydI5AkcQlj8qmK4t2hULkhH0qgBQC
         r03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIKbuTpzfW3yd3CewvFIKKZzMyKcmxzXmITP6uJRNoQ=;
        b=BXrDk7P8cVqUsy6k1JTgpYdOqSFfboki5za0VRWCQ2hMWF0IOrcAICmJr3seNSiJ6t
         OASwqgmbTYSaMJq3u1SvwO0RZDWi6eGTUpoEMNkYY+jXhdgZIJY+Q/CRjLIFK//9G012
         hXdYskHl0MyfR1WQ+bfxVQTPNjUPooNUoQUt3koSeOUfZs5Asd+RPMKa9/fVZS5YReDB
         OBu8jhnvEWrPiiECXU1oJESsKDo90zouKCBbRbgsoUMEX7cAs2PF4vUJPfVeW21I2ZxE
         0qVoF65pecchai6YrCPuxFfS6LX9BeWAYyf+plW5KR5BYvn/cm8eiy0nfKyS1fQzLIOF
         8/SA==
X-Gm-Message-State: AOAM530QT1xOH6E1SG5imrqEnS5U1rj4iiYUi5G8N9MsCX5AJPdwAiS9
        gM4Jjrs6lulCNGPsNUoh31Ey3w2ylbctbzuARXs=
X-Google-Smtp-Source: ABdhPJyqNOLr77X30jXERcm8sC9peDvPrCuRMfLz2B02kVMs0kUcK0gIWbTM7DPn60u3B36XxDSMGKgEmBBbjPS0aiE=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5547562ote.132.1610646039327;
 Thu, 14 Jan 2021 09:40:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610610444.git.mchehab+huawei@kernel.org> <8e16f3aa553786cd193e49882ce5131e3769afb8.1610610444.git.mchehab+huawei@kernel.org>
In-Reply-To: <8e16f3aa553786cd193e49882ce5131e3769afb8.1610610444.git.mchehab+huawei@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:40:28 -0500
Message-ID: <CADnq5_NeVyxMnUx35qXdm6i7gLbn_uCSNTBHJbEkSM765QsxKg@mail.gmail.com>
Subject: Re: [PATCH 06/10] drm: amd: amdgpu_dm.h: fix a wrong kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Eryk Brol <eryk.brol@amd.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 2:53 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> There's a missing colon, causing the markup to be ignored,
> solving those warnings:
>
>         ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:340: warning: Incorrect use of kernel-doc format:          * @active_vblank_irq_count
>         ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:379: warning: Function parameter or member 'active_vblank_irq_count' not described in 'amdgpu_display_manager'
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks, actually applied the same patch from Lukas Bulwahn a couple of days ago.

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index f084e2fc9569..5ee1b766884e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -337,7 +337,7 @@ struct amdgpu_display_manager {
>         const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
>
>         /**
> -        * @active_vblank_irq_count
> +        * @active_vblank_irq_count:
>          *
>          * number of currently active vblank irqs
>          */
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
