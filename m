Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6C52E833E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 07:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAAGdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 01:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbhAAGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 01:33:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 22:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=jOtAq9mWQyONFhL6Xhp1gqtk3+9m9zOkREw1eSb2WIA=; b=G1d71uu3PhwWH93E0JIXcwAJr2
        JN7+ZNUUVb23gdqMK1oji+JNWOO35R4sDpqwCEeGPKcPDYVwkTWTgDR1yIxGv+7rvQ7n2WaFjGM0k
        TEeFsviYxzQvdXa9I/kefFmRE3Aw1l5hQRNTAETJqJ+FyUJ6fBAUL8PLwN3qyxeBD99Ex5zHm8rLN
        d2Ce+S3bGB5gHoqi2dofCqtXRh8PgF02nZOQER3bq4loQiLn28NRcngdqjRZTvEcH8kEdrtB/XG9M
        lk1zd2HTuI9xi2M21HOTPPKxbX0thtA6sD0OAI8pTnzFz3xgUkLYcMVmQOlXGPtmc1/RZ5sayU0vm
        u3I1xQbA==;
Received: from [2601:1c0:6280:3f0::2c43]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kvDzF-0002G5-Fp; Fri, 01 Jan 2021 06:32:33 +0000
Subject: Re: Generate the config file for kernel compilation non-interactively
 in script.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>, linux-kernel@vger.kernel.org
References: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1b0ed31c-bccb-abcb-b8d5-159719e199c3@infradead.org>
Date:   Thu, 31 Dec 2020 22:32:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/20 8:51 PM, Hongyi Zhao wrote:
> Hi,
> 
> I want to build the realtime Linux for ROS 2 according to the
> guidelines here:
> <https://index.ros.org/doc/ros2/Tutorials/Building-Realtime-rt_preempt-kernel-for-ROS-2/>.
> 
> For this purpose, I must enable the rt_preempt relative options in the
> kernel withe the following method interactively:
> 
> $ make menuconfig
> 
> and set the following
> 
> # Enable CONFIG_PREEMPT_RT
>  -> General Setup
>   -> Preemption Model (Fully Preemptible Kernel (Real-Time))
>    (X) Fully Preemptible Kernel (Real-Time)
> 
> # Enable CONFIG_HIGH_RES_TIMERS
>  -> General setup
>   -> Timers subsystem
>    [*] High Resolution Timer Support
> 
> # Enable CONFIG_NO_HZ_FULL
>  -> General setup
>   -> Timers subsystem
>    -> Timer tick handling (Full dynticks system (tickless))
>     (X) Full dynticks system (tickless)
> 
> # Set CONFIG_HZ_1000 (note: this is no longer in the General Setup
> menu, go back twice)
>  -> Processor type and features
>   -> Timer frequency (1000 HZ)
>    (X) 1000 HZ
> 
> # Set CPU_FREQ_DEFAULT_GOV_PERFORMANCE [=y]
>  ->  Power management and ACPI options
>   -> CPU Frequency scaling
>    -> CPU Frequency scaling (CPU_FREQ [=y])
>     -> Default CPUFreq governor (<choice> [=y])
>      (X) performance
> 
> But this is very inconvenient for doing the above job in script. Is
> there an alternative method to generate the above configurations for
> kernel compilation  non-interactively in script.

Hi,
You can use scripts/config in the kernel source tree.
Something like this (I don't have RT kernel sources):


scripts/config -e PREEMPT_RT
scripts/config -e HIGH_RES_TIMERS
scripts/config -e NO_HZ_FULL
scripts/config -e HZ_1000
scripts/config -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE


Note that if any of those have other Kconfig dependencies, those Kconfig
symbols will also have to be enabled for this to work.

And then run 'make oldconfig' to update the kernel .config file.


HTH.
-- 
~Randy

