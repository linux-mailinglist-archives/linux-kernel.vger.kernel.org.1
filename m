Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D72C631B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgK0K3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:29:52 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:1403 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727350AbgK0K3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:29:51 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARASVS7028089;
        Fri, 27 Nov 2020 11:29:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=sJczjbpQfX0PLnxbrFfI+x6RYpd7E+Y0ydQKOCv9Npk=;
 b=trYJ3zegkLwhs/56ri5/mqTAtyHpnoC/+NAzuqUk2Tu/mEbsJ2gbnX1eQ7zyJLOsD7TT
 QHK9Q5f3/1519cXU/H/t0QSyqK924VC/E4SmuZ41fkR963mmFrXsg1u/JClAsTJR+WVv
 eSPZ3+pq4+GQYs/HWAVEkGg+JXhYKI4yCubXwCkB8JxWVaFDrxmU6k3eYYy7T8NHVLzW
 SqlIOE74RmVDAIiJ4YN52/C4Aaj5pUSncrKtTwXRbeSbm8rA850WUzLuYxDJWykow8sm
 wrzfAN769+8vJH2ForuBwd6Fj7b1R0fnvDOC9374XMCabktnkXwIH+W2OQBEISylJ4xv jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y05ht05b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 11:29:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D0A110002A;
        Fri, 27 Nov 2020 11:29:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4DB8D238E15;
        Fri, 27 Nov 2020 11:29:18 +0100 (CET)
Received: from SFHDAG1NODE1.st.com (10.75.127.1) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 11:29:17 +0100
Received: from SFHDAG1NODE1.st.com ([fe80::91:9840:ca1f:420f]) by
 SFHDAG1NODE1.st.com ([fe80::91:9840:ca1f:420f%20]) with mapi id
 15.00.1473.003; Fri, 27 Nov 2020 11:29:17 +0100
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: RE: [PATCH v3 3/5] perf: stm32: ddrperfm driver creation
Thread-Topic: [PATCH v3 3/5] perf: stm32: ddrperfm driver creation
Thread-Index: AQHVXOlD+ZgoQYwFK0SqFlAqcgIaiKdyAaSAgmgkBmA=
Date:   Fri, 27 Nov 2020 10:29:17 +0000
Message-ID: <19d2e68f0da640e7812dec1fee8a0de5@SFHDAG1NODE1.st.com>
References: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
 <1566918464-23927-4-git-send-email-gerald.baeza@st.com>
 <20191029143528.GB12800@willie-the-truck>
In-Reply-To: <20191029143528.GB12800@willie-the-truck>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_05:2020-11-26,2020-11-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will

Thanks a lot for your detailed review of my v3 below and sorry for the dela=
y of
my answer : those last months were rather focused on the pmu driver using
than its improvement.

I prepared a v4 on kernel 5.10, taking into account most of your remarks be=
low=20
but I still have some open points were I would like your feedback, that I w=
ill=20
take into account... quickly !

Best regards

G=E9rald



> From: Will Deacon <will@kernel.org>
> To: Gerald BAEZA <gerald.baeza@st.com>
> Subject: Re: [PATCH v3 3/5] perf: stm32: ddrperfm driver creation
>=20
> On Tue, Aug 27, 2019 at 03:08:20PM +0000, Gerald BAEZA wrote:
> > The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1
> SOC.
> >
> > This perf drivers supports the read, write, activate, idle and total
> > time counters, described in the reference manual RM0436 that is
> > accessible from Documentation/arm/stm32/stm32mp157-overview.rst
> >
> > Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> > ---
> >  drivers/perf/Kconfig         |   6 +
> >  drivers/perf/Makefile        |   1 +
> >  drivers/perf/stm32_ddr_pmu.c | 426
> > +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 433 insertions(+)
> >  create mode 100644 drivers/perf/stm32_ddr_pmu.c
> >
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig index
> > 09ae8a9..a3d917e 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -114,6 +114,12 @@ config THUNDERX2_PMU
> >  	   The SoC has PMU support in its L3 cache controller (L3C) and
> >  	   in the DDR4 Memory Controller (DMC).
> >
> > +config STM32_DDR_PMU
> > +       tristate "STM32 DDR PMU"
> > +       depends on MACH_STM32MP157
> > +       help
> > +         Support for STM32 DDR performance monitor (DDRPERFM).
>=20
> Weird indentation here (spaces not tabes?).

