Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE072CE071
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLCVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:16:51 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF9C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 13:16:05 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b18so3208343ots.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE2K/CILOD7x/mQFo0Rz+6Lwz9iUEQy1K2ey3j7mIvY=;
        b=RJvFpvNVdQHgoMCdGEJOrXTglxIdvZWaCGMEkkFNj5+/KVvxUKXNczdE5ARGh/r+X9
         kRN9dZlFLDoQIULz9HzkGbo0WG33na8+2Az/iu3B5aSisUYemDodBckMjlQMW0Hul9u9
         vDvOMQ7yewLVQhXF0RNF7q6iKv9e8vGalRbQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE2K/CILOD7x/mQFo0Rz+6Lwz9iUEQy1K2ey3j7mIvY=;
        b=R9d/0WAGyVwIw+aCPNJMU6X6RsrrqK4xUv+jv3EZ/Cg0Og6KukqbUwAyG8sXRRL9Qp
         p4FofvuH/porWRs+7GlweYbsvI2WN8165BHM3CBmcrLAuXgZW7tlsKc/Efl0FGhsvAuW
         uo7KIs9BvGKBgsljOqqWB+yU7AUdzxTcAvmWiAI2zjIe7yIQq2itMdUBi0RQZHeiA/iU
         ONTtJkcentOuRej3lxUmsQqTZqrd0POrKK5y74h7IxUPLQKqqx3KbVmb8ycgxlc9Gz/R
         Cj3n5ZUz10RsPeD+EL1Pz/mfqKRbrB4h2ZRo+wblmf0oiJOhzjLsmQlYcGOqQTUhiJec
         4snQ==
X-Gm-Message-State: AOAM531HJ1jakYsNf6gzvLnXjJkF15F5VIU6nHJSGc1s0OSHELQKKxoJ
        uvERtZY23MkVm+m/bdxGQQXGop66UAmZCEgqqo1+7w==
X-Google-Smtp-Source: ABdhPJwja/l4kUHtGAIlv6RL6aUgPiP7VSPC3Nl7pi1/Z1gf00h+gOaHAH90utQ+YTf9v60rVzhn7EE9I/kZrwvwO/Q=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr978736otb.281.1607030164448;
 Thu, 03 Dec 2020 13:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20201203191339.u5hfwy6ycrrzeb3z@adolin>
In-Reply-To: <20201203191339.u5hfwy6ycrrzeb3z@adolin>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 3 Dec 2020 22:15:53 +0100
Message-ID: <CAKMK7uFWb-4pGPMJyM7wwLkA-ayv1Axcs9+RNyM1q2SzwxHSBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: Add setup and testing information
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Melissa Wen <melissa.srw@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 8:13 PM Sumera Priyadarsini
<sylphrenadin@gmail.com> wrote:
>
> Update the vkms documentation to contain steps to:
>
>  - setup the vkms driver
>  - run tests using igt
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  Documentation/gpu/vkms.rst | 47 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 13bab1d93bb3..d6782174d23f 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -7,6 +7,53 @@
>  .. kernel-doc:: drivers/gpu/drm/vkms/vkms_drv.c
>     :doc: vkms (Virtual Kernel Modesetting)
>
> +SETUP

Absolute bikeshed, but we generally stick to titlecase for titles, so
just "Setup" and "Testing with IGT".
> +=====
> +
> +The VKMS driver can be setup with the following steps:
> +
> +To check if VKMS is loaded, run::
> +
> +  lsmod | grep vkms
> +
> +This should list the VKMS driver. If no output is obtained, then
> +you need to enable and/or load the VKMS driver.
> +Ensure that the VKMS driver has been set as a loadable module in your
> +kernel config file. The following line should be present in the .config
> +file in your kernel root::
> +
> +  CONFIG_DRM_VKMS=m
> +
> +Compile and build the kernel for the changes to get reflected.
> +If your existing config already has VKMS available as a loadable module,
> +then there is no need to build the kernel again.
> +Now, to load the driver, use::
> +
> +  sudo modprobe vkms
> +
> +On running the lsmod command now, the VKMS driver will appear listed.
> +You can also observe the driver being loaded in the dmesg logs.
> +
> +To disable the driver, use ::
> +
> +  sudo modprobe -r vkms
> +
> +TESTING WITH IGT
> +================
> +
> +The IGT GPU Tools is a test suite used specifically for debugging and
> +development of the DRM drivers.
> +The IGT Tools can be installed from
> +`here <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_ .
> +Once you have installed IGT, you can run tests using::
> +
> +  ./scripts/run-tests.sh -t <name of test>
> +
> +For example, to test the functionality of the igt_draw library,
> +we can run the kms_draw_crc test::
> +
> +  ./scripts/run-tests.sh -t kms_draw_crc

If we run igt tests directly, there's an option to select the right
device. This is important if you have more than one gpu driver
(usually the case if you run this directly, but even on virtual
machines there should usually be a drm driver around).  E.g. when I
run a test directly:

# tests/kms_flip --device drm:/dev/dri/card0

I'm not sure whether there's an option that's always going to select
the vkms device. I'm also not sure you can pass these options to
run-tests.sh, I kinda don't use that one myself ...

Aside from that looks all good to me.
-Daniel

> +
>  TODO
>  ====
>
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
