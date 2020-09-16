Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47CF26CBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgIPUhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgIPRJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:09:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABAAC02B8C0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:54:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r19so3508618pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BWx7U02Xwgr8h49vHLlU3F7645ke/l6EjELjcLk+Gho=;
        b=CVXWxM3EdUVW+s267ZSITr5ygZ99ky/R0r9hiMKW+V6Tq6Q1KzlFzlV/rLrhiMgT1A
         NyoxGsf9dx5Sd+OWqFbPITmrc7ZUu46kJUo2Et90OOpR8UuIS3SjjkNfkYeWDwp7dXC4
         dd7lBVMXidnp687j39KHM5NYqYwn2h6SITK90Yf9nyNRmv2qakPaQxgO4gnfLzyrEJ90
         YnUPGmaXIXc/tB3Kjjc/0+XTwnrO28SzArjQtI/cKcCtuzYuf/BW9Uvs/VyVCGDyLEW8
         fEDaHquXyiJqbpIPs69Jup1+XyxDaB2bOIP+PnAj2G2KsXBPZ3KSMReHqW+j1cO6VTbU
         x1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWx7U02Xwgr8h49vHLlU3F7645ke/l6EjELjcLk+Gho=;
        b=khCzGipRyUhnyRFtlY+iWzJeFlhITo5UubtwgTH9dizrGv1eBMZgrf9Utf9kDAahe0
         K60vuyJCg2zgfK6w8y2RktWLFokR6kxsETTfXLPVQmnzw8ok61gEuRG8ABRhix50i0Tc
         JzEKIBWVeX9hcKjY8Xi/kgmS69G2zfmG92e2OJ12Jcn9jvSk6XXxqzI3CZfWVwutbdD9
         98fOQEemfvO9bGOl6DEeqtsYyHgytCbry+ehOcJigMALLd4ABi7MjVyglds6Gw68nc3I
         utERXcuaLC5hJEQ2n4rjU2UDtiwKH/v8ozKGD7gEBncJqsMGeq1gL5t8E5kpkbOHsoBA
         xthg==
X-Gm-Message-State: AOAM531gaFp0T6KeJTsdsfDzQ4DC4kZceKHBKQB7wb42Se1nRtRruLAO
        6VsLRYsSomTf9BIk4OZcOvw=
X-Google-Smtp-Source: ABdhPJzmRu7YqDULZ99DIjYylvkSLVya0IErESyiEaqwo7Iqiw7zCeb34q1HcqeoQyFbJI9UKFi/XA==
X-Received: by 2002:a17:90b:a0a:: with SMTP id gg10mr4808469pjb.20.1600275260082;
        Wed, 16 Sep 2020 09:54:20 -0700 (PDT)
Received: from [10.230.28.120] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s19sm18477822pfc.69.2020.09.16.09.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:54:19 -0700 (PDT)
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
References: <20200901144324.1071694-1-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 00/16] arm/arm64: Turning IPIs into normal interrupts
Message-ID: <cdc9fbc6-b72a-2d72-fbbd-d93e05d2e4e0@gmail.com>
Date:   Wed, 16 Sep 2020 09:54:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2020 7:43 AM, Marc Zyngier wrote:
> For as long as SMP ARM has existed, IPIs have been handled as
> something special. The arch code and the interrupt controller exchange
> a couple of hooks (one to generate an IPI, another to handle it).
> 
> Although this is perfectly manageable, it prevents the use of features
> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
> also means that each interrupt controller driver has to follow an
> architecture-specific interface instead of just implementing the base
> irqchip functionalities. The arch code also duplicates a number of
> things that the core irq code already does (such as calling
> set_irq_regs(), irq_enter()...).
> 
> This series tries to remedy this on arm/arm64 by offering a new
> registration interface where the irqchip gives the arch code a range
> of interrupts to use for IPIs. The arch code requests these as normal
> per-cpu interrupts.
> 
> The bulk of the work is at the interrupt controller level, where all 5
> irqchips used on arm+SMP/arm64 get converted.
> 
> Finally, we drop the legacy registration interface as well as the
> custom statistics accounting.
> 
> Note that I have had a look at providing a "generic" interface by
> expanding the kernel/irq/ipi.c bag of helpers, but so far all
> irqchips have very different requirements, so there is hardly anything
> to consolidate for now. Maybe some as hip04 and the Marvell horror get
> cleaned up (the latter certainly could do with a good dusting).
> 
> This has been tested on a bunch of 32 and 64bit guests (GICv2, GICv3),
> as well as 64bit bare metal (GICv3). The RPi part has only been tested
> in QEMU as a 64bit guest, while the HiSi and Marvell parts have only
> been compile-tested.
> 
> I'm aiming for 5.10 for this, so any comment would be appreciated.

FWIW, I boot tested this on a Brahma-B53 device (GIC-400) in 32-bit and 
64-bit mode and on a Brahma-B15 device (GIC-400 as well) and both 
devices worked in all 3 configurations:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

All cores were brought up successfully. All of these devices use 
PSCI/ATF FWIW.
-- 
Florian
