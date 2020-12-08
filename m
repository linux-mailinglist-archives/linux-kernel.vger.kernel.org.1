Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06C32D2884
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgLHKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLHKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:09:14 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3CC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 02:08:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r7so4377684wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZ1JoaEugH2kZjiM+1q8p4p22cxzbXAaz18ICTGEw5w=;
        b=i8dF9UQdWs6QIpFpplKtGnT0gZMxooWKlGoQwA9Pl9IGUpXvDUntpDIWxBzAhlVS1G
         VSf06k+DRZQ9MylRwjBygEtv0u8c0WIPa4EmRcGnuaN8/MsrwcmKV1BBeT/xFC+LhOz1
         2ahcumv86T0qh7CJ9zR9ZNuLCrPMhokFUByDr0SZZGVTkA3fXFBtQ25SiRZstVoqET+B
         5jR2XRO76aMCn5LBpgMH6DVgEZOuLeYjiyncb7nUFhdWi9gNieHrGwE1KEl6oX0J30TY
         d/AF9zdhTEEpUbKePFmY6n30mQd9I89QNzZXNModfQwwp6yk2GuilYZvkro+HwL37V98
         vOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZ1JoaEugH2kZjiM+1q8p4p22cxzbXAaz18ICTGEw5w=;
        b=rCNyg8wIUcpstuOlB7kfLD3QTZ9bh14dNlbhbAO2hB2CQ2ncHIPemZJf0Z8Ijxm94Y
         A0YQd9D26QpdDC2w6pPbgyXO1YOXbGoXOJcJzM7dH+Aa9chaapbTSgv6hLU7eQARK01V
         HIgQ5IyaYpKjDtG4TX17v/7TtGnh3YWSvdte00Yo6PZc+u17y7L8IFVk5vqbOKec+90t
         ufa7WZhIphFLcf6EUEe1fZ01SMoOJ3aK1GfmywymeXpSL6Rw8Cg/kPFNOTHL4VctSyEb
         M0fYUxWMrR0LtP0IFocCJgTBOB9eEDmypSYkKXgUHnSGeHjr3ecRdbChphIDkMRoXNZK
         mkHg==
X-Gm-Message-State: AOAM5305t5FirFygpQxQEf/AuK7DHcHO5RYWThSAwBNHMCq7WoNvJddf
        +Gwg4wEY4PRsiF6MbamquMOVYw==
X-Google-Smtp-Source: ABdhPJx0/5YZtTz2GMggQZzAzXjM+OSm7kqbGZ6gvhOEG4D5YV1WkhrI2ITa8y8DL0W4HS9m5064iA==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr24415607wrt.425.1607422112519;
        Tue, 08 Dec 2020 02:08:32 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id q73sm2667566wme.44.2020.12.08.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:08:31 -0800 (PST)
Date:   Tue, 8 Dec 2020 10:08:30 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Qian Cai <qcai@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 17/26] kvm: arm64: Add offset for hyp VA <-> PA
 conversion
Message-ID: <20201208100830.dhkkhzsqiy46euod@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-18-dbrazdil@google.com>
 <1835d0c3d0f6024b7c6778d9d84f1120291eacad.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1835d0c3d0f6024b7c6778d9d84f1120291eacad.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

