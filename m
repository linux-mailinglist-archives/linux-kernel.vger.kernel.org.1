Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559CD2A33A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgKBTEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:04:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADEC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:04:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y12so15865066wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tf+lyKd6cxKdsDnu3FRIUy9U8nKGczUdtHTnDfNA6uk=;
        b=N88QPtjKr3lnoHDVn2ua8QmK+rTC4K1TDQ/67elgh7OvoyWwbfTLhBzeBR5rTpatH1
         v6v77w7acB2WFkVXtjdS7JXSqvbobWCYDMLW64nI3L2ClZ53hMTzpqxxYznu0S54Pl4r
         2EQWY+jZ4K4eEJ5ibYmRLuFe0EsSbFv8o03orKXY3NogDsoREZumC/abc6mpLHYbTCyy
         K3w7Skdcf/jdS9yl6fyZwp4dwmJyGUoTXRc+gylIzKnTKNaXrPpBHTiiLccZ8XzRwweU
         cRpB2FFk/SetlnTkO501C5ffSMH99MXWZg5ZYC3luCSRrgrlFLJ7+bHtEJ5GOQPmrx2T
         Flww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tf+lyKd6cxKdsDnu3FRIUy9U8nKGczUdtHTnDfNA6uk=;
        b=chWvq6rnY97st7Tzbe0W4kwKiK8lSCoRKAv8bFDxKwsTOjAx6rF4C5o5CPfrXcQzBS
         v8VbI7I0p4DCuKjU1ratARPNzfmyTihPmgZc4TfXGFpsohqr+EBXfVNPWkx+SRpkkWdx
         S0M26/0VjO0mWqPgZtRBl3Xo1PBPEkuSCKKu2MmoJdrCu5O3gUntOJvCi65kDp98L0CT
         Yugvxowx/7mQ6nxr/sTxXw3TNO3NTU71xzCrN8dKGsZg/4cAOngTf5UaWX395b5gCY5B
         baqeqwX5CGirwEZUDN/Rzz7Nw9/IT6C96Z8DHVIL+5tUETmQ9fYZyy3NrhFK8TsbFnqv
         lCOA==
X-Gm-Message-State: AOAM530m3zVDaP/awDPakTLlDAq6QqLN2iay+awWfclM7ElzsaRtiV3F
        MRITTc4M86AGI/wO+c2vP0AzF/lg8iFyVEpaC5E=
X-Google-Smtp-Source: ABdhPJwCdf6HK3BRONaxMlEO4sSZeGYlPQnVf6qELCEGG0Uy0dyaWX4udRuSFsUD6PPBSk5N9pJGkL5k6E56Pd6EU24=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr23289868wrl.124.1604343880677;
 Mon, 02 Nov 2020 11:04:40 -0800 (PST)
MIME-Version: 1.0
References: <1604318927-11896-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1604318927-11896-1-git-send-email-zou_wei@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Nov 2020 14:04:29 -0500
Message-ID: <CADnq5_OLB62R9NA_n6JW5vJQPANmBXD6DapMvP74i=amevxE1Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/pm: remove unused variable
To:     Zou Wei <zou_wei@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 8:44 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix variable set but not used compilation warning:
>
> ./vangogh_ppt.c:397:6: warning: variable =E2=80=98ret=E2=80=99 set but no=
t used [-Wunused-but-set-variable]
>   int ret =3D 0;
>       ^~~
>

Maybe you have an older version of the code?  It's currently used.

Alex


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 6e26025..355ade5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -394,8 +394,6 @@ static int vangogh_get_current_activity_percent(struc=
t smu_context *smu,
>                                                enum amd_pp_sensors sensor=
,
>                                                uint32_t *value)
>  {
> -       int ret =3D 0;
> -
>         if (!value)
>                 return -EINVAL;
>
> --
> 2.6.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
