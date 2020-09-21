Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7958527246D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIUM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:57:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIUM5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:57:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4FEDD6E;
        Mon, 21 Sep 2020 05:57:51 -0700 (PDT)
Received: from [10.57.43.251] (unknown [10.57.43.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276A53F73B;
        Mon, 21 Sep 2020 05:57:50 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, patches@amperecomputing.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1598033450-30145-1-git-send-email-tuanphan@os.amperecomputing.com>
Message-ID: <c2a14d58-e18f-ca93-4a56-0de11a41ed73@arm.com>
Date:   Mon, 21 Sep 2020 13:57:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1598033450-30145-1-git-send-email-tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-21 19:10, Tuan Phan wrote:
> DMC-620 PMU supports total 10 counters which each is
> independently programmable to different events and can
> be started and stopped individually.
> 
> Currently, it only supports ACPI. Other platforms feel free to test and add
> support for device tree.

[ Note to anyone playing along at home - the DMC-620 TRM documents the 
register map, but not the actual register contents or PMU event details. 
It'll be hard to use this driver meaningfully unless you're a licensee 
with access to the confidential "Design Manual". Also DMC-620 has no 
TrustZone support, so this particular setup relies on a special 
interconnect mediating Non-Secure accesses to the PMU registers (or 
possibly a massively-inadvisable integration of the entire thing as NS, 
but ugh...) ]

> Usage example:
>    #perf stat -e arm_dmc620_10008c000/clk_cycle_count/ -C 0
>    Get perf event for clk_cycle_count counter.
> 
>    #perf stat -e arm_dmc620_10008c000/clkdiv2_allocate,mask=0x1f,match=0x2f,
>    incr=2,invert=1/ -C 0
>    The above example shows how to specify mask, match, incr,
>    invert parameters for clkdiv2_allocate event.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> Changes in v3:
> - Removed "_OFFSET" suffix.
> - Renamed "affinity" to "irq".
> - Have a better definition of group register.
> 
> Changes in v2:
> - Removed IRQF_SHARED flag and added support for multiple
> PMUs sharing the same interrupt.
> - Fixed an interrupt handler race condition.
> 
> The ACPI binding spec for PMU DMC620 can be downloaded at:
> https://developer.arm.com/documentation/den0093/c/
> 
>   drivers/perf/Kconfig          |   8 +
>   drivers/perf/Makefile         |   1 +
>   drivers/perf/arm_dmc620_pmu.c | 880 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 889 insertions(+)
>   create mode 100644 drivers/perf/arm_dmc620_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 7305d57..240cc3e 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -123,6 +123,14 @@ config ARM_SPE_PMU
>   	  Extension, which provides periodic sampling of operations in
>   	  the CPU pipeline and reports this via the perf AUX interface.
>   
> +config ARM_DMC620_PMU
> +	tristate "Enable PMU support for the ARM DMC-620 memory controller"
> +	depends on ARM64 && ACPI

COMPILE_TEST coverage is always nice to have - nothing here should 
functionally depend on the CPU architecture.

> +	default n

No need to specify that - "n" is the implicit default anyway.

> +	help
> +	  Support for PMU events monitoring on the ARM DMC-620 memory
> +	  controller.
> +
>   source "drivers/perf/hisilicon/Kconfig"
>   
>   endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 2ebb4de..5d577d1 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>   obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>   obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>   obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> +obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> new file mode 100644
> index 0000000..811c4de
> --- /dev/null
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ARM DMC-620 memory controller PMU driver
> + *
> + * Copyright (C) 2020 Ampere Computing LLC.
> + */
> +
> +#define DMC620_PMUNAME		"arm_dmc620"
> +#define DMC620_DRVNAME		DMC620_PMUNAME "_pmu"
> +#define pr_fmt(fmt)		DMC620_DRVNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/perf_event.h>
> +#include <linux/perf/arm_pmu.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/rculist.h>
> +#include <linux/refcount.h>
> +
> +#define DMC620_PA_SHIFT					12
> +#define DMC620_CNT_MAX_PERIOD				0xffffffff
> +#define DMC620_PMU_CLKDIV2_MAX_COUNTERS			8
> +#define DMC620_PMU_CLK_MAX_COUNTERS			2
> +#define DMC620_PMU_MAX_COUNTERS				\
> +	(DMC620_PMU_CLKDIV2_MAX_COUNTERS + DMC620_PMU_CLK_MAX_COUNTERS)
> +
> +/*
> + * The PMU registers start at 0xA00 in the DMC-620 memory map, and these
> + * offsets are relative to that base.
> + *
> + * Each counter has a group of control/value registers, and the
> + * DMC620_PMU_COUNTERx offsets are within a counter group.
> + *
> + * The counter registers groups start at 0xA10.
> + */
> +#define DMC620_PMU_OVERFLOW_STATUS_CLKDIV2		0x8
> +#define  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK	\
> +		(DMC620_PMU_CLKDIV2_MAX_COUNTERS - 1)
> +#define DMC620_PMU_OVERFLOW_STATUS_CLK			0xC
> +#define  DMC620_PMU_OVERFLOW_STATUS_CLK_MASK		\
> +		(DMC620_PMU_CLK_MAX_COUNTERS - 1)
> +#define DMC620_PMU_COUNTERS_BASE			0x10
> +#define DMC620_PMU_COUNTERx_MASK_31_00			0x0
> +#define DMC620_PMU_COUNTERx_MASK_63_32			0x4
> +#define DMC620_PMU_COUNTERx_MATCH_31_00			0x8
> +#define DMC620_PMU_COUNTERx_MATCH_63_32			0xC
> +#define DMC620_PMU_COUNTERx_CONTROL			0x10
> +#define  DMC620_PMU_COUNTER_CONTROLx_ENABLE_MASK	BIT(0)
> +#define  DMC620_PMU_COUNTER_CONTROLx_INVERT_SHIFT	1

I'll try not to get bogged down in stylistic comments (there's a lot 
here that I would choose to do very differently), but for regular 
register fields I do think it's nice to standardise on bitfield.h rather 
than rolling yet another weird mix of ad-hoc accessors.

> +#define  DMC620_PMU_COUNTER_CONTROLx_EVENT_MUX		(((x)&0x1f)>>2)

Where is "x" supposed to come from here?

> +#define  DMC620_PMU_COUNTER_CONTROLx_EVENT_MUX_SHIFT	2
> +#define  DMC620_PMU_COUNTERx_CONTROL_INCR		(((x)&0x1ff)>>7)

Ditto, although I see that neither of these are actually used anywhere :/

> +#define  DMC620_PMU_COUNTERx_CONTROL_INCR_SHIFT		7
> +#define DMC620_PMU_COUNTERx_SNAPSHOT			0x18

Are the counter snapshot registers relevant considering you haven't 
included pmu_snapshot_req/ack?

> +#define DMC620_PMU_COUNTERx_VALUE			0x20
> +/* Offset of the registers for a given counter, relative to 0xA00 */
> +#define DMC620_PMU_COUNTERx_OFFSET(x) \
> +	(DMC620_PMU_COUNTERS_BASE + 0x28 * (x))

I have to say this double relative offset shenanigans is rather 
confusing, but at least it's hidden in these macros :/

> +#define DMC620_PMU_CLKDIV2_CYCLE_COUNT			0x0
> +#define DMC620_PMU_CLKDIV2_ALLOCATE			0x1
> +#define DMC620_PMU_CLKDIV2_QUEUE_DEPTH			0x2
> +#define DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA		0x3
> +#define DMC620_PMU_CLKDIV2_READ_BACKLOG			0x4
> +#define DMC620_PMU_CLKDIV2_WAITING_FOR_MI		0x5
> +#define DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION		0x6
> +#define DMC620_PMU_CLKDIV2_ENQUEUE			0x7
> +#define DMC620_PMU_CLKDIV2_ARBITRATE			0x8
> +#define DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE	0x9
> +#define DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE	0xA
> +#define DMC620_PMU_CLKDIV2_READ_DEPTH			0xB
> +#define DMC620_PMU_CLKDIV2_WRITE_DEPTH			0xC
> +#define DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH		0xD
> +#define DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH		0xE
> +#define DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH		0xF
> +#define DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH		0x10
> +#define DMC620_PMU_CLKDIV2_ACTIVATE			0x11
> +#define DMC620_PMU_CLKDIV2_RDWR				0x12
> +#define DMC620_PMU_CLKDIV2_REFRESH			0x13
> +#define DMC620_PMU_CLKDIV2_TRAINING_REQUEST		0x14
> +#define DMC620_PMU_CLKDIV2_T_MAC_TRACKER		0x15
> +#define DMC620_PMU_CLKDIV2_BK_FSM_TRACKER		0x16
> +#define DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER		0x17
> +#define DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN		0x18
> +#define DMC620_PMU_CLKDIV2_RANKS_IN_SREF		0x19
> +#define DMC620_PMU_CLK_CYCLE_COUNTER			0x20

At this point we suddenly deviate from straightforward hardware 
definitions - after looking at the rest of the code I can see what's 
going on, but it might be clearer to give the clk/clkdiv2 domain 
discrimination its own separate config field.

> +#define DMC620_PMU_CLK_REQUEST				0x21
> +#define DMC620_PMU_CLK_UPLOAD_STALL			0x22
> +#define DMC620_PMU_CLK_INDICATE_MASK			0x20
> +
> +static LIST_HEAD(dmc620_pmu_irqs);
> +static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
> +
> +struct dmc620_pmu_irq {
> +	struct hlist_node node;
> +	struct list_head pmus_node;
> +	struct list_head irqs_node;
> +	refcount_t refcount;
> +	unsigned int irq_num;
> +	unsigned int cpu;
> +};
> +
> +struct dmc620_pmu {
> +	struct pmu pmu;
> +	struct platform_device *pdev;
> +
> +	void __iomem *base;
> +	struct dmc620_pmu_irq *irq;
> +	struct list_head pmus_node;
> +
> +	/*
> +	 * We put all clkdiv2 and clk counters to a same array.
> +	 * The first DMC620_PMU_CLKDIV2_MAX_COUNTERS bits belong to
> +	 * clkdiv2 counters, the last DMC620_PMU_CLK_MAX_COUNTERS
> +	 * belong to clk counters.
> +	 */
> +	DECLARE_BITMAP(used_mask, DMC620_PMU_MAX_COUNTERS);
> +	struct perf_event *events[DMC620_PMU_MAX_COUNTERS];
> +};
> +
> +#define to_dmc620_pmu(p) (container_of(p, struct dmc620_pmu, pmu))
> +
> +static int cpuhp_state_num;
> +
> +static ssize_t
> +dmc620_pmu_events_sysfs_show(struct device *dev,
> +			   struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);
> +}
> +
> +#define DMC620_PMU_EVENT_ATTR(name, config)			\
> +	PMU_EVENT_ATTR(name, dmc620_pmu_event_attr_##name,	\
> +		       config, dmc620_pmu_events_sysfs_show)
> +
> +/* clkdiv2 events list */
> +DMC620_PMU_EVENT_ATTR(clkdiv2_cycle_count,
> +		DMC620_PMU_CLKDIV2_CYCLE_COUNT);

