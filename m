Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19F2AE2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgKJWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKJWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:10:53 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F3C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:10:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so6552690wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ukynJdVgZ5J1U+TIrNmOqXFA+lgvobo4dd1cCqdQQ+Q=;
        b=QvRqVwKUlzD/PN5Ki8U4o+iG6OiM14ucHgjS8nvbfRrAzyojd6sQVnmypsUZ2W9pvD
         0NuZy8JxUJk+i/ixHNdBhvRHTbTM4I1GY7zxIxcSvTL+Hpu+tZSFY1zU9Zn4M16NYBsv
         fn73zeH9JGqUiMQwJVFqr5i2Lyc56W/Zoihv1VwyGkEwjEYPQmbBVEMczynGi8/7vDyc
         bIm3VJdmVZ53UFMd+JmkcML2zpeRc2hDZxlBWyEC0+owuC7dAxD07EuTkwMwdSrFdFDI
         dJ+2MSZ8AZ+8al7SFwqzN6Cgd5eTNO8d+bR0x0+0yu3a6kd9bugXm+acTzjsZkrMskGO
         jykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ukynJdVgZ5J1U+TIrNmOqXFA+lgvobo4dd1cCqdQQ+Q=;
        b=T6lsHG/6JGtjdDGnQNxb1dgvFNAxlNjl3MeOm72z6mm3AAFBbU8p4qkGFCS3Fc2vlW
         ZLECnT5ZKQiR2wl4Y2PB0YghM3VjLLkMLL+Oo/SwUb/c62lZ6nEs0fPh5qoxNl8o2+iF
         Te8qvyZCwsQdI9pD9DplawXlvVb/j6FKLIkdOamIlUUB9ZIVKjxthKXmoiweIoWbUzsb
         1k46JPp9t6/E2hag84FGjoj333+hgUFCAuzvBpo1g47nSdabbCGPE9OXVCUwIWaDpb7y
         ZeSJi6Kz24KKYYuU6KuhmL91xUCvt29DFvLLTJN+fFDsDYe13RxfFR91Vf/TrBgTRc2I
         yNNA==
X-Gm-Message-State: AOAM5328PTuj0+a5hFg4KoG8H7MSXKPfBE62EJ4tVs84nOqVUkGF2+Fp
        QzDHDBiVzcS1YnaJV8X4Ve7rxxNDn0ccOEB0PZk=
X-Google-Smtp-Source: ABdhPJxBwPA7qVfB77oYJYHLquoUC/Tat5KRk52NjV+OfYgKGD916hz3E+sw5nyp1u12rnNY2h2w8t7Y/h/3Q05QVtI=
X-Received: by 2002:adf:e551:: with SMTP id z17mr26987302wrm.374.1605046250594;
 Tue, 10 Nov 2020 14:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org> <20201109211855.3340030-9-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:10:39 -0500
Message-ID: <CADnq5_Nz78bu3yovnPGUw+fOXRNb1hoZUQAFcoqkdUpCxENWpg@mail.gmail.com>
Subject: Re: [PATCH 08/20] drm/radeon/radeon_i2c: Remove pointless function header
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

On Mon, Nov 9, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_i2c.c:46: warning: Function parameter or m=
ember 'radeon_connector' not described in 'radeon_ddc_probe'
>  drivers/gpu/drm/radeon/radeon_i2c.c:46: warning: Function parameter or m=
ember 'use_aux' not described in 'radeon_ddc_probe'
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
>  drivers/gpu/drm/radeon/radeon_i2c.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon=
/radeon_i2c.c
> index 545e31e6cc3a9..aa61b3cb4049c 100644
> --- a/drivers/gpu/drm/radeon/radeon_i2c.c
> +++ b/drivers/gpu/drm/radeon/radeon_i2c.c
> @@ -38,10 +38,6 @@ extern int radeon_atom_hw_i2c_xfer(struct i2c_adapter =
*i2c_adap,
>                                    struct i2c_msg *msgs, int num);
>  extern u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
>
> -/**
> - * radeon_ddc_probe
> - *
> - */
>  bool radeon_ddc_probe(struct radeon_connector *radeon_connector, bool us=
e_aux)
>  {
>         u8 out =3D 0x0;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
