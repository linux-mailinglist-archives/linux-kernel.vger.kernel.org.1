Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99127AAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgI1J1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:27:09 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:39911 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgI1J1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:27:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07946264|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00498141-0.00192746-0.993091;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.IdDAHLT_1601285220;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.IdDAHLT_1601285220)
          by smtp.aliyun-inc.com(10.147.44.118);
          Mon, 28 Sep 2020 17:27:00 +0800
Date:   Mon, 28 Sep 2020 17:26:54 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENI?= =?utf-8?Q?=5D?= cpuidle: add
 riscv cpuidle driver
Message-ID: <20200928092654.GB4756@g8Exdroid64>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
 <80bc85f5-fba3-5f08-4d73-372b5f495833@linaro.org>
 <58abe153-689d-460c-a119-91270cd110cf.liush@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58abe153-689d-460c-a119-91270cd110cf.liush@allwinnertech.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 08:58:02PM +0800, 刘邵华BTD wrote:
> Hi Daniel,
> > > This patch adds a cpuidle driver for systems based RISCV architecture.
> > > This patch supports state WFI. Other states will be supported in the
> > > future.
> > > 
> > > Signed-off-by: liush <liush@allwinnertech.com>
> > > ---
> > 
> > [ ... ]
> > 
> > >  
> > >  obj-$(CONFIG_RISCV_M_MODE) += traps_misaligned.o
> > > diff --git a/arch/riscv/kernel/cpuidle.c b/arch/riscv/kernel/cpuidle.c
> > > new file mode 100644
> > > index 00000000..a3289e7
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/cpuidle.c
> > > @@ -0,0 +1,8 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <asm/cpuidle.h>
> > > +
> > > +void cpu_do_idle(void)
> > > +{
> > > + __asm__ __volatile__ ("wfi");
> > > +
> > 
> > extra line
> > 
> > > +}
> 
> > As for the next deeper states should end up with the cpu_do_idle
> > function, isn't there an extra operation with the wfi() like flushing
> > the l1 cache?
> 
> Data cache consistency is mainly ensured by hardware in riscv, and there is no 
> implementation of flushing data cache in kernel. Before wfi(),add an memory 
> barrier operation - mb(). Is this feasible? 
> 
>   //arch/riscv/include/asm/barrier.h
> 
>   17 #define RISCV_FENCE(p, s) \
>   18         __asm__ __volatile__ ("fence " #p "," #s : : : "memory")
>   19 
>   20 /* These barriers need to enforce ordering on both devices or memory. */                                                                                                            
>   21 #define mb()            RISCV_FENCE(iorw,iorw) 
> 
> 
> After modification, the codes is as follows.
> 
> 81 @@ -0,0 +1,8 @@
> 82 +// SPDX-License-Identifier: GPL-2.0
> 83 +#include <asm/cpuidle.h>
> 84 +
> 85 +void cpu_do_idle(void)
> 86 +{
> 87 +       mb();
take a sceptical attibute with it , anyway mb() shout comment it with why
> 88 +       __asm__ __volatile__ ("wfi");
> 89 +
> 90 +}
> 
> > > diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> > > index c0aeedd..f6be0fd 100644
> > > --- a/drivers/cpuidle/Kconfig
> > > +++ b/drivers/cpuidle/Kconfig
> > > @@ -62,6 +62,11 @@ depends on PPC
> > >  source "drivers/cpuidle/Kconfig.powerpc"
> > >  endmenu
> > >  
> > > +menu "RISCV CPU Idle Drivers"
> > > +depends on RISCV
> > > +source "drivers/cpuidle/Kconfig.riscv"
> > > +endmenu
> > > +
> > >  config HALTPOLL_CPUIDLE
> > >   tristate "Halt poll cpuidle driver"
> > >   depends on X86 && KVM_GUEST
> > > diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
> > > new file mode 100644
> > > index 00000000..e86d36b
> > > --- /dev/null
> > > +++ b/drivers/cpuidle/Kconfig.riscv
> > > @@ -0,0 +1,11 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# RISCV CPU Idle drivers
> > > +#
> > > +config RISCV_CPUIDLE
> > > +        bool "Generic RISCV CPU idle Driver"
> > > +        select DT_IDLE_STATES
> > > + select CPU_IDLE_MULTIPLE_DRIVERS
> > > +        help
> > > +          Select this option to enable generic cpuidle driver for RISCV.
> > > +   Now only support C0 State.
> > 
> > Identation
> 
> I'll fix it. Thank you!

-- 
<http://www.allwinnertech.com> Allwinnertech Technology


