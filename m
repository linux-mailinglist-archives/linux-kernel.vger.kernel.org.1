Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBCC2D4242
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgLIMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbgLIMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:38:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA40C0613D6;
        Wed,  9 Dec 2020 04:38:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so1513038wme.0;
        Wed, 09 Dec 2020 04:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D/KypZakA4UxagWK/2hXE8wWxYD2PEUjisB6s0l/9WM=;
        b=Qi3TZSUDiLcXn5UUbiEaoaLJDlhF/12hNt3PPNdep6S2PmX/vpeEBvA4+VXlowRJbF
         AzEg5mEG+bfCTE5WEMz9VFFEVIwKvIQac/HasmtBaif9OssUzaZ+S9CK4BH2gjD8uGhm
         QDhjqxxYC/3FIF7rH6PYCkjXgcQXqCTlIX7iXVYrVbQS+/L0tF3Ia8XmK+sIYCwJ+FiP
         oeWDtsxA1gw+EXUdvT+I4hBEvqx0/w2dzlITNpNSG8x3jDVIpb6zHml2aCraS40CPwt0
         p6kT1yEFWzT2/pCCCVBo6gWt9WttkiWmaxZ28vy1bAxjTpQsu9GpVEJ0jo2IJcnn9WIT
         prgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/KypZakA4UxagWK/2hXE8wWxYD2PEUjisB6s0l/9WM=;
        b=qJr4YBHpHUvjXoSkjX1X/3P60tAldEI8QsYydhlpPHB+4ekrnP/AitkuKNsh63auIr
         EYevH52epDLRI3I77v5KFt6kR04Vf1zsHx///Gv7YoB8zXMGqbCoNeDwl1S5+Mt0gQTR
         2jjo65bC9vQCIje/V/Dwrk/oZffxIIelMGEXUet5hYU0Ise3PXQ0uTxWrPwORulgYOkQ
         G3ytNHxxYWdDwEHlu4pWQOyZTJto/87p3vWWqqtEXJu3MmZ6ZtYzdO0yDLeI0R3Tq9Zy
         ygmFhw5lSG6FIliU3zoTRRJAlF6AwLIB9YTRS0AcTp4GX35mjt6osZpVifUC6SN9Dqv0
         JZGg==
X-Gm-Message-State: AOAM533Knjj2vWdMs6y5+5b+nZxsuO94LElpTEaApm+Rm8lGiSWGpBTL
        HRK2V7WeD0Z/L/9Syi0g2Ps=
X-Google-Smtp-Source: ABdhPJzyYysSK2F8jK5JjnoeZJGzX3cfqCwAyPvsSFd9q6wo09QjxYABdlLV4mJG8gLx1mJVNgA/Pg==
X-Received: by 2002:a1c:7f81:: with SMTP id a123mr2646822wmd.6.1607517486368;
        Wed, 09 Dec 2020 04:38:06 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id q12sm3493822wmc.45.2020.12.09.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:38:04 -0800 (PST)
Date:   Wed, 9 Dec 2020 09:37:54 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] drm/vkms: Add setup and testing information
Message-ID: <20201209123754.pdyautzwtfno5m3p@smtp.gmail.com>
References: <20201208203735.ukqrgjmlntbvxc7e@adolin>
 <20201209005408.GP401619@phenom.ffwll.local>
 <CACAkLuqvHw898DBYo3TgaTr5_6Mr=p=CXaBzFo_7P8N5geOZyw@mail.gmail.com>
 <CAKMK7uEh1Z=H7HByVpp7WVM=AdURyRB0VtJpempLy4W3hMOH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEh1Z=H7HByVpp7WVM=AdURyRB0VtJpempLy4W3hMOH9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09, Daniel Vetter wrote:
