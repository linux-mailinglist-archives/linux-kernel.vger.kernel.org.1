Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E3283F78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgJETTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJETTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:19:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776F3C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:19:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d3so641533wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKJ0Z2LrOcSMty3u3jdPYY8eZgYP8C0LUVpRcfJQcdA=;
        b=oXM1ucCGVCDA8xwI/i2vJHb4ovOKZts7YSPsUFdJF7e/+sZSaDL7A0QYciZ7OWuKEf
         rDEcBJ5P6vGuCTJG+i1pmHmXvSeD26/8Ct7Airpr30KIuDF60vxZk6AJJ2a6dVpCxSNG
         nXasaQHlATpm13XS77Z/Cy5N9YgkqS4OaAg86L3akOoTTEVQDB0GN8syBnKNs4hKfGD7
         HBo1SU03KYfh5feBYpd01SNUHCrGOjvhlCclnVr1AIGSe2Nm2aQEM3X+vK7eIZRsnJxH
         14N5FncC90+0CPjWihgjSMRilELvRK59CY1nl5lQw8MBlixkmz86vWsO0T+EGP9tEXnc
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKJ0Z2LrOcSMty3u3jdPYY8eZgYP8C0LUVpRcfJQcdA=;
        b=pRBkCyjEUG1nTTkfheHnU7rAf48yPEElEE9A0YUdbKjPjHcG44KD8/ElJJMm4ebacV
         b8n2oDTJPL9Z46Z85etsrirY0T9kI1+NLEWuEmZA6OT0AbQZRZp1QIJNZtxFyPtDh/5e
         uKynLoUopgzk+AHRhNJ3pcZlDX7DwPC+2VGpnyo7VFnZ5cGooet7LcJZ2PYWfQH/2gcE
         OG2qM/Yko+MRz1G4/kXAYeIy/ZCp9nU94bqj8+qgTgX9n/YmYmDepN3TfaVjqBe1lcF/
         as3dEXapwlHYOKMVzVkPzH5nSqskBkNJnj/46+Z65MSXaBIWPX08zWNZKT16+yx9xach
         tRyQ==
X-Gm-Message-State: AOAM531KKWbjI6OuQL0/K3+jitPt4S73RaV492AgvIpluwRCFk5g3Nqn
        TvfzIFHSMTRkP8K3ZTxjH50JCVfzlMZFKlWitaw=
X-Google-Smtp-Source: ABdhPJzKpkAc9+tHVLcH2XCyoRrlWag4dHEgar33qcoBOzqjotkNWv+m9JGfXyTZ0TRLtiEivBDItncnmVVXp51/CnU=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr857264wme.39.1601925541053;
 Mon, 05 Oct 2020 12:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201004064917.17941-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20201004064917.17941-1-lukas.bulwahn@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 5 Oct 2020 15:18:49 -0400
Message-ID: <CADnq5_M4nagoEoVYL011ysVDZyWp3hKQjfO97GQuvyeW-_QdWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unintended executable mode
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:22 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Besides the intended change, commit 3437f5f6c979 ("drm/amdgpu: add gfx
> support for van gogh (v2)") also set the source files gfx_v10_0.c to be
> executable, i.e., changed from old mode 644 to new mode 755.
>
> Set to the usual mode for source and headers files. No functional change.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Luben already sent out a similar patch.  Fixed up and will be pushed out soon.

Alex


> ---
> applies cleanly on next-20201002
>
> Alex, please pick this minor non-urgent cleanup patch on your -next tree.
>
> Huang Rui, please ack. You might want to check your development environment
> introducing those executable modes on files.
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> old mode 100755
> new mode 100644
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
