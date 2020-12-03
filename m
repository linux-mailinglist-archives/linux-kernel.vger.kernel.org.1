Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4F2CCE33
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgLCFCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 00:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:02:31 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA1C061A4D;
        Wed,  2 Dec 2020 21:01:51 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p126so940922oif.7;
        Wed, 02 Dec 2020 21:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xhPmXGe2TmQ1T8FUkBkZbWfsA9sbZw6W4geuHUSY+s0=;
        b=KWftkvGCjHdjjdSp83LlC5tIRRLWTWaNcqW5A5lhWAV2R0qrU5IOkq/a7O0kvfejlA
         rr7ZJGNNSzBbet6dMF9iNpmDbJEBTEVWKYWIXBQ4L8y+ex7Wg4USV+e43JNhvPivy1zl
         7hvAh3Uom+yPQPOPucVPPkMPBoemkGF17FytW+m2avdbGUCV3pGAXaPT6+IauOZ9OnsL
         zsqxYdo58VObj5gnhBctQTpdJyz7TWWMKyM+RDNFbDMwHTWantQkT9EPcH8nVD/xnT+B
         3gpbuuHCiRglD0DPa848kjp2G0YnRrHwxTBJ5a1zyV/0Jhp1XABiXB98YQwb8kl685rk
         39bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xhPmXGe2TmQ1T8FUkBkZbWfsA9sbZw6W4geuHUSY+s0=;
        b=ZVbiIjKyZINKVBjGlRYjO4o+WGbGwWCtZBLpzKwv6deWWhx7Wer2RBfi4h5+nXTbkU
         ZM2d5bfzCkriUsK2ZJ7AH0pXzQEd70t0EqGa+I01v6tFDXNTCDi/T2ThDXmIDkU+wlIQ
         cLQCgh4AbpTO704K6ylDZFPjLeDvKe5yBL9q+3BrgP3Ri99rSo8kMmj8lDmjcZ1EOlUv
         HJPTxSuUbjJC/h8YRYTXT3v++LM01c2SR/DPl7TJjjzYQUEM8xWna0Ap2hrE0iHXYiQn
         YLuEcj5pgxGQBvpIr/g0L/S6rKGp2IBlW/0QeAWWJolAoy32pC6Tnqm7vRC7rsuHgE2c
         V+hw==
X-Gm-Message-State: AOAM533tmzUI/MzPN99T8OT2htGZjBQJ41PCvmIv1zz6qqcbMsxmtC/R
        kT+JEANZYvUDUr4hg5rI9J9Eb/ydahWhwjI/0ss=
X-Google-Smtp-Source: ABdhPJwdcKf0tkF3epFtOf2LnYfdbX0fkojq661TQO2vTSqo7wKalSEV2Rw1RKszQGPMi/nFn9EhXQr/KunOeaQQLog=
X-Received: by 2002:a54:4608:: with SMTP id p8mr783202oip.5.1606971711182;
 Wed, 02 Dec 2020 21:01:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606897462.git.mchehab+huawei@kernel.org>
 <65bae21ebb9de534483b282fb091d4526cff0be8.1606897462.git.mchehab+huawei@kernel.org>
 <21d4e623-4250-454f-67ff-658da99cf26d@amd.com>
In-Reply-To: <21d4e623-4250-454f-67ff-658da99cf26d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 3 Dec 2020 00:01:39 -0500
Message-ID: <CADnq5_Opbff_Nn=pq7dCd3TWY9Tqrh24GdBj-=pB1R3eYS7q+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: amdgpu: fix a kernel-doc markup
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 3:45 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 02.12.20 um 09:27 schrieb Mauro Carvalho Chehab:
> > The function name at kernel-doc markup doesn't match the name
> > of the function:
> >
> >       drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1534: warning: expecti=
ng prototype for amdgpu_debugfs_print_bo_info(). Prototype was for amdgpu_b=
o_print_info() instead
> >
> > Fix it.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Applied.  Thanks!

Alex

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index c6c9723d3d8a..fd7a93c32235 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1518,7 +1518,7 @@ uint32_t amdgpu_bo_get_preferred_pin_domain(struc=
t amdgpu_device *adev,
> >       } while (0)
> >
> >   /**
> > - * amdgpu_debugfs_print_bo_info - print BO info in debugfs file
> > + * amdgpu_bo_print_info - print BO info in debugfs file
> >    *
> >    * @id: Index or Id of the BO
> >    * @bo: Requested BO for printing info
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
