Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819D62F62B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbhANOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhANOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:07:15 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:06:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d20so5267649otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqVRxnaEr6fxC2Np3c8vMV9XMhe2EyasTUleGDdIiio=;
        b=D6MODicRMqbQQrqQVvw89GhxAZYUzTkESKlqdoc3nmD11tujGqgeuWnlkzNHjBMuA/
         rsCgb9LUAd5IvQ5pLw9D9I9tRD9xM2wmqMvyNJhkartSsDQx7kZsRJuu9w+zFVrLqNRG
         RXYnIam3eUm0Onzm6xxIraQEAHClT+3yvDCXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqVRxnaEr6fxC2Np3c8vMV9XMhe2EyasTUleGDdIiio=;
        b=ZxWbpmyu3pDOcZRaZMWf4vJSzrXmW34ORru6hD+RAxJl30xcOj3dQ7moDn+PQQSDkt
         xZni3nYkGelwUoZ3a0/y90p/vCNuMiaBRDzG7UvkBwo3IQTKgOF7ihXj9ZjLrMniRPaB
         ovTViTXoL8+qj5IXHQoxXrorLvrNxCRzfT1iwZwllJWNvfR8drs4QMWparVXXII75gUL
         N/LhMuVD0Um1PYbUuyJ8mzpTsKo+SNzm5+HJU0mk+DlHyePA+s3t/Kklm/9nnjNia9v+
         bAfM6W4y6acOSexNtJDK2BRPQ68cSwd+b8jr3ZIfYcIdvtPnxIbHHlmm+U3Gdsms31Oa
         V+VA==
X-Gm-Message-State: AOAM531NHxDDxSESwc7JPFHbrKNDKyvEkH+PRH1P/4Bj0lhtE5wlnp0/
        UdD3E+IBBXFcqQ9YxEMECgO3YIOFHZVJsfRNA5q3THaXXKQWnw==
X-Google-Smtp-Source: ABdhPJyw9HaWyyzCICTVUTT7wUNnge/s8N2IbJcsIfDuGT9CYuReZqXPAG/KZccfmoHhjVFHWIs/pOYUFiPFjiTQAg8=
X-Received: by 2002:a05:6830:1bef:: with SMTP id k15mr4587211otb.303.1610633194394;
 Thu, 14 Jan 2021 06:06:34 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com> <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
 <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com> <CABXGCsOcBMT4rL-bb4K_TzK70YmQsgNX37sHEHiqp_1kK1_UEQ@mail.gmail.com>
 <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com>
In-Reply-To: <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 14 Jan 2021 15:06:23 +0100
Message-ID: <CAKMK7uHhpEUXmJCS8=EzxYmT0R1UUF-RCRWx0guFKZo0JKTHhw@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 2:56 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 14.01.21 um 01:22 schrieb Mikhail Gavrilov:
> > On Tue, 12 Jan 2021 at 01:45, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
> >> But what you have in your logs so far are only unrelated symptoms, the
> >> root of the problem is that somebody is leaking memory.
> >>
> >> What you could do as well is to try to enable kmemleak
> > I captured some memleaks.
> > Do they contain any useful information?
>
> Unfortunately not of hand.
>
> I also don't see any bug reports from other people and can't reproduce
> the last backtrace you send out TTM here.
>
> Do you have any local modifications or special setup in your system?
> Like bpf scripts or something like that?

There's another bug report (for rcar-du, bisected to the a switch to
use more cma helpers) about leaking mmaps, which keeps too many fb
alive, so maybe we have gained a refcount leak somewhere recently. But
could also be totally unrelated.
-Daniel



>
> Christian.
>
> >
> > [1] https://pastebin.com/n0FE7Hsu
> > [2] https://pastebin.com/MUX55L1k
> > [3] https://pastebin.com/a3FT7DVG
> > [4] https://pastebin.com/1ALvJKz7
> >
> > --
> > Best Regards,
> > Mike Gavrilov.
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
