Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F582E7ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgLaI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 03:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgLaI6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 03:58:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2293422287;
        Thu, 31 Dec 2020 08:57:29 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kutlu-004h5B-Vs; Thu, 31 Dec 2020 08:57:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Dec 2020 08:57:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shenming Lu <lushenming@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com,
        yuzenghui@huawei.com
Subject: Re: [PATCH RFC] KVM: arm64: vgic: Decouple the check of the
 EnableLPIs bit from the ITS LPI translation
In-Reply-To: <20201231062813.714-1-lushenming@huawei.com>
References: <20201231062813.714-1-lushenming@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <683134bdea8a22d3bb784117dcfe17a1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lushenming@huawei.com, will@kernel.org, eric.auger@redhat.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shemming,

On 2020-12-31 06:28, Shenming Lu wrote:
> When the EnableLPIs bit is set to 0, any ITS LPI requests in the
> Redistributor would be ignored. And this check is independent from
> the ITS LPI translation. So it might be better to move the check
> of the EnableLPIs bit out of the LPI resolving, and also add it
> to the path that uses the translation cache.

But by doing that, you are moving the overhead of checking for
EnableLPIs from the slow path (translation walk) to the fast
path (cache hit), which seems counter-productive.

> Besides it seems that
> by this the invalidating of the translation cache caused by the LPI
> disabling is unnecessary.
> 
> Not sure if I have missed something... Thanks.

I am certainly missing the purpose of this patch.

The effect of EnableLPIs being zero is to drop the result of any
translation (a new pending bit) on the floor. Given that, it is
immaterial whether this causes a new translation or hits in the
cache, as the result is still to not pend a new interrupt.

I get the feeling that you are trying to optimise for the unusual
case where EnableLPIs is 0 *and* you have a screaming device
injecting tons of interrupt. If that is the case, I don't think
this is worth it.

Thanks,

         M.

> 
> Signed-off-by: Shenming Lu <lushenming@huawei.com>
> ---
>  arch/arm64/kvm/vgic/vgic-its.c     | 9 +++++----
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 4 +---
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-its.c 
> b/arch/arm64/kvm/vgic/vgic-its.c
> index 40cbaca81333..f53446bc154e 100644
> --- a/arch/arm64/kvm/vgic/vgic-its.c
> +++ b/arch/arm64/kvm/vgic/vgic-its.c
> @@ -683,9 +683,6 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct
> vgic_its *its,
>  	if (!vcpu)
>  		return E_ITS_INT_UNMAPPED_INTERRUPT;
> 
> -	if (!vcpu->arch.vgic_cpu.lpis_enabled)
> -		return -EBUSY;
> -
>  	vgic_its_cache_translation(kvm, its, devid, eventid, ite->irq);
> 
>  	*irq = ite->irq;
> @@ -738,6 +735,9 @@ static int vgic_its_trigger_msi(struct kvm *kvm,
> struct vgic_its *its,
>  	if (err)
>  		return err;
> 
> +	if (!irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
> +		return -EBUSY;
> +
>  	if (irq->hw)
>  		return irq_set_irqchip_state(irq->host_irq,
>  					     IRQCHIP_STATE_PENDING, true);
> @@ -757,7 +757,8 @@ int vgic_its_inject_cached_translation(struct kvm
> *kvm, struct kvm_msi *msi)
> 
>  	db = (u64)msi->address_hi << 32 | msi->address_lo;
>  	irq = vgic_its_check_cache(kvm, db, msi->devid, msi->data);
> -	if (!irq)
> +
> +	if (!irq || !irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
>  		return -EWOULDBLOCK;
> 
>  	raw_spin_lock_irqsave(&irq->irq_lock, flags);
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> index 15a6c98ee92f..7b0749f7660d 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> @@ -242,10 +242,8 @@ static void vgic_mmio_write_v3r_ctlr(struct 
> kvm_vcpu *vcpu,
> 
>  	vgic_cpu->lpis_enabled = val & GICR_CTLR_ENABLE_LPIS;
> 
> -	if (was_enabled && !vgic_cpu->lpis_enabled) {
> +	if (was_enabled && !vgic_cpu->lpis_enabled)
>  		vgic_flush_pending_lpis(vcpu);
> -		vgic_its_invalidate_cache(vcpu->kvm);
> -	}
> 
>  	if (!was_enabled && vgic_cpu->lpis_enabled)
>  		vgic_enable_lpis(vcpu);

-- 
Jazz is not dead. It just smells funny...
