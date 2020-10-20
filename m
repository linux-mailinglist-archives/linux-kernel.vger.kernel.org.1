Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4B293BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbgJTMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405888AbgJTMcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:32:07 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1C222265;
        Tue, 20 Oct 2020 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603197126;
        bh=FNskQlyvjAYQ2kRwtssvTisWlw7hhgIkump+feNnth0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rZ9Ra18GZ+F44faWs6WTiw+eQmQtzYA2X2KmekvneqthHeJVYllH19lEDFgSbyDJ/
         tqdMBTqCDaIW8DBtvqvx7+tzk8SFLK6JRL16U4iYCUlwDGgR/OroVhUZDX2Jb4ELf5
         e2YYWVpFbwsYACRsP++e5PWxAGP6Vp5BmsR6I9Ks=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUqo8-002jGz-39; Tue, 20 Oct 2020 13:32:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Oct 2020 13:32:03 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
In-Reply-To: <20201020122535.paym32gksuhcqtwq@holly.lan>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
 <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
 <f3596e3ed70737d36f72056827d7d441@kernel.org>
 <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
 <20201020122535.paym32gksuhcqtwq@holly.lan>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <abe358694e06a6076fb5838d1231eee6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel.thompson@linaro.org, sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-20 13:25, Daniel Thompson wrote:
> On Tue, Oct 20, 2020 at 04:52:43PM +0530, Sumit Garg wrote:

[...]

>> So in general, IPI as a normal IRQ is still useful for debugging but
>> it can't debug a core which is stuck in deadlock with interrupts
>> disabled.
>> 
>> And since we choose override default implementations for pseudo NMI
>> support, we need to be backwards compatible for platforms which don't
>> possess pseudo NMI support.
> 
> Do the fallback implementations require a new IPI? The fallbacks
> could rely on existing mechanisms such as the smp_call_function
> family.

Indeed. I'd be worried of using that mechanism for NMIs, but normal
IPIs should stick to the normal cross-call stuff.

The jury is still out on why this is a good idea, given that it
doesn't work in the only interesting case (deadlocked CPUs).

          M.
-- 
Jazz is not dead. It just smells funny...
