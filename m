Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98182C9154
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgK3Wm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgK3Wm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:42:29 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:41:48 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so12986450otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cffxSMp/tqz/8dS/QJHaqWHBLSeQ1Bh+L4mSuRlC9KQ=;
        b=XxbLp+dE7ThVntrw76R8GDuw2aYCdf1M0rowUeGSoDltF2E2f+eI17Jc8HV5Cl0PJb
         inYi3gBagNBdHPopQZDTTroh1uFxElUa7bA6ermpb5wc3nZWyu9+NdIVnPPcpmJjdWHM
         pbAb8/AutyNR6PTwiNggUW6XHusnR9LQ8ALs/2vDqB7+sqF3zP9skLkYrIyOrtr5huWq
         nzxa3a2f+Al1g5g8HxOJBOFDuhRqNi7Q7R0ew//BEv7x8X7fxqogAEyjTrScBGwjgPjN
         iDB2h6+di/yh9i4CHOHqmKvAODzczCpL5Bht7omX3A1np5FsPsfYNo/aFVfxgnW/tHmH
         N2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cffxSMp/tqz/8dS/QJHaqWHBLSeQ1Bh+L4mSuRlC9KQ=;
        b=o8eGe1zDq6lNnAh/blhXN1y+rmZ7v2X6SE6LxD7IL9Z0Yj/z1i56XjEb/4m2EK+Php
         Mj6jB8R4chjqFanjiHY+wcsN4NJ8ARxpRMzXc2dWrQ0MeqWC+QDvZuE5Zu4SwfM8a1Kq
         byhAJ21GmWcLPhl140DGe2HK8Xit8yyLRhbanBoE1WQ+EfX8LnX1O8SLwROUgtrvcHO9
         b1vbGyiJj51zdJ2f3c6laVPFtJtQiWVsfE1YG6GZpb/y8y+H8cORABPsAvUhZfhC5Pfh
         4Kj7psjpwaZI/FpNg0d4FITz3dsJaa+dnkIazJzW7DSvZuWZ2Gau+iLJTS7efC/mDMOi
         PP+g==
X-Gm-Message-State: AOAM533xb1CV6ihVSXFGyVH3PnEd09TrlIxRWqXVL42UrOkfwabBko4p
        Gz72cvcJhIeAjwsKKPJQoerhnxb779hsu55TRVI=
X-Google-Smtp-Source: ABdhPJxQObIZqEQzrYyJNyLOSlwaGlT6oG/gi0of7EFIb3bqwmShNujaPgIuvQhIDmBGsNmmf89T2gkZqt+A5PIxe/I=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19239286otf.132.1606776106727;
 Mon, 30 Nov 2020 14:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-30-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:41:35 -0500
Message-ID: <CADnq5_NoskERy7y6rN6VFKo71AW+C1s+Zy8CBm8Z_rLzLdaBYA@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/amdgpu/vcn_v1_0: Fix a few kernel-doc misdemeanours
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:439: warning: Excess function para=
meter 'sw' description in 'vcn_v1_0_disable_clock_gating'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:566: warning: Excess function para=
meter 'sw' description in 'vcn_v1_0_enable_clock_gating'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Function parameter =
or member 'addr' not described in 'vcn_v1_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Function parameter =
or member 'seq' not described in 'vcn_v1_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Function parameter =
or member 'flags' not described in 'vcn_v1_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1454: warning: Excess function par=
ameter 'fence' description in 'vcn_v1_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1495: warning: Function parameter =
or member 'job' not described in 'vcn_v1_0_dec_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1495: warning: Function parameter =
or member 'flags' not described in 'vcn_v1_0_dec_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Function parameter =
or member 'addr' not described in 'vcn_v1_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Function parameter =
or member 'seq' not described in 'vcn_v1_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Function parameter =
or member 'flags' not described in 'vcn_v1_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1628: warning: Excess function par=
ameter 'fence' description in 'vcn_v1_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1655: warning: Function parameter =
or member 'job' not described in 'vcn_v1_0_enc_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1655: warning: Function parameter =
or member 'flags' not described in 'vcn_v1_0_enc_ring_emit_ib'
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 86e1ef732ebec..72148f3b27d04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -431,7 +431,6 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu=
_device *adev)
>   * vcn_v1_0_disable_clock_gating - disable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Disable clock gating for VCN block
>   */
> @@ -558,7 +557,6 @@ static void vcn_v1_0_disable_clock_gating(struct amdg=
pu_device *adev)
>   * vcn_v1_0_enable_clock_gating - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Enable clock gating for VCN block
>   */
> @@ -1445,7 +1443,9 @@ static void vcn_v1_0_dec_ring_insert_end(struct amd=
gpu_ring *ring)
>   * vcn_v1_0_dec_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> @@ -1484,7 +1484,9 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amd=
gpu_ring *ring, u64 addr, u64
>   * vcn_v1_0_dec_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: job to retrive vmid from
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write ring commands to execute the indirect buffer
>   */
> @@ -1619,7 +1621,9 @@ static void vcn_v1_0_enc_ring_set_wptr(struct amdgp=
u_ring *ring)
>   * vcn_v1_0_enc_ring_emit_fence - emit an enc fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write enc a fence and a trap command to the ring.
>   */
> @@ -1644,7 +1648,9 @@ static void vcn_v1_0_enc_ring_insert_end(struct amd=
gpu_ring *ring)
>   * vcn_v1_0_enc_ring_emit_ib - enc execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: job to retrive vmid from
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write enc ring commands to execute the indirect buffer
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
