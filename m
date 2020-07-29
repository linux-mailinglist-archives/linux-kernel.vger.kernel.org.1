Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3947231C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2Jts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 05:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgG2Jts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:49:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA60C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:49:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v22so6165146edy.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCwve/GSQ0PM+VLoVzHp74iG5IouH+0k4NcSwjdJu78=;
        b=Fc2pBAa8fbNxmY+4xmemVrmZVCTuQMhNhCbW9wIMS8v32lNz8SCsUO3P4uT8XZTD7H
         UfOMDWV9+hji2skyLGWySFfDBGVBluIO/pQKX+OyBdH6hdT8iaPw3hhsScy/fb4bW9Gs
         FDH7SvMayNU74z69bEo+4zbNfV+f8kRdwIFbElE0fNYvibwXClMc/4jbuDxxpUyP1/N9
         SxJ1zqTIsvgLrTJWApi96EyuUR4ecRhQ+20QfWezs/nAn34a6FR1By77oUKtI2Crova7
         d14B7JjEo2phbF/C5BZr5EUc0TvCEkvPi+7tMk7Mvrabee6m2ZEZnhn2fPtXguEttguj
         41tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCwve/GSQ0PM+VLoVzHp74iG5IouH+0k4NcSwjdJu78=;
        b=k+f/kl8EoC7D2YtrakqAZdJaIeLDz8jtKH5SxWzAQDzFvHM5WodfABodHW5SzDDSzZ
         1HgLzrSh0GLaSnp/FDN1caVVunKXL+5hpVNfgySwKyZQMS8R2rh7AUyyPbh2gJHVPp0K
         zty2iKUD1+HwWG2wNAEboEAM3NtadTajeymvc54sFFz+97P3GWSGSUoGcOSL2eFsbM3I
         P7XeO3H/+VkevtJLKqU5LjaDKutJpr/u0gTKCQdiMUgm9urZZdIVg59ungQD/BneH32I
         eYj/+HDMAD8cneZO40dUwLfkzWKnyqhF55yEiHlNYDuz1yIj4Zc/00lxbs41FYVvyAMf
         N7GQ==
X-Gm-Message-State: AOAM530zOpj4bYWYKOdCwqS/nAe9HKN6k4fHBAXh5jRXYYtntz0kAxOv
        oIPGz7ReWg5wEYW0h0a320M=
X-Google-Smtp-Source: ABdhPJyC58IUur3BWYx2xe8F1hYV3okkEL1hWUX1g9eJPglxm6FBxyNRg5VFD2C5/DpvVGuB9Dd/Mg==
X-Received: by 2002:a05:6402:1687:: with SMTP id a7mr29689719edv.358.1596016186516;
        Wed, 29 Jul 2020 02:49:46 -0700 (PDT)
Received: from skbuf ([188.25.95.40])
        by smtp.gmail.com with ESMTPSA id m24sm1142659eje.80.2020.07.29.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 02:49:45 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:49:43 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dumbtoi.fsf@kurt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:40:29AM +0200, Kurt Kanzenbach wrote:
> Hi Alison,
> 
> On Wed Jul 29 2020, Alison Wang wrote:
> > In the current arm64 defconfig, CONFIG_IRQ_TIME_ACCOUNTING is enabled as
> > default. According to my tests on NXP's LayerScape and i.MX platforms,
> > the system hangs when running the command "stress-ng --hrtimers 1" with
> > CONFIG_IRQ_TIME_ACCOUNTING enabled. Disabling this option, the issue
> > disappears. CONFIG_IRQ_TIME_ACCOUNTING causes serious performance impact
> > when running hrtimer stress test at the same time.
> 
> I think instead of disabling the option for all arm64 devices, it might
> be better to analyze the root-cause why the hrtimer test hangs when this
> option is enabled.
> 
> +Cc hrtimer maintainers: Thomas and Anna-Maria
> 
> Thanks,
> Kurt

For more context, here is my original report of the issue:
https://lkml.org/lkml/2020/6/4/1062

Just like you, I could not reproduce the RCU stalls and system hang on a
5.6-rt kernel, just on mainline and derivatives, using the plain
defconfig.

The issue is not specific to Layerscape or i.MX8, but rather I was able
to see the same behavior on Marvell Armada 37xx as well as Qualcomm
MSM8976.

So, while of course I agree that disabling IRQ time accounting for arm64
isn't a real solution, it isn't by far an exaggerated proposal either.
Nonetheless, the patch is just a RFC and should be treated as such. We
are at a loss when it comes to debugging this any further and we would
appreciate some pointers.

Thanks,
-Vladimir
