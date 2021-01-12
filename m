Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A562F3DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391166AbhALV6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbhALV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:58:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:57:32 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q205so3952775oig.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bjYKw/mZXSGXW12duexWo6SJ7uate8q8HNfOvYGKdLs=;
        b=RdI/j+ZnCNl5us/umshUsZYsQ+OQFfIORN89cxi0qvxFbW11Z6RR4LIf3fCI7GVmKF
         7hdMNGS9EpFB9rqJHo6so/WD4x47hwwEAiOXBvN/q5ccHvthFZKKvL1Bek1gwVOb8/o9
         pCw7m7/aEIxXsDHS5l350wxxM4YB5i6MlwjrhPaYVusbiOTwquPNrpyOEwnaqjWsoF52
         WqsFoZhd+U2PWGje8dLnNMEvPneZCHJL088h29w5GR9fq0/Fhs/5Kjj7uhyC3+C5u93a
         hagDLr3jgBL1oDc/llXArfzRm+mdl+kmnHZwqjMpqiq92S+DSO5vtjg08es6WUN5aOt0
         nPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bjYKw/mZXSGXW12duexWo6SJ7uate8q8HNfOvYGKdLs=;
        b=n03/ebm8b6TWEJ66dX9FghIStX8NulzdcobRwwsXWxTCPWljX0qgqGoQ8Wcu6eyJev
         GHQmdIzszbvlfBeHcHEjzF03Ppi0ooFzbQE5y3iQlGt8hYkzuDkBiiDUG+WnuBIIrJqE
         EPi/ofoAyecQquigwisuhwtH6AX/IEeTsTKCcTrLjNhZLIbGtRfdDkyU5B/5zdmcL13p
         Wjt5Gvqb3VqhfOolz+MS8+VZWHmWQvT3qqMPZUfQ2guMgpTgdogGkXGPfKexeFK4/2hq
         StZfGTszsVJUFd4cdSOgNC8rzvKibUAvkl6i6+ll2wJoexlVdzrTerotTAyGV4GOGqok
         2bgw==
X-Gm-Message-State: AOAM530nP8+39C4Is8rjPMCIP08JUTQJr4BAUajGDiiP/TlvMOBQ4M/S
        Zvy2q9xzs+7jDjPtoZevGmVCtlAdHu2iS6ipOfk=
X-Google-Smtp-Source: ABdhPJw8nEPrw/DF5mJev64+us3eTwmsz5935DNCpHhwFGdqdg0F/2lyp5XGK77gmS5equg4IGsH8mdyGGblxPy49no=
X-Received: by 2002:aca:6202:: with SMTP id w2mr725916oib.5.1610488651798;
 Tue, 12 Jan 2021 13:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-2-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 16:57:20 -0500
Message-ID: <CADnq5_OCbxmN+OPFcc1-ROFfJoLHnOgMnAQLNNrTuAS176MjMA@mail.gmail.com>
Subject: Re: [PATCH 01/40] drm/amd/display/dc/dce/dce_aux: Mark
 'dce_aux_transfer_raw' as __maybe_unused
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

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c: In function =E2=
=80=98dce_aux_transfer_raw=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:579:7: warning: v=
ariable =E2=80=98bytes_replied=E2=80=99 set but not used [-Wunused-but-set-=
variable]
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_aux.c
> index 3204292a5aeae..d51b5fe91287d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -576,7 +576,7 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
>         *operation_result =3D get_channel_status(aux_engine, &returned_by=
tes);
>
>         if (*operation_result =3D=3D AUX_CHANNEL_OPERATION_SUCCEEDED) {
> -               int bytes_replied =3D 0;
> +               int __maybe_unused bytes_replied =3D 0;
>                 bytes_replied =3D read_channel_reply(aux_engine, payload-=
>length,
>                                          payload->data, payload->reply,
>                                          &status);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
