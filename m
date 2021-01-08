Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4F2EF2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAHM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:56:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725965AbhAHM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:56:20 -0500
X-UUID: b37d82cfde794de1824e229c8e3eae46-20210108
X-UUID: b37d82cfde794de1824e229c8e3eae46-20210108
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1571851200; Fri, 08 Jan 2021 20:55:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Jan 2021 20:55:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 20:55:27 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <sumit.garg@linaro.org>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alexandru.elisei@arm.com>, <catalin.marinas@arm.com>,
        <jolsa@redhat.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <oliver.sang@intel.com>,
        <peterz@infradead.org>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] arm64: perf: Fix access percpu variables in preemptible context
Date:   Fri, 8 Jan 2021 20:55:27 +0800
Message-ID: <20210108125527.14175-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFA6WYNepUP=SeHWnDDbxx=ggwPq2jDd5JmrcXD5GoMC5dYH2g@mail.gmail.com>
References: <CAFA6WYNepUP=SeHWnDDbxx=ggwPq2jDd5JmrcXD5GoMC5dYH2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F980DBE543524F6AD1695F19CA3150DE4755680F32B8DE46EE87E0314CCD295D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,
 
Thanks for your reply.
 
> On Mon, 21 Dec 2020 at 21:53, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> >
> > commit 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
> > reinitilizes lockup detector after arm64 PMU is initialized and open
> > a window for accessing smp_processor_id() in preemptible context.
> > Since hardlockup_detector_perf_init() always called in init stage
> > with a single cpu, but we initialize lockup detector after the init task
> > is migratable.
> >
> > Fix this by utilizing lockup detector reconfiguration which calls
> > softlockup_start_all() on each cpu and calls watatchdog_nmi_enable() later.
> > Because softlockup_start_all() use IPI call function to make sure
> > watatchdog_nmi_enable() will bind on each cpu and fix this issue.
> 
> IMO, this just creates unnecessary dependency for hardlockup detector
> init via softlockup detector (see the alternative definition of
> lockup_detector_reconfigure()).


The arm64/Kconfig select HAVE_HARDLOCKUP_DETECTOR_PERF if we have NMI:
	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI

And in lib/Kconfig.debug HARDLOCKUP_DETECTOR select SOFTLOCKUP_DETECTOR automatically.
	config HARDLOCKUP_DETECTOR_PERF
		bool
		select SOFTLOCKUP_DETECTOR

So we don't need to explicitly select softlockup.
And actually this patch is not a perfect solution like you said
(hardlockup depends on softlockup),
but the key point is that lockup_detector_init() seems only design for
using in early init stage and not for calling in later deffered initial process.


> 
> >
> >     BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> 
> How about just the below fix in order to make CONFIG_DEBUG_PREEMPT happy?
> 
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..db06ee28f48e 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -165,7 +165,7 @@ static void watchdog_overflow_callback(struct
> perf_event *event,
> 
>  static int hardlockup_detector_event_create(void)
>  {
> -       unsigned int cpu = smp_processor_id();
> +       unsigned int cpu = raw_smp_processor_id();
>         struct perf_event_attr *wd_attr;
>         struct perf_event *evt;
> 

This won't solve the issue that arm64 called this in preemptible context,
I was trying to find a balance that can pass CONFIG_DEBUG_PREEMPT and
calling lockup_detector_init() in non-preemptive context.

watchdog_nmi_probe() and the following hardlockup_detector_event_create use
this_cpu_read/write, thus the topic of solution is better to be
'how to call lockup_detector_init() in preemptive context'

we can't just use preempt_disable/enable between lockup_detector_init() because
the call tree inside it will use kamlloc() with GFP_KERNEL which would check by might_sleep()


The v2 is now what I can find to solve this and the smallest change.
But the drawback, again, is hardlockup depends on softlockup.

The other solution may be executed lockup_detector_init in a binded thread
which only bind to one cpu.


BRs,
Lecopzer


> -Sumit
> 
> >     caller is debug_smp_processor_id+0x20/0x2c
> >     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.0+ #276
> >     Hardware name: linux,dummy-virt (DT)
> >     Call trace:
> >       dump_backtrace+0x0/0x3c0
> >       show_stack+0x20/0x6c
> >       dump_stack+0x2f0/0x42c
> >       check_preemption_disabled+0x1cc/0x1dc
> >       debug_smp_processor_id+0x20/0x2c
> >       hardlockup_detector_event_create+0x34/0x18c
> >       hardlockup_detector_perf_init+0x2c/0x134
> >       watchdog_nmi_probe+0x18/0x24
> >       lockup_detector_init+0x44/0xa8
> >       armv8_pmu_driver_init+0x54/0x78
> >       do_one_initcall+0x184/0x43c
> >       kernel_init_freeable+0x368/0x380
> >       kernel_init+0x1c/0x1cc
> >       ret_from_fork+0x10/0x30
> 
