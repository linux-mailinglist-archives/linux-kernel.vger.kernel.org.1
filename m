Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC42E85FA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 01:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbhABANZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 19:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhABANY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 19:13:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E990C061573
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 16:12:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 23so51061729lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 16:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbck+fgkUSYN3SoIvVdtLOIeWmttzgxmYEJ24u5l950=;
        b=kFXUD1Kh5qBPu/fWthGSe75e3mKRdKKrrI1+SpBjIvEc/0AD4j2daAm/y09QmDw7W+
         zqkhNkQ/bw6R0MI/0Jwt4bxi8qCCRPTqQij8/lvUiBouueVxbL6OSju+1KGkB+C4Hr+x
         i8Gd+WMwcA5D88jq9uA63q6qKY+/53OnraiLoUo4XAYudSgw/x0Y6MFHquVaDDNNSl4M
         t2aKvocvpF1nNhKGC0vEVkXX10Z85kkorTdSt4tUVQysaIYYqw2KD29g2p+DdNaTz8La
         accU1rggwdt9KEUEwDDBD8nACqFhXHN63dYBP8jmmgVd8glBMWS4Y0ByjynmAOCthC7d
         vwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbck+fgkUSYN3SoIvVdtLOIeWmttzgxmYEJ24u5l950=;
        b=ocp41D/lrXLFjWANB0g/7WNv9M8OwK+wJoLDaWubzDWTO2AA3aGKpU1vfNyufaIlTP
         vDRLDsmlLSzjCQKsec6/a0uk/T8fu7n9RvzGG9iWs63msmKMd50nyQL64zuIyKvYhRej
         ctQbyvFsGyAloRdzBh7n4lg8kMA7xdilX3tY08n3PdqAWJlKmvCK/mbEJBMMmIzcfVIz
         OdMOQZvDSwHwydC/xxe2bL6IdHF88J9sY9IfrPFWJ0IDsneW4fb5xax4mJlMXKohySkM
         vI+CwvlRcnCUycjnFO7E7wTT+ukLbVNySYvZ41xFgFZDVzh1wJtmlJCwaxTh1bFapu6v
         ItqA==
X-Gm-Message-State: AOAM530cFCD2sL5HwlGCYGxrZVc3aClClamzTcvnJi4kCMIg6PAPlB5p
        ftoLHyZaNUYpDdNic2r+5Jmk0eo+lwgQ9pOGmjZ9jX+YaCujrJW3
X-Google-Smtp-Source: ABdhPJynk4sQGX5K5GUk8WUbWuVCojFzQzSpFzdPNixvK/fUCy2UaCuLTw3xXbCxR7tk3G14LlKla2rINn0AWD+j9qY=
X-Received: by 2002:a19:8b83:: with SMTP id n125mr30122878lfd.75.1609546362734;
 Fri, 01 Jan 2021 16:12:42 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
 <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org> <CAGP6PO+JjF0iDXHqUD31cBtNASqbik_iEb3DguqVhUBG+q4LYQ@mail.gmail.com>
 <75ee2c40-6a23-9a28-157e-72018faf0925@infradead.org>
In-Reply-To: <75ee2c40-6a23-9a28-157e-72018faf0925@infradead.org>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sat, 2 Jan 2021 08:12:30 +0800
Message-ID: <CAGP6POKUJOZ842mnU4-yWmgZnYNFVuHPFP1tMbFppOjfg9VdgQ@mail.gmail.com>
Subject: Re: Generate the config file for kernel compilation non-interactively
 in script.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 2, 2021 at 12:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 1/1/21 1:55 AM, Hongyi Zhao wrote:
> > On Fri, Jan 1, 2021 at 2:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 12/31/20 8:51 PM, Hongyi Zhao wrote:
> >>> Hi,
> >>>
> >>> I want to build the realtime Linux for ROS 2 according to the
> >>> guidelines here:
> >>> <https://index.ros.org/doc/ros2/Tutorials/Building-Realtime-rt_preempt-kernel-for-ROS-2/>.
> >>>
> >>> For this purpose, I must enable the rt_preempt relative options in the
> >>> kernel withe the following method interactively:
> >>>
> >>> $ make menuconfig
> >>>
> >>> and set the following
> >>>
> >>> # Enable CONFIG_PREEMPT_RT
> >>>  -> General Setup
> >>>   -> Preemption Model (Fully Preemptible Kernel (Real-Time))
> >>>    (X) Fully Preemptible Kernel (Real-Time)
> >>>
> >>> # Enable CONFIG_HIGH_RES_TIMERS
> >>>  -> General setup
> >>>   -> Timers subsystem
> >>>    [*] High Resolution Timer Support
> >>>
> >>> # Enable CONFIG_NO_HZ_FULL
> >>>  -> General setup
> >>>   -> Timers subsystem
> >>>    -> Timer tick handling (Full dynticks system (tickless))
> >>>     (X) Full dynticks system (tickless)
> >>>
> >>> # Set CONFIG_HZ_1000 (note: this is no longer in the General Setup
> >>> menu, go back twice)
> >>>  -> Processor type and features
> >>>   -> Timer frequency (1000 HZ)
> >>>    (X) 1000 HZ
> >>>
> >>> # Set CPU_FREQ_DEFAULT_GOV_PERFORMANCE [=y]
> >>>  ->  Power management and ACPI options
> >>>   -> CPU Frequency scaling
> >>>    -> CPU Frequency scaling (CPU_FREQ [=y])
> >>>     -> Default CPUFreq governor (<choice> [=y])
> >>>      (X) performance
> >>>
> >>> But this is very inconvenient for doing the above job in script. Is
> >>> there an alternative method to generate the above configurations for
> >>> kernel compilation  non-interactively in script.
> >>
> >> Hi,
> >> You can use scripts/config in the kernel source tree.
> >> Something like this (I don't have RT kernel sources):
> >>
> >>
> >> scripts/config -e PREEMPT_RT
> >> scripts/config -e HIGH_RES_TIMERS
> >> scripts/config -e NO_HZ_FULL
> >> scripts/config -e HZ_1000
> >> scripts/config -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> >
> > Wonderful. Thanks a lot for your instructions. I really have noticed
> > this tool but failed to figure out the corresponding translation rules
> > for the options used by menuconfig and this script.
> >
> > BTW, how do you figure out the above options/arguments corresponding
> > to the ones I've mentioned previously?
> >
>
> Oh, I just took the ones that you had listed and removed the leading
> "CONFIG_" from them.
>
> >>
> >> Note that if any of those have other Kconfig dependencies, those Kconfig
> >> symbols will also have to be enabled for this to work.
> >
> > How to know whether an option has other Kconfig dependencies and find
> > the corresponding symbols/arguments for feeding to scripts/config?
>
> Use one of the interactive config tools (nconfig, xconfig).
> They will show you dependencies, but you may have to enable other
> symbols first.
>
> Maybe it would be easier to do a temporary 'make allmodconfig'
> to have the symbols that you are interested in be enabled, then
> you can find them and look at their dependencies.

It sounds still complicated for manually operation of the above
mentioned procedure even by the virtue of scripts/config. The more
feasible way should be done with python package/binding/library
programmatically, but I'm not sure whether such stuff exists.

BR,
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
