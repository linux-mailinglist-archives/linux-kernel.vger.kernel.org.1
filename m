Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C530C2F5371
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbhAMTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbhAMTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610566526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VbEtyqBdwcJzKeG1wyZKRO8aTEA6+w3GGKg392l/7SU=;
        b=OGGwrtNqTmNVud44aHrtAeUMKiUVW5Efl119INtlaDwIOBcpwv1ADqiqsB5JvEv4bxuGWz
        GSjjmyjXy0yD4igpJgZk0AX1EgTIRDqcJ03+GyZajAKkW0L4dcCCc+/2wrVGs2GOrq9qcP
        7DUfk6UDzRDPaNZYxzguwjfTn387RhI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-sOyHBoM2M42naALBunZJbQ-1; Wed, 13 Jan 2021 14:35:24 -0500
X-MC-Unique: sOyHBoM2M42naALBunZJbQ-1
Received: by mail-pj1-f72.google.com with SMTP id z17so1918863pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbEtyqBdwcJzKeG1wyZKRO8aTEA6+w3GGKg392l/7SU=;
        b=DSFDMxJPoTHj+FuMAxHvS58jXRcnyVxrgSHOL/lVhIswT4rIlvWV+3fm3oSvGrmF5i
         ff3QAscNqP3XED2yPyyoMQPUs4eDAWt3KCWgMMr+HvxV6dY5g6QygPE1iiukQplxkJPS
         zcfxCSTENnr8A0u5CVTJUt/MbOpwcQalsZnCjeYauvCYTfqFl90qy+C8Z4aI2zyQHOlb
         +0AcpQEGQLPnQvAPewSo97d8Gss9r0c1W0FkH/ZFFEm1pNnrMVkRF1lknLmucrqVa94j
         KaJnneKIoWDVWr9neGzhUdTBjwmKvTzUsIjxSvJ4c2HgbUGRHX8/wWIgn9Gab0eq4kR1
         Wc4g==
X-Gm-Message-State: AOAM533yp4OYn7qj97k1/qDSElR2eVJxbJlmHzr3ZQoP6n0KoK9WQC5b
        7kul6j4qlIut4m/NVSqB+wO4s0zkDnucfUmr2tBKJeMz5SmJivo9ZufLVkJGdFTVLCcTKFG4IOz
        oUtI+tyYVzcROiCG97pGYUcGLw3bJvFqs3CtzjM4r
X-Received: by 2002:a17:90a:4bc3:: with SMTP id u3mr897606pjl.56.1610566523640;
        Wed, 13 Jan 2021 11:35:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2fp4B6076gDor+MKRDmZygwIeP4EAAXjFgkA3mR5JdkHoL53cyA3W5wgmGsBrvY5bwF+aXTr6Q8622nmc0XE=
X-Received: by 2002:a17:90a:4bc3:: with SMTP id u3mr897578pjl.56.1610566523391;
 Wed, 13 Jan 2021 11:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20201211222448.2115188-1-dianders@chromium.org>
 <CAD=FV=Ve4wGJ=KxQjraYsiAQZHG_5qEeFW0ZhmBBkRmtdm7Gwg@mail.gmail.com>
 <CAO-hwJK+=537C-EbgNXPY3=m5LvM8SVKCDB5X145BfSMHgUMdw@mail.gmail.com>
 <CAO-hwJLuzAccZbLSCvyP0JnkCW8fgswrm8RJfMaVKjtyF5Yg_A@mail.gmail.com> <CAD=FV=W3uzNPwAGPCUfjC-zoWEPyY4bF8TE4JgPP21s-3MAfpQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W3uzNPwAGPCUfjC-zoWEPyY4bF8TE4JgPP21s-3MAfpQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 13 Jan 2021 20:35:12 +0100
Message-ID: <CAO-hwJ+Gz_yp_vn1prREvhcU=YqVatqd_Hp+95L5i2=bcwfhbA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] HID: i2c-hid: Reorganize to allow supporting goodix,gt7375p
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Jiri Kosina <jikos@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Pavel Balan <admin@kryma.net>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 5:05 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jan 13, 2021 at 7:09 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > > I wanted to apply the series yesterday, but for these kinds of changes
> > > I like giving it a spin on actual hardware. Turns out that my XPS-13
> > > can not boot to v5.11-rc2, which makes testing the new branch slightly
> > > more difficult.
> > >
> > > I'll give it a spin next week, but I think I should be able to land it for 5.12.
> > >
> > > Regarding the defconfig conflict, no worries, we can handle it with
> > > Stephen and Linus.
> > >
> >
> > After 2 full kernel bisects (I messed up the first because I am an
> > idiot and inverted good and bad after the first reboot), I found my
> > culprit, and I was able to test the series today.
> >
> > The series works fine regarding enumeration and removing of devices,
> > but it prevents my system from being suspended. If I rmmod
> > i2c-hid-acpi, suspend works fine, but if it is present, it immediately
> > comes back, which makes me think that something must be wrong.
> >
> > I also just reverted the series and confirmed that suspend/resume now
> > works, meaning that patch 1/4 needs to be checked.
>
> Can you give me any hints about what type of failure you're seeing?
> Any logs?  I don't have an ACPI system to test with...

I don't have any logs, just that the system comes back up. There is a
chance we are not powering the device down correctly, which triggers
an IRQ and which puts the system back on.

>
> Is there any chance that some type of userspace / udev rule is getting
> tripped up by the driver being renamed?  We ran into something like
> this recently on Chrome OS where we had a tool that was hardcoded to
> look for "i2c-hid" and needed to be adapted to account for the new
> driver name.  Often userspace tweaks with wakeup rules based on driver
> name...

I don't think there is anything like that on a regular desktop.

>
> I'll go stare at the code now and see if anything jumps out.
>

Thanks, but don't spend too much time on it, unless something really
jumps out. I'll debug that tomorrow. It's much easier with an actual
device than by just looking at the code.

Cheers,
Benjamin

> -Doug
>

