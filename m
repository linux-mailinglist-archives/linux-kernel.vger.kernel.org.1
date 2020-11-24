Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53452C2CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390334AbgKXQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389995AbgKXQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:20:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E56C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:20:22 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so22977859wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XRHVrvJlQ2ukq/CC/8wyIWEOQ1Yb+bvOP9mD1Riz8v8=;
        b=VYlHHhi1Gtt/tX7oWShWAUryetvvip9qc45T3ikc6wMLDImKqrr66TQDdjRbMMfdEV
         gAMKBJ1ujkmYACJK/dJcqSpP87/s+cgXLRDRi8rCB+LyLznZKZQgqIkieXhLgAgY2CWA
         bK6qY3Fq2NRxNeKTWuSIsDrakRQvB1lIkzfH9XNwXaSU0dThhF1APRerx+j7jOJSvz9+
         uolBab+CCLKegHH/+NboVq1zwKJErR0gRgyZngI5zebT5dVWn9Hub0P/YPBrlXIAXArX
         4kpFe8b/xZlauX8pgqtKEm5c5BlBQqKb4vXS/g06n5C7XdZX4fO3LNk0TB8tltQzsrEW
         xh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XRHVrvJlQ2ukq/CC/8wyIWEOQ1Yb+bvOP9mD1Riz8v8=;
        b=IcAOJuN8qeO+z4h+uwX8S7h8RxjSjfONjFg4Ad2FOjMdPE7z6Vcop+FUezaizNlaSf
         +SK3peq3UqPFPHiXOxVHP0lXJ0vQdBnXiRnw8xbFaGas3gke0KWeUwde0b5RkFW29wdk
         1LO1uUq5l3OoCxoIFYlE8KpwPoZqryqn0OqYgKyO734BOD8rMSia0D/veuog+x76eSPX
         0kWU9ONM2TRQAE4dVMs/fbmOoLBmmzfaTfHxID64uEiQ0j+zWmFNQzDmIBQNL8q2UavN
         m6sepZGamXBYuP8CltypkCUvx57krtyCAPHDYe8LcDBRD+jJV+w38meFx7B+ni0SQ0lJ
         lmOg==
X-Gm-Message-State: AOAM531hzq138XWmEez/6WhdubIXQBQ3ojQjx4cQruWDxl9nQNkSHUFr
        5wKAzX6C0c9xJEcDjoyGguhqBDTh/pjNkFyAZW0TNg7v
X-Google-Smtp-Source: ABdhPJysvdibjEh6/FdZavSHyPtReDD/t7W/CQ8sXKWCu4ZRVqycdledwmcNtHDNrhY3dA2LcoqUh3N/pbTWlJgXkY0=
X-Received: by 2002:adf:e551:: with SMTP id z17mr6217281wrm.374.1606234821414;
 Tue, 24 Nov 2020 08:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-35-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-35-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:20:09 -0500
Message-ID: <CADnq5_M6xVdz7R85K5MZkGeYfrQYXm+Rk7e3RkXawhy=L4WyNQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/amdgpu/uvd_v4_2: Add one and remove another
 function param description
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
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:448: warning: Function parameter o=
r member 'flags' not described in 'uvd_v4_2_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:448: warning: Excess function para=
meter 'fence' description in 'uvd_v4_2_ring_emit_fence'
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
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index 2c8c35c3bca52..bf3d1c63739b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -439,7 +439,7 @@ static void uvd_v4_2_stop(struct amdgpu_device *adev)
>   * @ring: amdgpu_ring pointer
>   * @addr: address
>   * @seq: sequence number
> - * @fence: fence to emit
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
