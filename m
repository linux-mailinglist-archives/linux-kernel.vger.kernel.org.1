Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D852A6D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgKDSwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:52:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43174 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgKDSwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:52:11 -0500
Received: from zn.tnic (p200300ec2f0ef400317dde2deb3fed11.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f400:317d:de2d:eb3f:ed11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5CBD1EC0179;
        Wed,  4 Nov 2020 19:52:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604515930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j35nNUv7vFKPZCAWGuXz8ekUUIF51j9Annk7NSuaxBA=;
        b=CCBUBlunPd2Wfa6m5DSTGXAr7/w4HCLTmNA4aAn0gHiWqbEYtl9VXfWeULS/z5fKyvjTep
        BxSMyAg0xzOwlIfhwitqAmqPONucjkw0Ev9sFuEO9NjkuGhVbmCN6meBveQMWQ6SaMfa/g
        MrzmgVD4XIW4ZpwQcnme1EoLDji8L7A=
Date:   Wed, 4 Nov 2020 19:51:57 +0100
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
Message-ID: <20201104185157.GE23298@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-4-shuo.a.liu@intel.com>
 <20201102143707.GC15392@zn.tnic>
 <20201103062718.GD12408@shuo-intel.sh.intel.com>
 <20201103102538.GB6310@zn.tnic>
 <20201104035027.GA17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104035027.GA17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 11:50:27AM +0800, Shuo A Liu wrote:
> On Tue  3.Nov'20 at 11:25:38 +0100, Borislav Petkov wrote:
> > On Tue, Nov 03, 2020 at 02:27:18PM +0800, Shuo A Liu wrote:
> > > The code just followed KVM style (see kvm_arch_para_features()).
> > 
> > Do you see Documentation/virt/kvm/cpuid.rst?
> 
> OK. It documents the leaf number.

It also says

"Note also that old hosts set eax value to 0x0. This should be
interpreted as if the value was 0x40000001."

Does this hold true for the acrn HV? The fact that I'm asking about
all those things should give you a hint that documenting the API is
important.

> > Now where is yours explaining what your hypervisor is doing?
> 
> Currently, it is in arch/x86/include/asm/acrn.h.

Yeah, you can't expect people to go scrape it from headers though - it
should be concentrated in a doc file.

> If the leaf numbers be documented explicitly (like kvm), i think i can
> use them as eax of cpuid_eax() directly (back to your first comment).

Which means, you don't need to do the logical OR-ing which kvm does
because of what I pasted above about eax being 0 on old hosts. Now we're
getting somewhere...

> 	cpuid_eax(ACRN_CPUID_FEATURES)...
> 
> If you looking at implementation of acrn-hypervisor, you will found the
> leaf number is hardcoded in the hypervisor. So, they also can be
> documented explicitly.

Ok.

> OK. I can add a similar cpuid.rst for acrn.

Yes please.

> Yes. Fix patches are always welcome.

Ok, good, the thing is open. You could put that in the doc too, along
with the link so that people can find it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
