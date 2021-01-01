Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F642E836C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAAJz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 04:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbhAAJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 04:55:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39533C061573
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 01:55:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l11so48418021lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 01:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8tRY/CPEm7kvKeq5zIF2wmxzVp2WAU8nwfizCftDNs=;
        b=ZHdB46yotMhp3/IBmfy1r1FMC76WmecdW/CY8/rM5IZzIwxUCKuax9qjp4LzXfGYzB
         SUma1c4JyvgN+spR38Lj0RLjmNf0ZwjT2AsNDqqgrO/fkLJMSrS6/b2F0+mfVq3HadMw
         2I5vPJ9IKHdiDLzvYz4YVhOPa7GE5zFQmFaYH7VkBGKF0NrOO5CjvDD0nIJ4xkI6y7OB
         MgLW55f8K44/AmICsNMBhetMRw77NOyLo4Nss7avwXShpPeUqsJs4lJjTiYPG7jT2WVe
         1ONIvfz0NHfYaFFMCYDBSDKldDyJLNfMWIEAsuq3nr4XCaYLCmIqpy2j3NIkvqMlGGev
         6uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8tRY/CPEm7kvKeq5zIF2wmxzVp2WAU8nwfizCftDNs=;
        b=uGQDBo6WRTfBqWXt2/FX+SMMditpL4GpYmFHvIzVaXpcRJ1CX/7V/IK5HgnP8AnME8
         M9KJ5GzeL/6uqVpuR7BLqKB/77wr7aRpmbrphKHjRqBXfNvXpfQmwOqzRUu2pFuJimWZ
         GIenb4ZAUReTgpqCRb2p1YKzteT1dv782RL/Ma/urSeTJAFutbjYe/cYLatqCnoK4xyJ
         4zRg2OpWD4Omx17nE2TuTAzFfhMbcIuoKEQBJ10Y0ITqgxKAtONB5QPO8feDdAWzDMkt
         1qsCckiT2sa2DmNynW7ZEadKJjXgaOOBE0QJHTytv33evT0Nv6sXX7zGwhW0Pl3qkx31
         ZacA==
X-Gm-Message-State: AOAM533mp8+/t8/ZJBkg+8p3iDoe7TXK5dPmEaetiFvYEGQWcwE1+Zz1
        ca2Eo+7DUlpunXKZW097ShL5u/yE2jDkEc/TQS5DQ+GFJXWoXjgi
X-Google-Smtp-Source: ABdhPJyNHJmriLpjDO1Rs668lPXN3e1aNHBaXxaqy4RG/GZHKfxy/vnzIezyhgrTGxy615eYBbF8PfWSKQgiM5rVff0=
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr28541245ljj.246.1609494913489;
 Fri, 01 Jan 2021 01:55:13 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
 <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org>
In-Reply-To: <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Fri, 1 Jan 2021 17:55:02 +0800
Message-ID: <CAGP6PO+JjF0iDXHqUD31cBtNASqbik_iEb3DguqVhUBG+q4LYQ@mail.gmail.com>
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

Wonderful. Thanks a lot for your instructions. I really have noticed
this tool but failed to figure out the corresponding translation rules
for the options used by menuconfig and this script.

BTW, how do you figure out the above options/arguments corresponding
to the ones I've mentioned previously?

>
> Note that if any of those have other Kconfig dependencies, those Kconfig
> symbols will also have to be enabled for this to work.

How to know whether an option has other Kconfig dependencies and find
the corresponding symbols/arguments for feeding to scripts/config?

> And then run 'make oldconfig' to update the kernel .config file.

Thanks again.

BR,
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
