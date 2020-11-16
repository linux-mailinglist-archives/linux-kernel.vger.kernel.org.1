Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7E2B51B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgKPT5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgKPT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:57:08 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD13CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:57:07 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 19so489125wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/UCaw7X3P7z/cBmEH8BLiazMTEggP6Dng172R08XqlE=;
        b=nFLRdlWHDhI4/em2J4oMSbWjBy5R4ImhX7LV8vU1ixn1HBQXMYllhhhcwC2Vj4oH0P
         x10fZuCzUqw5PKY1YYnIwAm8BArxr2xMV9j2U3urB+JOxLRLP86eQGt1E/UJUf37VzUi
         SF3Ee5jsoxCHv0cr8mlSbPtnui98wj+jtfxyUCCvuejtaJ3yLV2ZMdviU8sWGgoQnVF4
         PTalG8ih1QEddSfnRuBn+wmZdD6o7D9YD4RfLaBhUb3nOzJqQYHlmzVzec99VnFXCKss
         SQWmL/9ANDBR+p8fyW5DW+9/hx1eHhTqUQIA55vJWUmPJ8o9/iGSJjcg4v5XJFqgWt9b
         iZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/UCaw7X3P7z/cBmEH8BLiazMTEggP6Dng172R08XqlE=;
        b=YUuj8Nd04BZtMZQKgkZnblDTH7mDszmeJc1LO/StjXn+NaTPUnmWk1yAZE/FXgmpn6
         BmX7pMvwhHnp7SDg8hTNykqXXer0zNbOM62buwUr0HVSsW5j0NfdDBJ96BiWLyQe+/VV
         wcYK7VkOVCsIcdKEFi1cRbhlKrjjkI0i7V8/0xkKDHKz+MRl1JvLgdy95IwAtwMRyJQU
         wZoMU2dX2UY1Q25Lrbt+epivkhpbyWMi7nuxmT9dIAMfsUcetuE9sU7KNrPqgFpXtvco
         +HYnzwCxp8KrQjx0XGZ43p1yaJxXH6H0JLRwkSEQaYthuP6g11JYaQdkBstMBOD01moY
         njgg==
X-Gm-Message-State: AOAM531YiZ+gE+GPr8Cn4bU1zzk42oe3+CORXbc+DuFQ6Av1EXJRc8XM
        no3bUZUBpVXuIhX0iLvxuLEJe2L+TkNkBlsXesk=
X-Google-Smtp-Source: ABdhPJxCVpNqYs3aplYAyaOcRgyLwjP46yvCt4GGTWu8IPMC+qRBXB8iwEnsCdRX5XgAkvcTX1wkre9lWbQq4iRax/A=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr538158wmb.39.1605556626649;
 Mon, 16 Nov 2020 11:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-16-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:56:55 -0500
Message-ID: <CADnq5_M2_Uu8Zf8OiOp8yOQmyYG0Lk=ist_CO+6u80_SOWyqjQ@mail.gmail.com>
Subject: Re: [PATCH 15/43] drm/radeon/atom: Move 'radeon_atom_hw_i2c_*()'s
 prototypes into shared header
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

On Mon, Nov 16, 2020 at 12:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/atombios_i2c.c:100:5: warning: no previous protot=
ype for =E2=80=98radeon_atom_hw_i2c_xfer=E2=80=99 [-Wmissing-prototypes]
>  100 | int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/atombios_i2c.c:150:5: warning: no previous protot=
ype for =E2=80=98radeon_atom_hw_i2c_func=E2=80=99 [-Wmissing-prototypes]
>  150 | u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap)
>  | ^~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/atom.h       | 7 +++++++
>  drivers/gpu/drm/radeon/radeon_i2c.c | 4 ----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.h b/drivers/gpu/drm/radeon/atom.=
h
> index 1bf06c91cd959..5de0563b63d2e 100644
> --- a/drivers/gpu/drm/radeon/atom.h
> +++ b/drivers/gpu/drm/radeon/atom.h
> @@ -154,6 +154,13 @@ bool atom_parse_data_header(struct atom_context *ctx=
, int index, uint16_t *size,
>  bool atom_parse_cmd_header(struct atom_context *ctx, int index,
>                            uint8_t *frev, uint8_t *crev);
>  int atom_allocate_fb_scratch(struct atom_context *ctx);
> +
> +struct i2c_msg;
> +struct i2c_adapter;
> +int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
> +                           struct i2c_msg *msgs, int num);
> +u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
> +
>  #include "atom-types.h"
>  #include "atombios.h"
>  #include "ObjectID.h"
> diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon=
/radeon_i2c.c
> index aa61b3cb4049c..e543d993f73ee 100644
> --- a/drivers/gpu/drm/radeon/radeon_i2c.c
> +++ b/drivers/gpu/drm/radeon/radeon_i2c.c
> @@ -34,10 +34,6 @@
>  #include "radeon.h"
>  #include "atom.h"
>
> -extern int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
> -                                  struct i2c_msg *msgs, int num);
> -extern u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
> -
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