> On Wed, Dec 9, 2020 at 12:33 PM Sumera Priyadarsini
> <sylphrenadin@gmail.com> wrote:
> >
> > On Wed, Dec 9, 2020 at 6:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Wed, Dec 09, 2020 at 02:07:35AM +0530, Sumera Priyadarsini wrote:
> > > > Update the vkms documentation to contain steps to:
> > > >
> > > >  - setup the vkms driver
> > > >  - run tests using igt
> > > >
> > > > Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> > > > ___
> > > > Changes in v2:
> > > >  - Change heading to title case (Daniel)
> > > >  - Add examples to run tests directly (Daniel)
> > > >  - Add examples to run subtests (Melissa)
> > > > ---
> > > >  Documentation/gpu/vkms.rst | 67 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 67 insertions(+)
> > > >
> > > > diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> > > > index 13bab1d93bb3..d6739fbbe503 100644
> > > > --- a/Documentation/gpu/vkms.rst
> > > > +++ b/Documentation/gpu/vkms.rst
> > > > @@ -7,6 +7,73 @@
> > > >  .. kernel-doc:: drivers/gpu/drm/vkms/vkms_drv.c
> > > >     :doc: vkms (Virtual Kernel Modesetting)
> > > >
> > > > +Setup
> > > > +=====
> > > > +
> > > > +The VKMS driver can be setup with the following steps:
> > > > +
> > > > +To check if VKMS is loaded, run::
> > > > +
> > > > +  lsmod | grep vkms
> > > > +
> > > > +This should list the VKMS driver. If no output is obtained, then
> > > > +you need to enable and/or load the VKMS driver.
> > > > +Ensure that the VKMS driver has been set as a loadable module in your
> > > > +kernel config file. Do::
> > > > +
> > > > +  make nconfig
> > > > +
> > > > +  Go to `Device Drivers> Graphics support`
> > > > +
> > > > +  Enable `Virtual KMS (EXPERIMENTAL)`
> > > > +
> > > > +Compile and build the kernel for the changes to get reflected.
> > > > +Now, to load the driver, use::
> > > > +
> > > > +  sudo modprobe vkms
> > > > +
> > > > +On running the lsmod command now, the VKMS driver will appear listed.
> > > > +You can also observe the driver being loaded in the dmesg logs.
> > > > +
> > > > +To disable the driver, use ::
> > > > +
> > > > +  sudo modprobe -r vkms
> > > > +
> > > > +Testing With IGT
> > > > +================
> > > > +
> > > > +The IGT GPU Tools is a test suite used specifically for debugging and
> > > > +development of the DRM drivers.
> > > > +The IGT Tools can be installed from
> > > > +`here <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_ .
> > > > +
> > > > +The tests need to be run without a compositor, so you need to switch to text
> > > > +only mode. You can do this by::
> > > > +
> > > > +  sudo systemctl isolate multi-user.target
> > > > +
> > > > +To return to graphical mode, do::
> > > > +
> > > > +  sudo systemctl isolate graphical.target
> > > > +
> > > > +Once you are in text only mode, you can run tests using the --device switch
> > > > +or IGT_DEVICE variable to specify the device filter for the driver we want
> > > > +to test::
> > > > +
> > > > +  sudo ./build/tests/<name of test> --device "sys:/sys/devices/platform/vkms"
> > > > +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/<name of test>
> > > > +
> > > > +For example, to test the functionality of the writeback library,
> > > > +we can run the kms_writeback test::
> > > > +
> > > > +  sudo ./build/tests/kms_writeback --device "sys:/sys/devices/platform/vkms"
> > > > +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_writeback
> > > > +
> > > > +You can also run subtests if you do not want to run the entire test::
> > > > +
> > > > +  sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
> > > > +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
> > >
> > > Does IGT_DEVICE also work with run-tests.sh? Aside from my curious
> > > question, patch looks good to me, thanks a lot.
> >
> > Good catch, it does.
> >
> > Melissa, IGT_FORCE_DRIVER also works. I think I was used test/kms_flip
> > earlier instead of
> > ./build/test/kms_flip hence the fluke.
> >
> > Should I add these also to the docs, was wondering if it will get too
> > confusing....
> 
> I think IGT_FORCE_DRIVER is deprecated, so better not to mention that.
> IGT_DEVICE and --device are the new thing. I think just adding a
> sentence that IGT_DEVICE also works with the run-tests scripts would
> be good perhaps.

Yes, that's what I think too

Good work!

Melissa

> -Daniel
> 
> >
> > >
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >
> > > > +
> > > >  TODO
> > > >  ====
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
