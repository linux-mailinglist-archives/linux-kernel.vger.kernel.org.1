Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EEB2F66BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbhANRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbhANRFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:05:20 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:04:40 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x13so5804364oto.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DcVRvQEK7ksubu7g+BB/M37uMUpdY8RBvVIUKA9uUCk=;
        b=Qb/35rVZ24JSH6+SSpdwffQ69oePR9MbcclY9d7TRIfrPOBODobGBlt7y9wR78Repb
         6Yze7DGyLsVcimBRs9o8cj6d8OTzXwbVb4evPuCHoc0FqBddRycYiLS255WdgGD0Sa8s
         LhKIDdVy6StZq5J60M+dQZEibkcY6dGm9MbEH2n2BWfTMrYztIrEdpZp+etF4S6WT5Fd
         k86RWyATyMG8W4I7utzTn+RaCNbc/TR+auD6smY5W5o/j31iDb1LiMqIUGtqoUo/7GK0
         AURrCOT38EdlLvH3BpY+Sq9c+A4fGxV2IJcTEXFrUJculfioSQHZX+VafN0Mywga5WZ0
         97xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DcVRvQEK7ksubu7g+BB/M37uMUpdY8RBvVIUKA9uUCk=;
        b=mjfPAD6IIl/RSDEb9tRmbde9hOTrA0LLJQ0rBKpfUouU59lfs759bo5UnuryWM17va
         GIjXCQA2fvuaDx5EF0pUJrSwazcsOeh5j2hz9LG3L/4m+ngSwA18OW0U2uEH81Y7iAIE
         5Cu3BbVUw0RfUfHN9SvOlZ63z9dmokWWEnTwpWmGGlN9Cdxq+bhXqZWTRa43iCEZ/dyM
         0p5NiRph6fks4BfGWx9qmWx+yQfhvXEbKIDfWnrKn4cXw80bNAyE2qDj3B+DEAoijV/9
         1svhCwtrjVSwBLP8YJX7qFakBEj/9YLCv/FwT41Q398dBJYpqO45xh9xXV/IQufVJi7M
         EMww==
X-Gm-Message-State: AOAM530kCmM4z1TJcH5z1zlzlDFSRgG/xK8BbLWa1kda8HSQ15HPnuQJ
        bVQAtNVN5U+7CklMdQIi4o3ZGQttc2x0NkRgfWQW5W1i
X-Google-Smtp-Source: ABdhPJw+JlA063PAdoTTOEgSfyjqNQT04QxRsju0aUqbDUwPE10f33+nO6AG5esZksVrA15EMTbabwx+1GdJiwhuAXo=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5433320ote.132.1610643879714;
 Thu, 14 Jan 2021 09:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-4-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-4-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:04:28 -0500
Message-ID: <CADnq5_O_c1fEd6OFGsjvh09oZwGhaMg1yzVP8cm0NpJwgqERPw@mail.gmail.com>
Subject: Re: [PATCH 03/30] drm/amd/display/dmub/src/dmub_dcn30: Include our
 own header containing prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn30.c:83:6: warnin=
g: no previous prototype for =E2=80=98dmub_dcn30_backdoor_load=E2=80=99 [-W=
missing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn30.c:118:6: warni=
ng: no previous prototype for =E2=80=98dmub_dcn30_setup_windows=E2=80=99 [-=
Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/=
gpu/drm/amd/display/dmub/src/dmub_dcn30.c
> index f00df02ded81b..7e6f4dbabe45b 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
> @@ -26,6 +26,7 @@
>  #include "../dmub_srv.h"
>  #include "dmub_reg.h"
>  #include "dmub_dcn20.h"
> +#include "dmub_dcn30.h"
>
>  #include "sienna_cichlid_ip_offset.h"
>  #include "dcn/dcn_3_0_0_offset.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
