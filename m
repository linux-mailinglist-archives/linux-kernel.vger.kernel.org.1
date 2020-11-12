Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3699C2B107F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKLVeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:34:22 -0500
Received: from mail-mw2nam12on2134.outbound.protection.outlook.com ([40.107.244.134]:1248
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbgKLVeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfMRN82p6tBXYXWA/6xnxv1IFjBa3Km6VM2vW8e6TsXC3a4W2akjqDehBm97c/GV2FJeg3KC1nXtPM9J/ETD33VOcOcDP9caQgyAtS6vNg13ZlcNl4RcHqcmpYzet3KaEaZY3AEPvKqdi87Gmpm8hQbLNQBe0j6oL4qOHfi12Eidz8G1Mv39ZCCSOSY7A6p86XTKkEGlxuu4uAFhNxLjdOCkJoX0rBTwVuhu6+S9Rw9z5Gk12QOrAwcsq+GfPd6fUH+ce/vbenthrvG2tOTOvAC2pHeMO/87pnh8iF843wAfivcMxo+4tgUAIeq4iK3Zvv/IheRbTo9QQkhXQuUFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB6KBcpepA/2E6zeLYc7xU38Ta3GP0frjoz4Gtkotyk=;
 b=JCSaSMMsP4UR3UQO27+RtXh7s63L6ODDs1lFPkhfRiKlEiQruyd0qEsHRxAFPPUzzF7miJi5Jlh2rTF+CrsvW+LuYmbqi2JlB2AScZgEtoxt6ybAN142PtrXpnoIebULrQT8kOj/mllpBHqjcrwW06H3S37WT7KgkRKBqnQzf4q6bN1ltWnYix4nbh96ya9iA2hxQNI2QFwJhix/j5ABDYcXNxliqBpkSSat3WOcFo+ma7yc+Ov3DgRa2hjrOrfsZaxsL0aYcyVtfKz6s5/wKFRPGa4zrFsyD9GowBokdMsekP+LdQZ1QWtQ704vKUthc53DSnZBD+jni9iBDiMWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB6KBcpepA/2E6zeLYc7xU38Ta3GP0frjoz4Gtkotyk=;
 b=Q3eWtnFqN6lVXlixNGM2MphfOBx26gr3RgPbl6s1Xv3lvg2xiL/AgIzRgiYtAdxlBQVOqG9u3ajZ1WJj7xjEsaUjzci1qGSUNXw0Qe//IRDNire6hpuDZpVejUKkldZ1Bl1ZYLICWK0HbecDIXoqCGYArCpcBPwTIaX/eJvTGPg=
Authentication-Results: os.amperecomputing.com; dkim=none (message not signed)
 header.d=none;os.amperecomputing.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 SJ0PR01MB6126.prod.exchangelabs.com (2603:10b6:a03:29b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Thu, 12 Nov 2020 21:34:03 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::e015:fa9f:e0a4:3813]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::e015:fa9f:e0a4:3813%3]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 21:34:03 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v6] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <1604518246-6198-1-git-send-email-tuanphan@os.amperecomputing.com>