> > +/*
> > + * Store a hyp VA <-> PA offset into a hyp-owned variable.
> > + */
> > +static void init_hyp_physvirt_offset(void)
> > +{
> > +	extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
> > +	u64 kern_va, hyp_va;
> > +
> > +	/* Compute the offset from the hyp VA and PA of a random symbol. */
> > +	kern_va = (u64)kvm_ksym_ref(__hyp_text_start);
> > +	hyp_va = __early_kern_hyp_va(kern_va);
> > +	CHOOSE_NVHE_SYM(hyp_physvirt_offset) = (s64)__pa(kern_va) - (s64)hyp_va;
> 
> The code here introduced a warning on TX2 from today's linux-next.
> 
> .config: https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
> 
> [   29.356963] CPU255: Booted secondary processor 0x0000011f03 [0x431f0af1]
> [   29.358301] smp: Brought up 2 nodes, 256 CPUs
> [   29.364962] SMP: Total of 256 processors activated.
> [   29.364985] CPU features: detected: Privileged Access Never
> [   29.365003] CPU features: detected: LSE atomic instructions
> [   29.365023] CPU features: detected: CRC32 instructions
> [   29.431660] CPU: All CPU(s) started at EL2
> [   29.431685] ------------[ cut here ]------------
> [   29.431713] virt_to_phys used for non-linear address: (____ptrval____) (__hyp_idmap_text_end+0x0/0x534)
> [   29.431744] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x80/0xc0
> [   29.431759] Modules linked in:
> [   29.431787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc6-next-20201207+ #2
> [   29.431804] pstate: 10400009 (nzcV daif +PAN -UAO -TCO BTYPE=--)
> [   29.431819] pc : __virt_to_phys+0x80/0xc0
> [   29.431834] lr : __virt_to_phys+0x80/0xc0
> [   29.431848] sp : ffff000005fefc90
> [   29.431862] x29: ffff000005fefc90 x28: ffff8000191c9010 
> [   29.431891] x27: ffff000005f21228 x26: b14e19fe279ae3eb 
> [   29.431920] x25: ffff8000191c9010 x24: ffff8000191c9000 
> [   29.431948] x23: ffff8000191c9000 x22: 000f800011235acc 
> [   29.431975] x21: 0000000000000001 x20: 000f800000000000 
> [   29.432003] x19: ffff800011235acc x18: ffff6001cedcc336 
> [   29.432031] x17: 0000000000001308 x16: 0000000000000002 
> [   29.432058] x15: 0000000000000000 x14: 7261656e696c2d6e 
> [   29.432086] x13: ffff600000bfdee7 x12: 1fffe00000bfdee6 
> [   29.432113] x11: 1fffe00000bfdee6 x10: ffff600000bfdee6 
> [   29.432141] x9 : ffff80001020a928 x8 : ffff000005fef737 
> [   29.432169] x7 : 0000000000000001 x6 : ffff600000bfdee7 
> [   29.432196] x5 : ffff600000bfdee7 x4 : 1fffe00000bfdedc 
> [   29.432223] x3 : 1fffe00000be4009 x2 : ffff600000bfdf5c 
> [   29.432251] x1 : 8fd448c3d76ca800 x0 : 0000000000000000 
> [   29.432279] Call trace:
> [   29.432294]  __virt_to_phys+0x80/0xc0
> [   29.432312]  kvm_compute_layout+0x21c/0x264
> init_hyp_physvirt_offset at arch/arm64/kvm/va_layout.c:47
> (inlined by) kvm_compute_layout at arch/arm64/kvm/va_layout.c:82
> [   29.432327]  smp_cpus_done+0x164/0x17c
> [   29.432342]  smp_init+0xc4/0xd8
> [   29.432358]  kernel_init_freeable+0x4ec/0x734
> [   29.432375]  kernel_init+0x18/0x12c
> [   29.432391]  ret_from_fork+0x10/0x1c
> [   29.432405] irq event stamp: 490612
> [   29.432424] hardirqs last  enabled at (490611): [<ffff800010207f60>] console_unlock+0x8e0/0xca0
> [   29.432440] hardirqs last disabled at (490612): [<ffff800011212f44>] el1_dbg+0x24/0x50
> [   29.432455] softirqs last  enabled at (487946): [<ffff800010010a98>] _stext+0xa98/0x113c
> [   29.432473] softirqs last disabled at (487939): [<ffff8000100ec5e8>] irq_exit+0x500/0x5e0
> [   29.432492] ---[ end trace 96247b4cbbdf9333 ]---
> 

Thanks for the report, I've been able to reproduce with CONFIG_DEBUG_VIRTUAL=y
and the kernel running in EL2. Doesn't pose any functional issues as the results
of this are never used. I'll post a fix later today.

David


