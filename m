Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E402E2F9AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbhARIID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:08:03 -0500
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:56604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733285AbhARIHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:07:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 93B0D1800BC3D;
        Mon, 18 Jan 2021 08:07:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3873:4321:4385:5007:6119:7652:7903:9010:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12663:12740:12760:12895:13439:13972:14096:14097:14659:14721:21080:21433:21451:21627:21740:21987:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: twig35_0f0e18727547
X-Filterd-Recvd-Size: 3611
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jan 2021 08:07:08 +0000 (UTC)
Message-ID: <5f204c6bde4324cd73ab9b6f6b5bf9d436e30abe.camel@perches.com>
Subject: Re: [PATCH] mm/memcontrol: Remove unneeded semicolons
From:   Joe Perches <joe@perches.com>
To:     Chengyang Fan <cy.fan@huawei.com>, akpm@linux-foundation.org
Cc:     richard.weiyang@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <0e528801-78ed-e71c-1237-648a86f0791c@huawei.com>
References: <20210118015229.2599778-1-cy.fan@huawei.com>
         <0037bf34a326f44585c634d346c8134cf9efc062.camel@perches.com>
         <0e528801-78ed-e71c-1237-648a86f0791c@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Sun, 17 Jan 2021 23:03:29 -0800
User-Agent: Evolution 3.38.1-1 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-18 at 11:18 +0800, Chengyang Fan wrote:
> I'm doing the work.

Good, thank you.
 
> Should I submit patches individually or together?

I believe you should submit multiple patches, one for each subsystem.

For instance, a single patch should change all of:

> arch/powerpc/include/asm/book3s/32/mmu-hash.h:static inline void cleanup_cpu_mmu_context(void) { };
> arch/powerpc/include/asm/book3s/64/mmu.h:static inline void radix_init_pseries(void) { };
> arch/powerpc/include/asm/firmware.h:static inline void pseries_probe_fw_features(void) { };
> arch/powerpc/include/asm/kvm_ppc.h:static inline void kvmppc_alloc_host_rm_ops(void) {};
> arch/powerpc/include/asm/kvm_ppc.h:static inline void kvmppc_free_host_rm_ops(void) {};
> arch/powerpc/include/asm/kvm_ppc.h:static inline void kvmppc_free_pimap(struct kvm *kvm) {};
> arch/powerpc/include/asm/paca.h:static inline void allocate_paca_ptrs(void) { };
> arch/powerpc/include/asm/paca.h:static inline void allocate_paca(int cpu) { };
> arch/powerpc/include/asm/paca.h:static inline void free_unused_pacas(void) { };
> arch/powerpc/include/asm/rtas.h:static inline void rtas_initialize(void) { };
> arch/powerpc/include/asm/setup.h:static inline void setup_barrier_nospec(void) { };
> arch/powerpc/include/asm/setup.h:static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
> arch/powerpc/include/asm/setup.h:static inline void setup_spectre_v2(void) {};
> arch/powerpc/include/asm/simple_spinlock.h:static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
> arch/powerpc/include/asm/simple_spinlock.h:static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
> arch/powerpc/include/asm/smp.h:static inline void smp_release_cpus(void) { };
> arch/powerpc/include/asm/xmon.h:static inline void xmon_setup(void) { };
> arch/powerpc/include/asm/xmon.h:static inline void xmon_register_spus(struct list_head *list) { };
> arch/powerpc/kernel/prom.c:static inline void save_fscr_to_task(void) {};
> arch/powerpc/kernel/setup.h:static inline void setup_power_save(void) { };
> arch/powerpc/kernel/setup.h:static inline void check_smt_enabled(void) { };
> arch/powerpc/kernel/setup.h:static inline void setup_tlb_core_data(void) { };
> arch/powerpc/kernel/setup.h:static inline void exc_lvl_early_init(void) { };
> arch/powerpc/kernel/setup.h:static inline void emergency_stack_init(void) { };
> arch/powerpc/kernel/setup.h:static inline void kvm_cma_reserve(void) { };
> arch/powerpc/platforms/powernv/subcore.h:static inline void update_subcore_sibling_mask(void) { };
> arch/powerpc/platforms/pseries/pseries.h:static inline void smp_init_pseries(void) { };

