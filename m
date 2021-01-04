Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351312E9BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhADRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADRZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:25:00 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA139C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 09:24:19 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 9so32920895oiq.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+t5f9rj+zFO163yFTzAFQCz1fqjzf9FIqP0MEvWgYU0=;
        b=XTen9sP8H7Egth4yZB1CyiTAz15KI1TshTmBmrB7azD0EP7T/3IDYAXD3eZ/EB4BUa
         EPeFkVmMz53KBerMnpUbuXV3qz7XkcDptBzJ3hKycBHI6bbwdPdlA4Vp6EnqtgLwrGzw
         Ywkg0iSkhnJ0B9DgvmYJCnU4Kld8ao1E+P0UpwVYhtB0JJsoXVUuKTWkzcwLuXXzuUvs
         z14kaoqRE7vv55Jf0GB323yUDO9w5ZPegyFdjUOhZ1iiRzxosMXWvbO0xt29H3EtylIm
         dRQaubyhBw8BS3LIXCeyKLlV/RHwqVJyOkkI5TdixgvPEFKn8EswRn/A1Gh6qt3HedSK
         1TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+t5f9rj+zFO163yFTzAFQCz1fqjzf9FIqP0MEvWgYU0=;
        b=bWSKu/OFF51ClOhBGKVvIjVtrqcneAR8hd7gYl7/SozJ5wLvjrf0OOhUS80Te1wmfp
         kNdTVntK5kduAu52fqaQD1JaafZlcZQ5Id1KuDqfAp1tbqFlB5vCZw+lHIVvmfOx7Tp8
         Akl/yAqB/qGBLY5DW/x9CiQ1O84uXrRWorRxwu7YnB7tbFKgs8Iip2AWTpQ2ef4jtXp9
         a+8vV8axmx/KxMzpvrFJBTGQ0okBpLYD2GKpFMiYHS3jFmDVzX95gRyvwz99Qcjw7oBv
         omb6nA+frJCpQFPZacycnHvcNzsnmREGtBTcdodR6Zb5POu2h+bhtPH/KQjX9+FHNerq
         ebhA==
X-Gm-Message-State: AOAM532OH1cVFrR5/2hPauauhYzsx7fyZkt40yhH3ql51Oxn7c5MuFa5
        bbuOH0wL0phezHPV1vJdbBUV9OeqjCQjSfAad2s=
X-Google-Smtp-Source: ABdhPJxy6IPoPtiBLKLdXKz3Mq9/q8CK8ookN74f8KGFRaWOePMCH6kuGw3veJl9VHWaEum6vyU5wBUFuK8qdJzk/jY=
X-Received: by 2002:a54:4083:: with SMTP id i3mr18358315oii.120.1609781059268;
 Mon, 04 Jan 2021 09:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20210103140248.3889757-1-arnd@kernel.org> <BN8PR12MB4770D2DD3E0A5ECF5EA9C55AFCD20@BN8PR12MB4770.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB4770D2DD3E0A5ECF5EA9C55AFCD20@BN8PR12MB4770.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Jan 2021 12:24:08 -0500
Message-ID: <CADnq5_MMAkeRppmnoE0zgu2PWr1MN+R9uWque4Srv93e1iH+-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unused variable warning
To:     "Lin, Wayne" <Wayne.Lin@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, "R, Bindu" <Bindu.R@amd.com>,
        "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
        "Brol, Eryk" <Eryk.Brol@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 4, 2021 at 7:58 AM Lin, Wayne <Wayne.Lin@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks Arnd.
>
> Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
>
> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Sunday, January 3, 2021 10:03 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng=
.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Chris=
tian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Ve=
tter <daniel@ffwll.ch>; R, Bindu <Bindu.R@amd.com>; Lin, Wayne <Wayne.Lin@a=
md.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Kazlauskas, Nicholas <Nicholas.Kazlaus=
kas@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabin=
do <Aurabindo.Pillai@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com=
>; Simon Ser <contact@emersion.fr>; Brol, Eryk <Eryk.Brol@amd.com>; Bas Nie=
uwenhuizen <bas@basnieuwenhuizen.nl>; Lakha, Bhawanpreet <Bhawanpreet.Lakha=
@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amd/display: Fix unused variable warning
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some of the newly added code is hidden inside of #ifdef blocks, but one v=
ariable is unused when debugfs is disabled:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8370:8: error=
: unused variable 'configure_crc' [-Werror,-Wunused-variable]
>
> Change the #ifdef to an if(IS_ENABLED()) check to fix the warning and avo=
id adding more #ifdefs.
>
> Fixes: c920888c604d ("drm/amd/display: Expose new CRC window property")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 4 +---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 42b0fdb72e7b..5071b55ad0f6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8379,8 +8379,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm=
_atomic_state *state)
>  acrtc->dm_irq_params.stream =3D dm_new_crtc_state->stream;
>  manage_dm_interrupts(adev, acrtc, true);
>  }
> -#ifdef CONFIG_DEBUG_FS
> -if (new_crtc_state->active &&
> +if (IS_ENABLED(CONFIG_DEBUG_FS) && new_crtc_state->active &&
>  amdgpu_dm_is_valid_crc_source(dm_new_crtc_state->crc_src)) {
>  /**
>   * Frontend may have changed so reapply the CRC capture @@ -8401,7 +8400=
,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *sta=
te)
>  amdgpu_dm_crtc_configure_crc_source(
>  crtc, dm_new_crtc_state, dm_new_crtc_state->crc_src);
>  }
> -#endif
>  }
>
>  for_each_new_crtc_in_state(state, crtc, new_crtc_state, j) diff --git a/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd=
/display/amdgpu_dm/amdgpu_dm_crc.h
> index 0235bfb246e5..eba2f1d35d07 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
> @@ -46,13 +46,13 @@ static inline bool amdgpu_dm_is_valid_crc_source(enum=
 amdgpu_dm_pipe_crc_source  }
>
>  /* amdgpu_dm_crc.c */
> -#ifdef CONFIG_DEBUG_FS
>  bool amdgpu_dm_crc_window_is_default(struct dm_crtc_state *dm_crtc_state=
);  bool amdgpu_dm_crc_window_changed(struct dm_crtc_state *dm_new_crtc_sta=
te,
>  struct dm_crtc_state *dm_old_crtc_state);  int amdgpu_dm_crtc_configure_=
crc_source(struct drm_crtc *crtc,
>  struct dm_crtc_state *dm_crtc_state,
>  enum amdgpu_dm_pipe_crc_source source);
> +#ifdef CONFIG_DEBUG_FS
>  int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src=
_name);  int amdgpu_dm_crtc_verify_crc_source(struct drm_crtc *crtc,
>       const char *src_name,
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