Date:   Thu, 12 Nov 2020 13:33:59 -0800
Cc:     patches@amperecomputing.com, robin.murphy@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C36D5B5B-6710-4740-B5D1-250B2915FFC2@amperemail.onmicrosoft.com>
References: <1604518246-6198-1-git-send-email-tuanphan@os.amperecomputing.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
X-Originating-IP: [73.151.56.145]
X-ClientProxiedBy: CY4PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:903:77::16) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.148] (73.151.56.145) by CY4PR06CA0030.namprd06.prod.outlook.com (2603:10b6:903:77::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 21:34:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0010ba59-f59e-45dd-e321-08d88752aca6
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR01MB6126BA85B452F84F488F75F8E0E70@SJ0PR01MB6126.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/BQ0ZM0Z8Op59xrwcBe2GzCKtDWDu/jMc/xXtPbOsZbpraYztCLjWtvRb4y9mEi037d1Ck4hjqg/vxWjXw/Rqkra2Hkq75tEIieFtu5As5g0Kp16a5h8OaZf/ZozysKifMdRZoSOhOMpFPU6yAh9kEvy89h8EGPBb5dXgleZn13r2d+lcbzDC3bxtI3V7KiksM9SLChwxQx22o7Qj0IY7/bxtaDZhW2EbLapLWbBL4trp2hbSNxR+q7NJ7b8Cj7ki1vNFQfV/HpV//T/mwMzJlQNwaLILQcpiFEgHo3ovxeu2x8v6goIAYsm5BlyhGJ1jpH01XMlZThVeitbDg+eV0uIHWJxleBeQBUg8Cl0L44UI5cmlwjKyDcXNfqz5Cfg3/8StvG0GYBmNDHMGCWMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(2906002)(16526019)(2616005)(8676002)(8936002)(52116002)(26005)(33656002)(956004)(83380400001)(478600001)(5660300002)(966005)(186003)(6862004)(54906003)(30864003)(4326008)(316002)(16576012)(66946007)(6486002)(66556008)(42882007)(53546011)(83170400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: czUzW1VZTZ3QWKvQqmcqSx43bQjFXAKOzH7XLfQHQsal2HYt+ndnwg61hseQ8/VSTYvEGpQbEaAZJDWupOLFRwrPqyls+DiOqhVLIGOb+Zo6j0leetMult3ZLfqq6xj0p6O41xQhM+8AVFT8idbH3jdxUoo1RIH/2Ca1kODfi7apqNcZCLLlhWf3WstAzZKSMvxDu4Qg+1J8h4beL9/HWKXO2N/zQLMnh1RjnD4e4o1JIgiyZjSXthzuS9uKTcOlEMRM16+xqV5csedIaqzzQjMFdPG5JOiu0/8dFtMz0nlf7VRAre4xF+cvjcdw9qnO8Bnn/bI7YWply7FAtAPK3lvn1y8De3sjZPy+4XVFHa31m1Kn5NXU9fldVo0wNjmrKUwPjdJscHPe+Bip36DWtKRRr/CcyKMyAJgu0LOaVjtxIgG+XzgnDdslCVbO9v017LRZOwGtjjfLGpsE4aApbywReCFAZ56ETA81WHSxyZRYkjiPM1IzQwmHV8lg6IGVS4Smqq02p2Z56FY7SSMrP2XYUYMW011N9phauvcI44B9Z04Yll5wsyurm2Y0RvZNCRtsrQ7m6HnkD8gtOs7cSH2Xy1Qz5QFH5QetLwj/KMJlYqGGIBmjYn9JxDNhUvRY4IbtaZyZB/toUFhvQkEnAQ==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010ba59-f59e-45dd-e321-08d88752aca6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 21:34:02.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n19PUSpJvBFwK3U4EQq055QGqr+Kh8x3DjHz6bSJgpmz5R3qP+IGcvMqVaHgxjFmTzlk8fOOy0DlmJRMdgR4m5NbAwTV8sW51CagKnl4/9UkvjxMKMeievOlvFD70TH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark/Will,
Do you have any further  concerns of this patch? If not, can we merge it?

Thanks,

> On Nov 4, 2020, at 11:30 AM, Tuan Phan <tuanphan@os.amperecomputing.com> =
wrote:
>=20
> DMC-620 PMU supports total 10 counters which each is
> independently programmable to different events and can
> be started and stopped individually.
>=20
> Currently, it only supports ACPI. Other platforms feel free to test and a=
dd
> support for device tree.
>=20
> Usage example:
>  #perf stat -e arm_dmc620_10008c000/clk_cycle_count/ -C 0
>  Get perf event for clk_cycle_count counter.
>=20
>  #perf stat -e arm_dmc620_10008c000/clkdiv2_allocate,mask=3D0x1f,match=3D=
0x2f,
>  incr=3D2,invert=3D1/ -C 0
>  The above example shows how to specify mask, match, incr,
>  invert parameters for clkdiv2_allocate event.
>=20
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> Changes in v6:
> - Fixed compiling error with COMPILE_TEST for s390.
> - Removed 64BIT from COMPILE_TEST.
>=20
> Changes in v5:
> - Fixed warning issue with robot test.
> - Allow only 1 event at a same time due to HW limitation.
>=20
> Changes in v4:
> - Addressed Robin's comments.
>=20
> Changes in v3:
> - Removed "_OFFSET" suffix.
> - Renamed "affinity" to "irq".
> - Have a better definition of group register.
>=20
> Changes in v2:
> - Removed IRQF_SHARED flag and added support for multiple=20
> PMUs sharing the same interrupt.
> - Fixed an interrupt handler race condition.
>=20
> The ACPI binding spec for PMU DMC620 can be downloaded at:
> https://developer.arm.com/documentation/den0093/c/
>=20
> drivers/perf/Kconfig          |   7 +
> drivers/perf/Makefile         |   1 +
> drivers/perf/arm_dmc620_pmu.c | 748 +++++++++++++++++++++++++++++++++++++=
+++++
> 3 files changed, 756 insertions(+)
> create mode 100644 drivers/perf/arm_dmc620_pmu.c
>=20
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 130327ff..3075cf1 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -130,6 +130,13 @@ config ARM_SPE_PMU
> 	  Extension, which provides periodic sampling of operations in
> 	  the CPU pipeline and reports this via the perf AUX interface.
>=20
> +config ARM_DMC620_PMU
> +	tristate "Enable PMU support for the ARM DMC-620 memory controller"
> +	depends on (ARM64 && ACPI) || COMPILE_TEST
> +	help
> +	  Support for PMU events monitoring on the ARM DMC-620 memory
> +	  controller.
> +
> source "drivers/perf/hisilicon/Kconfig"
>=20
> endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 5365fd5..5260b11 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
> +obj-$(CONFIG_ARM_DMC620_PMU) +=3D arm_dmc620_pmu.o
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.=
c
> new file mode 100644
> index 0000000..004930e
> --- /dev/null
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -0,0 +1,748 @@
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
> +#include <linux/bitfield.h>
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
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/rculist.h>
> +#include <linux/refcount.h>
> +
> +#define DMC620_PA_SHIFT					12
> +#define DMC620_CNT_INIT					0x80000000
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
> + * DMC620_PMU_COUNTERn offsets are within a counter group.
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
> +#define DMC620_PMU_COUNTERn_MASK_31_00			0x0
> +#define DMC620_PMU_COUNTERn_MASK_63_32			0x4
> +#define DMC620_PMU_COUNTERn_MATCH_31_00			0x8
> +#define DMC620_PMU_COUNTERn_MATCH_63_32			0xC
> +#define DMC620_PMU_COUNTERn_CONTROL			0x10
> +#define  DMC620_PMU_COUNTERn_CONTROL_ENABLE		BIT(0)
> +#define  DMC620_PMU_COUNTERn_CONTROL_INVERT		BIT(1)
> +#define  DMC620_PMU_COUNTERn_CONTROL_EVENT_MUX		GENMASK(6, 2)
> +#define  DMC620_PMU_COUNTERn_CONTROL_INCR_MUX		GENMASK(8, 7)
> +#define DMC620_PMU_COUNTERn_VALUE			0x20
> +/* Offset of the registers for a given counter, relative to 0xA00 */
> +#define DMC620_PMU_COUNTERn_OFFSET(n) \
> +	(DMC620_PMU_COUNTERS_BASE + 0x28 * (n))
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
> +struct dmc620_pmu_event_attr {
> +	struct device_attribute attr;
> +	u8 clkdiv2;
> +	u8 eventid;
> +};
> +
> +static ssize_t
> +dmc620_pmu_event_show(struct device *dev,
> +			   struct device_attribute *attr, char *page)
> +{
> +	struct dmc620_pmu_event_attr *eattr;
> +
> +	eattr =3D container_of(attr, typeof(*eattr), attr);
> +
> +	return sprintf(page, "event=3D0x%x,clkdiv2=3D0x%x\n", eattr->eventid, e=
attr->clkdiv2);
> +}
> +
> +#define DMC620_PMU_EVENT_ATTR(_name, _eventid, _clkdiv2)		\
> +	(&((struct dmc620_pmu_event_attr[]) {{				\
> +		.attr =3D __ATTR(_name, 0444, dmc620_pmu_event_show, NULL),	\
> +		.clkdiv2 =3D _clkdiv2,						\
> +		.eventid =3D _eventid,					\
> +	}})[0].attr.attr)
> +
> +static struct attribute *dmc620_pmu_events_attrs[] =3D {
> +	/* clkdiv2 events list */
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_cycle_count, 0x0, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_allocate, 0x1, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_queue_depth, 0x2, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_wr_data, 0x3, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_read_backlog, 0x4, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_mi, 0x5, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_hazard_resolution, 0x6, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_enqueue, 0x7, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_arbitrate, 0x8, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_lrank_turnaround_activate, 0x9, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_prank_turnaround_activate, 0xa, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_read_depth, 0xb, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_write_depth, 0xc, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_highigh_qos_depth, 0xd, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_high_qos_depth, 0xe, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_medium_qos_depth, 0xf, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_low_qos_depth, 0x10, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_activate, 0x11, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_rdwr, 0x12, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_refresh, 0x13, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_training_request, 0x14, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_t_mac_tracker, 0x15, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_bk_fsm_tracker, 0x16, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_bk_open_tracker, 0x17, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_pwr_down, 0x18, 1),
> +	DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_sref, 0x19, 1),
> +
> +	/* clk events list */
> +	DMC620_PMU_EVENT_ATTR(clk_cycle_count, 0x0, 0),
> +	DMC620_PMU_EVENT_ATTR(clk_request, 0x1, 0),
> +	DMC620_PMU_EVENT_ATTR(clk_upload_stall, 0x2, 0),
> +	NULL,
> +};
> +
> +static struct attribute_group dmc620_pmu_events_attr_group =3D {
> +	.name =3D "events",
> +	.attrs =3D dmc620_pmu_events_attrs,
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
> +#define ATTR_CFG_FLD_clkdiv2_CFG	config2
> +#define ATTR_CFG_FLD_clkdiv2_LO		9
> +#define ATTR_CFG_FLD_clkdiv2_HI		9
> +
> +#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
> +	(lo) =3D=3D (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
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
> +	((((attr)->cfg) >> lo) & GENMASK_ULL(hi - lo, 0))
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
> +GEN_PMU_FORMAT_ATTR(clkdiv2);
> +
> +static struct attribute *dmc620_pmu_formats_attrs[] =3D {
> +	&format_attr_mask.attr,
> +	&format_attr_match.attr,
> +	&format_attr_invert.attr,
> +	&format_attr_incr.attr,
> +	&format_attr_event.attr,
> +	&format_attr_clkdiv2.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dmc620_pmu_format_attr_group =3D {
> +	.name	=3D "format",
> +	.attrs	=3D dmc620_pmu_formats_attrs,
> +};
> +
> +static const struct attribute_group *dmc620_pmu_attr_groups[] =3D {
> +	&dmc620_pmu_events_attr_group,
> +	&dmc620_pmu_format_attr_group,
> +	NULL,
> +};
> +
> +static inline
> +u32 dmc620_pmu_creg_read(struct dmc620_pmu *dmc620_pmu,
> +			unsigned int idx, unsigned int reg)
> +{
> +	return readl(dmc620_pmu->base + DMC620_PMU_COUNTERn_OFFSET(idx) + reg);
> +}
> +
> +static inline
> +void dmc620_pmu_creg_write(struct dmc620_pmu *dmc620_pmu,
> +			unsigned int idx, unsigned int reg, u32 val)
> +{
> +	writel(val, dmc620_pmu->base + DMC620_PMU_COUNTERn_OFFSET(idx) + reg);
> +}
> +
> +static
> +unsigned int dmc620_event_to_counter_control(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr =3D &event->attr;
> +	unsigned int reg =3D 0;
> +
> +	reg |=3D FIELD_PREP(DMC620_PMU_COUNTERn_CONTROL_INVERT,
> +			ATTR_CFG_GET_FLD(attr, invert));
> +	reg |=3D FIELD_PREP(DMC620_PMU_COUNTERn_CONTROL_EVENT_MUX,
> +			ATTR_CFG_GET_FLD(attr, event));
> +	reg |=3D FIELD_PREP(DMC620_PMU_COUNTERn_CONTROL_INCR_MUX,
> +			ATTR_CFG_GET_FLD(attr, incr));
> +
> +	return reg;
> +}
> +
> +static int dmc620_get_event_idx(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +	int idx, start_idx, end_idx;
> +
> +	if (ATTR_CFG_GET_FLD(&event->attr, clkdiv2)) {
> +		start_idx =3D 0;
> +		end_idx =3D DMC620_PMU_CLKDIV2_MAX_COUNTERS;
> +	} else {
> +		start_idx =3D DMC620_PMU_CLKDIV2_MAX_COUNTERS;
> +		end_idx =3D DMC620_PMU_MAX_COUNTERS;
> +	}
> +
> +	for (idx =3D start_idx; idx < end_idx; ++idx) {
> +		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
> +			return idx;
> +	}
> +
> +	/* The counters are all in use. */
> +	return -EAGAIN;
> +}
> +
> +static inline
> +u64 dmc620_pmu_read_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +
> +	return dmc620_pmu_creg_read(dmc620_pmu,
> +				    event->hw.idx, DMC620_PMU_COUNTERn_VALUE);
> +}
> +
> +static void dmc620_pmu_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 delta, prev_count, new_count;
> +
> +	do {
> +		/* We may also be called from the irq handler */
> +		prev_count =3D local64_read(&hwc->prev_count);
> +		new_count =3D dmc620_pmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count,
> +			prev_count, new_count) !=3D prev_count);
> +	delta =3D (new_count - prev_count) & DMC620_CNT_MAX_PERIOD;
> +	local64_add(delta, &event->count);
> +}
> +
> +static void dmc620_pmu_event_set_period(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +
> +	local64_set(&event->hw.prev_count, DMC620_CNT_INIT);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      event->hw.idx, DMC620_PMU_COUNTERn_VALUE, DMC620_CNT_INIT);
> +}
> +
> +static void dmc620_pmu_enable_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +	u32 reg;
> +
> +	reg =3D dmc620_event_to_counter_control(event) | DMC620_PMU_COUNTERn_CO=
NTROL_ENABLE;
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      event->hw.idx, DMC620_PMU_COUNTERn_CONTROL, reg);
> +}
> +
> +static void dmc620_pmu_disable_counter(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      event->hw.idx, DMC620_PMU_COUNTERn_CONTROL, 0);
> +}
> +
> +static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
> +{
> +	struct dmc620_pmu_irq *irq =3D data;
> +	struct dmc620_pmu *dmc620_pmu;
> +	irqreturn_t ret =3D IRQ_NONE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(dmc620_pmu, &irq->pmus_node, pmus_node) {
> +		unsigned long status;
> +		struct perf_event *event;
> +		unsigned int idx;
> +
> +		/*
> +		 * HW doesn't provide a control to atomically disable all counters.
> +		 * To prevent race condition (overflow happens while clearing status r=
egister),
> +		 * disable all events before continuing
> +		 */
> +		for (idx =3D 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
> +			event =3D dmc620_pmu->events[idx];
> +			if (!event)
> +				continue;
> +			dmc620_pmu_disable_counter(event);
> +		}
> +
> +		status =3D readl(dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLKDIV2=
);
> +		status |=3D (readl(dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLK) =
<<
> +				DMC620_PMU_CLKDIV2_MAX_COUNTERS);
> +		if (status) {
> +			for_each_set_bit(idx, &status,
> +					DMC620_PMU_MAX_COUNTERS) {
> +				event =3D dmc620_pmu->events[idx];
> +				if (WARN_ON_ONCE(!event))
> +					continue;
> +				dmc620_pmu_event_update(event);
> +				dmc620_pmu_event_set_period(event);
> +			}
> +
> +			if (status & DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK)
> +				writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
> +
> +			if ((status >> DMC620_PMU_CLKDIV2_MAX_COUNTERS) &
> +				DMC620_PMU_OVERFLOW_STATUS_CLK_MASK)
> +				writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLK);
> +		}
> +
> +		for (idx =3D 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
> +			event =3D dmc620_pmu->events[idx];
> +			if (!event)
> +				continue;
> +			if (!(event->hw.state & PERF_HES_STOPPED))
> +				dmc620_pmu_enable_counter(event);
> +		}
> +
> +		ret =3D IRQ_HANDLED;
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
> +		if (irq->irq_num =3D=3D irq_num && refcount_inc_not_zero(&irq->refcoun=
t))
> +			return irq;
> +
> +	irq =3D kzalloc(sizeof(*irq), GFP_KERNEL);
> +	if (!irq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&irq->pmus_node);
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	irq->cpu =3D raw_smp_processor_id();
> +	refcount_set(&irq->refcount, 1);
> +
> +	ret =3D request_irq(irq_num, dmc620_pmu_handle_irq,
> +			  IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			  "dmc620-pmu", irq);
> +	if (ret)
> +		goto out_free_aff;
> +
> +	ret =3D irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
> +	if (ret)
> +		goto out_free_irq;
> +
> +	ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
> +	if (ret)
> +		goto out_free_irq;
> +
> +	irq->irq_num =3D irq_num;
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
> +static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num=
)
> +{
> +	struct dmc620_pmu_irq *irq;
> +
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	irq =3D __dmc620_pmu_get_irq(irq_num);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	if (IS_ERR(irq))
> +		return PTR_ERR(irq);
> +
> +	dmc620_pmu->irq =3D irq;
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	return 0;
> +}
> +
> +static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
> +{
> +	struct dmc620_pmu_irq *irq =3D dmc620_pmu->irq;
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
> +	WARN_ON(irq_set_affinity_hint(irq->irq_num, NULL));
> +	free_irq(irq->irq_num, irq);
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
> +	kfree(irq);
> +}
> +
> +static int dmc620_pmu_event_init(struct perf_event *event)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	struct perf_event *sibling;
> +
> +	if (event->attr.type !=3D event->pmu->type)
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
> +	/*
> +	 * Many perf core operations (eg. events rotation) operate on a
> +	 * single CPU context. This is obvious for CPU PMUs, where one
> +	 * expects the same sets of events being observed on all CPUs,
> +	 * but can lead to issues for off-core PMUs, where each
> +	 * event could be theoretically assigned to a different CPU. To
> +	 * mitigate this, we enforce CPU assignment to one, selected
> +	 * processor.
> +	 */
> +	event->cpu =3D dmc620_pmu->irq->cpu;
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * We can't atomically disable all HW counters so only one event allowe=
d,
> +	 * although software events are acceptable.
> +	 */
> +	if (event->group_leader !=3D event &&
> +			!is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling !=3D event &&
> +				!is_software_event(sibling))
> +			return -EINVAL;
> +	}
> +
> +	hwc->idx =3D -1;
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
> +	event->hw.state =3D 0;
> +	dmc620_pmu_event_set_period(event);
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
> +	event->hw.state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int dmc620_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +	struct perf_event_attr *attr =3D &event->attr;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx;
> +	u64 reg;
> +
> +	idx =3D dmc620_get_event_idx(event);
> +	if (idx < 0)
> +		return idx;
> +
> +	hwc->idx =3D idx;
> +	dmc620_pmu->events[idx] =3D event;
> +	hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	reg =3D ATTR_CFG_GET_FLD(attr, mask);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      idx, DMC620_PMU_COUNTERn_MASK_31_00, lower_32_bits(reg));
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      idx, DMC620_PMU_COUNTERn_MASK_63_32, upper_32_bits(reg));
> +
> +	reg =3D ATTR_CFG_GET_FLD(attr, match);
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      idx, DMC620_PMU_COUNTERn_MATCH_31_00, lower_32_bits(reg));
> +	dmc620_pmu_creg_write(dmc620_pmu,
> +			      idx, DMC620_PMU_COUNTERn_MATCH_63_32, upper_32_bits(reg));
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
> +	struct dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx =3D hwc->idx;
> +
> +	dmc620_pmu_stop(event, PERF_EF_UPDATE);
> +	dmc620_pmu->events[idx] =3D NULL;
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
> +	irq =3D hlist_entry_safe(node, struct dmc620_pmu_irq, node);
> +	if (cpu !=3D irq->cpu)
> +		return 0;
> +
> +	target =3D cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >=3D nr_cpu_ids)
> +		return 0;
> +
> +	/* We're only reading, but this isn't the place to be involving RCU */
> +	mutex_lock(&dmc620_pmu_irqs_lock);
> +	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
> +		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +
> +	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
> +	irq->cpu =3D target;
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
> +	int i, ret;
> +
> +	dmc620_pmu =3D devm_kzalloc(&pdev->dev,
> +			sizeof(struct dmc620_pmu), GFP_KERNEL);
> +	if (!dmc620_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, dmc620_pmu);
> +
> +	dmc620_pmu->pmu =3D (struct pmu) {
> +		.module =3D THIS_MODULE,
> +		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr	=3D perf_invalid_context,
> +		.event_init	=3D dmc620_pmu_event_init,
> +		.add		=3D dmc620_pmu_add,
> +		.del		=3D dmc620_pmu_del,
> +		.start		=3D dmc620_pmu_start,
> +		.stop		=3D dmc620_pmu_stop,
> +		.read		=3D dmc620_pmu_read,
> +		.attr_groups	=3D dmc620_pmu_attr_groups,
> +	};
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dmc620_pmu->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dmc620_pmu->base))
> +		return PTR_ERR(dmc620_pmu->base);
> +
> +	/* Make sure device is reset before enabling interrupt */
> +	for (i =3D 0; i < DMC620_PMU_MAX_COUNTERS; i++)
> +		dmc620_pmu_creg_write(dmc620_pmu, i, DMC620_PMU_COUNTERn_CONTROL, 0);
> +	writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
> +	writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLK);
> +
> +	irq_num =3D platform_get_irq(pdev, 0);
> +	if (irq_num < 0)
> +		return irq_num;
> +
> +	ret =3D dmc620_pmu_get_irq(dmc620_pmu, irq_num);
> +	if (ret)
> +		return ret;
> +
> +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +				  "%s_%llx", DMC620_PMUNAME,
> +				  (u64)(res->start >> DMC620_PA_SHIFT));
> +	if (!name) {
> +		dev_err(&pdev->dev,
> +			  "Create name failed, PMU @%pa\n", &res->start);
> +		goto out_teardown_dev;
> +	}
> +
> +	ret =3D perf_pmu_register(&dmc620_pmu->pmu, name, -1);
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
> +	struct dmc620_pmu *dmc620_pmu =3D platform_get_drvdata(pdev);
> +
> +	dmc620_pmu_put_irq(dmc620_pmu);
> +
> +	/* perf will synchronise RCU before devres can free dmc620_pmu */
> +	perf_pmu_unregister(&dmc620_pmu->pmu);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id dmc620_acpi_match[] =3D {
> +	{ "ARMHD620", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, dmc620_acpi_match);
> +static struct platform_driver dmc620_pmu_driver =3D {
> +	.driver	=3D {
> +		.name		=3D DMC620_DRVNAME,
> +		.acpi_match_table =3D dmc620_acpi_match,
> +	},
> +	.probe	=3D dmc620_pmu_device_probe,
> +	.remove	=3D dmc620_pmu_device_remove,
> +};
> +
> +static int __init dmc620_pmu_init(void)
> +{
> +	cpuhp_state_num =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
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
> --=20
> 2.7.4
>=20

