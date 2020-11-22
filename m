Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219B42BC846
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 19:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgKVSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 13:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgKVSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 13:42:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BEEC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 10:42:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d17so15792573ion.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UOiIGOgu38ijX99g4kc5PywAvhubzlIGo2W55MlBzwI=;
        b=jFyT5zI5/5VK/u6I/ZcJmbttkJxXr49IaB0KvWoPS1VegFssTW9GmF1+vMYzd3srlp
         9PQRd8hnCYCbEdgZPH57kr36GXsYl2fME3c7vwvIpYN7scbCfIMDuwWG52BPolHxDAid
         fxL4yUcYZQjRcHOeMGxqEWuzSECVblUzDCqZO0mNgkqZQdZWWyiHv0nUBkIbTQNCadKt
         dYBqY68itQtt6AoUSOpB/Ue7VJIIdj3ToFiKZKek3VcVj6mQkxq7GCKYef5U+Io37Ij2
         6w/06M7/s8tRoA8PINiNwERVHDgvrpTD78ykV5mMKc3TRYl3od2N4MFqpq2h9BqYbvhu
         9C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UOiIGOgu38ijX99g4kc5PywAvhubzlIGo2W55MlBzwI=;
        b=lhXboVr9yQZIf+to9juA+dcjPXfXb5SPPmrvd0Ijt6vAO59oJW5OhgvN9m8Yc5ervo
         dSyC/c3Qf+qBKpHYZ7byPhS0s/fKicdMiGsl98xT5X9OoJAtRjWTJpXmJCWQgHVy1t9e
         SfhfgYiTWdxIVJ8XyCexKCemRD2xH7eMo72B0sLYh/zcKMoivse5bBbvZ0hvHXhle3NF
         xrr+nuembki4hrYMfr42Xbp4PHpx1HxL1lWsk1JF8MFZgZuzDMoPtA3CjUGsyqVu3zig
         Puq5j4i54X1hEbzu0e3uJUX4ngaJwXuEH15alH7ZG9swiLGSjeriyWUMDAzzssTGBGc5
         LNfw==
X-Gm-Message-State: AOAM530QMO36aRtOq2sWvxW3tCAChvYw/2zoA9KDoh+fWfwHVJWFblKb
        1uVReerb6xMk/L7hLXySe4abwtF3hxScQzXuivJ/T4SFsDkB4Q==
X-Google-Smtp-Source: ABdhPJzslcMs52aGLZt17HcelrQB1uSpRbD5h8kvnWcvBFTSCr1Qf6njV1Y4aNFyqoT9yKpIEFvYHxnN7WickfeGcsU=
X-Received: by 2002:a05:6602:1492:: with SMTP id a18mr8722808iow.124.1606070542825;
 Sun, 22 Nov 2020 10:42:22 -0800 (PST)
MIME-Version: 1.0
References: <CAAObsKCP+ve2ZdXQk62aTo70G9i9Vo17dh6k-fcY23NC=EYZxg@mail.gmail.com>
 <CAJiuCcf3YYvAjyPwn8XK-56_YJ4dxQFAUOpL0nEQ8fnED5u8rQ@mail.gmail.com>
In-Reply-To: <CAJiuCcf3YYvAjyPwn8XK-56_YJ4dxQFAUOpL0nEQ8fnED5u8rQ@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 22 Nov 2020 19:42:11 +0100
Message-ID: <CAJiuCcd1XkDJanizAgSuPW1ExMO1Zo7SF8gsdxpmeXuYkRUQfg@mail.gmail.com>
Subject: Re: devfreq and panfrost on Allwinner H6
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Tomeu,

On Wed, 7 Oct 2020 at 19:49, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi Tomeu,
>
> On Wed, 7 Oct 2020 at 10:58, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> >
> > Hi Cl=C3=A9ment,
> >
> > Have just noticed that my Pine H64 board hangs when I try to set the
> > performance governor for the GPU devfreq.
> >
> > Is this a known bug?
> Yes it is.
>
> I try to summarize everything in this message:
> https://lkml.org/lkml/2020/8/3/153

Finally got it working with Jernej's help by setting a fixed frequency
to the GPU PLL.

https://github.com/clementperon/linux/commits/h6_gpu_devfreq

