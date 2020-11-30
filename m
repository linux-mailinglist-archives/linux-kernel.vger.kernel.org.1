Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72D2C8383
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgK3Lu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbgK3Lu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:50:26 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C420B2074A;
        Mon, 30 Nov 2020 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606736985;
        bh=pgFsJz6+xwO0ONaJrG4G+55biFAhUPSSqR+91oyiBUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ds2NevWQVVnXnC6pud42fd56+wiR1fPDhErH0fO2BGozOuvJigl6vU8G3GXWHVedf
         Mz/rMlUoUhiH6VkVyfU7fUjwwt1hSQ0FhNaoFPXAE9hQWsY1YjK6niGZjPOjeoGhnF
         y4sMJJNqmxmiS6tUVvS8NNTsueW+v3+C5GhZ66uA=
Date:   Mon, 30 Nov 2020 11:49:40 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
Message-ID: <20201130114940.GB24563@willie-the-truck>
References: <20201124195940.27061-1-samitolvanen@google.com>
 <20201124195940.27061-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124195940.27061-3-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:59:40AM -0800, Sami Tolvanen wrote:
> Use scs_alloc() to allocate also IRQ and SDEI shadow stacks instead of
> using statically allocated stacks.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/Makefile |  1 -
>  arch/arm64/kernel/entry.S  |  6 ++--
>  arch/arm64/kernel/irq.c    | 19 ++++++++++
>  arch/arm64/kernel/scs.c    | 16 ---------
>  arch/arm64/kernel/sdei.c   | 71 +++++++++++++++++++++++++++++++-------
>  include/linux/scs.h        |  4 ---
>  6 files changed, 81 insertions(+), 36 deletions(-)
>  delete mode 100644 arch/arm64/kernel/scs.c

[...]

> @@ -70,18 +97,40 @@ static int _init_sdei_stack(unsigned long * __percpu *ptr, int cpu)
>  	return 0;
>  }
>  
> +static int _init_sdei_scs(unsigned long * __percpu *ptr, int cpu)
> +{
> +	void *s;
> +
> +	s = scs_alloc(cpu_to_node(cpu));
> +	if (!s)
> +		return -ENOMEM;
> +	per_cpu(*ptr, cpu) = s;
> +
> +	return 0;
> +}
> +
>  static int init_sdei_stacks(void)
>  {
>  	int cpu;
>  	int err = 0;
>  
>  	for_each_possible_cpu(cpu) {
> -		err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
> -		if (err)
> -			break;
> -		err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
> -		if (err)
> -			break;
> +		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> +			err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
> +			if (err)
> +				break;
> +			err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
> +			if (err)
> +				break;
> +		}
> +		if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> +			err = _init_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
> +			if (err)
> +				break;
> +			err = _init_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
> +			if (err)
> +				break;

This looks ok to me, but I think it would be better to follow the same
approach as you have for the IRQ stacks and instead have a separate
init_sdei_scs() function (similarly for the free() path), which means
you can simply the IS_ENABLED() checks too.

Either way:

Acked-by: Will Deacon <will@kernel.org>

Will
