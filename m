Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8E2EF96B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbhAHUj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbhAHUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:39:56 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBFC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:39:16 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j12so10925367ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LbL2Dr2OA34OBObvO2XG7FOhOz6bhRwrWXKAgmeY+cE=;
        b=Ca1Q2uAb3M+v2uxazpdjCzVwAlHGVsYO5KEobRYXWcEAfV/CePHFxHsC0FKcF8G8HU
         K9Y9G9bIlkXTCRM9aIoD0mChGxonTEHdnCFooV97r8NpCD3smcHyOUNA49g7snuFIbhg
         nYmoOOwUtTcWRKUfNfrTNmBkRog0/IRipNb6k0sPwN6NLDv4PuUSsq3rBl92OxiIXWGQ
         PP/EIYTT6kKfBPY4Ko5bmE8sHbXOSJhcHlIZJII2jbp91+DFFimZrwhtv3jZO05F1VLc
         ZaCKWHSGif7Rio0vll5EuENPe/OlduCkVbq5wnFgmqt+idTEtmo4H8hZb2SoPALzKFcm
         lnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LbL2Dr2OA34OBObvO2XG7FOhOz6bhRwrWXKAgmeY+cE=;
        b=jc3oVrQ1JZUbF13vXMokrmWivQplx1ID2ztu/3EaKGgsas0XX3toR7VOWrOC7gjCLi
         Ex6wVZkiijf98T4XWwCt1xxeI23cI7d0i8yWBqarkNVCQTxw4m++6+ExiKw9sio2Br8b
         QUicvjIowjtAhh1aQumtN6GPjrO63ugbn4KxUQ7USKnAvEDZPJHQ0YMMu0V36auap6aB
         qJJ5VYjDH1gmDwjUUwhU0vx/83GqoWPSpgAV7bDJr5JNoq03GWkWgvZnKgw+gfPLsO05
         TXBY8bgaKgoi2B5UabhsTI4KNSuOBTNcnTVC0Mk4kyHxWWjXhPlwe6Mcj4xZZra0ktvR
         bYPw==
X-Gm-Message-State: AOAM531ro9rtFQL49Ha4jyHsCIR1rdARBMUv9jOKkvphYHqvq4M+9eb0
        gbTsFk10ieTUPf1AprmEmORfktIebRTaNQEZTqQ=
X-Google-Smtp-Source: ABdhPJwx+z0MTVNUE63OnTtCnT0bfez2GTMZcacp2FrfJBIxw/e9o7MEMkkLARXEG+wO/GmnhMcWsz/HHcP7PnKlZWg=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr3808067otl.311.1610138355123;
 Fri, 08 Jan 2021 12:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-15-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-15-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:39:04 -0500
Message-ID: <CADnq5_Pyi7cbPBm4R3kNAqTi3CAb94gV+DMsMEJLru7iqdfypQ@mail.gmail.com>
Subject: Re: [PATCH 14/40] drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs: Demote
 non-kernel-doc comment blocks
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Eryk Brol <eryk.brol@amd.com>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:699:=
 warning: Function parameter or member 'm' not described in 'dmub_tracebuff=
er_show'
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:699:=
 warning: Function parameter or member 'data' not described in 'dmub_traceb=
uffer_show'
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:743:=
 warning: Function parameter or member 'm' not described in 'dmub_fw_state_=
show'
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:743:=
 warning: Function parameter or member 'data' not described in 'dmub_fw_sta=
te_show'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Eryk Brol <eryk.brol@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 11459fb09a372..d645f3e4610eb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -691,7 +691,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(stru=
ct file *f, const char __us
>         return size;
>  }
>
> -/**
> +/*
>   * Returns the DMCUB tracebuffer contents.
>   * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_tracebuffer
>   */
> @@ -735,7 +735,7 @@ static int dmub_tracebuffer_show(struct seq_file *m, =
void *data)
>         return 0;
>  }
>
> -/**
> +/*
>   * Returns the DMCUB firmware state contents.
>   * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_fw_state
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