# glmark2-es2-drm --off-screen
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    glmark2 2020.04
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    OpenGL Information
    GL_VENDOR:     Panfrost
    GL_RENDERER:   Mali T720 (Panfrost)
    GL_VERSION:    OpenGL ES 3.0 Mesa 20.2.2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[build] use-vbo=3Dfalse: FPS: 182 FrameTime: 5.495 ms
[build] use-vbo=3Dtrue: FPS: 528 FrameTime: 1.894 ms
[texture] texture-filter=3Dnearest: FPS: 604 FrameTime: 1.656 ms
[texture] texture-filter=3Dlinear: FPS: 599 FrameTime: 1.669 ms
[texture] texture-filter=3Dmipmap: FPS: 581 FrameTime: 1.721 ms
[shading] shading=3Dgouraud: FPS: 418 FrameTime: 2.392 ms
[shading] shading=3Dblinn-phong-inf: FPS: 386 FrameTime: 2.591 ms
[shading] shading=3Dphong: FPS: 325 FrameTime: 3.077 ms
[shading] shading=3Dcel: FPS: 308 FrameTime: 3.247 ms
[bump] bump-render=3Dhigh-poly: FPS: 214 FrameTime: 4.673 ms
[bump] bump-render=3Dnormals: FPS: 518 FrameTime: 1.931 ms
[bump] bump-render=3Dheight: FPS: 501 FrameTime: 1.996 ms
[effect2d] kernel=3D0,1,0;1,-4,1;0,1,0;: FPS: 295 FrameTime: 3.390 ms
[effect2d] kernel=3D1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 82 FrameTime: 12.1=
95 ms
[pulsar] light=3Dfalse:quads=3D5:texture=3Dfalse: FPS: 507 FrameTime: 1.972=
 ms
[desktop] blur-radius=3D5:effect=3Dblur:passes=3D1:separable=3Dtrue:windows=
=3D4:
FPS: 46 FrameTime: 21.739 ms
[desktop] effect=3Dshadow:windows=3D4: FPS: 172 FrameTime: 5.814 ms
[buffer] columns=3D200:interleave=3Dfalse:update-dispersion=3D0.9:update-fr=
action=3D0.5:update-method=3Dmap:
FPS: 34 FrameTime: 29.412 ms
[buffer] columns=3D200:interleave=3Dfalse:update-dispersion=3D0.9:update-fr=
action=3D0.5:update-method=3Dsubdata:
FPS: 33 FrameTime: 30.303 ms
[buffer] columns=3D200:interleave=3Dtrue:update-dispersion=3D0.9:update-fra=
ction=3D0.5:update-method=3Dmap:
FPS: 40 FrameTime: 25.000 ms
[ideas] speed=3Dduration: FPS: 66 FrameTime: 15.152 ms
[jellyfish] <default>: FPS: 158 FrameTime: 6.329 ms
[terrain] <default>: FPS: 12 FrameTime: 83.333 ms
[shadow] <default>: FPS: 211 FrameTime: 4.739 ms
[refract] <default>: FPS: 45 FrameTime: 22.222 ms
[conditionals] fragment-steps=3D0:vertex-steps=3D0: FPS: 654 FrameTime: 1.5=
29 ms
[conditionals] fragment-steps=3D5:vertex-steps=3D0: FPS: 296 FrameTime: 3.3=
78 ms
[conditionals] fragment-steps=3D0:vertex-steps=3D5: FPS: 645 FrameTime: 1.5=
50 ms
[function] fragment-complexity=3Dlow:fragment-steps=3D5: FPS: 468
FrameTime: 2.137 ms
[function] fragment-complexity=3Dmedium:fragment-steps=3D5: FPS: 289
FrameTime: 3.460 ms
[loop] fragment-loop=3Dfalse:fragment-steps=3D5:vertex-steps=3D5: FPS: 459
FrameTime: 2.179 ms
[loop] fragment-steps=3D5:fragment-uniform=3Dfalse:vertex-steps=3D5: FPS:
460 FrameTime: 2.174 ms
[loop] fragment-steps=3D5:fragment-uniform=3Dtrue:vertex-steps=3D5: FPS: 21=
8
FrameTime: 4.587 ms
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
                                  glmark2 Score: 313
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Regards,
Clement

>
> Clement
>
> >
> > Thanks,
> >
> > Tomeu
