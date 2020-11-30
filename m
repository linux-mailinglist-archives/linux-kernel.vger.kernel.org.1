Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625912C838B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgK3Lvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:51:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8474 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgK3Lvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:51:39 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cl3T85PZXzhknh;
        Mon, 30 Nov 2020 19:50:36 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 19:50:47 +0800
Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>, <linuxarm@huawei.com>, <eric.auger@redhat.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f6e8ee71-f76b-428c-cd56-5bc93b1afafe@huawei.com>
Date:   Mon, 30 Nov 2020 19:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 2020/11/30 18:26, Shameer Kolothum wrote:
> At present, the support for GICv2 backward compatibility on GICv3/v4
> hardware is determined based on whether DT/ACPI provides a memory
> mapped phys base address for GIC virtual CPU interface register(GICV).
> This creates a problem that a Qemu guest boot with default GIC(GICv2)
> hangs when firmware falsely reports this address on systems that don't
> have support for legacy mode.

So the problem is that BIOS has provided us a bogus GICC Structure.

> As per GICv3/v4 spec, in an implementation that does not support legacy
> operation, affinity routing and system register access are permanently
> enabled. This means that the associated control bits are RAO/WI. Hence
> use the ICC_SRE_EL1.SRE bit to decide whether hardware supports GICv2
> mode in addition to the above firmware based check.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> On Hisilicon D06, UEFI sets the GIC MADT GICC gicv_base_address but the
> GIC implementation on these boards doesn't have the GICv2 legacy support.
> This results in, Guest boot hang when Qemu uses the default GIC option.
> 
> With this patch, the Qemu Guest with GICv2 now gracefully exits,
>   "qemu-system-aarch64: host does not support in-kernel GICv2 emulation"
> 
> Not very sure there is a better way to detect this other than checking
> the SRE bit as done in this patch(Of course, we will be fixing the UEFI
> going forward).

Yes, I had seen the same problem on the D06. But I *do* think it's the
firmware that actually needs to be fixed.

> Thanks,
> Shameer
> 
> ---
>   drivers/irqchip/irq-gic-v3.c | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 16fecc0febe8..15fa1eea45e4 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1835,6 +1835,27 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
>   	of_node_put(parts_node);
>   }
>   
> +/* SRE bit being RAO/WI implies no GICv2 legacy mode support */

I'm wondering if this is a mandate of the architecture.

> +static bool __init gic_gicv2_compatible(void)
> +{
> +	u32 org, val;
> +
> +	org = gic_read_sre();
> +	if (!(org & ICC_SRE_EL1_SRE))
> +		return true;
> +
> +	val = org & ~ICC_SRE_EL1_SRE;
> +	gic_write_sre(val);
> +
> +	val = gic_read_sre();
> +	gic_write_sre(org);
> +
> +	if (val & ICC_SRE_EL1_SRE)
> +		return false;
> +
> +	return true;
> +}
> +
>   static void __init gic_of_setup_kvm_info(struct device_node *node)
>   {
>   	int ret;
> @@ -1851,10 +1872,12 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>   				 &gicv_idx))
>   		gicv_idx = 1;
>   
> -	gicv_idx += 3;	/* Also skip GICD, GICC, GICH */
> -	ret = of_address_to_resource(node, gicv_idx, &r);
> -	if (!ret)
> -		gic_v3_kvm_info.vcpu = r;
> +	if (gic_gicv2_compatible()) {
> +		gicv_idx += 3;	/* Also skip GICD, GICC, GICH */
> +		ret = of_address_to_resource(node, gicv_idx, &r);
> +		if (!ret)
> +			gic_v3_kvm_info.vcpu = r;
> +	}
>   
>   	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>   	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
> @@ -2164,7 +2187,7 @@ static void __init gic_acpi_setup_kvm_info(void)
>   
>   	gic_v3_kvm_info.maint_irq = irq;
>   
> -	if (acpi_data.vcpu_base) {
> +	if (gic_gicv2_compatible() && acpi_data.vcpu_base) {
>   		struct resource *vcpu = &gic_v3_kvm_info.vcpu;
>   
>   		vcpu->flags = IORESOURCE_MEM;

Thanks,
Zenghui
