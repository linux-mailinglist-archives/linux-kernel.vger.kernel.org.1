Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549902A41B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgKCKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:25:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44670 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:25:50 -0500
Received: from zn.tnic (p200300ec2f10e0003c085ddaf11537c5.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:3c08:5dda:f115:37c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 347511EC03B9;
        Tue,  3 Nov 2020 11:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604399149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jmja/QfDPCZEo2TLVBj+4U5mu7pdYN9iPevbinoGNcA=;
        b=HYtVGEtUdzhFkTtrCTTpaPnykto98yNQQN6JlbjQK8eBLHUULD5XdUOwmgVQqjDHboAl6F
        Khapm2etZvL8Tt08bzJ3oEmrSanPFFMe90eIt8JFsp7CJ6NERusvoJtPvXH+3eQPEMMlUt
        9j66961oBHpS0sVF4NU6I5HdysA2WKY=
Date:   Tue, 3 Nov 2020 11:25:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuo A Liu <shuo.a.liu@intel.com>
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
Message-ID: <20201103102538.GB6310@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-4-shuo.a.liu@intel.com>
 <20201102143707.GC15392@zn.tnic>
 <20201103062718.GD12408@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103062718.GD12408@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:27:18PM +0800, Shuo A Liu wrote:
> The code just followed KVM style (see kvm_arch_para_features()).

Do you see Documentation/virt/kvm/cpuid.rst?

Now where is yours explaining what your hypervisor is doing?

> I can change to use
> 	cpuid_eax(acrn_cpuid_base() + 1)...
> If you prefer to.

Yes please.

> hypervisor_cpuid_base() implies the base is variable, no? We use
> this function to detect the base.

Yes, but you need to document all that and make it clear and
understandable. If Linux is supposed to run as an acrn guest, that
interface better be documented just like KVM does.

Also, if there's a bug in the KVM guest/host interface, we might be able
to fix it modulo ABI. Is that possible with acrn?

I'm guessing the answer to that is yes if I'm looking at

https://github.com/projectacrn/acrn-hypervisor

?

> OK. Then i will define acrn_cpuid_base() as a static inline function
> in asm/acrn.h for callers.

Yah, that function is simple enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