Done

>=20
> >  config XGENE_PMU
> >          depends on ARCH_XGENE
> >          bool "APM X-Gene SoC PMU"
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile index
> > 2ebb4de..fd3368c 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_IMX8_DDR_PMU) +=3D
> fsl_imx8_ddr_perf.o
> >  obj-$(CONFIG_HISI_PMU) +=3D hisilicon/
> >  obj-$(CONFIG_QCOM_L2_PMU)	+=3D qcom_l2_pmu.o
> >  obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > +obj-$(CONFIG_STM32_DDR_PMU) +=3D stm32_ddr_pmu.o
> >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> >  obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o diff --git
> > a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c new
> file
> > mode 100644 index 0000000..d0480e0
> > --- /dev/null
> > +++ b/drivers/perf/stm32_ddr_pmu.c
> > @@ -0,0 +1,426 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file is the STM32 DDR performance monitor (DDRPERFM) driver
> > + *
> > + * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
> > + * Author: Gerald Baeza <gerald.baeza@st.com>  */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +/*
> > + * The PMU is able to freeze all counters and generate an interrupt
> > +when there
> > + * is a counter overflow. But, relying on this means that we lose all
> > +the
> > + * events that occur between the freeze and the interrupt handler
> execution.
> > + * So we use a polling mechanism to avoid this lose of information.
> > + * The fastest counter can overflow in ~8s @533MHz (that is the
> > +maximum DDR
> > + * frequency supported on STM32MP157), so we poll in 4s intervals to
> > +ensure
> > + * we don't reach this limit.
> > + */
> > +#define POLL_MS		4000
> > +
> > +#define DDRPERFM_CTL	0x000
> > +#define DDRPERFM_CFG	0x004
> > +#define DDRPERFM_STATUS 0x008
> > +#define DDRPERFM_CCR	0x00C
> > +#define DDRPERFM_IER	0x010
> > +#define DDRPERFM_ISR	0x014
> > +#define DDRPERFM_ICR	0x018
> > +#define DDRPERFM_TCNT	0x020
> > +#define DDRPERFM_CNT(X)	(0x030 + 8 * (X))
> > +#define DDRPERFM_HWCFG	0x3F0
> > +#define DDRPERFM_VER	0x3F4
> > +#define DDRPERFM_ID	0x3F8
> > +#define DDRPERFM_SID	0x3FC
> > +
> > +#define CTL_START	0x00000001
> > +#define CTL_STOP	0x00000002
> > +#define CCR_CLEAR_ALL	0x8000000F
> > +#define SID_MAGIC_ID	0xA3C5DD01
>=20
> What's this for? The check during probe looks weird.

Indeed, I removed it.

>=20
> > +
> > +enum {
> > +	READ_CNT,
> > +	WRITE_CNT,
> > +	ACTIVATE_CNT,
> > +	IDLE_CNT,
> > +	TIME_CNT,
> > +	PMU_NR_COUNTERS
> > +};
>=20
> I think these correspond directly to the values set by userspace in attr.=
config,
> so you probably want to clamp attr.config to be < PMU_NR_COUNTERS in
> stm32_ddr_pmu_event_init().
>=20

Done

