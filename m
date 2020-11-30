Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B462C9286
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbgK3X3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388590AbgK3X3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:29:18 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:28:38 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id j15so16167827oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ib7F0wrlRrbhxbZ6/EzZShONgbtSJ0jIgAfxKhWyPA=;
        b=OLCPN3Au3UUPcRNJgSYmlA4bAg1MaFhQXY6bjWwjrJsqy2b9KN+hRPS4tezmPolKyB
         LVo/sIwDfC7iz8P8hMVVXnLaRSK/CYO9p5uecCxPM1td8Rw3c3QuQgtkyB+X31J8N7Om
         DSoTDX0u+qr812aeTrN9mpJXGVu1WV0H8FdlSprIb9R8TvZg629KbyLaQPiAl0Z/Xbp2
         RrBQYnWC5p6Qo9HVh9kk+abS9Lb1TccwrU/aXnKE5mm9KpkFvZ5ulK9noDO62FoVDXEu
         QHJTnLB43wYLoVOuxOMk16dArCEi4xNGRRp5r6qYKRFVrnwiQZXRc+YEa/fs257NZ2lN
         SFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ib7F0wrlRrbhxbZ6/EzZShONgbtSJ0jIgAfxKhWyPA=;
        b=RgEqv5Y2HVX41nuw5TChv/fheeLSHQ3HpTesVDQbiDzO6N0m6N3rs8cPybw0D20ri2
         avcHMc7I5gB8L7gfnaP3cG9a6gGkYhMy03YLEIQgrvGNw2IsFiSUO8Oj7nd33KHYSgJM
         wB1gXaNKXclHOVChYij+9xd1PiOrTZe/3VP22ih30gpqOdX+PTOTlRcnJEAsttz3d30/
         bUbcG2ezSOkh3FkJuszj6gaa9NCvWBqcxAnnPc5WFq2sh0kaElEyJHEWsoS3Bk0aJYP1
         cN3m14HNIpHciCa2wlpAdl6nphlsucxI0BuV1w0ZpUFpBYbvDsxHY7cPwlzxTs8JdOfb
         841Q==
X-Gm-Message-State: AOAM530NVehaTUBdmNyV/MgzcrUF4Zd0cto4iraeUz24npCES+dIWuGa
        +FivAZZJVHgvM+u+EuktO3REMdywkWP9t0Td+yk=
X-Google-Smtp-Source: ABdhPJzP2wePVUwNhPUll3zT7E0oyWKKyNq5Pe6VKXzpawH6iUFiKk89j+QfN4UBxZjCrdOngEWEHY8ZFUSywXqwwR4=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr150944oib.120.1606778917428;
 Mon, 30 Nov 2020 15:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-10-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:28:26 -0500
Message-ID: <CADnq5_Ox53r0qF-bDOSVZY0hD09WwFqFTEqDPsvRCpBCs6-aXg@mail.gmail.com>
Subject: Re: [PATCH 09/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'smu8_init_function_pointers()' prototype to shared header
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
>  drivers/gpu/drm/amd/pm/inc/hwmgr.h             | 1 +
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/=
inc/hwmgr.h
> index 1bb379498a121..0e22cba3ce3a6 100644
> --- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> @@ -828,5 +828,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
>
>  #define PHM_ENTIRE_REGISTER_MASK 0xFFFFFFFFU
>
> +int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
>
>  #endif /* _HWMGR_H_ */
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index 739e215ec8b7f..ec17a3e63ea02 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -47,7 +47,6 @@ extern const struct pp_smumgr_func smu10_smu_funcs;
>  extern const struct pp_smumgr_func vega20_smu_funcs;
>
>  extern int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
> -extern int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
>  extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
