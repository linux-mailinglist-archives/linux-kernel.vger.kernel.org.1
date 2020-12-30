Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21C2E7B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgL3Rdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 12:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgL3Rdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:33:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F0C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 09:33:10 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ae900b929ac10dfcb3199.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e900:b929:ac10:dfcb:3199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DF171EC04EF;
        Wed, 30 Dec 2020 18:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609349588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rO9syfStUEfHNv7W5nzX2+XmAelNVPGS6C6pYWHTnt8=;
        b=Mrn2ft5i8pm39vjj4DiU0/t1ZV+aTF9hTSTCFt+WnrZ608Q7gP+mO8H6rnMNUyhcXDyYcB
        JfEKVRzqtNx/u1To/C+R9JheRfOHTdf71wq1Q/iCfJajcACvya4C6RWhvL7A3QB0pT82iB
        Is30uzSuJjbMgADV67ZRhGzRPGRASW4=
Date:   Wed, 30 Dec 2020 18:33:05 +0100
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v6 04/18] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201230173305.GF22022@zn.tnic>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-5-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201093853.12070-5-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:38:39PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The Service VM communicates with the hypervisor via conventional
> hypercalls. VMCALL instruction is used to make the hypercalls.
> 
> ACRN hypercall ABI:
>   * Hypercall number is in R8 register.
>   * Up to 2 parameters are in RDI and RSI registers.
>   * Return value is in RAX register.
> 
> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
> register as direct register constraints, use supported constraint as
> input with a explicit MOV to R8 in beginning of asm.
> 
> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fengwei Yin <fengwei.yin@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> ---
>  arch/x86/include/asm/acrn.h | 54 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

The x86 bits in patches 2-4 look ok now, thanks!

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