> > +struct stm32_ddr_pmu {
> > +	struct pmu pmu;
> > +	void __iomem *membase;
> > +	struct clk *clk;
> > +	struct hrtimer hrtimer;
> > +	cpumask_t pmu_cpu;
> > +	ktime_t poll_period;
> > +	struct perf_event *events[PMU_NR_COUNTERS];
> > +	u64 events_cnt[PMU_NR_COUNTERS];
> > +};
> > +
> > +static inline struct stm32_ddr_pmu *pmu_to_stm32_ddr_pmu(struct
> pmu
> > +*p) {
> > +	return container_of(p, struct stm32_ddr_pmu, pmu); }
> > +
> > +static inline struct stm32_ddr_pmu *hrtimer_to_stm32_ddr_pmu(struct
> > +hrtimer *h) {
> > +	return container_of(h, struct stm32_ddr_pmu, hrtimer); }
> > +
> > +static void stm32_ddr_pmu_event_configure(struct perf_event *event) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	unsigned long config_base =3D event->hw.config_base;
> > +	u32 val;
> > +
> > +	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase +
> DDRPERFM_CTL);
> > +
> > +	if (config_base < TIME_CNT) {
> > +		val =3D readl_relaxed(stm32_ddr_pmu->membase +
> DDRPERFM_CFG);
> > +		val |=3D (1 << config_base);
> > +		writel_relaxed(val, stm32_ddr_pmu->membase +
> DDRPERFM_CFG);
> > +	}
> > +}
> > +
> > +static void stm32_ddr_pmu_event_read(struct perf_event *event) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	unsigned long config_base =3D event->hw.config_base;
> > +	struct hw_perf_event *hw =3D &event->hw;
> > +	u64 prev_count, new_count, mask;
> > +	u32 val, offset, bit;
> > +
> > +	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase +
> DDRPERFM_CTL);
> > +
> > +	if (config_base =3D=3D TIME_CNT) {
> > +		offset =3D DDRPERFM_TCNT;
> > +		bit =3D 1 << 31;
> > +	} else {
> > +		offset =3D DDRPERFM_CNT(config_base);
> > +		bit =3D 1 << config_base;
> > +	}
> > +	val =3D readl_relaxed(stm32_ddr_pmu->membase +
> DDRPERFM_STATUS);
> > +	if (val & bit)
> > +		pr_warn("STM32 DDR PMU hardware counter overflow\n");
>=20
> I don't think this print is useful. Surely overflow is fatal and you shou=
ld do
> something like put the event into an error state?

The polling period is adjusted with 100% margin so we never saw this overfl=
ow
while using the driver during the past four years and we won't see it, as f=
ar
as the driver is not modified.

So I would propose to keep the overflow detection just in case a future cha=
nge=20
leads to get it but I do not see how to do this (with regards to the user l=
and=20
notification) : any example I could have a look on ?

>=20
> > +	val =3D readl_relaxed(stm32_ddr_pmu->membase + offset);
> > +	writel_relaxed(bit, stm32_ddr_pmu->membase + DDRPERFM_CCR);
> > +	writel_relaxed(CTL_START, stm32_ddr_pmu->membase +
> DDRPERFM_CTL);
> > +
> > +	do {
> > +		prev_count =3D local64_read(&hw->prev_count);
> > +		new_count =3D prev_count + val;
> > +	} while (local64_xchg(&hw->prev_count, new_count) !=3D
> prev_count);
> > +
> > +	mask =3D GENMASK_ULL(31, 0);
> > +	local64_add(val & mask, &event->count);
> > +
> > +	if (new_count < prev_count)
> > +		pr_warn("STM32 DDR PMU software counter rollover\n");
>=20
> These are 64-bit. How fast do you expect the counters to tick?

