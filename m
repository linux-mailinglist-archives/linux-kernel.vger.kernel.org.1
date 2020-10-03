Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00712824D0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgJCOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgJCOcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:32:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64DD7206B8;
        Sat,  3 Oct 2020 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601735520;
        bh=ewfSVLKWIxlh/mN5jtanPBaopxBzCdbn+TR8pcyPzlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpIvtdwbmTv7OgJbiUJunMk+CIyDw7Zb8Y/f639/Hjs5oAGohFw8KdqE6JtoSQhc0
         NBRugm1bhxII9OyzWDDxgw7E29MrmR7jLuCpIcxos1S08PZ+5Sac6JROcUEEKhFSwR
         016U/ITIYy9kU2lMe4hYdHz1tStaYdAWQoju1dw4=
Date:   Sat, 3 Oct 2020 16:32:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v39 00/24] Intel SGX foundations
Message-ID: <20201003143246.GA800720@kroah.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 07:50:35AM +0300, Jarkko Sakkinen wrote:
> Intel(R) SGX is a set of CPU instructions that can be used by applications
> to set aside private regions of code and data. The code outside the enclave
> is disallowed to access the memory inside the enclave by the CPU access
> control.
> 
> There is a new hardware unit in the processor called Memory Encryption
> Engine (MEE) starting from the Skylake microacrhitecture. BIOS can define
> one or many MEE regions that can hold enclave data by configuring them with
> PRMRR registers.
> 
> The MEE automatically encrypts the data leaving the processor package to
> the MEE regions. The data is encrypted using a random key whose life-time
> is exactly one power cycle.
> 
> The current implementation requires that the firmware sets
> IA32_SGXLEPUBKEYHASH* MSRs as writable so that ultimately the kernel can
> decide what enclaves it wants run. The implementation does not create
> any bottlenecks to support read-only MSRs later on.
> 
> You can tell if your CPU supports SGX by looking into /proc/cpuinfo:
> 
> 	cat /proc/cpuinfo  | grep sgx

I might be late to the game, but why are you trying to dual-license the
new files you are adding in this patch?  How will that help anyone?

I have had many talks with Intel about this in the past, and last I
heard was that when dual-licensing made sense, they would be explicit as
to why it was happening.  Or is my memory failing me?

thanks,

greg k-h
