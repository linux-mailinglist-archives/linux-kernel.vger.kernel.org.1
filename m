Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DED2DAF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgLOOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgLOOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:52:03 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14F1C0617A6;
        Tue, 15 Dec 2020 06:51:22 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j20so15097741otq.5;
        Tue, 15 Dec 2020 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0DMv/St3NqIUqqEhzUW0JjVVj9cnrE4Jv/Mn3i8+BQ=;
        b=Y1uPN1EWWchDXLF16HwOYZllLm+z8b8kgPh247aP1bEKMr0lzTVSD1Kawq3VWpTfik
         86oyL2c7ebaxTZM+bPv3dYlR5SM9sZXNougTWPTL5l1CIYrZrhCkCd5h8HVBV2WcTvFY
         4iZ9SwaGz1x1qUU9UZrbV/0mzCfgLqqwO3sONr0FURw1vrDardYkHIU5/DabijTMwFrO
         qmoZlMT6pihTdUWbBFMoxxA3L+Dql10+jgKDjQWkMBnj6APhr1JFamISwPAilVSmY9t2
         IVRCB1kUQHnm/KFX8iAu6rZA5jziQZeP5jgCq9AbjnxehxLqL2eYdVr6ej+qnH0PWN4x
         KDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0DMv/St3NqIUqqEhzUW0JjVVj9cnrE4Jv/Mn3i8+BQ=;
        b=SiM99l5jZpifI0y5BRKOt/AlQI4+majU5cU2+43HK4/Xl+EGcDC9gbkfS31MdU9fsf
         cbZW+4Bx67acMJRqU/4pcTarPt2vVsM77qYJIV8jFZUoMkNiTzI1Vjl9/ngT2HjNl3lv
         qKLeebu/CfaV4Nzns4CqdlUIoDgQT44K27UE1/I//DLIjQWIKh019ianvYwWCCY+535h
         Fwxdgl5rNSjYuK2TSQuzonsJRqZhS46Xc5xid/Q1c0Z54pWvHKsMzQQxf27yDvPyyCvX
         vB5PQqPwJJvJbGjLbxjjoWwJJXuUEHhgs8bD0hlC1NqhXcQyy+hUQcoZsfQtDOr+fy9f
         I3+Q==
X-Gm-Message-State: AOAM532eUdjY37xQp6IwKW8o1aYW2TOI18h9P5phkhzYlwgL/FvsHp8g
        1OSxyqRp2Op9IiqTTzG0s0WSkNRm93VTUjNaeHc=
X-Google-Smtp-Source: ABdhPJwLVsjfgzc+RExdBVI/+RYvWYtptZozVV3ppwiUhcjKkD9kx1KH9rRorpvj1NtS6mo7tcQEss3dO6Q8jlOOlHQ=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr23521172otg.311.1608043882328;
 Tue, 15 Dec 2020 06:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201215105651.138391-1-colin.king@canonical.com>
In-Reply-To: <20201215105651.138391-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Dec 2020 09:51:11 -0500
Message-ID: <CADnq5_MtLo6SiWOSADwmTEr46gEfqC5Oj15Tj4TypGx8tsAoAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix spelling mistake "Heterogenous" -> "Heterogeneous"
To:     Colin King <colin.king@canonical.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 5:56 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a comment in the Kconfig. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index b3672d10ea54..e8fb10c41f16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: MIT
>  #
> -# Heterogenous system architecture configuration
> +# Heterogeneous system architecture configuration
>  #
>
>  config HSA_AMD
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
