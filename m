Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00742A2D11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKBOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:37:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47324 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKBOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:37:20 -0500
Received: from zn.tnic (p200300ec2f086a005eef14ece2bfc9a7.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:5eef:14ec:e2bf:c9a7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B96D1EC0328;
        Mon,  2 Nov 2020 15:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604327839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CrGg9rK4uvm4Q0y8bZd5vyUgp74wB3OKjww/RvmQ3bc=;
        b=VKYNztmH3e6yxoLu4KiMwGTgYAffpJTGSTVnIVpUx9RR78Znmnop8oXFmtYiubFMpjo01O
        bf7LQOakzENwY7f62FyaTm5bZGTiEyJz0hLZzUDj66CNU8w87Wwd2wsNTcG4T69rE+w8ht
        JLrcZFjemQ4ntG50P9FQVZFpCCVxN/c=
Date:   Mon, 2 Nov 2020 15:37:07 +0100
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
Subject: Re: [PATCH v5 03/17] x86/acrn: Introduce an API to check if a VM is
 privileged
Message-ID: <20201102143707.GC15392@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-4-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019061803.13298-4-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 02:17:49PM +0800, shuo.a.liu@intel.com wrote:
> +bool acrn_is_privileged_vm(void)
> +{
> +	return cpuid_eax(acrn_cpuid_base() | ACRN_CPUID_FEATURES) &
> +			 ACRN_FEATURE_PRIVILEGED_VM;

I asked in the previous review why that acrn_cpuid_base() is used here,
you said that the base might vary. Looking at hypervisor_cpuid_base(),
it searches in the range [0x40000000, 0x40010000] with an 0x100 offset.

So you're saying that ACRN_CPUID_FEATURES is the first leaf beyond the
base. Close?

If so, why isn't the code doing this?

	return cpuid_eax(acrn_cpuid_base() + 1)...

and why doesn't it have a comment above it explaining that the base can
change and it needs to be discovered each time?

> +EXPORT_SYMBOL_GPL(acrn_is_privileged_vm);

Also, that acrn_is_privileged_vm() silly helper is used only once and
I don't like the exported symbols pollution we're doing. So make that
function give you the eax of ACRN_CPUID_FEATURES and callers can do
their testing themselves.

When it turns out that code patterns get repeated, you can then
aggregate stuff into a helper.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
