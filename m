Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936B22C9169
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgK3WrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgK3WrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:47:10 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6722C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:46:29 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so16068884oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pi3SM6JsbvfP6RtMtAXOSB9JCtD13VeOaOmtjrxWoNE=;
        b=dL9e3q/XYScyZt1CTB6FOMhIphcFfhq1C1YAFX/arw1+b5OeQZEUAU8znvkNpTUUAG
         Inrdwdqu9WIn7Y0v/7ad/CDfkuduUa2Xgc+1yZReYfcOc2z5PDlaMdqTf0KUvxZe47cf
         ugzJ1eODfdUs3LxxV5n8ZSI1MvASmqLCF2WmSNzuDZMHU4LNEQS3kygjGTpomrbQDe08
         quXoEqCD1GoPjkftsNlmYlCgOCbJ8ZIo6vzAfJPv9p/gma0RKp47Uq23HYLAKgACR+Y/
         U26IGDdKlS/dK5u8qHL1bOmZ7xWB5vP9L0QHZqS04U/iH9MApzFcvWFS5I+HctjSrB7N
         mLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pi3SM6JsbvfP6RtMtAXOSB9JCtD13VeOaOmtjrxWoNE=;
        b=L8S1CYEt0/NGo6ogK0W92Hk9dASQeeHtPTOE9tR2RCZ87JLm2TVZGbj1hAVIzKJC0K
         bhDFmUOWqzPQFn4rFoj9Jq6fa5JVn+iQ6VlFggtIf8A0SoOuz1OxTTdaCSum3//OASCr
         xwt3Dt3sAlU4mL6Hd7tjrnz35nTH8xPsskPfTFxyeCWCxfN/trifyKdk0C33dn4JqqfG
         r99HGlGthRuDqRWNF37SOU4+zHzKCEBpD5UZ3lWClWm0LTrPQv/NBMsGsgeZKszt5g1w
         yWFi7kpQPGUjQmjDbgKSWzHN3s2rvri9VNbGYDiZ+Nw/7VOYyUcRqAwkroe485hScJ1n
         DXdQ==
X-Gm-Message-State: AOAM533GCh2VkQM0xmp39EAma1iRiPX30k2oAbgDmWvHlEd1UdzU/tCA
        br5y4KZQBayye5YkCAm/GxIFBTVF0UqLVX2yM/A=
X-Google-Smtp-Source: ABdhPJyVPYvbRlGWhU4027iV9VxnHVIyndLx35nN/54epKccBDgJJjeplJFCEeDXIs3pCTpPAQmUO/UCOr7n82NakZA=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr3064oih.123.1606776389395;
 Mon, 30 Nov 2020 14:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-33-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-33-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:46:18 -0500
Message-ID: <CADnq5_Oh5+4rSVV766LuLjBCFPuJh1xdybFu8jnP=Ywyq9UwFg@mail.gmail.com>
Subject: Re: [PATCH 32/40] drm/amd/amdgpu/vcn_v2_0: Fix a few kernel-doc misdemeanours
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:483: warning: Excess function para=
meter 'sw' description in 'vcn_v2_0_disable_clock_gating'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:644: warning: Excess function para=
meter 'sw' description in 'vcn_v2_0_enable_clock_gating'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1404: warning: Function parameter =
or member 'count' not described in 'vcn_v2_0_dec_ring_insert_nop'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Function parameter =
or member 'addr' not described in 'vcn_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Function parameter =
or member 'seq' not described in 'vcn_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Function parameter =
or member 'flags' not described in 'vcn_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1426: warning: Excess function par=
ameter 'fence' description in 'vcn_v2_0_dec_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1465: warning: Function parameter =
or member 'job' not described in 'vcn_v2_0_dec_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1465: warning: Function parameter =
or member 'flags' not described in 'vcn_v2_0_dec_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Function parameter =
or member 'addr' not described in 'vcn_v2_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Function parameter =
or member 'seq' not described in 'vcn_v2_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Function parameter =
or member 'flags' not described in 'vcn_v2_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1609: warning: Excess function par=
ameter 'fence' description in 'vcn_v2_0_enc_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1636: warning: Function parameter =
or member 'job' not described in 'vcn_v2_0_enc_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1636: warning: Function parameter =
or member 'flags' not described in 'vcn_v2_0_enc_ring_emit_ib'
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index e285f9c9d460e..5687c5ed0fb99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -475,7 +475,6 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu=
_device *adev, bool indirec
>   * vcn_v2_0_disable_clock_gating - disable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Disable clock gating for VCN block
>   */
> @@ -636,7 +635,6 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amd=
gpu_device *adev,
>   * vcn_v2_0_enable_clock_gating - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Enable clock gating for VCN block
>   */
> @@ -1397,6 +1395,7 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_rin=
g *ring)
>   * vcn_v2_0_dec_ring_insert_nop - insert a nop command
>   *
>   * @ring: amdgpu_ring pointer
> + * @count: the number of NOP packets to insert
>   *
>   * Write a nop command to the ring.
>   */
> @@ -1417,7 +1416,9 @@ void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_rin=
g *ring, uint32_t count)
>   * vcn_v2_0_dec_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> @@ -1454,7 +1455,9 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 seq,
>   * vcn_v2_0_dec_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: job to retrive vmid from
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write ring commands to execute the indirect buffer
>   */
> @@ -1600,7 +1603,9 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgp=
u_ring *ring)
>   * vcn_v2_0_enc_ring_emit_fence - emit an enc fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write enc a fence and a trap command to the ring.
>   */
> @@ -1625,7 +1630,9 @@ void vcn_v2_0_enc_ring_insert_end(struct amdgpu_rin=
g *ring)
>   * vcn_v2_0_enc_ring_emit_ib - enc execute indirect buffer
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
