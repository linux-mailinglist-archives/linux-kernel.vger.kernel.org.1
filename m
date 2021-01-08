Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480BE2EF97A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbhAHUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbhAHUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:40:32 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592B8C061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:39:52 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x13so10931553oto.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iac5XmZ0aSrPS3x4buC8VUJtjwj44d0E1FKt4htO0mc=;
        b=HCXOX5LQSKc9wfoXyQF3/5NqcGdNl4Axz0ovvQqyj6BWLBT0FYt2ARefLwylGulsmv
         9W1TgXQ7BoXD+VtEohi2qrje+a34upCTUiEPZhUbq/cJxBcm3N7ONmZI2I+0YWBP6SmN
         p3ffNs35srwJf8PrWLXssWyImz4o98fJPfExrWDtPmQxoo/s6hkf3tpAyIqo/Vu/ICZC
         hWKqsWdBLlOW9E4VutNpmsTDgd6uZtV95f2Led0rcUmJudz5QoO4H+Be2EvIHe9AhzO3
         yOj7lC/RPToR3aW4DB66gEeKV7gT8VY7qUXWkf0hB+OQP+QPkxbj0gQRjXPKFCnoquln
         nGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iac5XmZ0aSrPS3x4buC8VUJtjwj44d0E1FKt4htO0mc=;
        b=IU6pAwvkgfNeow+Tf+Uvz9pLSVjJnvn2NrqyvdmtbJJ9UkLR5eQe0eXSr+O36LCuK3
         4gXrTdh2IqEwN4fz8bEVsn5/dWcEKwBc7Q/A1jN6LNeCEdsLqyHanT8me/XpYaW/iDUa
         mVtJqEJkocYQ6+dUoPvrTvuiltKzGOdjST2OQAOAMJqaY4fFc+gDTK2pyETbJEw62nL5
         pHchUkxkUD9YWnScVnRL30LlcoXjrZrz5eWgaI+ak2B2iPcv/hMfvTEYnABHnogqNvEh
         Y/3Soal5GO7OQyGu6e/OIgkPmb4Nq/KT/fKhcVROtLaIe2BcUMA79+XR6olJJUtES2XU
         4xqQ==
X-Gm-Message-State: AOAM531+Tj68ZHbkkNIioreGQPJEkTHP6hH/U9bSQYCo9qlqYj2mRDMT
        aE7fBW+tyl8SrX+wxRkrJKBRBzyFU7RdOwLUm5NreuSc
X-Google-Smtp-Source: ABdhPJxGTk80mgwAzb1wy8whX7yzl4+b5mretNLGSn18GjLOVwMurYgzStVlo5sqtojIZQZSIGyfqYYhRZhlk4tB8Fo=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3802145oti.23.1610138391838;
 Fri, 08 Jan 2021 12:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-16-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:39:40 -0500
Message-ID: <CADnq5_Odv9EXFfi5TGVDrdDnLrtJs4sH4E4Om-oFw4TsLdBV8w@mail.gmail.com>
Subject: Re: [PATCH 15/40] drm/amd/display/dc/bios/command_table_helper: Fix
 kernel-doc formatting
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
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

Applied.  Thanks!

Alex

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.c:131=
: warning: Function parameter or member 't' not described in 'dal_cmd_table=
_helper_transmitter_bp_to_atom'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../display/dc/bios/command_table_helper.c    | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b=
/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
> index 48b4ef03fc8f8..5b77251e05909 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
> @@ -114,18 +114,14 @@ bool dal_cmd_table_helper_controller_id_to_atom(
>  }
>
>  /**
> -* translate_transmitter_bp_to_atom
> -*
> -* @brief
> -*  Translate the Transmitter to the corresponding ATOM BIOS value
> -*
> -* @param
> -*   input transmitter
> -*   output digitalTransmitter
> -*    // =3D00: Digital Transmitter1 ( UNIPHY linkAB )
> -*    // =3D01: Digital Transmitter2 ( UNIPHY linkCD )
> -*    // =3D02: Digital Transmitter3 ( UNIPHY linkEF )
> -*/
> + * translate_transmitter_bp_to_atom - Translate the Transmitter to the
> + *                                    corresponding ATOM BIOS value
> + * @t: transmitter
> + * returns: output digitalTransmitter
> + *    // =3D00: Digital Transmitter1 ( UNIPHY linkAB )
> + *    // =3D01: Digital Transmitter2 ( UNIPHY linkCD )
> + *    // =3D02: Digital Transmitter3 ( UNIPHY linkEF )
> + */
>  uint8_t dal_cmd_table_helper_transmitter_bp_to_atom(
>         enum transmitter t)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
