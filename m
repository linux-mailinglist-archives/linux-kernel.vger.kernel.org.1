Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458B02F9DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbhARLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390137AbhARLTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:19:04 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2481520E65;
        Mon, 18 Jan 2021 11:18:23 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1SY8-008Sno-QZ; Mon, 18 Jan 2021 11:18:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jan 2021 11:18:20 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix the return value of
 smp_call_function_single()
In-Reply-To: <20210118093137.3383-1-yejune.deng@gmail.com>
References: <20210118093137.3383-1-yejune.deng@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <af2ea1ad8df12907fa24eb4bf44c6e99@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yejune.deng@gmail.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-18 09:31, Yejune Deng wrote:
> In smp_call_function_single(), the 3rd parameter isn't the return value
> and it's always positive. But it may return a negative value. So the
> 'ret' is should be the return value of the smp_call_function_single().
> 
> In check_kvm_target_cpu(), 'phys_target' is more readable than 'ret'.
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  arch/arm64/kvm/arm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 04c44853b103..5fa5c04106de 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1815,9 +1815,9 @@ static int init_hyp_mode(void)
>  	return err;
>  }
> 
> -static void check_kvm_target_cpu(void *ret)
> +static void check_kvm_target_cpu(void *phys_target)
>  {
> -	*(int *)ret = kvm_target_cpu();
> +	*(int *)phys_target = kvm_target_cpu();
>  }
> 
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long 
> mpidr)
> @@ -1879,7 +1879,7 @@ void kvm_arch_irq_bypass_start(struct
> irq_bypass_consumer *cons)
>  int kvm_arch_init(void *opaque)
>  {
>  	int err;
> -	int ret, cpu;
> +	int ret, cpu, phys_target;
>  	bool in_hyp_mode;
> 
>  	if (!is_hyp_mode_available()) {
> @@ -1900,7 +1900,7 @@ int kvm_arch_init(void *opaque)
>  			 "Only trusted guests should be used on this system.\n");
> 
>  	for_each_online_cpu(cpu) {
> -		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
> +		ret = smp_call_function_single(cpu, check_kvm_target_cpu, 
> &phys_target, 1);
>  		if (ret < 0) {
>  			kvm_err("Error, CPU %d not supported!\n", cpu);
>  			return -ENODEV;

That's not the purpose of this code. We check the target CPU
for so that we can decide to *fail* the KVM init if there is
a CPU we do not support (we definitely used to do that with
32bit), and the error message clearly states this.

So if you want to handle a cross-call failure, please do that.
But don't change the existing semantics of this code.

         M.
-- 
Jazz is not dead. It just smells funny...
