Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA74B2EBC23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAFKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbhAFKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609927775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSjdbFg4NJLQwoCyw1lWkPOfCwj1ksW1BVmATmrSGjM=;
        b=PDS+kANwfRUezns0I5TjWbr05khgBkRIBLsnS5pwB8+eOXhq+0Y7kPmT8jfOEW5yfsemeU
        0vtf9lrZPz83uG05kLtpkmBajwh8bd1FwwFvasdNUIBjHZwNTsSdPSROfr0qUykDNB74GS
        S6m7xsU452zEPnx9oYCIZzxZWPy4/zE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-ynNEUIIWMaeuZ4WL3xgfwg-1; Wed, 06 Jan 2021 05:09:34 -0500
X-MC-Unique: ynNEUIIWMaeuZ4WL3xgfwg-1
Received: by mail-ed1-f72.google.com with SMTP id bf13so1752539edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wSjdbFg4NJLQwoCyw1lWkPOfCwj1ksW1BVmATmrSGjM=;
        b=QpCcxbws05pkiyWFdG+tH2RHJJBY6RHCZHkAR3e7Am2VjAZ/TUfv7YA53KhP6ilA5N
         I+1Vihqk1VxBu3ItFBO6RmWOqP8ldrYvuC8TZb0E3zGYc/HJItdyGoidAyOzX15r//sF
         CcumHlsZkrOgEFbwtUzUdhTc5WclBBddN7BoZvZ0imVmeoM6jcjSyC3gRZRE3vB/A0fN
         fjPwjFANmd18UbiDGPzgualfL7+XsFdtazkauhyR5KWefVE0Cs3KF3c5N5h/SiiqVSjh
         4GZjapHd1f0bsNcO2WuG6RCq0Sp7WLbg9GCOYXvh5LIRZva/L1YK2E0tB3hUimlimI3G
         ZRVA==
X-Gm-Message-State: AOAM533UJimwz8r3VPwwFWaR6AeTA1ZDhgQVbNWh0vZMeKDL2eiqqigb
        U2/TlF1Dzq4aEeoqKQwOfGKPSCqVLhVdCt4Y50CoBHJL0JblrRYyvKpa3OKTgSM7xmePAdEIfrP
        Uaijet06Qf4hVfGM9yeNLxwUE
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr2360274eja.486.1609927767716;
        Wed, 06 Jan 2021 02:09:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzy3Z7B7XX+dB40OsAjYmF54OLrU/JFo24uFOV7tgw3OFSl9LhPVHOMP2BM9GYjJKCitjwCg==
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr2360264eja.486.1609927767520;
        Wed, 06 Jan 2021 02:09:27 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u24sm1039419eje.71.2021.01.06.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:09:26 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, w90p710@gmail.com, pbonzini@redhat.com,
        nitesh@redhat.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert "KVM: x86: Unconditionally enable irqs in guest
 context"
In-Reply-To: <20210105192844.296277-1-nitesh@redhat.com>
References: <20210105192844.296277-1-nitesh@redhat.com>
Date:   Wed, 06 Jan 2021 11:09:26 +0100
Message-ID: <874kjuidgp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nitesh Narayan Lal <nitesh@redhat.com> writes:

> This reverts commit d7a08882a0a4b4e176691331ee3f492996579534.
>
> After the introduction of the patch:
>
> 	87fa7f3e9: x86/kvm: Move context tracking where it belongs
>
> since we have moved guest_exit_irqoff closer to the VM-Exit, explicit
> enabling of irqs to process pending interrupts should not be required
> within vcpu_enter_guest anymore.
>
> Conflicts:
> 	arch/x86/kvm/svm.c
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c |  9 +++++++++
>  arch/x86/kvm/x86.c     | 11 -----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cce0143a6f80..c9b2fbb32484 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4187,6 +4187,15 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
>  
>  static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
>  {
> +	kvm_before_interrupt(vcpu);
> +	local_irq_enable();
> +	/*
> +	 * We must have an instruction with interrupts enabled, so
> +	 * the timer interrupt isn't delayed by the interrupt shadow.
> +	 */
> +	asm("nop");
> +	local_irq_disable();
> +	kvm_after_interrupt(vcpu);
>  }
>  
>  static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3f7c1fc7a3ce..3e17c9ffcad8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9023,18 +9023,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  
>  	kvm_x86_ops.handle_exit_irqoff(vcpu);
>  
> -	/*
> -	 * Consume any pending interrupts, including the possible source of
> -	 * VM-Exit on SVM 

I kind of liked this part of the comment, the new (old) one in
svm_handle_exit_irqoff() doesn't actually explain what's going on.

> and any ticks that occur between VM-Exit and now.

Looking back, I don't quite understand why we wanted to account ticks
between vmexit and exiting guest context as 'guest' in the first place;
to my understanging 'guest time' is time spent within VMX non-root
operation, the rest is KVM overhead (system). It seems to match how the
accounting is done nowadays after Tglx's 87fa7f3e98a1 ("x86/kvm: Move
context tracking where it belongs").

> -	 * An instruction is required after local_irq_enable() to fully unblock
> -	 * interrupts on processors that implement an interrupt shadow, the
> -	 * stat.exits increment will do nicely.
> -	 */
> -	kvm_before_interrupt(vcpu);
> -	local_irq_enable();
>  	++vcpu->stat.exits;
> -	local_irq_disable();
> -	kvm_after_interrupt(vcpu);
>  
>  	if (lapic_in_kernel(vcpu)) {
>  		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;

FWIW,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

