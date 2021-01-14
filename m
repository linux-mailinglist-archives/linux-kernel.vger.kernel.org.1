Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E32F6703
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbhANRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbhANRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:56 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB890C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:09:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d8so5830106otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PP8JE5c217gRoDVJCLejZjx16kM8emU+qTiJxyx5nEo=;
        b=usJkqjuY4p1amaQeSCnJmbev6MRgEF66fWJXOjX6Or/PJFfh3cMRqYjusuFaXNV9qP
         Wphi+XMAosPFkFVkDka3Kej/TufR9kqUCFIHjFmmxLX75R7IBsaBG7M+Y0rl8JP6AD1k
         Vs7Bl8kT4+9uR65zo1GXx3OpJM/xYbM1sCbcxHG4LTHmp8ZU6FF9fwWV0FFfw5HrUxe1
         NqLuFxwkcRtav6xTXXA3vdRnacaUPBgrYVnS5lpw1kuLJv7S8R9TFMmNRs/hdqITHhJs
         Oa8Zswh9aHaxktp1F90KlvmGuEpdGi63LbrgLpAKj6T+ENJghk15hnRB4FFVM13HT1rB
         +eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PP8JE5c217gRoDVJCLejZjx16kM8emU+qTiJxyx5nEo=;
        b=iQIwwe1rFeRYUkjsfK/zOpc79DYOc3mBNq89XdXptk8cIx14LTOpmWEDT40lpME0/l
         JXiqSy4Jf2MHwMVnfycznV87ieQFeKQxRbQk7mM1t6fygAOmkQWFc6brFccE/x0dcA3a
         oYW8ZybaPyOM/ddc82HV5920t0E4YuNfih7rJFw+SUQzukKfPHqZduVkSoyf3Xr9viV9
         mZ5WzWf6Acd4rzvDVYCOsiixNrS2+lMGmijgTgAAwiuXXMT2HpsHveAgbmnv5wpaI2zb
         0Trf9FoZg2xDrg7YHERVeRM2bv0eSsU0Arx3NeZzekH68mUlDnZTGFMi1OvSuXkTzf99
         YDMw==
X-Gm-Message-State: AOAM533XYammwQ/GjqMJVZBjbMEoQdG1X9CfR1d0hfK1KIrChCG3nPAH
        xoh4ctfEjZYrjssCfeURjXn7BPWwiMNIu98XdEY=
X-Google-Smtp-Source: ABdhPJwHMFovgVFcpXbhJJ59jVrNPEJXn7I/BV2m1pE8Y+1ZrLLfTc/fcTVjseUJrIEMzw5MMeFqYFbgIRbIypIhUhA=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr5272258otl.311.1610644181186;
 Thu, 14 Jan 2021 09:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-9-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:09:30 -0500
Message-ID: <CADnq5_NVQSOt6qqqGxKgVEqYpJRwOo+Tu_y+SZg2Er9SWA8pDA@mail.gmail.com>
Subject: Re: [PATCH 08/30] drm/amd/display/dc/core/dc_link_dp: Staticify local
 function 'linkRateInKHzToLinkRateMultiplier'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3710:19: warn=
ing: no previous prototype for =E2=80=98linkRateInKHzToLinkRateMultiplier=
=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function =
=E2=80=98dpcd_set_source_specific_data=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4403:18: warn=
ing: variable =E2=80=98result_write_min_hblank=E2=80=99 set but not used [-=
Wunused-but-set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_link_dp.c
> index 2fc12239b22cb..3c33b8fe218e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -3707,7 +3707,7 @@ bool detect_dp_sink_caps(struct dc_link *link)
>         /* TODO save sink caps in link->sink */
>  }
>
> -enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link_rate_i=
n_khz)
> +static enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link=
_rate_in_khz)
>  {
>         enum dc_link_rate link_rate;
>         // LinkRate is normally stored as a multiplier of 0.27 Gbps per l=
ane. Do the translation.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
