Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1703127E739
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgI3KyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3KyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:54:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:54:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f092a005c3b806e425f5e5c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:5c3b:806e:425f:5e5c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E71B1EC027B;
        Wed, 30 Sep 2020 12:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601463257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WL1myHE/ZtfyxVu6FcNzOVHaU5bWBkNp7k6YwK+1ZeE=;
        b=Iuixgu/tN0hMXg9g5Mp+cl0nk34W+SK5JVD1mcZBDg0kg8adeXUXY00JdUqTLIDUKY9432
        RRCRB5CHTA2bkPUU98kIivOvL9SA7rfFEBN0/nKXUs5pl4U6E5v4guIiSHAeUmVqSUXl97
        gldoi9z0h19BxaD36k9Q6p6DTCVgd7w=
Date:   Wed, 30 Sep 2020 12:54:08 +0200
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
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20200930105408.GE6810@zn.tnic>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922114311.38804-5-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:42:58PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The Service VM communicates with the hypervisor via conventional
> hypercalls. VMCALL instruction is used to make the hypercalls.
> 
> ACRN hypercall ABI:
>   * Hypercall number is in R8 register.
>   * Up to 2 parameters are in RDI and RSI registers.
>   * Return value is in RAX register.

I'm assuming this is already cast in stone in the HV and it cannot be
changed?

> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
> register as direct register constraints, here are two ways to use R8 in
> extended asm:
>   1) use explicit register variable as input
>   2) use supported constraint as input with a explicit MOV to R8 in
>      beginning of asm
> 
> The number of instructions of above two ways are same.
> Asm code from 1)
>   38:   41 b8 00 00 00 80       mov    $0x80000000,%r8d
>   3e:   48 89 c7                mov    %rax,%rdi
>   41:   0f 01 c1                vmcall
> Here, writes to the lower dword (%r8d) clear the upper dword of %r8 when
> the CPU is in 64-bit mode.
> 
> Asm code from 2)
>   38:   48 89 c7                mov    %rax,%rdi
>   3b:   49 b8 00 00 00 80 00    movabs $0x80000000,%r8
>   42:   00 00 00
>   45:   0f 01 c1                vmcall
> 
> Choose 1) for code simplicity and a little bit of code size
> optimization.

What?

How much "optimization" is this actually? A couple of bytes?

And all that for this

	/* Nothing can come between the r8 assignment and the asm: */

restriction?

If it is only a couple of bytes, just do the explicit MOV to %r8 and
f'get about it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
