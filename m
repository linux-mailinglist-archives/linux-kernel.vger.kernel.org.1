Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD662F3F79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405000AbhALWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403885AbhALWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:21:56 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA7C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:21:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id d189so4037319oig.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l7Y0duFp1C4lw+E+Nzfmj0+WgSI2yLq1yZ1r2Jd4oJQ=;
        b=nXbX9TIhOYo3owiFsiD4pDz/CGmBtv7vaR2Mr+twRXbhbA0/4xxNTkQpUYKr0Rx7FW
         KAUTGT42Qi0G1N1/3m3N3JW+uAHGoEWyGL0slDq3UCUpVLuZcpWitXD92husg/0kG9My
         jFUc6upfUIU+tF8JDpXeT16C0fsJNYxBXCFlG/ALJUUNVl76wDgQAICTL813QulIpgz2
         f5JEAmCjmIxGzkIYR/cqgR9LLCLw4HPDQRB7NiSanJnpOhf50Spx4VMmtHCGLdE0T7HE
         4LAJ/6pc4aNGuZ9UkhJ+2yjQRuqMhl8WhECtubae+pnBfIqzr2vBml5UW+NNTiVF5pSr
         su3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l7Y0duFp1C4lw+E+Nzfmj0+WgSI2yLq1yZ1r2Jd4oJQ=;
        b=OqTxnY6Gz4MbMZypAEciBz1vJSSn5MMej2cpzVOrC8Jo8is76ZxE1l8mExgTgotIR6
         i9W0LxKCBbMUxePFm8990RRDMZNSQg3D/CifgAlUhsJi+UxoH3OueUSADFIeRraXoxwf
         G7C5aMQSkh0AviO5FRb3eK7SBYIzcWPgu7CHpVfw5LsHuG3YIGu7XozzLRGb/LWPkLAC
         WpQ0MTJyMVB9UvHq6G7RaSx8UY1u0xtQzxjfp0emdpetNUIK50RAsH1TNdqTaJxHhsD9
         pVUa9rd/qDv7proFEGtKTnbvUKOhgNp4881x/S8nNTZs1hu3t4kGHEc7TYj9gpgqo8hP
         mQyg==
X-Gm-Message-State: AOAM531oYeBEd9HgZt+Bk/odI2Q/t337v9/4SK+cIORR8yp4p1X/yjaM
        QhPXxeWyd3DTPb+mpapTUkU5ogy2guxHj0u6Klg=
X-Google-Smtp-Source: ABdhPJxc5anMDvnjB+DYgVroZJaGh8IVQ/N4EE42+1GEuf5KCxPaap0rjwGvZsYy5PBdgItNxBVoosG7fY3rOW6L+Qo=
X-Received: by 2002:a54:4083:: with SMTP id i3mr812054oii.120.1610490075337;
 Tue, 12 Jan 2021 14:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-23-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-23-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:21:03 -0500
Message-ID: <CADnq5_MddJZ8EFERTXZp8OfzZxmyHaevd9PZ9VhB+29N557O9g@mail.gmail.com>
Subject: Re: [PATCH 22/40] drm/amd/display/dc/dce110/dce110_hw_sequencer:
 Demote non-conformant kernel-doc header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:16=
39: warning: Function parameter or member 'dc' not described in 'dce110_ena=
ble_accelerated_mode'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:16=
39: warning: Function parameter or member 'context' not described in 'dce11=
0_enable_accelerated_mode'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 4c230f1de9a30..c57405fa4bebc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1628,7 +1628,7 @@ static struct dc_link *get_edp_link_with_sink(
>         return link;
>  }
>
> -/**
> +/*
>   * When ASIC goes from VBIOS/VGA mode to driver/accelerated mode we need=
:
>   *  1. Power down all DC HW blocks
>   *  2. Disable VGA engine on all controllers
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
