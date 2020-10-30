Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70DD29FC43
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgJ3DpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgJ3DpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:45:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:45:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k10so3609460wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqRQo1k+LyBootWHIaIxWjANkP7ifh1D8uGLNtgxfI4=;
        b=NfiTO9tOxd9P308/HhlATOrmcqAD62BLyB79f+18OkTCEA10hoCvxR7zLfUXi5/+kp
         KldGo5NtKuI+jcxjVy8Gqr02bkHtRt9CHRs4hiiazCClbDwj+ENrxo4mvlry36WvX2XG
         Hfc9cuTHpbt6ectqZUDDpS0EPNxCUjTISiweYb4ETvTml0blH6j96nYm9au7/26Sndje
         sof5VpViWl/mpTMcsb0obaLPyri3JwFbPh21iSHQHUVLkIqCZXI2MuwteDJOD6YHS4Uh
         +rZtkkm6S0uUzkjSruu0NHg0Ac0fjVw5fIbTeTtUOzLHPGcjaMC4qA3CN6xaTp9fwL+9
         ZDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqRQo1k+LyBootWHIaIxWjANkP7ifh1D8uGLNtgxfI4=;
        b=U4784cBpj0NoCeBDZvpsjGc4lsgZYMMmFG/3GxkhGu9VSzwNm9WRXQbrsi/9REiekP
         HzHFzRxmZYzJ8Z1xonKFcYyiLaC0Lu2nZ0J38Sgk2TsP98pFBPUjdyXUVecYB3l9nDJn
         R/RLV/u9BsOnpeAk/UZdVDGW6QnALjM5XZu1sGIcA5K1mmVebCqypVCCMfsslNFvih4f
         rBEomtYWFc+bEMUVPumnJo5FZ+AesAHKXheSUnAAvZVMo2d2wsD1LWzFlJbJKhQkyEEk
         YpCjaH6VKswkavIW4DqSzWA+sd0dS7oiH65QlpKq0jLhEDSNtfihFbUKyVDVrwabLQhh
         OPQA==
X-Gm-Message-State: AOAM5329+IDIPtClVznsQkzrnOa9vTm7BLTzUGKyb9+rs7zgD6sOUI2V
        VkX7XdLlu4uZqu+gFi/mgHxn0BZ2uVz9iDl6Pbw=
X-Google-Smtp-Source: ABdhPJyZsaTRPa6cjCtyjtMW3tmQylPLGZh/UEBXCyh2htGgoNYKtpTOtToxkbQ8qz6xDinhIr5w6dbXejWAKDUGNhw=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr401458wrl.124.1604029499181;
 Thu, 29 Oct 2020 20:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201026210039.3884312-1-arnd@kernel.org> <20201026210039.3884312-2-arnd@kernel.org>
In-Reply-To: <20201026210039.3884312-2-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Oct 2020 23:44:47 -0400
Message-ID: <CADnq5_OORogMPV6zrEPGNGJ-jEamkzymdGTyHetrF_9xvoVx_w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: fix incorrect enum type
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Galiffi <david.galiffi@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Martin Tsai <martin.tsai@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        jinlong zhang <jinlong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Oct 26, 2020 at 5:01 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> core_link_write_dpcd() returns enum dc_status, not ddc_result:
>
> display/dc/core/dc_link_dp.c: In function 'dp_set_panel_mode':
> display/dc/core/dc_link_dp.c:4237:11: warning: implicit conversion from 'enum dc_status' to 'enum ddc_result'
> [-Wenum-conversion]
>
> Avoid the warning by using the correct enum in the caller.
>
> Fixes: 0b226322434c ("drm/amd/display: Synchronous DisplayPort Link Training")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index ff1e9963ec7a..98464886341f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4230,7 +4230,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>
>                 if (edp_config_set.bits.PANEL_MODE_EDP
>                         != panel_mode_edp) {
> -                       enum ddc_result result = DDC_RESULT_UNKNOWN;
> +                       enum dc_status result = DC_ERROR_UNEXPECTED;
>
>                         edp_config_set.bits.PANEL_MODE_EDP =
>                         panel_mode_edp;
> @@ -4240,7 +4240,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>                                 &edp_config_set.raw,
>                                 sizeof(edp_config_set.raw));
>
> -                       ASSERT(result == DDC_RESULT_SUCESSFULL);
> +                       ASSERT(result == DC_OK);
>                 }
>         }
>         DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
