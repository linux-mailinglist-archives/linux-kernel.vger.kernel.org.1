Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8B2771D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIXNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgIXNJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:09:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CCC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:09:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 4742929CF4D
Subject: Re: [PATCH v3 16/16] ARM: Remove custom IRQ stat accounting
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kernelci-results@groups.io
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-17-maz@kernel.org>
 <aa8ff875-bee8-26f8-46b0-df579f2067a7@collabora.com>
 <875z83r08a.wl-maz@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <3cd270a8-ddff-b3aa-5d7f-e7224deefbcc@collabora.com>
Date:   Thu, 24 Sep 2020 14:09:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <875z83r08a.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2020 10:29, Marc Zyngier wrote:
> Hi Guillaume,
> 
> On Thu, 24 Sep 2020 10:00:09 +0100,
> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>>
>> Hi Marc,
>>
>> On 01/09/2020 15:43, Marc Zyngier wrote:
>>> Let's switch the arm code to the core accounting, which already
>>> does everything we need.
>>>
>>> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>  arch/arm/include/asm/hardirq.h | 17 -----------------
>>>  arch/arm/kernel/smp.c          | 20 ++++----------------
>>>  2 files changed, 4 insertions(+), 33 deletions(-)
>>
>> This appears to be causing a NULL pointer dereference on
>> beaglebone-black, it got bisected automatically several times.
>> None of the other platforms in the KernelCI labs appears to be
>> affected.
> 
> Hmm. My bet is that because this is a UP machine running an SMP
> kernel, and I fell into the trap of forgetting about this 32bit
> configuration.
> 
> I expect the following patch to fix it. Please give it a go if you can
> (I'm away at the moment and can't test much, and do not have any
> physical 32bit machine to test this on).

OK thanks, that worked:

  https://lava.baylibre.com/scheduler/job/143170

I've added this fix to the kernel branch used on
staging.kernelci.org which is based on linux-next, so it will get
fully verified a bit later today.

Guillaume


> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 00327fa74b01..b4e3d336dc33 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -531,7 +531,12 @@ void show_ipi_list(struct seq_file *p, int prec)
>  	unsigned int cpu, i;
>  
>  	for (i = 0; i < NR_IPI; i++) {
> -		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
> +		unsigned int irq;
> +
> +		if (!ipi_desc[i])
> +			continue;
> +
> +		irq = irq_desc_get_irq(ipi_desc[i]);
>  		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
>  
>  		for_each_online_cpu(cpu)
> 
> Thanks,
> 
> 	M.
> 

