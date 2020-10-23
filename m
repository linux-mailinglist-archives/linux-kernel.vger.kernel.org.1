Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD638297764
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbgJWS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbgJWS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:58:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319AC0613CE;
        Fri, 23 Oct 2020 11:58:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so3255625wrq.11;
        Fri, 23 Oct 2020 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVVGoFH+W6TXbwZk/lJDswsi31Devdn0bKrhChGZkSw=;
        b=oifvqLuPq3+kt6YtYbANPBM9dRUg1EIA7QF5vNUYPPyrBU78UHFhGUF1lQX0Xst+jG
         X6tO/bqSp6e16Za1yek76z98m5+wzRq5h91bKIQfk8QYOy1JXaOh6HKiBN0XVQJEwCu9
         +EnxXKRbZxJT7jGcJStMkFIu4lyQZr+EhL85UvUWW5qnj/k5VBzaedJvudGI2Pzt8mYd
         yVO+CNJN6/IxTaDNL6Eff1uNe3MB1EosEM3e1BkZQugCyc938gn1tcgipCDXF1ndNY7L
         wcqiTH2CjC5ieg7jYWpf1cY1pjK+ZGG4WZVSGlU1IiKhHP3j7/9hSVzMgjBD67tP8/W+
         1aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVVGoFH+W6TXbwZk/lJDswsi31Devdn0bKrhChGZkSw=;
        b=HQXqaXa6jf+9IKh/P5ef5xdqJJvvfgRij2PBaPTfzTAbzKfZ3+MoPUEBBlS8lUEJk+
         fwogRfJb+63IQJLWCZrlUiJlE21NPAAPPNYjtEXNqq2XHKxhmb3rX7ZbDUf9HBmVYZC8
         tQaFeFmwMEFKA/nemM8DrI5dK1bRlaXvltL2+BpDpOPjY/Ilw8LO8ABoCbf8hQSZWoPt
         EPK34CgtTZL+3nvrvji9j+UpfdURrKMUO9l4qkaCfun4xq21gwTDzbNZEjz9aSslTQV2
         dRYJ3Iv8tgYQQ1hoE1O1jswMwPSmTR50ZWYZSIp4LAHuxvnFkK80hZLp/UIaIv+45GMX
         R95A==
X-Gm-Message-State: AOAM533ur0hJ04Lfi0oZws1SYU81KQyWxHnPEGiCZgOpcCckdhDttE9R
        IRBhkSJ9M0PZ4cEbOeZ0itmO0HYfi4eoJlL1YQI=
X-Google-Smtp-Source: ABdhPJxhOalGy8AVCk6uFL0CL8XNNtHj2n59zH+OlgCHHeE/mvzoX8Mkq8zjdC575NT151N0gWOsX5KiiZu/oQ7WESg=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr4374706wrl.124.1603479516631;
 Fri, 23 Oct 2020 11:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <632b3b11118969ff6fccb8a2f606c87fde41c138.1603469755.git.mchehab+huawei@kernel.org>
 <ecb99629-f593-b389-60b3-dc6f1b306c8b@amd.com>
In-Reply-To: <ecb99629-f593-b389-60b3-dc6f1b306c8b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 23 Oct 2020 14:58:24 -0400
Message-ID: <CADnq5_OF2+QpPeBOXkR+JWkCog1ZAckejK2y2o4yf44U9Jrxgw@mail.gmail.com>
Subject: Re: [PATCH v3 03/56] amdgpu: fix a few kernel-doc markup issues
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 23, 2020 at 12:38 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 23.10.20 um 18:32 schrieb Mauro Carvalho Chehab:
> > A kernel-doc markup can't be mixed with a random comment,
> > as it causes parsing problems.
> >
> > While here, change an invalid kernel-doc markup into
> > a common comment.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index f8785bdec79c..1d4b54950528 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -239,9 +239,11 @@ bool amdgpu_device_supports_baco(struct drm_device=
 *dev)
> >       return amdgpu_asic_supports_baco(adev);
> >   }
> >
> > +/*
> > + * VRAM access helper functions
> > + */
> > +
> >   /**
> > - * VRAM access helper functions.
> > - *
> >    * amdgpu_device_vram_access - read/write a buffer in vram
> >    *
> >    * @adev: amdgpu_device pointer
> > @@ -4497,7 +4499,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >       bool need_emergency_restart =3D false;
> >       bool audio_suspended =3D false;
> >
> > -     /**
> > +     /*
> >        * Special case: RAS triggered and full reset isn't supported
> >        */
> >       need_emergency_restart =3D amdgpu_ras_need_emergency_restart(adev=
);
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
