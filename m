Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDD2817B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbgJBQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgJBQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601655616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qbg2ZB8Tj8uINky/kbffAXyE83kY0z9BaKEEMl4D6xg=;
        b=gPtO7IREOiQYWmXnIE36xMRDuiDpQE1cMi6Ao3+mPbOPP8ymcv8wGtlRLjLZDmdjuz5rxf
        9ArF2IP/NvHvvxfYNAS4sHkVpHl6oubbNssh4854CM+VDQRy76f8DVq0jmPdft6bHxQEdS
        0VKlb2K5gJskapwgtKlrAVCpvzdd6ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-GcFFDOn3MHmryeMOzKjB-g-1; Fri, 02 Oct 2020 12:20:13 -0400
X-MC-Unique: GcFFDOn3MHmryeMOzKjB-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9232710BBEDD;
        Fri,  2 Oct 2020 16:20:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F35A60C47;
        Fri,  2 Oct 2020 16:20:05 +0000 (UTC)
Date:   Fri, 2 Oct 2020 18:20:03 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        qemu-devel@nongnu.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] arm64: kvm: Introduce MTE VCPU feature
Message-ID: <20201002162003.u2yn3kqj6b4busbj@kamzik.brq.redhat.com>
References: <20200925093607.3051-1-steven.price@arm.com>
 <20200925093607.3051-3-steven.price@arm.com>
 <20201002143050.zamkpmqysy6k5ngl@kamzik.brq.redhat.com>
 <8b617aef-2bff-8af0-df47-f9f863ab6fa0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b617aef-2bff-8af0-df47-f9f863ab6fa0@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 04:30:47PM +0100, Steven Price wrote:
> On 02/10/2020 15:30, Andrew Jones wrote:
> > On Fri, Sep 25, 2020 at 10:36:07AM +0100, Steven Price wrote:
> > > +	if (system_supports_mte() && kvm->arch.mte_enabled && pfn_valid(pfn)) {
> > 
> > 'system_supports_mte() && kvm->arch.mte_enabled' is redundant, but I
> > assume system_supports_mte() is there to improve the efficiency of the
> > branch, as it's using cpus_have_const_cap().
> 
> system_supports_mte() compiles to 0 when MTE support isn't built in, so this
> code can be removed by the compiler,

I know. That's what I meant by "improve the efficiency of the branch"


> whereas with kvm->arch.mte_enabled I
> doubt the compiler can deduce that it is never set.
> 
> > Maybe a helper like
> > 
> >   static inline bool kvm_arm_mte_enabled(struct kvm *kvm)
> >   {
> >     return system_supports_mte() && kvm->arch.mte_enabled;
> >   }
> > 
> > would allow both the more efficient branch and look less confusing
> > where it gets used.
> 
> I wasn't sure it was worth having a helper since this was the only place
> checking this condition. It's also a bit tricky putting this in a logical
> header file, kvm_host.h doesn't work because struct kvm hasn't been defined
> by then.

OK, but I feel like we're setting ourselves up to revisit these types of
conditions again when our memories fade or when new developers see them
for the first time and ask.

Thanks,
drew

> 
> Steve
> 
> > > +		/*
> > > +		 * VM will be able to see the page's tags, so we must ensure
> > > +		 * they have been initialised.
> > > +		 */
> > > +		struct page *page = pfn_to_page(pfn);
> > > +		long i, nr_pages = compound_nr(page);
> > > +
> > > +		/* if PG_mte_tagged is set, tags have already been initialised */
> > > +		for (i = 0; i < nr_pages; i++, page++) {
> > > +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> > > +				mte_clear_page_tags(page_address(page));
> > > +		}
> > > +	}
> > > +
> > >   	if (writable)
> > >   		kvm_set_pfn_dirty(pfn);
> > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > > index a655f172b5ad..5010a47152b4 100644
> > > --- a/arch/arm64/kvm/sys_regs.c
> > > +++ b/arch/arm64/kvm/sys_regs.c
> > > @@ -1132,7 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
> > >   			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> > >   		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> > >   	} else if (id == SYS_ID_AA64PFR1_EL1) {
> > > -		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
> > > +		if (!vcpu->kvm->arch.mte_enabled)
> > > +			val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
> > >   	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
> > >   		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> > >   			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> > > @@ -1394,6 +1395,9 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > >   static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
> > >   				   const struct sys_reg_desc *rd)
> > >   {
> > > +	if (vcpu->kvm->arch.mte_enabled)
> > > +		return 0;
> > > +
> > >   	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
> > >   }
> > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > index f6d86033c4fa..87678ed82ab4 100644
> > > --- a/include/uapi/linux/kvm.h
> > > +++ b/include/uapi/linux/kvm.h
> > > @@ -1035,6 +1035,7 @@ struct kvm_ppc_resize_hpt {
> > >   #define KVM_CAP_LAST_CPU 184
> > >   #define KVM_CAP_SMALLER_MAXPHYADDR 185
> > >   #define KVM_CAP_S390_DIAG318 186
> > > +#define KVM_CAP_ARM_MTE 188
> > >   #ifdef KVM_CAP_IRQ_ROUTING
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > 
> > Besides the helper suggestion nit
> > 
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > 
> 
> 

