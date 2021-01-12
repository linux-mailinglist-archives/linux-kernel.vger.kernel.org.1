Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2D2F3E63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394287AbhALWHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbhALWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:07:08 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F60C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:06:28 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a109so3750otc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2IK/NFjofvH2Ou69izMNHCTAVddaeni/Whrm41uViw=;
        b=YO6eD2IUoUgFIpbB/zPQCGazEd3RveHhEhQcr7AdqNpI4vqwLyv3TmTyiWg9GY73dp
         HDrNWSHPB3QjJqrAaforMFJpWYbyv+dzceBZdsiwQL/SJFLHBpfFlkSNhAIsyYqZfJDQ
         J0m5KVJpTz85YHMG67Fkl3/GS+MAmCLOqJGGpKweG+xn+vWYe82x4UtX9QvWLdLniS7m
         NZD+sw7QSzgtLCnuJZrHwsc2ADvEODMHFuAJLTtPY9Qc+F7t+mwZHkwgj8iP1YU5SuSQ
         LZIgVK+RDcHVvz3lU0Ge5iZX+2ZGZlRngJpn1BoUE4UMkQGZEkHEjDoZWypBP+sCdr45
         hJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2IK/NFjofvH2Ou69izMNHCTAVddaeni/Whrm41uViw=;
        b=dDBncc1rb0LkI6mSNQixuZ+Wb2R2YbeM6qs/2u4jVKpkQz3BV/JGquGGEUELJ3wtrv
         fHby4Ui4H+ObD2/4mfLdyJC54TFmtR2bnnWcT5JoY6j2KvxtIYj+ns/a1NvDNnkA2P+B
         Xn4Ke17Ps0THYx+85BGlnevRt432x1KSJfHwzxbmx/ExuzyqwHpoctyR9BxTCmbHIlGG
         0rXABApI/hNg9E0j/5LRlJNTgv5x90d0a+TzSHCgkmsHyL+AswVq0fhiPCajpnr5on9n
         ypLuOrazy1h5yV3u/wpmLrvkBaNPT/Lh7AmGQ2pCnILwDadK1UiUwgmWjogRK+u8RmmN
         A/JA==
X-Gm-Message-State: AOAM533Cr2WaLhulzSbfxi/iVneKAtJUuknpwgMn1EVSCAEiltrinJJU
        VhQJR34IN1IhTD5f+fV4Lkn6h7fHwOcFuajdBctXJuIN
X-Google-Smtp-Source: ABdhPJytTKIB/gdnU7OV+wKOCYl0AHKhhm3eKvGBPp/te0fMVPwCgYqzSE9geOrWFVaPw0pJm8BS43a1Eo/lN3GnUvg=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr994925otl.311.1610489187690;
 Tue, 12 Jan 2021 14:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-11-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:06:16 -0500
Message-ID: <CADnq5_N40DL6=VKXA89kbTH-h=AoZ3HTJm3L2yqa0=V8v05eiA@mail.gmail.com>
Subject: Re: [PATCH 10/40] drm/amd/display/dc/dce120/dce120_hw_sequencer:
 Encompass defines in same clause as their use
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
> Ideally someone should strip-out all these garbage 'if 0's.
>
> Tempted to carry out the work myself on principle!
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_hw_sequencer.c:53=
:47: warning: =E2=80=98reg_offsets=E2=80=99 defined but not used [-Wunused-=
const-variable=3D]
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
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
> index 66a13aa39c951..d4afe6c824d2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
> @@ -50,6 +50,7 @@ struct dce120_hw_seq_reg_offsets {
>         uint32_t crtc;
>  };
>
> +#if 0
>  static const struct dce120_hw_seq_reg_offsets reg_offsets[] =3D {
>  {
>         .crtc =3D (mmCRTC0_CRTC_GSL_CONTROL - mmCRTC0_CRTC_GSL_CONTROL),
> @@ -79,7 +80,6 @@ static const struct dce120_hw_seq_reg_offsets reg_offse=
ts[] =3D {
>  /***********************************************************************=
********
>   * Private definitions
>   ***********************************************************************=
*******/
> -#if 0
>  static void dce120_init_pte(struct dc_context *ctx, uint8_t controller_i=
d)
>  {
>         uint32_t addr;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
