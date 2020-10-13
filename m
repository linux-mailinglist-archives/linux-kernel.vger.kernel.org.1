Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6328CF00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgJMNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgJMNQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:16:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3BC0613D0;
        Tue, 13 Oct 2020 06:16:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a72so10287978wme.5;
        Tue, 13 Oct 2020 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lW4dFaX7zENb53L/tQnCRjjQKB77rHKz+r8ZW7p+KU=;
        b=jRefv6wAPkcjLEUrg0lsNRz9xZOtlpZDjYV+z3w6hlJEqA1Q7SlQci9S23IZDlN4g9
         YYKyAYrbFJeNahTRsWVlqLuzAg/ijzeiNIzS48rkdpij1Mr2HQ6Eml0/tVlzAgT75FJm
         yl535TpmDxaFlxWTsZ43ezYar43gYHtTS6n4d7Eya86vLdRMJQqsD8+pHEaWqmeZjOvH
         gG3OaRmNLazhAIcYmuOkCdyrSSjDTvdpa7+yYxZ7I/r/pFZDTOI9DeA1B6GP7qCEH7Ou
         AAFTpHdHdB4waig/dVUS5GU1XaNl+Z3jb+Y3jSwEp0V3XB+SMQt2QwfsjpD4a+WmQ0fJ
         1lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lW4dFaX7zENb53L/tQnCRjjQKB77rHKz+r8ZW7p+KU=;
        b=XMWoIbSaJrrhbw5eHcYOYqA5xtuk/6AZjrwTVckTKHaibEpzCl7O9cyd3HzbiCRe4Q
         oEYarXijp+xZScqnY5iS/F8PUzW2sX9AEAw4lbS0RG/ogVbOtMZ8yTff3lWTxHJcupYr
         kO8NyXhdLd4gElXAXtwzmuKkEl4fjUWVPGJ/b00IW1l2qRkIc7dyYF2s5mh6fRq3F745
         6oEukfBq2GsTpvgz0JyIvStq3d7s3RGO9qF8UvYRxfQbTCakp3FKAF54MwXevvsjUtJP
         h0mBBLQeDKcIfskGDUKikm3V53z0RbKLeBFBUxPspyg1Zy5ZAVhKKFQo7GJeO5xLiiZt
         clow==
X-Gm-Message-State: AOAM532eGvtbXB07IoCSUCjtfYUxar4yWxyqGUwPLwA7MrsWAPi49CyJ
        jh7voeOtSC5qeGSODEDU8SxmC5GOlrWa1ket6z4=
X-Google-Smtp-Source: ABdhPJyF/ftciBqzh4ch1CG+SWuyn6xuAXkHcUCbsiHDWmq1tOGg12CynfIElRQkbmq/7l1KZq6D6ByKciowJMl1XDo=
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr8363338wmd.79.1602594975661;
 Tue, 13 Oct 2020 06:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602589096.git.mchehab+huawei@kernel.org> <5698741522f375b5687860b597ecb786e14dfc82.1602589096.git.mchehab+huawei@kernel.org>
In-Reply-To: <5698741522f375b5687860b597ecb786e14dfc82.1602589096.git.mchehab+huawei@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Oct 2020 09:16:03 -0400
Message-ID: <CADnq5_NCgoqbBc5LG2QANh9n14h7RO1A5eZ8Dn95EkHCiRfWsA@mail.gmail.com>
Subject: Re: [PATCH v6 72/80] drm/amd/display: kernel-doc: document force_timing_sync
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Victor Lu <victorchengchi.lu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Oct 13, 2020 at 7:54 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> As warned when running "make htmldocs":
>
>         ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:345: warning: Function parameter or member 'force_timing_sync' not described in 'amdgpu_display_manager'
>
> This new struct member was not documented at kernel-doc markup.
>
> Fixes: 3d4e52d0cf24 ("drm/amd/display: Add debugfs for forcing stream timing sync")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index dd1559c743c2..fc7e3e9fd719 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -149,6 +149,8 @@ struct amdgpu_dm_backlight_caps {
>   * @cached_state: Caches device atomic state for suspend/resume
>   * @cached_dc_state: Cached state of content streams
>   * @compressor: Frame buffer compression buffer. See &struct dm_comressor_info
> + * @force_timing_sync: set via debugfs. When set, indicates that all connected
> + *                    displays will be forced to synchronize.
>   */
>  struct amdgpu_display_manager {
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
