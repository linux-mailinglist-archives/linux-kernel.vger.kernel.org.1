Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1D26A634
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIONV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIONRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:17:33 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00590C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:16:55 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so2942355ilp.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/HlO2pz67e4hxYirmZqk4ySGJecTpWx3uH4onJVbvU=;
        b=Ao6JMC6MHz4vIH5oPcx8XvXMXNBpuT6aZgdgvKvyHV/hNMlBoELCsvdTJFmmq14gbE
         wpEde/KfyVyFa+9WwWJkJYfVu6a0Q3aJcrFAORKIbcdpmNJ2v9vG5QLHqNVDqT2mL71e
         0YXAHgkC4RSoeJ2fQ0H4LNQ5DhFhFDiAX6dY7pFYVOS7ENh31SSkeYZhK+Y+PZ8GXtni
         it5g8WftJxlJ6qHd3exqCyuQIyIaqVW0k8SqqAOp7WiqgFAbXPp2vkFA7GJeDXi7QWuN
         4Y0cLMfUJtcUKC9g6CzlkkBxSrMKYD2mmLINKs5X/rS/b0CeqJhOTjO/+4aMQTc3iy6N
         nSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/HlO2pz67e4hxYirmZqk4ySGJecTpWx3uH4onJVbvU=;
        b=E4zOgXuAjf2I809r/3UZ99lGLvNX5xN9q99tGhgui61wrdn0Z9b97ZRFMAaNtCrdTT
         dAsqLZMQiBGSIBqJLeNoLlC6gUUrm2a1pHQEE5GhS6OBsp4l5srVbDrj4KMPwVIzVGk1
         2N+SZYdPBCa8iV7fR67NPZH1H1XzeVhMPyhhNIM/F1gZGAQGLA+vnMBqtsJ2MuKhxgcg
         kK16aeadKYKjLg4RZjqgFzgnxqqSzUbEjiekzzKAFT9T3q0o92O4bbjuI/W9M/Rp4sAJ
         t6LA+c3QUf2L1Jrmx0h2DIkxPcBQCBmqllxwb13dTxnhd082+nkYIR0bBIiYglTOePJ5
         ToIA==
X-Gm-Message-State: AOAM532nuDGWZyCQYVaNlh9JQi3YicOhl+TwLYhYaieLpFiWpo3HEhr7
        M+UMR0gjIazu10nGYHHrYASrcfPEWVSURuX7XG5dqg==
X-Google-Smtp-Source: ABdhPJzSPncGLKmwONqIrR5yKoPLvcW5c4OXIAKLZmbI58H8i0gsT7/X+baLgsqUByC1c10NX7cSCvumNCkKi81cKhE=
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr16457759ilq.287.1600175813496;
 Tue, 15 Sep 2020 06:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125813.8809-1-brgl@bgdev.pl> <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
 <20200915131228.GX3956970@smile.fi.intel.com>
In-Reply-To: <20200915131228.GX3956970@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Sep 2020 15:16:42 +0200
Message-ID: <CAMRc=MdGwkEp4sL=oBuk-x4cd7BWga76X0Rvq8PN-P+vjvp=Fg@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: generalize GPIO line names property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 3:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 15, 2020 at 02:01:56PM +0200, Anders Roxell wrote:
> > On Tue, 8 Sep 2020 at 18:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > I initially sent this as part of the gpio-mockup overhaul but since
> > > these patches are indepentent and the work on gpio-mockup may become
> > > more complicated - I'm sending these separately.
> > >
> > > The only change is adding additional property helpers to count strings
> > > in array.
> > >
> > > Bartosz Golaszewski (3):
> > >   device: property: add helpers to count items in string arrays
> > >   gpiolib: generalize devprop_gpiochip_set_names() for device properties
> > >   gpiolib: unexport devprop_gpiochip_set_names()
>
> Ha-ha, OF unittest is of_node centric. definitely there is no backed device.
>
> Bart, it seems we are stuck with fwnode interface.
>

Wait what?! This means the implementation is wrong - the whole concept
of device properties is to be generic and to hide the underlying
fwnode or OF properties. If anything we should fix
device/base/property.c to fall back to OF.

What is happening exactly? If all fwnode code compiled out?

I'll try to give it a spin and see what can be done but I don't like
that device_property_* functions fail if you have OF but not fwnode.

Bart
