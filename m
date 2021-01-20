Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54A72FD610
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391669AbhATQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:51:56 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64524 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391623AbhATQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611161246; x=1642697246;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f/6B+U88WSe2xMQeGzdeR6lOL8Z3BXjNUSDfIqFQAeE=;
  b=lJUf9Fq2G4pcqfMSwO3LKaJhwi5Oc45gFXAXM+rsm8lp5InTDWZ0GtjV
   y+nYljyUpFPLmCA4h51zbBoxdL4pam/CCbcEe//K4Swg3vEobR4PEwkSr
   9rtdqBphtWYSFjX4K7y84KhU28fQlgaxZ6eqijonKiGH6eG5dJ/sDprFl
   U=;
X-IronPort-AV: E=Sophos;i="5.79,361,1602547200"; 
   d="scan'208";a="112233310"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Jan 2021 16:46:34 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 98CBFA18DB;
        Wed, 20 Jan 2021 16:46:33 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 16:46:33 +0000
Received: from edge-m1-r3-201.e-iad16.amazon.com (10.43.162.94) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 16:46:31 +0000
Subject: Re: [RFC PATCH 2/7] arm64: kernel: Add a WFI hook.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Hector Martin" <marcan@marcan.st>, <linux-kernel@vger.kernel.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-3-mohamed.mediouni@caramail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <b30f1d3a-3a74-b562-afb6-da88a547468b@amazon.com>
Date:   Wed, 20 Jan 2021 17:46:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120132717.395873-3-mohamed.mediouni@caramail.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D16UWB004.ant.amazon.com (10.43.161.170) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 14:27, Mohamed Mediouni wrote:
> From: Stan Skowronek <stan@corellium.com>
> =

> WFI drops register state on Apple Silicon for SMP systems.

It probably drops the register because it loses power on WFI, right?

Have you tried to set the ARM64_REG_CYC_OVRD_ok2pwrdn_force_up bit in =

ARM64_REG_CYC_OVRD yet? XNU has a call for that[1]. Maybe that's enough =

to convince the core to preserve its register state for now.

For real power savings, we will probably want much more sophisticated =

deep sleep capabilities later that would reach beyond just register =

saving on WFI (different wakeup mechanisms, IRQ balancing, etc).


Alex

[1] =

https://github.com/opensource-apple/xnu/blob/master/osfmk/arm64/machine_rou=
tines_asm.s#L797

> =

> This hook will be used for a hardware workaround in the
> Apple CPU start driver.
> =

> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
> ---
>   arch/arm64/include/asm/cpu_ops.h |  2 ++
>   arch/arm64/kernel/cpu_ops.c      |  6 ++++++
>   arch/arm64/kernel/process.c      | 11 +++++++++--
>   3 files changed, 17 insertions(+), 2 deletions(-)
> =

> diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cp=
u_ops.h
> index e95c4df83911..4be0fc5bcaf9 100644
> --- a/arch/arm64/include/asm/cpu_ops.h
> +++ b/arch/arm64/include/asm/cpu_ops.h
> @@ -23,6 +23,7 @@
>    * @cpu_boot:	Boots a cpu into the kernel.
>    * @cpu_postboot: Optionally, perform any post-boot cleanup or necessary
>    *		synchronisation. Called from the cpu being booted.
> + * @cpu_wfi:    Optionally, replace calls to WFI in default idle with th=
is.
>    * @cpu_can_disable: Determines whether a CPU can be disabled based on
>    *		mechanism-specific information.
>    * @cpu_disable: Prepares a cpu to die. May fail for some mechanism-spe=
cific
> @@ -43,6 +44,7 @@ struct cpu_operations {
>   	int		(*cpu_prepare)(unsigned int);
>   	int		(*cpu_boot)(unsigned int);
>   	void		(*cpu_postboot)(void);
> +	void		(*cpu_wfi)(void);
>   #ifdef CONFIG_HOTPLUG_CPU
>   	bool		(*cpu_can_disable)(unsigned int cpu);
>   	int		(*cpu_disable)(unsigned int cpu);
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index e133011f64b5..6979fc4490b2 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -19,12 +19,18 @@ extern const struct cpu_operations smp_spin_table_ops;
>   extern const struct cpu_operations acpi_parking_protocol_ops;
>   #endif
>   extern const struct cpu_operations cpu_psci_ops;
> +#ifdef CONFIG_ARCH_APPLE
> +extern const struct cpu_operations cpu_apple_start_ops;
> +#endif
> =

>   static const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
> =

>   static const struct cpu_operations *const dt_supported_cpu_ops[] __init=
const =3D {
>   	&smp_spin_table_ops,
>   	&cpu_psci_ops,
> +#ifdef CONFIG_ARCH_APPLE
> +	&cpu_apple_start_ops,
> +#endif
>   	NULL,
>   };
> =

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 34ec400288d0..611c639e20be 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -57,6 +57,7 @@
>   #include <asm/processor.h>
>   #include <asm/pointer_auth.h>
>   #include <asm/stacktrace.h>
> +#include <asm/cpu_ops.h>
> =

>   #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PE=
R_TASK)
>   #include <linux/stackprotector.h>
> @@ -74,8 +75,14 @@ void (*arm_pm_restart)(enum reboot_mode reboot_mode, c=
onst char *cmd);
> =

>   static void noinstr __cpu_do_idle(void)
>   {
> -	dsb(sy);
> -	wfi();
> +	const struct cpu_operations *ops =3D get_cpu_ops(task_cpu(current));
> +
> +	if (ops->cpu_wfi) {
> +		ops->cpu_wfi();
> +	} else {
> +		dsb(sy);
> +		wfi();
> +	}
>   }
> =

>   static void noinstr __cpu_do_idle_irqprio(void)
> --
> 2.29.2
> =





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



