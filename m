Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E392E85FF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 01:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhABA26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 19:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhABA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 19:28:58 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCEBC061573
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 16:28:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x20so51131397lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phswr07iLwNrHODrC7PjcOhOZ3B79j3PNBm+G91lhyI=;
        b=fXfXUrcq08X5/3z2aV+55FQM4A8cE/IQfX+9ajtxSgsWQNYpdRPt1h9UdGJJ/ZAKsm
         YRzufBIIE0g3sKVPTAg5pwJNdVColE01L5U5Azwxii8z/2zWi7yJ0PEsHWQgt7x9zn86
         NGV3NOThL1hCm8tKdHVOIAsGi+2NEWyzgckTEdhZS/ywMqqCS8iXOzMt5TmT28hmZiUE
         hBbv7WgEf40KcwMKKLDn7ZAijMdh8WyIqCrruyE3M4QIfL5IyGmto/LG8hZ2k8nxHd3B
         h8IvWJppMyDaUZfjpM5WQ1zmvx0qpEMPkgEaUhN593MKrpYDtfSj1TddJtH4oqZmc9uf
         ZQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phswr07iLwNrHODrC7PjcOhOZ3B79j3PNBm+G91lhyI=;
        b=Yj/1VpktIAmcWrBCgtLj6mADQ8Hky2L1m7Crmf1NFdIMFKLZOA7hS44RLHj8izZmo7
         MY/qCMyBIlD9urbeL6SMcqaZB47jRUAHzmdsDgQdJV+1eG+1jGVOyHe2parI2xB+fow2
         lW37GZmGaijdmGsK2pGEqbj4qPiz5uzyRcPg/eDKupvcIvA3hTJRO9GlQz5wvB+KbqPg
         p+bYoZRyDS4nRP5JsdSwbtwR7gJfnvNc8PBT4wDKiS7wi7kyOvAeVuXwOy9r2twO3pcJ
         YKp1Lptve/aDllKJG3Cf4X7QBBNuO3admy1lMCXaNfTvmP1gOnWoXEdY1nB8PZjQ/fn6
         3aNQ==
X-Gm-Message-State: AOAM530tH+eX3VI8TMM1qcFy7qm+b7K6A6+ZbUXL5hfseW2Sn3YlDIMO
        raVN4V1jTIrTRoeuD03XbMMoCplc+64gjjtS3clsLQCvFppGsVDC
X-Google-Smtp-Source: ABdhPJzoGB+95M+l5sOm5IIdsWs5Etecp3llqmRyxEsqvukw1k/XeoZDTkB6O0BSq1YBdGq1oqfyaABtwQHx5DgQG00=
X-Received: by 2002:a19:804c:: with SMTP id b73mr29671337lfd.231.1609547295954;
 Fri, 01 Jan 2021 16:28:15 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
 <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org>
In-Reply-To: <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sat, 2 Jan 2021 08:28:04 +0800
Message-ID: <CAGP6PO+P1Ps0U67=i=5WaWeK1=ZfTxPoGZdp3FBPoMe18WGU3g@mail.gmail.com>
Subject: Re: Generate the config file for kernel compilation non-interactively
 in script.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 1, 2021 at 2:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/31/20 8:51 PM, Hongyi Zhao wrote:
> > Hi,
> >
> > I want to build the realtime Linux for ROS 2 according to the
> > guidelines here:
> > <https://index.ros.org/doc/ros2/Tutorials/Building-Realtime-rt_preempt-kernel-for-ROS-2/>.
> >
> > For this purpose, I must enable the rt_preempt relative options in the
> > kernel withe the following method interactively:
> >
> > $ make menuconfig
> >
> > and set the following
> >
> > # Enable CONFIG_PREEMPT_RT
> >  -> General Setup
> >   -> Preemption Model (Fully Preemptible Kernel (Real-Time))
> >    (X) Fully Preemptible Kernel (Real-Time)
> >
> > # Enable CONFIG_HIGH_RES_TIMERS
> >  -> General setup
> >   -> Timers subsystem
> >    [*] High Resolution Timer Support
> >
> > # Enable CONFIG_NO_HZ_FULL
> >  -> General setup
> >   -> Timers subsystem
> >    -> Timer tick handling (Full dynticks system (tickless))
> >     (X) Full dynticks system (tickless)
> >
> > # Set CONFIG_HZ_1000 (note: this is no longer in the General Setup
> > menu, go back twice)
> >  -> Processor type and features
> >   -> Timer frequency (1000 HZ)
> >    (X) 1000 HZ
> >
> > # Set CPU_FREQ_DEFAULT_GOV_PERFORMANCE [=y]
> >  ->  Power management and ACPI options
> >   -> CPU Frequency scaling
> >    -> CPU Frequency scaling (CPU_FREQ [=y])
> >     -> Default CPUFreq governor (<choice> [=y])
> >      (X) performance
> >
> > But this is very inconvenient for doing the above job in script. Is
> > there an alternative method to generate the above configurations for
> > kernel compilation  non-interactively in script.
>
> Hi,
> You can use scripts/config in the kernel source tree.
> Something like this (I don't have RT kernel sources):
>
>
> scripts/config -e PREEMPT_RT
> scripts/config -e HIGH_RES_TIMERS
> scripts/config -e NO_HZ_FULL
> scripts/config -e HZ_1000
> scripts/config -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE

Based on the built-in help of this script:

$ bash scripts/config -h |& egrep -- '-e |--file|commands'
commands:
    --enable|-e option   Enable option
    commands can be repeated multiple times
    --file config-file   .config file to change (default .config)

It's obviously that the above commands you suggested can be combined
into one as shown below:

$ scripts/config --file .config  -e PREEMPT_RT -e HIGH_RES_TIMERS -e
NO_HZ_FULL -e HZ_1000 -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE

or simply:

$ scripts/config -e PREEMPT_RT -e HIGH_RES_TIMERS -e NO_HZ_FULL -e
HZ_1000 -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE

BR,

>
>
> Note that if any of those have other Kconfig dependencies, those Kconfig
> symbols will also have to be enabled for this to work.
>
> And then run 'make oldconfig' to update the kernel .config file.
>
>
> HTH.
> --
> ~Randy
>


-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
