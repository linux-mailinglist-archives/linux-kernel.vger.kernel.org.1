Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7272EF986
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbhAHUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbhAHUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:41:12 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3DAC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:40:32 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id n42so10916487ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7USUfBSYNoXr//1ygkSq10RDo/1Zyym1BvRpYGLGfmo=;
        b=hL+zB/53a3D7/Dz2T4csFfGInwbU0EN94DemgSD+CYJUk4LwRrIxAUDKhrABpKUbGY
         m73J7++gpKyfHAsEbvUyYwh28HajKGoSgwjGFfO+jenIvmQU4x1ayaAzkKYRVFBklZDs
         bHGS3vYQoxgGVnnfDOz1kLPjV7R65V1dl/uqTG0zVuCid7sIRuZ0JZYb81dDFdUOYq1a
         n60oBvCd01ZadjpahratJ8mtq/hpKYMOcSk15QARypFtOdnfwHVVZSzxRBmykP0JcLx6
         UnCWIrRbQv0RZn8dNYvDgefi7gBdbAsn9QL1jNQiiX1CSnOvktcmUUipb2cmh9puhJml
         Zsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7USUfBSYNoXr//1ygkSq10RDo/1Zyym1BvRpYGLGfmo=;
        b=XVDA2OY924269O7jpYZX2dUr2khO72TbK/aUtCypEmsgfAMzcISk5AH7B1FnGiOBSW
         c1Rh9PW84qWT5sfD9c1LPp/k4mm4Ga3/547Mxjyr0uJs5J2SqYD+vJPlpPgK2By66XGA
         ls1YuU+UARtDLfhoqefivXBwUAclBmJJLNpTtQuLJUSg5Ei3Ox+UiWZ4pSI+lB+9uW/F
         KWpCYyI33YRykJTNFQyr1USv2BfOI1o6zFdwsudu4xacp6LKG0XrzSwZqvy7p0lfrora
         3giXO7rPFeeWou47F/PdwQVowh5xwDhYHjF0wh6Ye6gwFfehLjxzSc/losSkC11Kgk9Y
         fJEQ==
X-Gm-Message-State: AOAM531TaDQ5JbG097TXo/M9v8SjBWokLpYzzwBDRsuv9XYSp+treoEV
        PuvSMhJZcq/m8y2+4pETLSFEugt21Tzhp30FbcU=
X-Google-Smtp-Source: ABdhPJwRrpd22ECWoBX6bY7sHAEZBIGQRs0c0g7zfb7/k4Uv/xcqSzrQAYOSTfmFOjbYC1p2uB6IjCCBaJC8/o2fM5A=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr3997488ote.132.1610138430197;
 Fri, 08 Jan 2021 12:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-17-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:40:18 -0500
Message-ID: <CADnq5_MuiUeU=-Y0yi_3jv9j0dKuWNja1W8MA4vje-0Ggax+xA@mail.gmail.com>
Subject: Re: [PATCH 16/40] drm/amd/display/dc/bios/command_table_helper2: Fix
 legacy formatting problems
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

Applied.  Thanks!

Alex

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper2.c:14=
5: warning: Function parameter or member 't' not described in 'dal_cmd_tabl=
e_helper_transmitter_bp_to_atom2'
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
> ---
>  .../display/dc/bios/command_table_helper2.c   | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c =
b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index 7736c92d55c40..455ee2be15a36 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -128,18 +128,14 @@ bool dal_cmd_table_helper_controller_id_to_atom2(
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
> + * translate_transmitter_bp_to_atom2 - Translate the Transmitter to the
> + *                                     corresponding ATOM BIOS value
> + *  @t: transmitter
> + *  returns: digitalTransmitter
> + *    // =3D00: Digital Transmitter1 ( UNIPHY linkAB )
> + *    // =3D01: Digital Transmitter2 ( UNIPHY linkCD )
> + *    // =3D02: Digital Transmitter3 ( UNIPHY linkEF )
> + */
>  uint8_t dal_cmd_table_helper_transmitter_bp_to_atom2(
>         enum transmitter t)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
