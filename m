Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE02F60D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbhANMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbhANMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:13:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03276C061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 04:12:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r5so5419909eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P2H8xNGc4qJjyWrW7BK3wR5WxGbN+9v4i3sVmePnfdE=;
        b=qMLy+ue3L/NM69Ol9TI3ZSSVmVKPOMO6YNgiEAQtzybxn52dP1iSLfrwnF0VVjSmeV
         uIpoY04/TZfYrH1zfFtU1KNSLajFK4GqtcClTQ8RBvxE/qRLUuPoy1ib75cWJh2imf0A
         B1Ted8JpNVGFaAwjqNdJOSnsTeFQKAM8AtB9Gx/ohrN4NllXpXfNUToQQ4myy7fG9MAp
         +6IKatovaFOxcKoLgrKDTUj2hXQmE5bfg3baGss1KsIPdk5FNqTEQZj9wuF5LmLgyDLS
         tXEJI9E9dy+29PSqNwSYuaUELcfwI+YSgT0yI+aV5M0LAkWscooDcShjl2u+moQITwIr
         GxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P2H8xNGc4qJjyWrW7BK3wR5WxGbN+9v4i3sVmePnfdE=;
        b=RbAHIOzIs5eMs64NJGoYiMrZWayM35JgR8grrt5GPzLp5741xzVmrgTkXgYpDlL1rm
         EBqPleGUEM9eam6t3iPiEqVtO6ZpW/PkW2K1WbQZ3xqvaeWZD1mZHYIQNZ+ysfLOBMvK
         KJjjmEgvYieY7vkE+ro2by7xMFORTKxrdvstTPRA/brTF00dU6QZ20TBHAaFomrvoYRw
         fYUGMiQb1z2qPiOUcnkr50saynVu1YVd9dqmVSHXRNQO9txLeUGGC3gQnkEpJXmM2Kvb
         i8b8szYlVck30BlKoUIqydwrPn+wspQ8JXUeBJTQggVe7TcznSQUJn34nug+YcpNEDi8
         7wKA==
X-Gm-Message-State: AOAM530tqkgB8vtHHNO8Vf9SJtre4GYWUwj+oiJ+q3hIHusSbXr08FNT
        hpp5VUQR6G18E6xEeGSk/3jgFj3SrP9Mijuq
X-Google-Smtp-Source: ABdhPJwq7W1Mc96HpphlbK5qRA13EecL/9ShigsyCyGuL2nFxYbOb6v/X8VQd0eeDiaHPLr6cVOGtQ==
X-Received: by 2002:a05:6402:1646:: with SMTP id s6mr5474103edx.319.1610626339388;
        Thu, 14 Jan 2021 04:12:19 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t15sm2138323eds.38.2021.01.14.04.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 04:12:18 -0800 (PST)
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <592887f3a5baf0d2b2919617757f1f629aa4030b.1610622251.git.viresh.kumar@linaro.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 07/18] arch: microblaze: Remove CONFIG_OPROFILE support
Message-ID: <4afa1d09-cdd4-44a1-2fa2-1f6ca5657ef6@monstr.eu>
Date:   Thu, 14 Jan 2021 13:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <592887f3a5baf0d2b2919617757f1f629aa4030b.1610622251.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14. 01. 21 12:35, Viresh Kumar wrote:
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove the old oprofile's architecture specific support.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/microblaze/Kconfig                       |  1 -
>  arch/microblaze/Makefile                      |  2 --
>  arch/microblaze/oprofile/Makefile             | 14 ------------
>  .../microblaze/oprofile/microblaze_oprofile.c | 22 -------------------
>  4 files changed, 39 deletions(-)
>  delete mode 100644 arch/microblaze/oprofile/Makefile
>  delete mode 100644 arch/microblaze/oprofile/microblaze_oprofile.c
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index f82795592ce5..25a5a3fb14aa 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -30,7 +30,6 @@ config MICROBLAZE
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER
> -	select HAVE_OPROFILE
>  	select HAVE_PCI
>  	select IRQ_DOMAIN
>  	select XILINX_INTC
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index bb980891816d..b41f323e1fde 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -54,8 +54,6 @@ core-y += arch/microblaze/kernel/
>  core-y += arch/microblaze/mm/
>  core-$(CONFIG_PCI) += arch/microblaze/pci/
>  
> -drivers-$(CONFIG_OPROFILE) += arch/microblaze/oprofile/
> -
>  boot := arch/microblaze/boot
>  
>  # Are we making a simpleImage.<boardname> target? If so, crack out the boardname
> diff --git a/arch/microblaze/oprofile/Makefile b/arch/microblaze/oprofile/Makefile
> deleted file mode 100644
> index 107f2f55d995..000000000000
> --- a/arch/microblaze/oprofile/Makefile
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# arch/microblaze/oprofile/Makefile
> -#
> -
> -obj-$(CONFIG_OPROFILE) += oprofile.o
> -
> -DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
> -		oprof.o cpu_buffer.o buffer_sync.o \
> -		event_buffer.o oprofile_files.o \
> -		oprofilefs.o oprofile_stats.o \
> -		timer_int.o )
> -
> -oprofile-y := $(DRIVER_OBJS) microblaze_oprofile.o
> diff --git a/arch/microblaze/oprofile/microblaze_oprofile.c b/arch/microblaze/oprofile/microblaze_oprofile.c
> deleted file mode 100644
> index def17e59888e..000000000000
> --- a/arch/microblaze/oprofile/microblaze_oprofile.c
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/*
> - * Microblaze oprofile code
> - *
> - * Copyright (C) 2009 Michal Simek <monstr@monstr.eu>
> - * Copyright (C) 2009 PetaLogix
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License. See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -
> -#include <linux/oprofile.h>
> -#include <linux/init.h>
> -
> -int __init oprofile_arch_init(struct oprofile_operations *ops)
> -{
> -	return -1;
> -}
> -
> -void oprofile_arch_exit(void)
> -{
> -}
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



