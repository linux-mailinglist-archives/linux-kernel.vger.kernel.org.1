Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484122EFA33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbhAHVSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbhAHVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:18:45 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E915C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:18:05 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id b24so11117312otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ELcB1n16HnyQ+PPet2qQqyGcOAAV6Ox4dEHeBx+UOQ=;
        b=hLIj/KKW2I5OAEqC6oizpKmGpdvX7cKwHI5APTXltw2iaT5tY6p8sBnNeSQxT/CgdA
         Qfsni1x/hVSULOp2KDdVHyNLIYaxWqHl+YXO27uZGMvgy2Eao3KxJ5t17ssqz27qOHvY
         DSQZ4Km+A5F/spGhUpzPQY0tp2/0rUYEeKXo5ISyBUf7nXeeKEyWhmxf6GGdo8O4gJSe
         v1lU1rxVJaaR8/SWtbD5NQcGN9xFvReg+63xlDf6febIC+/ubMWO9WMl1FGEbNL1faD6
         MKP5nPLcMBCrKyNfhehpf8NhjQENNLlnmLItBK8w6FBqdVMiUJCjdyB8IVkV5Hqozw4e
         uasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ELcB1n16HnyQ+PPet2qQqyGcOAAV6Ox4dEHeBx+UOQ=;
        b=tgIccmoK6HkZdPVj5Nq6e78QrUORoqHhFhNdUkEufe1H5EKf0WkrapKy0TVR1lCnnm
         wKlpeUtAtVN0/GhidqbdI3RRmLIh7GQrfnXPMCxk2z1/N77Sc4989ysdCC/7y8xDDjXs
         CGdekocsgSeG/iClqYQT2xDJ98wDVtxTvxhKppIvVjloDpRGVQSZpCMEwgF+yNjb9uHp
         h+Qn9AcNUBvdFaov42nYDBIaxX1HjxnEgA31j6z/vmdJBQ7wn1jSqiYyjd8T95Gzgnny
         2Ee2rStIJGRGY7xf+z1d9S0WTqyMREvLksq6wcMwQfUGB8AFydtg+ZG/o/z7Hv7YxftT
         2Dpg==
X-Gm-Message-State: AOAM530v2/FDZuvSKkkg2csMJNUv/ZASGailzOf67B+Ot7ZuHDbyBtm+
        vlMwmu8P86r2/MWxsoh48UUn/+syhaN3l7Fko6w=
X-Google-Smtp-Source: ABdhPJxd7NOc/UlrlgEgpRKqoSLeq73YHde4TXgizOSPJ8EDuVrpVjMNAVnFEuJ8yS4fnR/Ur8lHAt4/tg1lidDpyBY=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3890500oti.23.1610140684949;
 Fri, 08 Jan 2021 13:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-30-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:17:53 -0500
Message-ID: <CADnq5_PT6StMHY-cQUMxKO+yFEZ9g4TUS6Ho2GoxDRfSPXW5=Q@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/display/dc/dce/dce_dmcu: Staticify local
 function call 'dce_dmcu_load_iram'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.c:74:6: warning: n=
o previous prototype for =E2=80=98dce_dmcu_load_iram=E2=80=99 [-Wmissing-pr=
ototypes]
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_d=
mcu.c:31:
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/=
drm/amd/display/dc/dce/dce_dmcu.c
> index f3ed8b619cafd..fa2b47d41ee2f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> @@ -71,7 +71,7 @@ static bool dce_dmcu_init(struct dmcu *dmcu)
>         return true;
>  }
>
> -bool dce_dmcu_load_iram(struct dmcu *dmcu,
> +static bool dce_dmcu_load_iram(struct dmcu *dmcu,
>                 unsigned int start_offset,
>                 const char *src,
>                 unsigned int bytes)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
