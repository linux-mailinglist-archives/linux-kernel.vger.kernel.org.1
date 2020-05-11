Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD61CE5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbgEKUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:39:01 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:38690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729801AbgEKUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:39:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0A199100E7B43;
        Mon, 11 May 2020 20:39:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7903:7974:9010:9025:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:13845:14096:14097:14181:14659:14721:21080:21325:21451:21627:21811:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: duck20_4e5e081df3660
X-Filterd-Recvd-Size: 2939
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 20:38:58 +0000 (UTC)
Message-ID: <02b965de57774f393bb16d669164e0cef2497f2f.camel@perches.com>
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
From:   Joe Perches <joe@perches.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 13:38:57 -0700
In-Reply-To: <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
References: <20200508140724.11324-1-yuehaibing@huawei.com>
         <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
         <20200511161756.7586afe6@gandalf.local.home>
         <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 22:27 +0200, Christian Borntraeger wrote:
> On 11.05.20 22:17, Steven Rostedt wrote:
> > On Mon, 11 May 2020 08:07:51 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> > 
> > > Thanks for noticing, looks like i missed them.
> > > 
> > > Acked-by: Sven Schnelle <svens@linux.ibm.com>
> > 
> > As this is s390 specific, will it be going through the s390 repo?
> 
> Yes. 
> I will pick this up. Vasily will then take care of it.

Awhile back, I posted a list of apparently unused static inline
functions in .h files treewide found by a script:

https://lore.kernel.org/lkml/4603e761a5f39f4d97375e1e08d20d720c526341.camel@perches.com/

Here are the s390 entries:

arch/s390/include/asm/atomic_ops.h:138:static inline long __atomic64_cmpxchg_bool(long *ptr, long old, long new)
arch/s390/include/asm/bitops.h:278:static inline void __set_bit_inv(unsigned long nr, volatile unsigned long *ptr)
arch/s390/include/asm/bitops.h:283:static inline void __clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
arch/s390/include/asm/cpu_mcf.h:106:static inline int kernel_cpumcf_begin(void)
arch/s390/include/asm/cpu_mcf.h:114:static inline void kernel_cpumcf_end(void)
arch/s390/include/asm/ftrace.h:64:static inline int is_ftrace_nop(struct ftrace_insn *insn)
arch/s390/include/asm/kvm_para.h:146:static inline long kvm_hypercall5(unsigned long nr, unsigned long p1,
arch/s390/include/asm/kvm_para.h:175:static inline long kvm_hypercall6(unsigned long nr, unsigned long p1,
arch/s390/include/asm/pci_dma.h:134:static inline void invalidate_table_entry(unsigned long *entry)
arch/s390/include/asm/pci_dma.h:176:static inline int entry_isprotected(unsigned long entry)
arch/s390/include/asm/timex.h:52:static inline void store_clock_comparator(__u64 *time)