The total time count is increment at the frequency of the DDR,=20
533 MHz on STM32MP15, so the rollover will happen in around 1000
years... so I am sad to discover that I will never see this warning :(
I removed it, thanks for pointing this out !

>=20
> > +static void stm32_ddr_pmu_event_start(struct perf_event *event, int
> > +flags) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	struct hw_perf_event *hw =3D &event->hw;
> > +
> > +	if (WARN_ON_ONCE(!(hw->state & PERF_HES_STOPPED)))
> > +		return;
> > +
> > +	if (flags & PERF_EF_RELOAD)
> > +		WARN_ON_ONCE(!(hw->state & PERF_HES_UPTODATE));
> > +
> > +	stm32_ddr_pmu_event_configure(event);
> > +
> > +	/* Clear all counters to synchronize them, then start */
> > +	writel_relaxed(CCR_CLEAR_ALL, stm32_ddr_pmu->membase +
> DDRPERFM_CCR);
> > +	writel_relaxed(CTL_START, stm32_ddr_pmu->membase +
> DDRPERFM_CTL);
> > +	local64_set(&hw->prev_count, 0);
> > +	hw->state =3D 0;
> > +}
> > +
> > +static void stm32_ddr_pmu_event_stop(struct perf_event *event, int
> > +flags) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	unsigned long config_base =3D event->hw.config_base;
> > +	struct hw_perf_event *hw =3D &event->hw;
> > +	u32 val, bit;
> > +
> > +	if (WARN_ON_ONCE(hw->state & PERF_HES_STOPPED))
> > +		return;
> > +
> > +	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase +
> DDRPERFM_CTL);
> > +	if (config_base =3D=3D TIME_CNT)
> > +		bit =3D 1 << 31;
> > +	else
> > +		bit =3D 1 << config_base;
> > +	writel_relaxed(bit, stm32_ddr_pmu->membase + DDRPERFM_CCR);
> > +	if (config_base < TIME_CNT) {
> > +		val =3D readl_relaxed(stm32_ddr_pmu->membase +
> DDRPERFM_CFG);
> > +		val &=3D ~bit;
> > +		writel_relaxed(val, stm32_ddr_pmu->membase +
> DDRPERFM_CFG);
> > +	}
> > +
> > +	hw->state |=3D PERF_HES_STOPPED;
> > +
> > +	if (flags & PERF_EF_UPDATE) {
> > +		stm32_ddr_pmu_event_read(event);
> > +		hw->state |=3D PERF_HES_UPTODATE;
> > +	}
> > +}
> > +
> > +static int stm32_ddr_pmu_event_add(struct perf_event *event, int
> > +flags) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	unsigned long config_base =3D event->hw.config_base;
> > +	struct hw_perf_event *hw =3D &event->hw;
> > +
> > +	stm32_ddr_pmu->events_cnt[config_base] =3D 0;
> > +	stm32_ddr_pmu->events[config_base] =3D event;
> > +
> > +	clk_enable(stm32_ddr_pmu->clk);
> > +	/*
> > +	 * Pin the timer, so that the overflows are handled by the chosen
> > +	 * event->cpu (this is the same one as presented in "cpumask"
> > +	 * attribute).
> > +	 */
> > +	hrtimer_start(&stm32_ddr_pmu->hrtimer, stm32_ddr_pmu-
> >poll_period,
> > +		      HRTIMER_MODE_REL_PINNED);
> > +
> > +	stm32_ddr_pmu_event_configure(event);
> > +
> > +	hw->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +
> > +	if (flags & PERF_EF_START)
> > +		stm32_ddr_pmu_event_start(event, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void stm32_ddr_pmu_event_del(struct perf_event *event, int
> > +flags) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	unsigned long config_base =3D event->hw.config_base;
> > +	bool stop =3D true;
> > +	int i;
> > +
> > +	stm32_ddr_pmu_event_stop(event, PERF_EF_UPDATE);
> > +
> > +	stm32_ddr_pmu->events_cnt[config_base] +=3D
> local64_read(&event->count);
> > +	stm32_ddr_pmu->events[config_base] =3D NULL;
> > +
> > +	for (i =3D 0; i < PMU_NR_COUNTERS; i++)
> > +		if (stm32_ddr_pmu->events[i])
> > +			stop =3D false;
> > +	if (stop)
>=20
> This is just i =3D=3D PMU_NR_COUNTERS if you add a break in the if clause=
.

Done

>=20
> > +		hrtimer_cancel(&stm32_ddr_pmu->hrtimer);
> > +
> > +	clk_disable(stm32_ddr_pmu->clk);
> > +}
> > +
> > +static int stm32_ddr_pmu_event_init(struct perf_event *event) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> pmu_to_stm32_ddr_pmu(event->pmu);
> > +	struct hw_perf_event *hw =3D &event->hw;
> > +
> > +	if (event->attr.type !=3D event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	if (is_sampling_event(event))
> > +		return -EINVAL;
> > +
> > +	if (event->attach_state & PERF_ATTACH_TASK)
> > +		return -EINVAL;
> > +
> > +	if (event->attr.exclude_user   ||
> > +	    event->attr.exclude_kernel ||
> > +	    event->attr.exclude_hv     ||
> > +	    event->attr.exclude_idle   ||
> > +	    event->attr.exclude_host   ||
> > +	    event->attr.exclude_guest)
> > +		return -EINVAL;
> > +
> > +	if (event->cpu < 0)
> > +		return -EINVAL;
> > +
> > +	hw->config_base =3D event->attr.config;
> > +	event->cpu =3D cpumask_first(&stm32_ddr_pmu->pmu_cpu);
> > +
> > +	return 0;
> > +}
> > +
> > +static enum hrtimer_restart stm32_ddr_pmu_poll(struct hrtimer
> > +*hrtimer) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu =3D
> hrtimer_to_stm32_ddr_pmu(hrtimer);
> > +	int i;
> > +
> > +	for (i =3D 0; i < PMU_NR_COUNTERS; i++)
> > +		if (stm32_ddr_pmu->events[i])
> > +			stm32_ddr_pmu_event_read(stm32_ddr_pmu-
> >events[i]);
> > +
> > +	hrtimer_forward_now(hrtimer, stm32_ddr_pmu->poll_period);
> > +
> > +	return HRTIMER_RESTART;
> > +}
> > +
> > +static ssize_t stm32_ddr_pmu_sysfs_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct dev_ext_attribute *eattr;
> > +
> > +	eattr =3D container_of(attr, struct dev_ext_attribute, attr);
> > +
> > +	return sprintf(buf, "config=3D0x%lx\n", (unsigned long)eattr->var); }
>=20
> Will you ever want to use other bits in the config to configure the PMU?
> If so, perhaps its worth carving out a smaller event field, a bit like
> fsl_imx8_ddr_perf.c does.
>=20

