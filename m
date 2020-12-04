Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1A2CF5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbgLDUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgLDUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:50 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF945C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:49:01 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id h18so2538616otq.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETBT8tLrqWhU3nQJzSd6pnShSvogFC7sNASc+9sqs84=;
        b=X+FBgvPnntPzx4qoAbpgm6nFj7+d26T0HuVa/rSpQ3DzJFvuqolcnpaLkYRm79Q8+M
         XeLX4Tx6t+uTQGlrNgSe2lHw4cqJWCV/Vt+OVDN+QAKXVg3bz3d1QV2OJcHbgaZfHcn5
         OodPePv4psMzAqlr39L1ykKMfWMeVWe0Xp/plL040gAMHCKYHpOSmBJXewtTcNOKX9Wy
         TAsznwK1xKd7zA3QcQNSYYJlP0mW2yEQ8hToZUjghT42SleNCa+E3rHe85lwc58XZmgl
         WiJEomjQze0QEXjx09VcEIVmbnXOthYItD3khx/jdY2QDY2OA+QP7hRJRnO3XtWhn50g
         XSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETBT8tLrqWhU3nQJzSd6pnShSvogFC7sNASc+9sqs84=;
        b=fe+q/oKNaCtedSCAyZlLm2FyulniqUbGNYcFNAAd4/0i80+Lz6sw6PMAhpflYsf9pf
         L3cesLdkZPEwocVs+yykHQdfTpMvawVdgIoG/3HebsnVQFITlbjeaWgYcDmJs9mDqd/W
         1QxUVTNAWmjnITAFevWwgsGOXofBaWQZp4E56bxaUAheB8d0rGg9IcEncJN3nEuridxY
         psho2Xkgpq57m3BXdsxV5z5jjFxxV3aXLqsBVq8kjbKocONl0YBUThKOQF8+CCHhXV4A
         LWry7nWL9IkM78Ms+Ca2nSW8gbupYNjeit4EwSJvhMYAdU3Hh05iqhOVt6s2DgYqKzCl
         UUHg==
X-Gm-Message-State: AOAM533RVOJeWJwMXUV1+ytf5Lpz+V7PqtLumtCzIy6gAqaAj+TttxOm
        o465KeGuoKYXWbhjboxDwtgAK85mS4qr4EJJlcs=
X-Google-Smtp-Source: ABdhPJzt4EfSu2Fb07W12172LWrggEAFHBbB7GRVJsw4ZlpnGKoPlkzO6SAaE4FBLON5IzCEG/DCXK8DNNX8h5GLXl0=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr2649539ote.132.1607114941003;
 Fri, 04 Dec 2020 12:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20201203230652.1480863-1-arnd@kernel.org> <BYAPR12MB2888D809724EADE2AAB77B74B0F10@BYAPR12MB2888.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2888D809724EADE2AAB77B74B0F10@BYAPR12MB2888.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Dec 2020 15:48:49 -0500
Message-ID: <CADnq5_PFVyL5sBc3zx5rLRV6NX2O8f_vZ7emWcDOEEwgaqqU1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix debugfs creation/removal, again
To:     "Zhou1, Tao" <Tao.Zhou1@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Li, Dennis" <Dennis.Li@amd.com>,
        "Chen, Guchun" <Guchun.Chen@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Ma, Le" <Le.Ma@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Clements, John" <John.Clements@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 1:17 AM Zhou1, Tao <Tao.Zhou1@amd.com> wrote:
>
> [AMD Public Use]
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Applied.  Thanks!

Alex

>
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@kernel.org>
> > Sent: Friday, December 4, 2020 7:07 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> > <daniel@ffwll.ch>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao
> > <Tao.Zhou1@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> > Yang, Stanley <Stanley.Yang@amd.com>; Ma, Le <Le.Ma@amd.com>; amd-
> > gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] drm/amdgpu: fix debugfs creation/removal, again
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There is still a warning when CONFIG_DEBUG_FS is disabled:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1145:13: error:
> > 'amdgpu_ras_debugfs_create_ctrl_node' defined but not used [-
> > Werror=unused-function]
> >  1145 | static void amdgpu_ras_debugfs_create_ctrl_node(struct
> > amdgpu_device *adev)
> >
> > Change the code again to make the compiler actually drop this code but not
> > warn about it.
> >
> > Fixes: ae2bf61ff39e ("drm/amdgpu: guard ras debugfs creation/removal based
> > on CONFIG_DEBUG_FS")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++--------
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ------
> >  2 files changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 9d11b847e6ef..c136bd449744 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -1167,7 +1167,7 @@ static void
> > amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
> >                       con->dir, &con->disable_ras_err_cnt_harvest);
> >  }
> >
> > -void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
> > +static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
> >               struct ras_fs_if *head)
> >  {
> >       struct amdgpu_ras *con = amdgpu_ras_get_context(adev); @@ -1189,7
> > +1189,6 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
> >
> >  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)  { -#if
> > defined(CONFIG_DEBUG_FS)
> >       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> >       struct ras_manager *obj;
> >       struct ras_fs_if fs_info;
> > @@ -1198,7 +1197,7 @@ void amdgpu_ras_debugfs_create_all(struct
> > amdgpu_device *adev)
> >        * it won't be called in resume path, no need to check
> >        * suspend and gpu reset status
> >        */
> > -     if (!con)
> > +     if (!IS_ENABLED(CONFIG_DEBUG_FS) || !con)
> >               return;
> >
> >       amdgpu_ras_debugfs_create_ctrl_node(adev);
> > @@ -1212,10 +1211,9 @@ void amdgpu_ras_debugfs_create_all(struct
> > amdgpu_device *adev)
> >                       amdgpu_ras_debugfs_create(adev, &fs_info);
> >               }
> >       }
> > -#endif
> >  }
> >
> > -void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
> > +static void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
> >               struct ras_common_if *head)
> >  {
> >       struct ras_manager *obj = amdgpu_ras_find_obj(adev, head); @@ -
> > 1229,7 +1227,6 @@ void amdgpu_ras_debugfs_remove(struct amdgpu_device
> > *adev,
> >
> >  static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)  { -
> > #if defined(CONFIG_DEBUG_FS)
> >       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> >       struct ras_manager *obj, *tmp;
> >
> > @@ -1238,7 +1235,6 @@ static void amdgpu_ras_debugfs_remove_all(struct
> > amdgpu_device *adev)
> >       }
> >
> >       con->dir = NULL;
> > -#endif
> >  }
> >  /* debugfs end */
> >
> > @@ -1286,7 +1282,8 @@ static int amdgpu_ras_fs_init(struct amdgpu_device
> > *adev)
> >
> >  static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)  {
> > -     amdgpu_ras_debugfs_remove_all(adev);
> > +     if (IS_ENABLED(CONFIG_DEBUG_FS))
> > +             amdgpu_ras_debugfs_remove_all(adev);
> >       amdgpu_ras_sysfs_remove_all(adev);
> >       return 0;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index 4667cce38582..762f5e46c007 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -592,14 +592,8 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device
> > *adev,  int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
> >               struct ras_common_if *head);
> >
> > -void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
> > -             struct ras_fs_if *head);
> > -
> >  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
> >
> > -void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
> > -             struct ras_common_if *head);
> > -
> >  int amdgpu_ras_error_query(struct amdgpu_device *adev,
> >               struct ras_query_if *info);
> >
> > --
> > 2.27.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
