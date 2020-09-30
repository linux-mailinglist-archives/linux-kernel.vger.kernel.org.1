Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76F27E359
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgI3IKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:10:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3IKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:10:08 -0400
Received: from zn.tnic (p200300ec2f092a00509dd0059ac29c82.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:509d:d005:9ac2:9c82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3D361EC04B9;
        Wed, 30 Sep 2020 10:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601453407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ueW1Vj+4C0xsdqtECsj5PcHsL94AM3OeuF4oGmr3Elw=;
        b=oRrT6G0LlpHr0sk03CoiBYrbuekPXujmkMzeuida31QBq3DUaGYmhv4cb9o7Zc3aHFNRId
        cHqAYt+mgwoUZwS7rM1j+Alm773/iVI8aUKm9CjFR/9t3VGKF0NfxmVLeoEA+jy9h8CR2G
        wOwlQM7xokiGtU9wIwOSFUlLndzl9ho=
Date:   Wed, 30 Sep 2020 10:09:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 03/17] x86/acrn: Introduce an API to check if a VM is
 privileged
Message-ID: <20200930080959.GD6810@zn.tnic>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-4-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922114311.38804-4-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:42:57PM +0800, shuo.a.liu@intel.com wrote:
> +static u32 acrn_cpuid_base(void)
> +{
> +	static u32 acrn_cpuid_base;
> +
> +	if (!acrn_cpuid_base && boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		acrn_cpuid_base = hypervisor_cpuid_base("ACRNACRNACRN", 0);
> +
> +	return acrn_cpuid_base;
> +}
> +
> +bool acrn_is_privileged_vm(void)
> +{
> +	return cpuid_eax(acrn_cpuid_base() | ACRN_CPUID_FEATURES) &

What's that dance and acrn_cpuid_base static thing needed for? Why not
simply:

	cpuid_eax(ACRN_CPUID_FEATURES) & ...

?

> +			 ACRN_FEATURE_PRIVILEGED_VM;
> +}
> +EXPORT_SYMBOL_GPL(acrn_is_privileged_vm);

Also, if you're going to need more of those bit checkers acrn_is_<something>
which look at ACRN_CPUID_FEATURES, just stash CPUID_0x40000001_EAX locally and
use a

	acrn_has(ACRN_FEATURE_PRIVILEGED_VM)

which does the bit testing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
