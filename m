Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4782C925A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgK3XRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK3XRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:17:48 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:17:07 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id v202so16110609oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0z0SXE8CVPIChDmKOmwTsYRaoR8qX/fK8KklCW+N/l8=;
        b=JToaLIuO/p7X7k6oHV5a/TjdCpmD6sO7yrjy4OYXDtYmvBFEzKGRTkTai2AYYp5Uyj
         O9GYoPtFHbbzWe0Bg5PB652fZDDIljPi+i+9TcGPGu+VycL4NdjSlFY2ep7LWaa8nVur
         8cheF6iw3PCN6TDwHzNVHmc06dCEDdjr3XHo2lnHn1OWiFAzTUuCPYpSok3qZb8ON0LB
         3+lETbFpb01TlQIBTxDcbZpXCnPfHQ7JqL3XOE9i4f/eexcTjTXlhTAU3z4EQXtsO/Xa
         ievk6N7AaqW57Mi0iSqU7Gumso8Ccs/XredO27WBg2E0pAAMvsOrSy9BijmNQDt/fUfj
         U4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0z0SXE8CVPIChDmKOmwTsYRaoR8qX/fK8KklCW+N/l8=;
        b=egYVO8g3IW2XhwByr0GiIOtUq7IjMrFGPRunbeL8KPFYKyKXmfi2DUHjjvvXgeqduB
         Q693rB5xKRIB7W1veptUmqc3+3EhnacqYJQFQrfncJfQWXD8Bgdh6BRFlW4/A3Rv3C5Y
         d/g4prhTTp8AQjRfO6kQ6DbRAMJulruGri/2vzr15uS+v1faO+w2O//6ojEezzKB5l1U
         6EOq8IgIhpCQOknZn3/u0xmJ8tEQDcRj1NtwhRoQlx+Qa4HkTNhT55rGDikjNgMYPFxc
         Coy+kwUG1FK+4MKRKb6IRZKImMV+cqfj1mzLVCyHSotvY/GiIdrR40S4OLTehWfnqcDO
         cqmw==
X-Gm-Message-State: AOAM5315gSpI9E4knXE9UBEDIOeHCu0nPAu9lY0+a3Pag80je7YrF3uH
        hKkOc5ir/POA1uANyK2f+r4jeCpAKEVXrROL49c=
X-Google-Smtp-Source: ABdhPJwylG4/WrqmfM33rZKNpP1ekm16r2XICleifSiU/CfyOhbqgaz+wcFex7cFkK3t0YkVczLNTTDWgadxoyonD84=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr118887oib.120.1606778227470;
 Mon, 30 Nov 2020 15:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-6-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:16:56 -0500
Message-ID: <CADnq5_MWwix=tbV_BZ-hrmVfYKw=xpXgUU2U2htL1roxvTbtYg@mail.gmail.com>
Subject: Re: [PATCH 05/40] drm/amd/pm/powerplay/smumgr/vegam_smumgr: Make
 function called by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vegam_smumgr.c:2249:5:=
 warning: no previous prototype for =E2=80=98vegam_thermal_avfs_enable=E2=
=80=99 [-Wmissing-prototypes]
>
> Cc: Evan Quan <evan.quan@amd.com>
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
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> index 38a5cdcf58967..7d024d3facef0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> @@ -2246,7 +2246,7 @@ static int vegam_update_sclk_threshold(struct pp_hw=
mgr *hwmgr)
>         return result;
>  }
>
> -int vegam_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
> +static int vegam_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
>         int ret;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
