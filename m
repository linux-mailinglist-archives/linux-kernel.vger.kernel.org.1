Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E832294D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437855AbgJUNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437716AbgJUNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603286302;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=0pHY+wGwa9VFDptn+0FQl0b/+iEnMoniGYleut0VOrE=;
        b=RENUwI9yKN9oNjAPT9/98b+VsnFsNDEO3yshg1JbFR52WFYgTX7bY1Wtnk3/exi+/2QeSy
        pZZXdrf2TgcCnu+1ufkurAcNDuQ2jaA194X9pXMLa1AYdxqWVKLSRLDlcWnv/aftT5d6fN
        NouzvWX2Yrp6fEzR7NJKh+zixyrk2CY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-shLH6zRwNluGaCf_dsgWHA-1; Wed, 21 Oct 2020 09:18:18 -0400
X-MC-Unique: shLH6zRwNluGaCf_dsgWHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFDD7106B387;
        Wed, 21 Oct 2020 13:18:15 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E53F560DA0;
        Wed, 21 Oct 2020 13:18:14 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 09LDIBR4032493;
        Wed, 21 Oct 2020 15:18:11 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 09LDI6Rj032492;
        Wed, 21 Oct 2020 15:18:06 +0200
Date:   Wed, 21 Oct 2020 15:18:06 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com,
        linux@rasmusvillemoes.dk, linux-toolchains@vger.kernel.org
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
Message-ID: <20201021131806.GA2176@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net>
 <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
 <20201021080031.GY2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021080031.GY2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:00:31AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2020 at 04:39:38PM -0700, Florian Fainelli wrote:
> > This patch causes all files under kernel/sched/* that include sched.h to
> > be rebuilt whenever the value of CONFIG_BLK_DEV_INITRD. There are at
> > least two build systems (buildroot and OpenWrt) that toggle this
> > configuration value in order to produce a kernel image without an
> > initramfs, and one with.
> > 
> > On ARM we get all of these to be needlessly rebuilt:
> 
> Is it really ARM specific? AFAICT this should happen on everything.
> 
> > Short of moving the STRUCT_ALIGNMENT to a separate header that would not
> > be subject to any configuration key change, can you think of a good way
> > to avoid these rebuilds, including for architectures like ARM that ship
> > their own vmlinux.lds.h? I would not say this is a bug, but it is
> > definitively an inconvenience.
> 
> Well, no :/ I barely made it work in the first place. This linker cruft
> is not my forte. GCC-4.9 being 'special' here is just weird in any case.
> 
> We can ask our friends on linux-toolchains; maybe they'll have a clue.
> 
> Guys, the problem is the below commit which, for dubious raisins makes
> kernel/sched/sched.h depend on asm-generic/vmlinux.lds.h and triggers
> rebuilds whenever a CONFIG mentioned in asm-generic/vmlinux.lds.h
> changes.
> 
> Is there an explanation for why GCC-4.9 is weird and is there a better
> way to find the appropriate value?

I have only looked at x86.
If you are talking about:
struct sched_class {
#define A(n) void (*n) (void);
#define B(n) A(n##0) A(n##1) A(n##2) A(n##3) A(n##4)
  B(fn1) B(fn2) B(fn3) B(fn4)
  A(fn50) A(fn51) A(fn52) A(fn53)
} __attribute__((aligned(32)));

struct sched_class a;

having the the variable aligned to 64 bytes rather than 32 bytes, it
started with
https://gcc.gnu.org/r0-127405-gd3c2fee09607e7d70cc7e69822638fab2bda6c7b
and disappeared with
https://gcc.gnu.org/r5-5887-g239711f6afe3070a11c4f1d9266588e8db1217ee

As the aligned attribute is just on the type and not on the actual
variables, I don't consider it a bug, GCC only guarantees it when
the variable itself has user specified alignment.
Otherwise the compiler can choose to align variables more if they
are large for performance reasons (to help vectorization e.g. when
the variable is copied around).  Plus the ABI sometimes requires
bigger alignment too (e.g. on x86_64 the psABI
says that array variables larger than 15 bytes must have alignment at least
16 bytes).

So, if you tweak the above testcase to have either
struct sched_class a __attribute__((aligned(32)));
or even remove it also from the sched_class struct, you should get
the behavior you want even from GCC 4.9 and other GCC versions.

And, if e.g. 32-byte alignment is not what you really need, but e.g.
natural alignment of the struct sched_class would be sufficient, you could
use __attribute__((aligned (alignof (struct sched_class)))) on the variables
instead (perhaps wrapped in some macro).

BTW, the 32 vs. 64 vs. whatever else byte alignment is heavily architecture
and GCC version dependent, it is not that on all arches larger structures
will be always 32 byte aligned no matter what.

>     Fixes: c3a340f7e7ea ("sched: Have sched_class_highest define by vmlinux.lds.h")
>     Reported-by: kernel test robot <lkp@intel.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lkml.kernel.org/r/20200630144905.GX4817@hirez.programming.kicks-ass.net
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 66fb84c3dc7e..3ceb4b7279ec 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -108,6 +108,17 @@
>  #define SBSS_MAIN .sbss
>  #endif
>  
> +/*
> + * GCC 4.5 and later have a 32 bytes section alignment for structures.
> + * Except GCC 4.9, that feels the need to align on 64 bytes.
> + */
> +#if __GNUC__ == 4 && __GNUC_MINOR__ == 9
> +#define STRUCT_ALIGNMENT 64
> +#else
> +#define STRUCT_ALIGNMENT 32
> +#endif
> +#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
> +
>  /*
>   * The order of the sched class addresses are important, as they are
>   * used to determine the order of the priority of each sched class in
> @@ -123,13 +134,6 @@
>  	*(__stop_sched_class)			\
>  	__end_sched_classes = .;
>  
> -/*
> - * Align to a 32 byte boundary equal to the
> - * alignment gcc 4.5 uses for a struct
> - */
> -#define STRUCT_ALIGNMENT 32
> -#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
> -
>  /* The actual configuration determine if the init/exit sections
>   * are handled as text/data or they can be discarded (which
>   * often happens at runtime)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5aa6661ecaf1..9bef2dd01247 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -67,6 +67,7 @@
>  #include <linux/tsacct_kern.h>
>  
>  #include <asm/tlb.h>
> +#include <asm-generic/vmlinux.lds.h>
>  
>  #ifdef CONFIG_PARAVIRT
>  # include <asm/paravirt.h>
> @@ -1810,7 +1811,7 @@ struct sched_class {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	void (*task_change_group)(struct task_struct *p, int type);
>  #endif
> -} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
> +} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
>  
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>  {
> 

	Jakub

