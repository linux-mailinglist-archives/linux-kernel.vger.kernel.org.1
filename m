Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855122AE311
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgKJWQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731997AbgKJWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:16:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A0C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:16:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so14391105wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7IU/PTOdi89iBvGbejecIifI0IrKP2ZeG1FWaivUjE=;
        b=GQ7Nx0TJM3+CwUm96Tq9Mf7jdPXglVP71dIaXGBqOYowxNU094z6er72cR4Yylxyyz
         gR+lg84u5J9T9utPWKI9BNe0Y9tAExmoa5DO4PpiXVYZFJyOyL+wqewAIGDWquj+EmKU
         RcgNEQ8V+o7A3dwd9ATwj661d+kXHoryyX379p9lvhLdbqP7+Cj3LWHFT6eKsSxFgV1I
         xAwOMVsauNWW4CpcPfIrjANq/h5AMzS4JN8A4OmeRtj1bQMaqZxrY6H5qDdy6efeKI88
         u7e6fK1J0QSMK3oQYSPYBEp4s7sglx50E+e48x26nG8zqwa+j4QwoHOCQrn2VlGm0t9w
         5tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7IU/PTOdi89iBvGbejecIifI0IrKP2ZeG1FWaivUjE=;
        b=TvZYzeEUwkH/Z/P+ingkbjTB1oMlxNa/YFu2tppGl1WdC8fCqn/UISMp9yBAMqOup4
         RhgCARfAi4zBozt7Qm5nyZNlIBwdiHAifVxnhyXHHIUt7BL9MRw6rrLUAr7ISeQM71e9
         8GGk1rdWSebvbHzPwHN0BsHHsC8aR/BnoMyN48aoo3EYMBAWh6shGWTMI3LfzAsQ+Ziy
         a2lkzABTh6S0rsgLzC0SE1zLVI/lN46rDS6/6/RKk2/0xzU4h6lHZtO9/Wfk6dhhp1M4
         AyHxn/cPMZosFW6mfhzvZjfBv+07vu073nYhuCDgK4sknny9cdmWF7znUsy2LL1BX+OB
         su5g==
X-Gm-Message-State: AOAM533F3o1BdnF2mM4SqADJrHQQNLspftdRUqaAQ31c4ahq2t8Jle/h
        3pCi2Z4bx52VsPH3Obr5FgvxIA1Bm3MQYqVNjCOzIq9Z
X-Google-Smtp-Source: ABdhPJyl54Wn0vogOWFtSLhB/Y7116uoi8lK0+5pQQ2q1rWelOzlqE/JqiJcgGTRG7deHLDB4tFGPn5cZJ4d30zkmaM=
X-Received: by 2002:adf:e350:: with SMTP id n16mr27062549wrj.419.1605046567611;
 Tue, 10 Nov 2020 14:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org> <20201109211855.3340030-11-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:15:56 -0500
Message-ID: <CADnq5_MNfZZTOky5HV6MLC4d6g69AxNo85snpTRjPY_g=MPzyg@mail.gmail.com>
Subject: Re: [PATCH 10/20] drm/radeon/radeon_ring: Add missing function
 parameters 'rdev' and 'data'
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
>  drivers/gpu/drm/radeon/radeon_ring.c:226: warning: Function parameter or=
 member 'rdev' not described in 'radeon_ring_unlock_undo'
>  drivers/gpu/drm/radeon/radeon_ring.c:240: warning: Function parameter or=
 member 'rdev' not described in 'radeon_ring_lockup_update'
>  drivers/gpu/drm/radeon/radeon_ring.c:283: warning: Function parameter or=
 member 'data' not described in 'radeon_ring_backup'
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
>  drivers/gpu/drm/radeon/radeon_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeo=
n/radeon_ring.c
> index 37093cea24c59..c3304c977a0a5 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -218,6 +218,7 @@ void radeon_ring_undo(struct radeon_ring *ring)
>  /**
>   * radeon_ring_unlock_undo - reset the wptr and unlock the ring
>   *
> + * @rdev:       radeon device structure
>   * @ring: radeon_ring structure holding ring information
>   *
>   * Call radeon_ring_undo() then unlock the ring (all asics).
> @@ -231,6 +232,7 @@ void radeon_ring_unlock_undo(struct radeon_device *rd=
ev, struct radeon_ring *rin
>  /**
>   * radeon_ring_lockup_update - update lockup variables
>   *
> + * @rdev:       radeon device structure
>   * @ring: radeon_ring structure holding ring information
>   *
>   * Update the last rptr value and timestamp (all asics).
> @@ -275,6 +277,7 @@ bool radeon_ring_test_lockup(struct radeon_device *rd=
ev, struct radeon_ring *rin
>   *
>   * @rdev: radeon_device pointer
>   * @ring: the ring we want to back up
> + * @data: placeholder for returned commit data
>   *
>   * Saves all unprocessed commits from a ring, returns the number of dwor=
ds saved.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
