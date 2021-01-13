Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B762F54D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAMWKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbhAMWFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:05:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BBF23370;
        Wed, 13 Jan 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610575484;
        bh=kaPg4tNbVSYG15sLbgGUHHLryojTzxy4vySqBttv3Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJaCDlxt+GHp9o2HTovqWg+cAk1bdIhy9M3+2dDZxKd/4ZC0D8of+KVDkdW9VWUpD
         yvS/PZsibm85+XKq7CHzoLbD3lNGcFNzxFHpF7gKH4de6Rr9PMsag8xOVol79XwMWU
         BEd9TiAejkD3nYHeOufpWOy8wEHkd/MRajYw8WcYLc8J3osGc6l2FdLwpuVXQE53Xl
         JLP/9hXBE7NnbbGaw/8grFzDHNEcwEfGnhMGFHOCeMtr87SaWp8PXmIFiC8DZosi1e
         +maaOLIjpELAkiIf6UuHcBOtNsDqRWEFiENvsD4AG4rMX/u0KvCJ9vT5L/+aVFQd9H
         BWbLQvwFouVVg==
Date:   Thu, 14 Jan 2021 00:04:37 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        bp@suse.de, x86@kernel.org
Subject: Re: [PATCH] x86/sgx: rename and document SGX bit lock
Message-ID: <X/9udYTX+k2G+tiZ@kernel.org>
References: <20210112221901.2CE31C8E@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112221901.2CE31C8E@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 02:19:01PM -0800, Dave Hansen wrote:
> 
> SGX ioctl() calls are serialized with a lock.  It's a weird open-coded
> lock that is not even called a "lock".  That makes it a weird beast,
> but Sean has convinced me it's a good idea without better alternatives.
> 
> Give the lock bit a better name, and document what it actually trying
> to do.
> 
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: x86@kernel.org
> 
> ---
> 
>  b/arch/x86/kernel/cpu/sgx/encl.h  |    2 +-
>  b/arch/x86/kernel/cpu/sgx/ioctl.c |   19 ++++++++++++++++---
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff -puN arch/x86/kernel/cpu/sgx/ioctl.c~sgx-encl-flags arch/x86/kernel/cpu/sgx/ioctl.c
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c~sgx-encl-flags	2021-01-12 14:02:24.480689006 -0800
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c	2021-01-12 14:02:24.486689006 -0800
> @@ -690,8 +690,21 @@ long sgx_ioctl(struct file *filep, unsig
>  	struct sgx_encl *encl = filep->private_data;
>  	int ret;
>  
> -	if (test_and_set_bit(SGX_ENCL_IOCTL, &encl->flags))
> -		return -EBUSY;
> +	/*
> +	 * Behold, the Big SGX Lock
> +	 *
> +	 * The primary function of this "lock" is to actively discourage
> +	 * attempts at multi-threaded enclave management.  Enclave management
> +	 * is fundamentally a single-threaded affair.  Enclave measurement,
> +	 * for instance would be worthless if two ADD_PAGES instances raced
> +	 * and occurred in different orders.
> +	 *
> +	 * encl->lock is ill suited for this because it would need to be
> +	 * conditionally dropped and reqacuired for operations like enclave
> +	 * page allocation and reclaim.
> +	 */
> +	if (test_and_set_bit(SGX_ENCL_IOCTL_LOCK, &encl->flags))
> +		return -EINVAL;

Precisely this come down to SGX_IOC_ENCLAVE_ADD_PAGES ioctl where
you need to do multiple sgx_alloc_epc_pages() calls. Other ioctl's
are not bound to this.

In other words, two threads could have ABBA race if they wait for each
other locks while swapping. Since cryptographic measurements require
strict order anyway, this is a simple way to sort out the issue.

Other way to sort this out would be to pre-allocate the amount of
pages and VA pages required to add new pages before taking the
lock but that its own set problems (like the being non-swappable
for a while).

Maybe these details could be sharpened in the comment? I agree with
the name change. I.e.

1. We do this because the add page flow requires this.
2. The order must be sequential anyway so no harm done.
3. Pre-allocating variable number of pages is not an alternative.

/Jarkko

>  
>  	switch (cmd) {
>  	case SGX_IOC_ENCLAVE_CREATE:
> @@ -711,6 +724,6 @@ long sgx_ioctl(struct file *filep, unsig
>  		break;
>  	}
>  
> -	clear_bit(SGX_ENCL_IOCTL, &encl->flags);
> +	clear_bit(SGX_ENCL_IOCTL_LOCK, &encl->flags);
>  	return ret;
>  }
> diff -puN arch/x86/kernel/cpu/sgx/encl.h~sgx-encl-flags arch/x86/kernel/cpu/sgx/encl.h
> --- a/arch/x86/kernel/cpu/sgx/encl.h~sgx-encl-flags	2021-01-12 14:02:24.482689006 -0800
> +++ b/arch/x86/kernel/cpu/sgx/encl.h	2021-01-12 14:16:37.511686879 -0800
> @@ -34,7 +34,7 @@ struct sgx_encl_page {
>  };
>  
>  enum sgx_encl_flags {
> -	SGX_ENCL_IOCTL		= BIT(0),
> +	SGX_ENCL_IOCTL_LOCK	= BIT(0), /* See sgx_ioctl() */
>  	SGX_ENCL_DEBUG		= BIT(1),
>  	SGX_ENCL_CREATED	= BIT(2),
>  	SGX_ENCL_INITIALIZED	= BIT(3),
> _
> 