Given that the macros literally just duplicate the event names listed 
here, and ultimately make the whole lot take up 3 times as many lines 
overall, I think it would end up *more* readable to simply use the raw 
event numbers at this point and not have the extra level of indirection 
at all.

> +DMC620_PMU_EVENT_ATTR(clkdiv2_allocate,
> +		DMC620_PMU_CLKDIV2_ALLOCATE);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_queue_depth,
> +		DMC620_PMU_CLKDIV2_QUEUE_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_wr_data,
> +		DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_read_backlog,
> +		DMC620_PMU_CLKDIV2_READ_BACKLOG);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_mi,
> +		DMC620_PMU_CLKDIV2_WAITING_FOR_MI);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_hazard_resolution,
> +		DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_enqueue,
> +		DMC620_PMU_CLKDIV2_ENQUEUE);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_arbitrate,
> +		DMC620_PMU_CLKDIV2_ARBITRATE);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_lrank_turnaround_activate,
> +		DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_prank_turnaround_activate,
> +		DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_read_depth,
> +		DMC620_PMU_CLKDIV2_READ_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_write_depth,
> +		DMC620_PMU_CLKDIV2_WRITE_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_highigh_qos_depth,
> +		DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_high_qos_depth,
> +		DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_medium_qos_depth,
> +		DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_low_qos_depth,
> +		DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_activate,
> +		DMC620_PMU_CLKDIV2_ACTIVATE);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_rdwr,
> +		DMC620_PMU_CLKDIV2_RDWR);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_refresh,
> +		DMC620_PMU_CLKDIV2_REFRESH);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_training_request,
> +		DMC620_PMU_CLKDIV2_TRAINING_REQUEST);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_t_mac_tracker,
> +		DMC620_PMU_CLKDIV2_T_MAC_TRACKER);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_bk_fsm_tracker,
> +		DMC620_PMU_CLKDIV2_BK_FSM_TRACKER);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_bk_open_tracker,
> +		DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_pwr_down,
> +		DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN);
> +DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_sref,
> +		DMC620_PMU_CLKDIV2_RANKS_IN_SREF);
> +
> +/* clk events list */
> +DMC620_PMU_EVENT_ATTR(clk_cycle_count,
> +		DMC620_PMU_CLK_CYCLE_COUNTER);
> +DMC620_PMU_EVENT_ATTR(clk_request,
> +		DMC620_PMU_CLK_REQUEST);
> +DMC620_PMU_EVENT_ATTR(clk_upload_stall,
> +		DMC620_PMU_CLK_UPLOAD_STALL);
> +
> +static struct attribute *dmc620_pmu_events_attrs[] = {
> +	&dmc620_pmu_event_attr_clkdiv2_cycle_count.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_allocate.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_queue_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_waiting_for_wr_data.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_read_backlog.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_waiting_for_mi.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_hazard_resolution.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_enqueue.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_arbitrate.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_lrank_turnaround_activate.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_prank_turnaround_activate.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_read_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_write_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_highigh_qos_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_high_qos_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_medium_qos_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_low_qos_depth.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_activate.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_rdwr.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_refresh.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_training_request.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_t_mac_tracker.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_bk_fsm_tracker.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_bk_open_tracker.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_ranks_in_pwr_down.attr.attr,
> +	&dmc620_pmu_event_attr_clkdiv2_ranks_in_sref.attr.attr,
> +	&dmc620_pmu_event_attr_clk_cycle_count.attr.attr,
> +	&dmc620_pmu_event_attr_clk_request.attr.attr,
> +	&dmc620_pmu_event_attr_clk_upload_stall.attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dmc620_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = dmc620_pmu_events_attrs,
> +};
> +
> +/* User ABI */
> +#define ATTR_CFG_FLD_mask_CFG		config
> +#define ATTR_CFG_FLD_mask_LO		0
> +#define ATTR_CFG_FLD_mask_HI		44
> +#define ATTR_CFG_FLD_match_CFG		config1
> +#define ATTR_CFG_FLD_match_LO		0
> +#define ATTR_CFG_FLD_match_HI		44
> +#define ATTR_CFG_FLD_invert_CFG		config2
> +#define ATTR_CFG_FLD_invert_LO		0
> +#define ATTR_CFG_FLD_invert_HI		0
> +#define ATTR_CFG_FLD_incr_CFG		config2
> +#define ATTR_CFG_FLD_incr_LO		1
> +#define ATTR_CFG_FLD_incr_HI		2
> +#define ATTR_CFG_FLD_event_CFG		config2
> +#define ATTR_CFG_FLD_event_LO		3
> +#define ATTR_CFG_FLD_event_HI		8
> +
> +#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
> +	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
> +
> +#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
> +	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
> +
> +#define GEN_PMU_FORMAT_ATTR(name)				\
> +	PMU_FORMAT_ATTR(name,					\
> +	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,		\
> +			     ATTR_CFG_FLD_##name##_LO,		\
> +			     ATTR_CFG_FLD_##name##_HI))
> +
> +#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
> +	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
> +
> +#define ATTR_CFG_GET_FLD(attr, name)				\
> +	_ATTR_CFG_GET_FLD(attr,					\
> +			  ATTR_CFG_FLD_##name##_CFG,		\
> +			  ATTR_CFG_FLD_##name##_LO,		\
> +			  ATTR_CFG_FLD_##name##_HI)
> +
> +GEN_PMU_FORMAT_ATTR(mask);
> +GEN_PMU_FORMAT_ATTR(match);
> +GEN_PMU_FORMAT_ATTR(invert);
> +GEN_PMU_FORMAT_ATTR(incr);
> +GEN_PMU_FORMAT_ATTR(event);

I have strong opinions about neater ways to do this, but I have 
expressed those in my own PMU driver ;)

> +static struct attribute *dmc620_pmu_formats_attrs[] = {
> +	&format_attr_mask.attr,
> +	&format_attr_match.attr,
> +	&format_attr_invert.attr,
> +	&format_attr_incr.attr,
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dmc620_pmu_format_attr_group = {
> +	.name	= "format",
> +	.attrs	= dmc620_pmu_formats_attrs,
> +};
> +
> +static const struct attribute_group *dmc620_pmu_attr_groups[] = {
> +	&dmc620_pmu_events_attr_group,
> +	&dmc620_pmu_format_attr_group,
> +	NULL,
> +};
> +
> +static inline
> +u32 dmc620_pmu_creg_read(struct dmc620_pmu *dmc620_pmu,
> +					  unsigned int idx,
> +					  unsigned int offset)

Indentation is weird here - this can easily fit in two lines (or even 
just one under the new rules)

> +{
> +	return readl(dmc620_pmu->base +
> +			DMC620_PMU_COUNTERx_OFFSET(idx) + offset);
> +}
> +
> +static inline
> +void dmc620_pmu_creg_write(struct dmc620_pmu *dmc620_pmu,
> +				  unsigned int idx,
> +				  unsigned int offset,
> +				  u32 val)

Ditto. Also most of the callsites for these two functions have really 
odd argument wrapping as well.

> +{
> +	writel(val, dmc620_pmu->base +
> +			DMC620_PMU_COUNTERx_OFFSET(idx) + offset);
> +}
> +
> +static
> +unsigned int dmc620_event_to_counter_control(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	unsigned int reg = 0;
> +
> +	reg |= ATTR_CFG_GET_FLD(attr, invert) <<
> +		DMC620_PMU_COUNTER_CONTROLx_INVERT_SHIFT;
> +	reg |= ATTR_CFG_GET_FLD(attr, incr) <<
> +		DMC620_PMU_COUNTERx_CONTROL_INCR_SHIFT;
> +	reg |= (ATTR_CFG_GET_FLD(attr, event) &
> +		~DMC620_PMU_CLK_INDICATE_MASK) <<

As before, keeping this separate from the event ID in the first place 
would avoid this kind of subtle weirdness.

> +		DMC620_PMU_COUNTER_CONTROLx_EVENT_MUX_SHIFT;
> +
> +	return reg;
> +}
> +
> +static int dmc620_get_event_idx(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +	int idx, start_idx, end_idx;
> +
> +	if (ATTR_CFG_GET_FLD(&event->attr, event) &
> +			DMC620_PMU_CLK_INDICATE_MASK) {
> +		start_idx = DMC620_PMU_CLKDIV2_MAX_COUNTERS;
> +		end_idx = DMC620_PMU_MAX_COUNTERS;
> +	} else {
> +		start_idx = 0;
> +		end_idx = DMC620_PMU_CLKDIV2_MAX_COUNTERS;
> +	}
> +
> +	for (idx = start_idx; idx < end_idx; ++idx) {
> +		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
> +			return idx;
> +	}
> +
> +	/* The counters are all in use. */
> +	return -EAGAIN;
> +}
> +
> +static u64 dmc620_pmu_read_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +
> +	return dmc620_pmu_creg_read(dmc620_pmu,
> +			  event->hw.idx,
> +			  DMC620_PMU_COUNTERx_VALUE);
> +}
> +
> +static void dmc620_pmu_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 delta, prev_count, new_count;
> +
> +	do {
> +		/* We may also be called from the irq handler */
> +		prev_count = local64_read(&hwc->prev_count);
> +		new_count = dmc620_pmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count,
> +			prev_count, new_count) != prev_count);
> +	delta = (new_count - prev_count) & DMC620_CNT_MAX_PERIOD;
> +	local64_add(delta, &event->count);
> +}
> +
> +static void dmc620_pmu_event_set_period(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +
> +	/*
> +	 * All DMC-620 PMU event counters are 32bit counters.
> +	 * To handle cases of extreme interrupt latency, we program

Once again I'll take the opportunity to get annoyed at this comment 
being blindly copied around. We're not dealing with sampling events 
here, so latency isn't really relevant - when merely counting you'll 
always have 2^32 counts to handle an overflow before you get a second 
overflow and actually lose information, regardless of where the counter 
started beforehand. There *is* still a justification for doing this 
trick, but it's simply about reads racing with overflow in general.

> +	 * the counter with half of the max count for the counters.
> +	 */
> +	u32 val = DMC620_CNT_MAX_PERIOD >> 1;
> +
> +	local64_set(&event->hw.prev_count, val);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_VALUE,
> +			  val);
> +}
> +
> +static void dmc620_pmu_enable_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +	u32 reg;
> +
> +	reg = dmc620_pmu_creg_read(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL);

