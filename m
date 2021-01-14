Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482982F6806
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbhANRqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbhANRqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:46:03 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A72C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:45:23 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id x5so5934002otp.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biVMFSBw0YDhsHHZD25EuPPOy/9ylGC+kj+DhNfcuK0=;
        b=adPoh0/PQ4EF55+Tnwj7ZNyJFQL8HROJbrAOy4PcjhxyvBRh068TN8gwbjOIFG5Rc9
         fvuJEd+sA1t76HIiAPUp3Y5RlJNs0XvWRK65xd9bwbH69hP1pSmbPbTSpYP1Sm1/DrZI
         xvxMcwCeD8EST+qBAciW6rAHFY+qNg4pELXoTmqTy9V+mtEzMbWYUOFR12M+TEsSfWeW
         tUdjutNQ4Fr5koPy9snsXyrE0HieJSiNMBReTLRLjTV8lTa9co1j/42CWeIlqAovQfFo
         UjsVINDarxji89xgIghPgWb9suLUGAx+pOmz9wWYxDQiWq2OJjFr/a9Yby+Zm91RubKh
         l6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biVMFSBw0YDhsHHZD25EuPPOy/9ylGC+kj+DhNfcuK0=;
        b=AVYVva5R/ONgEr++CDDaTV/zdSUMHbUHtODjvbcrs+b/dP7fUoA63jAkEI05IpuMKm
         9uOHb0OA+qsFiwaxNmvjLFL+9Eq0bfUHCuhzbjIXjAnpxqoXu/RyOL7zwQwNgHqqKhnH
         Vf+Sn5Sl/iWOIbPbEAnUwiQXSDJogkCCBTWzkkrvmMCZwMxYkDAez6OHF8+r8639O9fB
         qckq60d4cGkbocqCLfGmdslu91PP74TnjydUOaRnbqXk69u3mDiYC7GDYHKzkzM7MmnR
         cZGZ9ZYx1imM6QB4X1OW28uT7rg61/iX3nd48olMUdOFcbbQa0zO//92XTX8zcL6tVDE
         2xuw==
X-Gm-Message-State: AOAM530GyPcbelx5TYAQ3DNBoEB6kaQRAZ+l672MSbNuTlSOREhRvbOf
        8TUE56/6/+JnPnK9LUpzkC4BEGxMDF6m5dd16mc=
X-Google-Smtp-Source: ABdhPJy7vuCtX7WvgMlO6/iSixQuiAhNNyVMyJE9M+O+u56bCoDNtw9abgiE92q98Bsdq4GyUpFiU65Nyta1++5xi3s=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5559182ote.132.1610646323286;
 Thu, 14 Jan 2021 09:45:23 -0800 (PST)
MIME-Version: 1.0
References: <1610531055-56146-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610531055-56146-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:45:11 -0500
Message-ID: <CADnq5_PCkSMJcYu5YGa7zNg_xhfxMHWgAZoe5ybT0TQU+fK2ZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify bool comparison
To:     Yang Li <abaci-bugfix@linux.alibaba.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 8:51 AM Yang Li <abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c:3141:30-39:
> WARNING: Comparison to bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>

Applied all 4 patches.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> index 45f0289..f33e3de 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> @@ -3138,7 +3138,7 @@ static void CalculateFlipSchedule(
>                                 4.0 * (TimeForFetchingMetaPTEImmediateFlip / LineTime + 0.125),
>                                 1) / 4.0;
>
> -               if ((GPUVMEnable == true || DCCEnable == true)) {
> +               if ((GPUVMEnable || DCCEnable)) {
>                         mode_lib->vba.ImmediateFlipBW[0] = BandwidthAvailableForImmediateFlip
>                                         * ImmediateFlipBytes / TotImmediateFlipBytes;
>                         TimeForFetchingRowInVBlankImmediateFlip = dml_max(
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
