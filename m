Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0EA2C923F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgK3XLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbgK3XLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:11:05 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71293C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:10:25 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id x16so322988oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MqB4uxSS+iPnXKAcDpnlQHbGQ3lVIUy31ucDNBjIS5Q=;
        b=G7UcTmqfY6UjddXaZ0hntPYD8upw1vIMeqdjsItMhcP/O5i13V3TNuBr6R9uHWy8XV
         FHmmiPPUBSXO83tALNmEzUe4OHR7wT5Kre/+zOwGBwP1XrsKUEbWKgWXPCJONZ/+738b
         CZWoa/Iumw7I110YQLpm0oOhih6QLG3Ad7YqFtn4+hxuMq1h6SyvDTn0VVBPPNciAt8T
         9BtOmzuD0wfVnq8bTjkIxw+oD4lrL9nKrcEMCBISKEkrNvTn9j4DMW93FXdHSuTirMEv
         5I2Mh8x0cQPP+NAv1j20kDHR7WdwkhxSGBX+GZxYqBBrBKY/6v7nUH9Wvuwvo0p3mqAs
         j1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MqB4uxSS+iPnXKAcDpnlQHbGQ3lVIUy31ucDNBjIS5Q=;
        b=QUykUEOTfmcjLS9T7I07O5p2YeuBVGL1wm8RxVp1X2usjR//n5/kXmV9JczxpYTVd1
         78mYAFTUX52bT06pcM4XTM25n0LZeKRhK72GNCCFqLMV8eXnLdQyjx3fwzYiEZ4d3FH6
         2TWEujCKDPFx4RTudlWilTGO6QdewbD4fUgHBcs/KR1HB5MMQqNSOfi9VTVX64vbjqtJ
         ZoxjmFEh8nFMkFXesoxSm9zLaBArYb6Cr3w1wgz/blDTf8BoLugSkAH1uajIvirQhsHV
         B8fdAzRXsd2EZrV8LeQgEg6yCAOvbBAjKNr27TfGovysCIaSeSHKflNLbbZQMvNMEegr
         t1mQ==
X-Gm-Message-State: AOAM530vMXw4s8W0r3jigZR9RVL0Q78+vuUUJ6cc57dcvwx62EyDxTAc
        UgXY01zIc9CqRhKnT0VQKbWRmR9SkieLv/N5H+o=
X-Google-Smtp-Source: ABdhPJzQxjaycZ7pd5ksW0geDAvANUHHs/8Sm3OJPUfBBMN3TgvDSJ461DMyJjPYQrSKK324GWYNwB166U2buuMp94c=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr72250oih.123.1606777824964;
 Mon, 30 Nov 2020 15:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-3-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:10:13 -0500
Message-ID: <CADnq5_Njrr_3LAzk9R8+yaF0V4gfXGTrc31z7kKT1XR4FZEJGQ@mail.gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/pm/powerplay/smumgr/polaris10_smumgr: Make
 function called by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:42 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/polaris10_smumgr.c:214=
5:5: warning: no previous prototype for =E2=80=98polaris10_thermal_avfs_ena=
ble=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Evan Quan <evan.quan@amd.com>
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
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b=
/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> index 052bc88cf33c9..45214a364baa9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> @@ -2142,7 +2142,7 @@ static int polaris10_program_mem_timing_parameters(=
struct pp_hwmgr *hwmgr)
>         return 0;
>  }
>
> -int polaris10_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
> +static int polaris10_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