Do you need the expense of an MMIO read here? You know what value you 
used in event_add(), can't you just use that again? (or even better, 
simply avoid writing to the register twice in the first place)

> +	reg |= DMC620_PMU_COUNTER_CONTROLx_ENABLE_MASK;
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL,
> +			  reg);
> +}
> +
> +static void dmc620_pmu_disable_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +	u32 reg;
> +
> +	reg = dmc620_pmu_creg_read(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL);

Ditto here - in fact if you only wrote the whole register once in 
event_start(), then I think event_stop() could simply become a case of 
unconditionally writing 0.

> +	reg &= ~DMC620_PMU_COUNTER_CONTROLx_ENABLE_MASK;
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL,
> +			  reg);
> +}
> +
> +static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
> +{
> +	struct dmc620_pmu_irq *irq = data;
> +	struct dmc620_pmu *dmc620_pmu;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(dmc620_pmu,
> +				  &irq->pmus_node, pmus_node) {
> +		unsigned long status_clkdiv2, status_clk;
> +		struct perf_event *event;
> +		unsigned int idx;
> +
> +		status_clkdiv2 = readl(dmc620_pmu->base +
> +				  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
> +		status_clk = readl(dmc620_pmu->base +
> +				  DMC620_PMU_OVERFLOW_STATUS_CLK);
> +		if (!status_clkdiv2 && !status_clk)
> +			continue;
> +
> +		for (idx = 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
> +			event = dmc620_pmu->events[idx];
> +			if (!event)
> +				continue;
> +			dmc620_pmu_disable_counter(event);

Why bother interfering with counters that haven't overflowed? If you 
can't start and stop the whole PMU atomically (there appears to be a 
control for that, but I think I can see why it might not be generally 
usable) then I'm not sure there's much point trying to fake it in a way 
that's inherently inaccurate.

> +		}
> +
> +		for_each_set_bit(idx, &status_clkdiv2,
> +				  DMC620_PMU_CLKDIV2_MAX_COUNTERS) {
> +			event = dmc620_pmu->events[idx];
> +			if (WARN_ON_ONCE(!event))
> +				continue;
> +			dmc620_pmu_event_update(event);
> +			dmc620_pmu_event_set_period(event);
> +		}
> +
> +		for_each_set_bit(idx, &status_clk,
> +				  DMC620_PMU_CLK_MAX_COUNTERS) {
> +			event = dmc620_pmu->events[idx +
> +				DMC620_PMU_CLKDIV2_MAX_COUNTERS];
> +			if (WARN_ON_ONCE(!event))
> +				continue;
> +			dmc620_pmu_event_update(event);
> +			dmc620_pmu_event_set_period(event);
> +		}

Why have two separate effectively-identical loops? Just do something 
like "status = status_clkdiv2 | status_clk << 8;" right at the top then 
handle things uniformly as you do everywhere else.

> +
> +		if (status_clkdiv2)
> +			writel(0, dmc620_pmu->base +
> +				DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
> +		if (status_clk)
> +			writel(0, dmc620_pmu->base +
> +				DMC620_PMU_OVERFLOW_STATUS_CLK);
> +
> +		for (idx = 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
> +			event = dmc620_pmu->events[idx];
> +			if (!event)
> +				continue;
> +			if (!(event->hw.state & PERF_HES_STOPPED))
> +				dmc620_pmu_enable_counter(event);
> +		}
> +		ret = IRQ_HANDLED;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
> +{
> +	struct dmc620_pmu_irq *irq;
> +	int ret;
> +
> +	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
> +		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
> +			return irq;
> +
> +	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
> +	if (!irq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&irq->pmus_node);
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	irq->cpu = raw_smp_processor_id();
> +	refcount_set(&irq->refcount, 1);
> +
> +	ret = request_irq(irq_num, dmc620_pmu_handle_irq,
> +			  IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			  "dmc620-pmu", irq);
> +	if (ret)
> +		goto out_free_aff;
> +
> +	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
> +	if (ret)
> +		goto out_free_irq;
> +
> +	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
> +	if (ret)
> +		goto out_free_irq;
> +
> +	irq->irq_num = irq_num;
> +	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
> +
> +	return irq;
> +
> +out_free_irq:
> +	free_irq(irq_num, irq);
> +out_free_aff:
> +	kfree(irq);
> +	return ERR_PTR(ret);
> +}
> +
> +static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
> +{
> +	struct dmc620_pmu_irq *irq;
> +
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	irq = __dmc620_pmu_get_irq(irq_num);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	if (IS_ERR(irq))
> +		return PTR_ERR(irq);
> +
> +	dmc620_pmu->irq = irq;
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	return 0;
> +}
> +
> +static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
> +{
> +	struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
> +
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	list_del_rcu(&dmc620_pmu->pmus_node);
> +
> +	if (!refcount_dec_and_test(&irq->refcount)) {
> +		mutex_unlock(&dmc620_pmu_irqs_lock);
> +		return;
> +	}
> +
> +	list_del(&irq->irqs_node);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	free_irq(irq->irq_num, irq);
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
> +	kfree(irq);
> +}
> +
> +static int dmc620_pmu_event_init(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event *sibling;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * DMC 620 PMUs are shared across all cpus and cannot
> +	 * support task bound and sampling events.
> +	 */
> +	if (is_sampling_event(event) ||
> +		event->attach_state & PERF_ATTACH_TASK) {
> +		dev_dbg(dmc620_pmu->pmu.dev,
> +			"Can't support per-task counters\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_dbg(dmc620_pmu->pmu.dev,
> +			"Per-task mode not supported\n");

Isn't that saying the same thing as the message above?

> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Many perf core operations (eg. events rotation) operate on a
> +	 * single CPU context. This is obvious for CPU PMUs, where one
> +	 * expects the same sets of events being observed on all CPUs,
> +	 * but can lead to issues for off-core PMUs, where each
> +	 * event could be theoretically assigned to a different CPU. To
> +	 * mitigate this, we enforce CPU assignment to one, selected
> +	 * processor.
> +	 */
> +	event->cpu = dmc620_pmu->irq->cpu;
> +
> +	/*
> +	 * We must NOT create groups containing mixed PMUs, although software
> +	 * events are acceptable.
> +	 */
> +	if (event->group_leader->pmu != event->pmu &&
> +			!is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling->pmu != event->pmu &&
> +				!is_software_event(sibling))
> +			return -EINVAL;
> +	}

Given that you currently have no way to atomically schedule multiple 
events together on the hardware, strictly you can't even support grouped 
events from the same PMU either - software events are really the *only* 
thing you can allow to be grouped with at all.

With snapshots there should technically be a way of supporting accurate 
group measurements without any skew between counters, but I think it's 
rather fiddly to make it entirely race-free.

> +
> +	hwc->idx = -1;
> +	return 0;
> +}
> +
> +static void dmc620_pmu_read(struct perf_event *event)
> +{
> +	dmc620_pmu_event_update(event);
> +}
> +
> +static void dmc620_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +
> +	event->hw.state = 0;
> +	dmc620_pmu_event_set_period(event);
> +
> +	if (flags & PERF_EF_RELOAD) {
> +		unsigned long prev_raw_count =
> +			local64_read(&event->hw.prev_count);
> +
> +		dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_VALUE,
> +			  (unsigned int)prev_raw_count);
> +	}

That entire if statement is redundant (think about what 
dmc620_pmu_event_set_period() does...)

> +	dmc620_pmu_enable_counter(event);
> +}
> +
> +static void dmc620_pmu_stop(struct perf_event *event, int flags)
> +{
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;
> +
> +	dmc620_pmu_disable_counter(event);
> +	dmc620_pmu_event_update(event);
> +	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int dmc620_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event_attr *attr = &event->attr;
> +	unsigned long reg;

Strictly that should be u64, I think.

> +	int idx;
> +
> +	idx = dmc620_get_event_idx(event);
> +	if (idx < 0)
> +		return idx;
> +
> +	hwc->idx = idx;
> +	dmc620_pmu->events[idx] = event;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	reg = ATTR_CFG_GET_FLD(attr, mask);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_MASK_31_00,
> +			  lower_32_bits(reg));
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_MASK_63_32,
> +			  upper_32_bits(reg));
> +
> +	reg = ATTR_CFG_GET_FLD(attr, match);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_MATCH_31_00,
> +			  lower_32_bits(reg));
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_MATCH_63_32,
> +			  upper_32_bits(reg));
> +
> +	reg = dmc620_event_to_counter_control(event);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL,
> +			  (u32)reg);
> +
> +	if (flags & PERF_EF_START)
> +		dmc620_pmu_start(event, PERF_EF_RELOAD);
> +
> +	perf_event_update_userpage(event);
> +	return 0;
> +}
> +
> +static void dmc620_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	dmc620_pmu_stop(event, PERF_EF_UPDATE);
> +	dmc620_pmu->events[idx] = NULL;
> +	clear_bit(idx, dmc620_pmu->used_mask);
> +	perf_event_update_userpage(event);
> +}
> +
> +static int dmc620_pmu_cpu_teardown(unsigned int cpu,
> +				   struct hlist_node *node)
> +{
> +	struct dmc620_pmu_irq *irq;
> +	struct dmc620_pmu *dmc620_pmu;
> +	unsigned int target;
> +
> +	irq = hlist_entry_safe(node, struct dmc620_pmu_irq, node);
> +	if (cpu != irq->cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	/* We're only reading, but this isn't the place to be involving RCU */
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
> +		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
> +	irq->cpu = target;
> +
> +	return 0;
> +}
> +
> +static int dmc620_pmu_device_probe(struct platform_device *pdev)
> +{
> +	struct dmc620_pmu *dmc620_pmu;
> +	struct resource *res;
> +	char *name;
> +	int irq_num;
> +	int ret;
> +
> +	dmc620_pmu = devm_kzalloc(&pdev->dev,
> +			sizeof(struct dmc620_pmu), GFP_KERNEL);
> +	if (!dmc620_pmu)
> +		return -ENOMEM;
> +
> +	dmc620_pmu->pdev = pdev;
> +	platform_set_drvdata(pdev, dmc620_pmu);
> +
> +	dmc620_pmu->pmu = (struct pmu) {

You need to set pmu.module here too, since allowing it to be unloaded 
while the PMU is in use never ends well... ;)

> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= dmc620_pmu_event_init,
> +		.add		= dmc620_pmu_add,
> +		.del		= dmc620_pmu_del,
> +		.start		= dmc620_pmu_start,
> +		.stop		= dmc620_pmu_stop,
> +		.read		= dmc620_pmu_read,
> +		.attr_groups	= dmc620_pmu_attr_groups,
> +	};

Shouldn't you reset the hardware to a known state before doing anything 
else? Particularly if you get here after a kexec or similar, you could 
have counters running and/or the overflow interrupt already asserted 
that would fire your WARN_ON_ONCE() checks.

> +	irq_num = platform_get_irq(pdev, 0);
> +	if (irq_num < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ (%d)\n", irq_num);

platform_get_irq() already logs an error on failure.

> +		return irq_num;
> +	}
> +
> +	ret = dmc620_pmu_get_irq(dmc620_pmu, irq_num);
> +	if (ret)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dmc620_pmu->base = devm_ioremap_resource(&pdev->dev, res);

I'm sure someone will suggest using a stupid unwieldy "helper" to 
obfuscate those two nice clear lines, but personally I'm glad you haven't :)

