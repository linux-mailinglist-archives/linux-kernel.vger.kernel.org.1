Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510C5303FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405734AbhAZOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:12:57 -0500
Received: from foss.arm.com ([217.140.110.172]:41858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392684AbhAZOMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:12:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFD6106F;
        Tue, 26 Jan 2021 06:11:55 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.45.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33073F68F;
        Tue, 26 Jan 2021 06:11:50 -0800 (PST)
Date:   Tue, 26 Jan 2021 14:11:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [RFC PATCH 1/2] arm64/cpuinfo: Move init_cpu_features() ahead of
 setup.c::early_fixmap_init()
Message-ID: <20210126141148.GC80448@C02TD0UTHF1T.local>
References: <20210113014047.14371-1-justin.he@arm.com>
 <20210113014047.14371-2-justin.he@arm.com>
 <20210126135712.GA29956@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126135712.GA29956@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:57:13PM +0000, Will Deacon wrote:
> > @@ -297,16 +297,20 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >  	 */
> >  	arm64_use_ng_mappings = kaslr_requires_kpti();
> >  
> > -	early_fixmap_init();
> > -	early_ioremap_init();
> > -
> > -	setup_machine_fdt(__fdt_pointer);
> > -
> >  	/*
> >  	 * Initialise the static keys early as they may be enabled by the
> >  	 * cpufeature code and early parameters.
> >  	 */
> >  	jump_label_init();
> 
> I don't think your patch changes this, but afaict jump_label_init() uses
> per-cpu variables via cpus_read_lock(), yet we don't initialise our offset
> until later on. Any idea how that works?

We initialize the boot CPU's offset twice during boot, once before this
in smp_setup_processor_id(), and once afterwards in
smp_prepare_boot_cpu() since setup_per_cpu_areas() will allocate a new
region for CPU0.

IIUC per-cpu writes before smp_prepare_boot_cpu() are potentially dodgy
since they might be copied to other CPUs, but reads are all fine.

Mark.
