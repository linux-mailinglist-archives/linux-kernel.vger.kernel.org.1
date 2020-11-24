Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2182C2C81
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390248AbgKXQNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389426AbgKXQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:13:09 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E052C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:13:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so2909207wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qzYhP0b8ID3iThkWEoh3xFX/9VMn9nUYQ9ogFepHOHY=;
        b=TuQ0t9ZpKW4ggOGRiqM9dTnIH/lHkFnZhAF6uzm4dmBuQvOoa37WzbapO/5xtoLSkz
         zSVFoquDpoF8/3bSA3Zk7821O8rQHPeYblUsu2BGcMBmkWmX/aoNXNbtxN15GprgAPrh
         GjzCvfYT111CGrRk9Qh6cd04WWvw2KiGVMFQDTf/Y6khAlN4xCJKzqsn56333RzQ+VEQ
         Z6liRVkUclidNgKbEnh0N7IOFIZrt3JQtV6cenOM5d9NCG9hqmVx9mvSi08cStSCYRy1
         GQOLtAnZ2AIjSSlBCiAMTtzzvBmyyUXjN+rJ/ZW9ANS1l9hIpm7MMfCwJ484fhdwVL9v
         kdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qzYhP0b8ID3iThkWEoh3xFX/9VMn9nUYQ9ogFepHOHY=;
        b=aDBtyaS3y3ad3br28Oju9L6Z/0ZZGXkmACwByjpMFlOinM4wwyxy7KpDRIGfwZUUUq
         bpYOetCMN1eNKCTN2BBmtdm8TlgFMmgTJqqrQDD2+7zVpi3yd7hF4rYCc0BbgHeC25yx
         4UiTsX+oQ2abmq4alpoY8XGdKLQ8loQo31dkJmnjDU3sHZGko+5yBTicqItUwmVf5jAk
         Lz9pkPVgiNxvacOwiDbX0mFub7/Xl2IZrOMqaQjZg10coc6ihCCgCTOhcsHyOBggIiHz
         DV9e+ZkXG4gYnpxAYvXG5XdfHXLTtdwbZyM++CxqXTSyi/sGDm6zUrEdW3Hefe3q22Ff
         h5TQ==
X-Gm-Message-State: AOAM531hI+gvuT128IAIF7znt+0yWGKx5utAKUXym/KwHlphjIupauHM
        11j5R0KHQow4VYooyU8RRzNK8EI2vhPYPNxdhSs=
X-Google-Smtp-Source: ABdhPJzeyZtAFf/J5jW+ZtF8k+WE6FDG/QuzE51jZAELAPXsmdi3+wHV8nliAKBzAjjloQOYFQfS141MEL7cbeStRP8=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr5100898wmb.39.1606234388284;
 Tue, 24 Nov 2020 08:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-26-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-26-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:12:57 -0500
Message-ID: <CADnq5_Nw3MuqV-GcAiCcUkaVPpm-wXnsQ6Y2X-aZY21AxYPYWQ@mail.gmail.com>
Subject: Re: [PATCH 25/40] drm/amd/include/arct_ip_offset: Mark top-level
 IP_BASE definition as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/arct_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/arct_ip_offset.h:227:29: warning: =
=E2=80=98DBGU_IO_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  227 | static const struct IP_BASE DBGU_IO_BASE =3D{ { { { 0x000001E0, 0x=
000125A0, 0x0040B400, 0, 0, 0 } },
>  | ^~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/arct_ip_offset.h:127:29: warning: =
=E2=80=98PCIE0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  127 | static const struct IP_BASE PCIE0_BASE =3D{ { { { 0x000128C0, 0x00=
411800, 0x04440000, 0, 0, 0 } },
>  | ^~~~~~~~~~
>  In file included from drivers/gpu/drm/amd/amdgpu/arct_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/arct_ip_offset.h:63:29: warning: =
=E2=80=98FUSE_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  63 | static const struct IP_BASE FUSE_BASE =3D{ { { { 0x000120A0, 0x0001=
7400, 0x00401400, 0, 0, 0 } },
>  | ^~~~~~~~~
>
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
>  drivers/gpu/drm/amd/include/arct_ip_offset.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/arct_ip_offset.h b/drivers/gpu/d=
rm/amd/include/arct_ip_offset.h
> index a7791a9e1f905..af1c46991429b 100644
> --- a/drivers/gpu/drm/amd/include/arct_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/arct_ip_offset.h
> @@ -28,12 +28,12 @@
>  struct IP_BASE_INSTANCE
>  {
>      unsigned int segment[MAX_SEGMENT];
> -};
> +} __maybe_unused;
>
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE            =3D{ { { { 0x00000C20,=
 0x00012460, 0x00408C00, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
