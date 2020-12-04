Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08E52CED3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgLDLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLDLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:39:04 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69726C061A52;
        Fri,  4 Dec 2020 03:38:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so6733678wmf.3;
        Fri, 04 Dec 2020 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WgsTtVr/b1JNUa2uSYC+bnyuIfDmWDZgY06jl/btiUM=;
        b=OZjTDTLVXvWC3i4bqtbKHDxkCNeLgfToMm3x5guLX875tE+QWIbiVjiqR6c/FlxCUv
         n2iyMhsxRz2B9QfDtWScNj4mr1NkgbC/VDsiVK/hztmytyEi6VVlk0W/wGKy2spOopTw
         wiXqOuy8wQkwmY+e19pvbXRKcDJRziBgtAr8UVW16E7PREQJ6PnZUYRbNgS4kN8VXPAT
         8fbORoyg7ytq6aGLmkDOR9YJ1PoGKIXk1gvl4Y91Vfm2mpRvUHw/N4Xl/S4EZZpoIlQb
         6dFeV5oHbi5RliQtVDq1LlNqLIoaShGGIgxEHRzVsksSx1nsUqgfiE8rG1Q2qKG6x/QT
         PKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgsTtVr/b1JNUa2uSYC+bnyuIfDmWDZgY06jl/btiUM=;
        b=blFcllYWTuqxJRJfJ3TJhOIBn9at8MOJV/+cksUdRu6F+dmsKD/pTXzgqwtZIRE+MM
         xdkz2X2+KLfBWNYrptjG/GRAbKgJO3xRYLPsQoil5Sx1HEmWbSwMermmScTEsMk3DtDZ
         jzrXjUxLihlwYQXbDTX/+Sqbbf0WfXaA0Nkzig42a8mREAKKOjauyMq/ks3JTYKep3SX
         JC5EJe2HHDZwJufBySo1JR1n0+5fw9MDJeroopyTqFf4JCnOibWQ9FgvuE1eROpoSaCq
         88gNSzQ80rizTpw43Y31NWGFP4770aj2jGt5BrYu4WX+WhqU1TXU6n1Zhx1BjpWDO0tU
         De/Q==
X-Gm-Message-State: AOAM532y+yrb423czYjQgcy73tuWgFIQYnjtoiUjQdHdL6OLdhNpsdXA
        rC1IMa6mR5bEfWuOV/xveHE=
X-Google-Smtp-Source: ABdhPJwe7ZYZ5qIYf5OObsOoOELrU40M3Xz79So92Rzsl0qPPZ014V/qEFARPDztuHuVNSEmomXvlQ==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr3690871wmc.33.1607081903158;
        Fri, 04 Dec 2020 03:38:23 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id b18sm3413815wrt.54.2020.12.04.03.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:38:22 -0800 (PST)
Date:   Fri, 4 Dec 2020 08:38:16 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Add setup and testing information
Message-ID: <20201204113816.ec7wfqrzyello7wd@smtp.gmail.com>
References: <20201203191339.u5hfwy6ycrrzeb3z@adolin>
 <CAKMK7uFWb-4pGPMJyM7wwLkA-ayv1Axcs9+RNyM1q2SzwxHSBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFWb-4pGPMJyM7wwLkA-ayv1Axcs9+RNyM1q2SzwxHSBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumera,

Thanks for the doc improvements.
Please see some complimentary comments below.

On 12/03, Daniel Vetter wrote:
> On Thu, Dec 3, 2020 at 8:13 PM Sumera Priyadarsini
> <sylphrenadin@gmail.com> wrote:
> >
> > Update the vkms documentation to contain steps to:
> >
> >  - setup the vkms driver
> >  - run tests using igt
> >
> > Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> > ---
> >  Documentation/gpu/vkms.rst | 47 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> > index 13bab1d93bb3..d6782174d23f 100644
> > --- a/Documentation/gpu/vkms.rst
> > +++ b/Documentation/gpu/vkms.rst
> > @@ -7,6 +7,53 @@
> >  .. kernel-doc:: drivers/gpu/drm/vkms/vkms_drv.c
> >     :doc: vkms (Virtual Kernel Modesetting)
> >
> > +SETUP
> 
> Absolute bikeshed, but we generally stick to titlecase for titles, so
> just "Setup" and "Testing with IGT".
> > +=====
> > +
> > +The VKMS driver can be setup with the following steps:
> > +
> > +To check if VKMS is loaded, run::
> > +
> > +  lsmod | grep vkms
> > +
> > +This should list the VKMS driver. If no output is obtained, then
> > +you need to enable and/or load the VKMS driver.
> > +Ensure that the VKMS driver has been set as a loadable module in your
> > +kernel config file. The following line should be present in the .config
> > +file in your kernel root::
> > +
> > +  CONFIG_DRM_VKMS=m
> > +

Considering the target audience, I would make it clearer to explore the
configuration options using "make *config". As in
https://kernelnewbies.org/FirstKernelPatch#Recompiling_the_driver

> > +Compile and build the kernel for the changes to get reflected.
> > +If your existing config already has VKMS available as a loadable module,
> > +then there is no need to build the kernel again.
> > +Now, to load the driver, use::
> > +
> > +  sudo modprobe vkms
> > +
> > +On running the lsmod command now, the VKMS driver will appear listed.
> > +You can also observe the driver being loaded in the dmesg logs.
> > +
> > +To disable the driver, use ::
s/disable/unload/
> > +
> > +  sudo modprobe -r vkms
> > +
> > +TESTING WITH IGT
> > +================
> > +
> > +The IGT GPU Tools is a test suite used specifically for debugging and
> > +development of the DRM drivers.
> > +The IGT Tools can be installed from
> > +`here <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_ .
> > +Once you have installed IGT, you can run tests using::
> > +
> > +  ./scripts/run-tests.sh -t <name of test>
> > +
> > +For example, to test the functionality of the igt_draw library,
> > +we can run the kms_draw_crc test::
> > +
> > +  ./scripts/run-tests.sh -t kms_draw_crc
> 
> If we run igt tests directly, there's an option to select the right
> device. This is important if you have more than one gpu driver
> (usually the case if you run this directly, but even on virtual
> machines there should usually be a drm driver around).  E.g. when I
> run a test directly:
> 
> # tests/kms_flip --device drm:/dev/dri/card0
> 
> I'm not sure whether there's an option that's always going to select
> the vkms device. I'm also not sure you can pass these options to
> run-tests.sh, I kinda don't use that one myself ...

I also run a test directly. Some cases have many subtests, therefore I
can pass --run-subtest to specify one.

And, to select vkms, I use IGT_FORCE_DRIVER. For example:

# IGT_FORCE_DRIVER=vkms tests/kms_flip --run-subtest basic-plain-flip

> 
> Aside from that looks all good to me.
+1

Melissa
> -Daniel
> 
> > +
> >  TODO
> >  ====
> >
> > --
> > 2.25.1
> >
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
