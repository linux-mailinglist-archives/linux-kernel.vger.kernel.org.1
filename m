Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D432800DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgJAOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJAOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:05:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FBC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:05:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l15so2325174wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3QVRT/jOOAq5ZMDxd7abgDmidUjV54yxotdkWQACvo=;
        b=iN41AadoYyiL2k6h/OTKkRNPeByAwBmWbJyLRLjWYNFVVD8SxC6zPS0Tt9A49v65L8
         mvKdqtRpXURUZ5FVmOgY3LFMD2bNEyZraKCvS8uVnZnDX3czYtf5bJcqixyC7HhXFW5i
         701t5cehleEkwTHc+OW+wfZA0SJjv+HxF26kUP2X98jGTI2kP75QwOHcwQXjlH+w8B4i
         kgrZUCjcSoS4z9AoO73Hh9acdtbd7bbkSpLFFyCVPNU9xpeM6HpTeAA2HIFWy4cAiXcR
         4RSxoBKJlJw54BPb2yInaPbc8bdqwitlPQOYkbbwc87/W4od128pVonguMBdFo/AZ5Vd
         n1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3QVRT/jOOAq5ZMDxd7abgDmidUjV54yxotdkWQACvo=;
        b=a8tCCNLYy6Or3Hnx/2ODxFUTazUKbAbXKsulu/y0a+bgt5zzbGeZMRZZS/KxJ0jTBF
         fH4BqMsv9xlfQBsGYFNDQnuFTd8ycJSaYyIpkOWMIYjCji7lYBbKHKziSdAZ7kwh2+bZ
         cjUJDkWK3lpw5pJJo2lJ57AGRnIDFnaSHVbt/F8Z2Zosbs8CyQ1U0S39oqSEAA5L3DQz
         GhwM5VlS1oYON6aBG9TMZGShx0CMH1ZtOGo34n1PtJOpJOHGKkJPmjdWjWwujVZcN/kE
         /r6tcsMxei0/2JI27VIQFrRGq9HzMinlPJZ2xpXPhb2Hf+DWdXbS4q+H67uQw07Mf5E6
         /WkA==
X-Gm-Message-State: AOAM532aJPtryIR4wsb/VAs0/EVUkpJ8OZHFBl/rC8lRx09i0Ch8LBUv
        iiGlH+XIkKlTtrTdc3JC0x3uuVX9wpDPu2sHYoM=
X-Google-Smtp-Source: ABdhPJwosbQT4PVtn88XFzi7q/IHiboixcUsoO78LhaeO+AX0pxipGsBjeL77hjCzfCm5W3xTDrV+e6fNdJIlPTjUKs=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr201432wma.70.1601561126918;
 Thu, 01 Oct 2020 07:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <ghmu1758gs.fsf@gouders.net>
In-Reply-To: <ghmu1758gs.fsf@gouders.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Oct 2020 10:05:15 -0400
Message-ID: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
Subject: Re: BUG: amdgpu: NULL pointer dereference introduced in 5.9-rc1
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 4:46 PM Dirk Gouders <dirk@gouders.net> wrote:
>
> Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> introduced a NULL pointer dereference when booting with
> amdgpu.discovery=0.
>
> For amdgpu.discovery=0 that commit effectively removed the call of
> vega10_reg_base_init(adev), so I tested the correctness of the bisect
> session by restoring that function call for amdgpu_discovery == 0 and with
> that change, the NULL pointer dereference does not occur:
>

Can I add your Signed-off-by?

Thanks,

Alex

> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 84d811b6e48b..2e93c5e1e7e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -699,7 +699,8 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
>                                          "fallback to legacy init method\n");
>                                 vega10_reg_base_init(adev);
>                         }
> -               }
> +               } else
> +                       vega10_reg_base_init(adev);
>                 break;
>         case CHIP_VEGA20:
>                 vega20_reg_base_init(adev);
>
> Dirk
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