> +	if (IS_ERR(dmc620_pmu->base)) {
> +		dev_err(&pdev->dev,
> +			"ioremap failed for DMC-620 PMU resource\n");

devm_ioremap_resource() already logs errors on failure.

> +		ret = PTR_ERR(dmc620_pmu->base);
> +		goto out_teardown_dev;
> +	}
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +				  "%s_%llx", DMC620_PMUNAME,
> +				  (res->start) >> DMC620_PA_SHIFT);
> +	if (!name) {
> +		dev_err(&pdev->dev,
> +			  "Create name failed, PMU @%pa\n", &res->start);
> +		goto out_teardown_dev;
> +	}
> +
> +	ret = perf_pmu_register(&dmc620_pmu->pmu, name, -1);
> +	if (ret)
> +		goto out_teardown_dev;
> +
> +	return 0;
> +
> +out_teardown_dev:
> +	dmc620_pmu_put_irq(dmc620_pmu);
> +	synchronize_rcu();
> +	return ret;
> +}
> +
> +static int dmc620_pmu_device_remove(struct platform_device *pdev)
> +{
> +	struct dmc620_pmu *dmc620_pmu = platform_get_drvdata(pdev);
> +
> +	dmc620_pmu_put_irq(dmc620_pmu);
> +
> +	/* perf will synchronise RCU before devres can free dmc620_pmu */
> +	perf_pmu_unregister(&dmc620_pmu->pmu);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id dmc620_acpi_match[] = {
> +	{ "ARMHD620", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, dmc620_acpi_match);
> +static struct platform_driver dmc620_pmu_driver = {
> +	.driver	= {
> +		.name		= DMC620_DRVNAME,
> +		.acpi_match_table = ACPI_PTR(dmc620_acpi_match),

If you use ACPI_PTR() then you should really annotate the match table 
with __maybe_unused as well, but at the moment there's little point 
using it at all since you have a build dependency on ACPI anyway.

Robin.

> +	},
> +	.probe	= dmc620_pmu_device_probe,
> +	.remove	= dmc620_pmu_device_remove,
> +};
> +
> +static int __init dmc620_pmu_init(void)
> +{
> +	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      DMC620_DRVNAME,
> +				      NULL,
> +				      dmc620_pmu_cpu_teardown);
> +	if (cpuhp_state_num < 0)
> +		return cpuhp_state_num;
> +
> +	return platform_driver_register(&dmc620_pmu_driver);
> +}
> +
> +static void __exit dmc620_pmu_exit(void)
> +{
> +	platform_driver_unregister(&dmc620_pmu_driver);
> +	cpuhp_remove_multi_state(cpuhp_state_num);
> +}
> +
> +module_init(dmc620_pmu_init);
> +module_exit(dmc620_pmu_exit);
> +
> +MODULE_DESCRIPTION("Perf driver for the ARM DMC-620 memory controller");
> +MODULE_AUTHOR("Tuan Phan <tuanphan@os.amperecomputing.com");
> +MODULE_LICENSE("GPL v2");
> 
