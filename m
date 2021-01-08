Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2070D2EFA74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbhAHV2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbhAHV2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:28:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C26C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:27:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id r9so11020086otk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NYkErQ4AHdUR0Vvl84qd6HPOGv2R/JnhTegOcomXRBs=;
        b=q0qMGkjOefruAmuAbGs/pbxXilmN+s+QHQlgp3mq2OlofJyziZF3piioz+tFZJqBMA
         w2GxCvkSCaG9DRaXbEjIpLs1jgXF7JZEMNYfAq2haqUHexroxrmpFAaREN4BPO7EEP2D
         cYoRmvql5j299T0G8XxqxYvVaxbKGSdt6n4dZwU20sTxdSqX/ygqqrEG/4ZOJL5h4IXY
         fzYYSLcoeDVALgIWu/PPSODNbYtMA8ecQqv6WMFDnAYgVrxbNJfvQYsMZ3TfjK/V2+g0
         Gvkx96Ar247Mwemi7K2/LsyS7+UR4KkFwBrSf3eMlQ/PWtzYtbG/yx831l9/w/Uu9+gR
         KXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NYkErQ4AHdUR0Vvl84qd6HPOGv2R/JnhTegOcomXRBs=;
        b=M45RnsX0ICBNmfF15nFRE0JfOJlT/MZzEDNs0zs4Pmgdh7H/bHfesSBb/hI8w+04Vi
         thCogXSf9JWOEfzdsWhbS1o/9o5gaYG6NzKGF7Za+5P8pjRi9WYJpl0QQBUSNT2C+hEK
         h3qwGH/eAlL9LxIa1BWD3owIKDKD1Y9zK6lBrRsx5i5NPlU5dXRNEP+2smn9jEm3Z0bb
         7aSWDbB1QfDhDzaFEQW6quO7W6TnwCBt4hVlUEYdMC2jIckHd910xPy7QtQ8u/2+bPA1
         BznzJqg8lRiVHfxWERzpv49OltTxhc20aSWiKv05WoLoWgmLcJrjT6lR/qMizKcBo9lI
         3YQA==
X-Gm-Message-State: AOAM530yh0+3Sb0Mqln4d3XT140HMvEaM9KmA4iOZQWcS5H9ZJY1SWas
        18YBt3HIUny8WZTxQ/QS4jOYO3c4EdfO769Fe0vLCBiZ
X-Google-Smtp-Source: ABdhPJwEuslKFpvX3tR6DIk5q/5aW7SnKhw0lUKSGZXrCYTZ+XAAD8GfgyZK+WeNfJJKDTLIJOXd4n4XusWP+5d1cZQ=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3909843oti.23.1610141244904;
 Fri, 08 Jan 2021 13:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-41-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-41-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:27:13 -0500
Message-ID: <CADnq5_MYg_OBqm0a0oybZ1___MjjsfS6hhrjn9jKUuC+8Jgk9w@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amd/display/dc/gpio/hw_factory: Delete unused
 function 'dal_hw_factory_destroy'
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

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_factory.c:123:6: warnin=
g: no previous prototype for =E2=80=98dal_hw_factory_destroy=E2=80=99 [-Wmi=
ssing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/g=
pu/drm/amd/display/dc/gpio/hw_factory.c
> index da73bfb3cacd0..92c65d2fa7d71 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> @@ -119,17 +119,3 @@ bool dal_hw_factory_init(
>                 return false;
>         }
>  }
> -
> -void dal_hw_factory_destroy(
> -       struct dc_context *ctx,
> -       struct hw_factory **factory)
> -{
> -       if (!factory || !*factory) {
> -               BREAK_TO_DEBUGGER();
> -               return;
> -       }
> -
> -       kfree(*factory);
> -
> -       *factory =3D NULL;
> -}
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