I do not see any application for this, now or later on.

> > +
> > +#define STM32_DDR_PMU_ATTR(_name, _func, _config)
> 	\
> > +	(&((struct dev_ext_attribute[]) {				\
> > +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
> > +	})[0].attr.attr)
> > +
> > +#define STM32_DDR_PMU_EVENT_ATTR(_name, _config)		\
> > +	STM32_DDR_PMU_ATTR(_name, stm32_ddr_pmu_sysfs_show,
> 	\
> > +			   (unsigned long)_config)
> > +
> > +static struct attribute *stm32_ddr_pmu_event_attrs[] =3D {
> > +	STM32_DDR_PMU_EVENT_ATTR(read_cnt, READ_CNT),
> > +	STM32_DDR_PMU_EVENT_ATTR(write_cnt, WRITE_CNT),
> > +	STM32_DDR_PMU_EVENT_ATTR(activate_cnt, ACTIVATE_CNT),
> > +	STM32_DDR_PMU_EVENT_ATTR(idle_cnt, IDLE_CNT),
> > +	STM32_DDR_PMU_EVENT_ATTR(time_cnt, TIME_CNT),
> > +	NULL
> > +};
> > +
> > +static struct attribute_group stm32_ddr_pmu_event_attrs_group =3D {
> > +	.name =3D "events",
> > +	.attrs =3D stm32_ddr_pmu_event_attrs,
> > +};
> > +
> > +static const struct attribute_group *stm32_ddr_pmu_attr_groups[] =3D {
> > +	&stm32_ddr_pmu_event_attrs_group,
> > +	NULL,
> > +};
> > +
> > +static int stm32_ddr_pmu_device_probe(struct platform_device *pdev) {
> > +	struct stm32_ddr_pmu *stm32_ddr_pmu;
> > +	struct reset_control *rst;
> > +	struct resource *res;
> > +	int i, ret;
> > +	u32 val;
> > +
> > +	stm32_ddr_pmu =3D devm_kzalloc(&pdev->dev, sizeof(struct
> stm32_ddr_pmu),
> > +				     GFP_KERNEL);
> > +	if (!stm32_ddr_pmu)
> > +		return -ENOMEM;
> > +	platform_set_drvdata(pdev, stm32_ddr_pmu);
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	stm32_ddr_pmu->membase =3D devm_ioremap_resource(&pdev-
> >dev, res);
> > +	if (IS_ERR(stm32_ddr_pmu->membase)) {
> > +		pr_warn("Unable to get STM32 DDR PMU membase\n");
> > +		return PTR_ERR(stm32_ddr_pmu->membase);
> > +	}
> > +
> > +	stm32_ddr_pmu->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(stm32_ddr_pmu->clk)) {
> > +		pr_warn("Unable to get STM32 DDR PMU clock\n");
> > +		return PTR_ERR(stm32_ddr_pmu->clk);
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(stm32_ddr_pmu->clk);
> > +	if (ret) {
> > +		pr_warn("Unable to prepare STM32 DDR PMU clock\n");
> > +		return ret;
> > +	}
> > +
> > +	stm32_ddr_pmu->poll_period =3D ms_to_ktime(POLL_MS);
> > +	hrtimer_init(&stm32_ddr_pmu->hrtimer, CLOCK_MONOTONIC,
> > +		     HRTIMER_MODE_REL);
>=20
> I would /much/ prefer for the timer to be handled by the perf core
> automatically when a PMU is registered with
> PERF_PMU_CAP_NO_INTERRUPT. That way, other drivers can benefit from
> this without tonnes of code duplication.

Do you mean that the perf core offers such a possibility or do you suggest
to add it ?
Because, in kernel 5.10, I can still see such code duplication in several d=
rivers,=20
indeed  :(

> > +	stm32_ddr_pmu->hrtimer.function =3D stm32_ddr_pmu_poll;
> > +
> > +	/*
> > +	 * The PMU is assigned to the cpu0 and there is no need to manage
> cpu
> > +	 * hot plug migration because cpu0 is always the first/last active cp=
u
> > +	 * during low power transitions.
> > +	 */
> > +	cpumask_set_cpu(0, &stm32_ddr_pmu->pmu_cpu);
> > +
> > +	for (i =3D 0; i < PMU_NR_COUNTERS; i++) {
> > +		stm32_ddr_pmu->events[i] =3D NULL;
> > +		stm32_ddr_pmu->events_cnt[i] =3D 0;
> > +	}
> > +
> > +	val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_SID);
> > +	if (val !=3D SID_MAGIC_ID)
> > +		return -EINVAL;
> > +
> > +	stm32_ddr_pmu->pmu =3D (struct pmu) {
> > +		.task_ctx_nr =3D perf_invalid_context,
> > +		.start =3D stm32_ddr_pmu_event_start,
> > +		.stop =3D stm32_ddr_pmu_event_stop,
> > +		.add =3D stm32_ddr_pmu_event_add,
> > +		.del =3D stm32_ddr_pmu_event_del,
> > +		.event_init =3D stm32_ddr_pmu_event_init,
> > +		.attr_groups =3D stm32_ddr_pmu_attr_groups,
> > +	};
> > +	ret =3D perf_pmu_register(&stm32_ddr_pmu->pmu,
> "stm32_ddr_pmu", -1);
>=20
> You might want an index on the end of this name in case you ever want to
> support more than one in a given SoC.

There is no plan to embed multiple instances of this PMU in a SoC.

>=20
> > +	if (ret) {
> > +		pr_warn("Unable to register STM32 DDR PMU\n");
> > +		return ret;
> > +	}
> > +
> > +	rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +	if (!IS_ERR(rst)) {
> > +		reset_control_assert(rst);
> > +		udelay(2);
> > +		reset_control_deassert(rst);
> > +	}
> > +
> > +	pr_info("stm32-ddr-pmu: probed (DDRPERFM ID=3D0x%08x
> VER=3D0x%08x)\n",
> > +		readl_relaxed(stm32_ddr_pmu->membase +
> DDRPERFM_ID),
> > +		readl_relaxed(stm32_ddr_pmu->membase +
> DDRPERFM_VER));
>=20
> dev_info(). Similarly for many of your other pr_*() calls.

Done (for all occurrences)

>=20
> Will
