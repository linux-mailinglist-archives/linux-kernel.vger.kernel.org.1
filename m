Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE12C841F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgK3M2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgK3M2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:28:44 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7DD206D8;
        Mon, 30 Nov 2020 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606739283;
        bh=Y5BosvE/KDFgBM53wfMpjt70Flneb068MrFi0W6DPow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZxqS7iQDuVxoNaCdYiEp+wwnnWR2iYokX+r+EMIN9Uyn3yapeN0vGALd7sbLEir9e
         63vs3ZlpLhhOuPPsJc9GH3JF/o2f8JV22Zgk6e2JQXKf/Z1TX6biBrGKQFXl2A/kL2
         wI76HfWP4QbGAGfDxnFF+nbIUObesu87O5ghpXWg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjiHg-00EgcD-Np; Mon, 30 Nov 2020 12:28:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Nov 2020 12:28:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com, linuxarm@huawei.com
Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
In-Reply-To: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com, linuxarm@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 2020-11-30 10:26, Shameer Kolothum wrote:
> At present, the support for GICv2 backward compatibility on GICv3/v4
> hardware is determined based on whether DT/ACPI provides a memory
> mapped phys base address for GIC virtual CPU interface register(GICV).
> This creates a problem that a Qemu guest boot with default GIC(GICv2)

That'd be true of *any* guest using GICv2, not just when using QEMU as
the VMM, right?

> hangs when firmware falsely reports this address on systems that don't
> have support for legacy mode. 

And I guess it isn't just the guest that hangs, but the whole system can
go south (it would be totally legitimate for the HW to deliver a 
SError).

> As per GICv3/v4 spec, in an implementation that does not support legacy
> operation, affinity routing and system register access are permanently
> enabled. This means that the associated control bits are RAO/WI. Hence
> use the ICC_SRE_EL1.SRE bit to decide whether hardware supports GICv2
> mode in addition to the above firmware based check.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> On Hisilicon D06, UEFI sets the GIC MADT GICC gicv_base_address but the
> GIC implementation on these boards doesn't have the GICv2 legacy 
> support.
> This results in, Guest boot hang when Qemu uses the default GIC option.

What a bore. Is this glorious firmware really out in the wild?

> With this patch, the Qemu Guest with GICv2 now gracefully exits,
>  "qemu-system-aarch64: host does not support in-kernel GICv2 emulation"
> 
> Not very sure there is a better way to detect this other than checking
> the SRE bit as done in this patch(Of course, we will be fixing the UEFI
> going forward).

I don't think there is any other reliable way, but see below.

> 
> Thanks,
> Shameer
> 
> ---
>  drivers/irqchip/irq-gic-v3.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 16fecc0febe8..15fa1eea45e4 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1835,6 +1835,27 @@ static void __init
> gic_populate_ppi_partitions(struct device_node *gic_node)
>  	of_node_put(parts_node);
>  }
> 
> +/* SRE bit being RAO/WI implies no GICv2 legacy mode support */
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
>  static void __init gic_of_setup_kvm_info(struct device_node *node)
>  {
>  	int ret;
> @@ -1851,10 +1872,12 @@ static void __init
> gic_of_setup_kvm_info(struct device_node *node)
>  				 &gicv_idx))
>  		gicv_idx = 1;
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
>  	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>  	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
> @@ -2164,7 +2187,7 @@ static void __init gic_acpi_setup_kvm_info(void)
> 
>  	gic_v3_kvm_info.maint_irq = irq;
> 
> -	if (acpi_data.vcpu_base) {
> +	if (gic_gicv2_compatible() && acpi_data.vcpu_base) {
>  		struct resource *vcpu = &gic_v3_kvm_info.vcpu;
> 
>  		vcpu->flags = IORESOURCE_MEM;

The problem is that this gic_gicv2_compatible() comes in way too late,
and you are disabling SRE while we already have configured tons of 
stuff.
This has the potential for breaking things unexpectedly.

How about this instead? Completely untested, of course.

Thanks,

         M.

diff --git a/arch/arm64/kernel/cpufeature.c 
b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..c42f39154af9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1200,7 +1200,7 @@ static bool has_useable_gicv3_cpuif(const struct 
arm64_cpu_capabilities *entry,
  	if (!has_cpuid_feature(entry, scope))
  		return false;

-	has_sre = gic_enable_sre();
+	has_sre = gic_enable_sre(NULL);
  	if (!has_sre)
  		pr_warn_once("%s present but disabled by higher exception level\n",
  			     entry->desc);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 09c96f57818c..20a7102612da 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -182,7 +182,7 @@ static void init_gic_priority_masking(void)
  {
  	u32 cpuflags;

-	if (WARN_ON(!gic_enable_sre()))
+	if (WARN_ON(!gic_enable_sre(NULL)))
  		return;

  	cpuflags = read_sysreg(daif);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0febe8..db5ce3dd01c7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -103,6 +103,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
  /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
  static refcount_t *ppi_nmi_refs;

+static bool has_v2_compat;
+
  static struct gic_kvm_info gic_v3_kvm_info;
  static DEFINE_PER_CPU(bool, has_rss);

@@ -915,7 +917,7 @@ static void gic_cpu_sys_reg_init(void)
  	 *
  	 * Kindly inform the luser.
  	 */
-	if (!gic_enable_sre())
+	if (!gic_enable_sre(&has_v2_compat))
  		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");

  	pribits = gic_get_pribits();
@@ -1853,7 +1855,7 @@ static void __init gic_of_setup_kvm_info(struct 
device_node *node)

  	gicv_idx += 3;	/* Also skip GICD, GICC, GICH */
  	ret = of_address_to_resource(node, gicv_idx, &r);
-	if (!ret)
+	if (has_v2_compat && !ret)
  		gic_v3_kvm_info.vcpu = r;

  	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
@@ -2164,7 +2166,7 @@ static void __init gic_acpi_setup_kvm_info(void)

  	gic_v3_kvm_info.maint_irq = irq;

-	if (acpi_data.vcpu_base) {
+	if (has_v2_compat && acpi_data.vcpu_base) {
  		struct resource *vcpu = &gic_v3_kvm_info.vcpu;

  		vcpu->flags = IORESOURCE_MEM;
diff --git a/include/linux/irqchip/arm-gic-v3.h 
b/include/linux/irqchip/arm-gic-v3.h
index f6d092fdb93d..bdc390529367 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -693,11 +693,22 @@ int its_init(struct fwnode_handle *handle, struct 
rdists *rdists,
  	     struct irq_domain *domain);
  int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);

-static inline bool gic_enable_sre(void)
+static inline bool gic_enable_sre(bool *has_v2)
  {
  	u32 val;

  	val = gic_read_sre();
+	if (has_v2) {
+		if (!(val & ICC_SRE_EL1_SRE)) {
+			*has_v2 = true;
+		} else {
+			val &= ~ICC_SRE_EL1_SRE;
+			gic_write_sre(val);
+			val = gic_read_sre();
+			*has_v2 = !(val & ICC_SRE_EL1_SRE);
+		}
+	}
+
  	if (val & ICC_SRE_EL1_SRE)
  		return true;

-- 
Jazz is not dead. It just smells funny...
