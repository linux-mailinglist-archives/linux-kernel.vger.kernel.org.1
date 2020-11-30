Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233652C915E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgK3Wpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbgK3Wpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:45:41 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:44:55 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n12so13008071otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9eou7H4jUQYuMP40Vx2X7n5sdb9mdDkeKlmAnOCDMKk=;
        b=F8GJtZV0IDEsWCjG1kzv2MF1f+nIQbW4a9h0GlctfNufh5gZzzr2xi8E5QRtMsQLiu
         z5RiLnA1ZVEsTIu5ebHv5nf0nCIzV26e2ReLZCHtQR2wr/8nkW7DXAirLx33ztC8vHJ2
         iZA/NiFaY3ZMiMdgTm3xagDdlZskNmiotAGdbyNJJybxzmGV9O7W9hooXoxH3Bgrh9M9
         NGo5pZVEMJIAUclrZMfewAOT4uDM9beYKq7vmoeAu210qa3FHBE+hUyU6LhqlZnn3/Uw
         qHCuuE3Q6xcLxKHQ37R9hqIBrEp7As3a4jlNy4fGEbUiinHm5+JBJJEh0vCFCfn3TACq
         xe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9eou7H4jUQYuMP40Vx2X7n5sdb9mdDkeKlmAnOCDMKk=;
        b=d/QoRzdmSq4vzLslgYdU5fxiCEXWYWRdHfYWK2znGNqq8wevBtAsPfXotVk4uzuclt
         0PXW+ICZsDHe11QnqnWg7cWyWAuTSOaFLvxXMjyI64COBBgT3zm8Y+6Co890wKJz95Zm
         4dtkKFX1Vq09Jf+HA6+Wh8Xi5uZgK8qqkGrdpk4O7lz8nHaT70yAnYEkSZLoF8SFr8Fi
         rBbpaXHEu5mL3waUo5B6WOA1sRpvmk9tM0/qMIsKOotZ1OcWoHC/XRqeO9qUEP7R1nZc
         rdp01osk5ZldivELDR6D8TVoAnuFxZx8FwaqoyyhtPJ68P5siUK25iM7LJ/UR68M33yf
         uv4A==
X-Gm-Message-State: AOAM5324bc17xwacie9NEUDUlhjOwMigSAEMZ818uN+H0tyD/v8IRuWJ
        AXNp/tvXkYLxyubNNJ1PlqyfH56DHj7llTbBX/0=
X-Google-Smtp-Source: ABdhPJyv2GldrfqUXKNWguuCyw1r0o+rVIKgOCIw6Di6iY04CaqLyUTz+fvR1dByMsH//fFcavJ3RqADmaOJ43vm3cs=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18812087otg.311.1606776294749;
 Mon, 30 Nov 2020 14:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-32-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-32-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:44:43 -0500
Message-ID: <CADnq5_PHJnXaDbj=Y5zGoXgx+kD2aiN8LPDM52FqOxU2w15GJQ@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/amdgpu/jpeg_v2_0: Add some missing
 kernel-doc descriptions
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

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Function parameter =
or member 'addr' not described in 'jpeg_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Function parameter =
or member 'seq' not described in 'jpeg_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Function parameter =
or member 'flags' not described in 'jpeg_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:498: warning: Excess function par=
ameter 'fence' description in 'jpeg_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:549: warning: Function parameter =
or member 'job' not described in 'jpeg_v2_0_dec_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c:549: warning: Function parameter =
or member 'flags' not described in 'jpeg_v2_0_dec_ring_emit_ib'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor fixes.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 6b80dcea80ec8..15c0224d48b06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -489,7 +489,9 @@ void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring=
 *ring)
>   * jpeg_v2_0_dec_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> @@ -538,7 +540,9 @@ void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring=
 *ring, u64 addr, u64 seq,
>   * jpeg_v2_0_dec_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: job to retrive vmid from
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write ring commands to execute the indirect buffer.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
