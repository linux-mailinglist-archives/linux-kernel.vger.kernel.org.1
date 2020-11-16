Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A5F2B4321
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgKPLt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKPLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:49:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:49:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so23447285wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFJEkUj6StvnCLf3zA4XSa8BJ3U9++NnIiul0HVC8DY=;
        b=nTUfK2EitnQ5Q0QZZIJ6UfQATrjdCE4F3RuhLemICZ+FIa4eNeZj1jdUP59xrVtnyE
         wsRGi8ju0E8yAAhUqKqi4ygMnWHUbuQeVqoTv1FkbIukrUqFbNGApXG4mxG5JFLAiEes
         GEDmXKhmDHxx1AY5P4OHGfXHY307Dk63qu25+pSXuIsykolgBbqrylbhVDfRKQxutLfZ
         FbbwuqINVrnNdiE4btGAzPw9SBXpMYboa6sAmb6xKaSLydR9dXJbLV8ZSGCj4vHlY5E4
         GZC0xSP1mOsVLHma5ulVWJt6la+8lzkyh6mP1/A4UmV0RE8v56gUookImTFJyFIuvTMK
         wFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFJEkUj6StvnCLf3zA4XSa8BJ3U9++NnIiul0HVC8DY=;
        b=o9htipujV9fAYoMaJKigRGBJs0ujIN9/5OB0u9wEAQPkJADnDLzOirabLha6Ekf5eB
         XwPZMb1wLu1YGTOWArQT9P/2gCe7xjIYizjF2d4FrbFl5AXc0R51ixScO/rePyy3mk6/
         uXo2dDLEyypzH9/1BzlaS3V0UCEO8ble7SbbmHCE2bEhhLUtlrKzS72bGBbS+44NpY2p
         GCi4NjmRzmq9MO3WgDm6yfR61ytkVjABFv1xNHDaL8ntMbIFoYaU14e2jlMoyd7Hrjdk
         d2yAz1jQCg5KgcgTkD3Hhe2skZRyqFOg2sa/O3sa4AyH/ZYgZ/xuGTt1/A+DZVDLpzuo
         RLFw==
X-Gm-Message-State: AOAM53313EPXLJunGS+UcGSO7nNS1MRLhwsgGDhXZRMb8EdQs/yVbT1n
        qwMwOwHzlq6NYS7HfUo4QJ/W2mZKEHlaLkXp
X-Google-Smtp-Source: ABdhPJw4YkJYmgRylLEqTzHlY0X6lACb5edwRo2U/kN+S0kiJOP4jgTMcfO+OOMCh+jui7yGQnaCsw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr15591490wma.134.1605527395152;
        Mon, 16 Nov 2020 03:49:55 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:58a8:7836:6672:a072])
        by smtp.gmail.com with ESMTPSA id c17sm19262018wml.14.2020.11.16.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:49:54 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:49:52 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 13/24] kvm: arm64: Add CPU entry point in nVHE hyp
Message-ID: <20201116114952.ybj24wx44lofqs25@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-14-dbrazdil@google.com>
 <7b8f9dec846f172c2919e1d3f3c65245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8f9dec846f172c2919e1d3f3c65245@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  #ifdef CONFIG_CPU_PM
> >    DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > index 1697d25756e9..f999a35b2c8c 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > @@ -6,6 +6,7 @@
> > 
> >  #include <linux/arm-smccc.h>
> >  #include <linux/linkage.h>
> > +#include <linux/irqchip/arm-gic-v3.h>
> 
> This should probably be included from the file that provides init_el2_state.

Agreed. This is a workaround for the fact that the arm-gic* headers don't play
nice with each other (define the same constants). Including arm-gic-v3.h in
kvm_asm.h will trigger macro redefine warnings in vgic*-v2.c because they
include arm-gic.h.

Another option is to create a header just for el2 init. Would that be
preferable? Other ideas?

> 
> > 
> >  #include <asm/alternative.h>
> >  #include <asm/assembler.h>
> > @@ -159,6 +160,35 @@ alternative_else_nop_endif
> >  	ret
> >  SYM_CODE_END(___kvm_hyp_init)
> > 
> > +SYM_CODE_START(__kvm_hyp_cpu_entry)
> > +	msr	SPsel, #1			// We want to use SP_EL{1,2}
> > +
> > +	/*
> > +	 * Check that the core was booted in EL2. Loop indefinitely if not
> > +	 * because it cannot be safely given to the host without installing
> > KVM.
> > +	 */
> > +	mrs	x1, CurrentEL
> > +	cmp	x1, #CurrentEL_EL2
> > +	b.ne	.
> 
> This is a bit brutal. Consider using a WFE/WFI loop as we have in other
> places already (see __secondary_too_slow for example).

Ack

> > +
> > +	/* Initialize EL2 CPU state to sane values. */
> > +	mov	x29, x0
> > +	init_el2_state nvhe
> > +	mov	x0, x29
> > +
> > +	/*
> > +	 * Load hyp VA of C entry function. Must do so before switching on the
> > +	 * MMU because the struct pointer is PA and not identity-mapped in
> > hyp.
> > +	 */
> > +	ldr	x29, [x0, #NVHE_INIT_PSCI_CPU_ENTRY_FN]
> > +
> > +	/* Enable MMU, set vectors and stack. */
> > +	bl	___kvm_hyp_init
> > +
> > +	/* Leave idmap. */
> > +	br	x29
> 
> To a point I made against an earlier patch: psci_cpu_entry_fn seems to be a
> HYP
> VA, and really needs to be documented as such, because this is pretty hard
> to
> follow otherwise.
> 
> > +SYM_CODE_END(__kvm_hyp_cpu_entry)
> > +
> >  SYM_CODE_START(__kvm_handle_stub_hvc)
> >  	cmp	x0, #HVC_SOFT_RESTART
> >  	b.ne	1f
> 
> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
