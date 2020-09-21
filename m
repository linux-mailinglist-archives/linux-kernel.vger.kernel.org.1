Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59C3273101
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIURoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbgIURoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:44:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2313C2151B;
        Mon, 21 Sep 2020 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600710247;
        bh=Arof+t7RZMesEWYOG0q/K65qTQSUsR3YSbeXtjQZtLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdj8QUY35DLXeadsX8mhIaX+uEoxr9k8Ugskr/fkdQdqVBAICA5hNRdZdrCjpDgSM
         OuGT+vQnC241+3LLy4YbvGKg+kv54dVMqHgO+mo0MT3UyQII9JNlSW8Ub8b3g+D+QO
         DAvj1xOoVEu4RWszeCUqjt9jWgCvdI6cP124z5p8=
Date:   Mon, 21 Sep 2020 18:43:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20200921174357.GB3141@willie-the-truck>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
 <CAG_fn=WKaY9MVmbpkgoN4vaJYD_T_A3z2Lgqn+2o8-irmCKywg@mail.gmail.com>
 <CAG_fn=XV7JfJDK+t1X6bnV6gRoiogNXsHfww0jvcEtJ2WZpR7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XV7JfJDK+t1X6bnV6gRoiogNXsHfww0jvcEtJ2WZpR7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:37:10PM +0200, Alexander Potapenko wrote:
> On Mon, Sep 21, 2020 at 4:58 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 4:31 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Sep 21, 2020 at 03:26:04PM +0200, Marco Elver wrote:
> > > > Add architecture specific implementation details for KFENCE and enable
> > > > KFENCE for the arm64 architecture. In particular, this implements the
> > > > required interface in <asm/kfence.h>. Currently, the arm64 version does
> > > > not yet use a statically allocated memory pool, at the cost of a pointer
> > > > load for each is_kfence_address().
> > > >
> > > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Co-developed-by: Alexander Potapenko <glider@google.com>
> > > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > > For ARM64, we would like to solicit feedback on what the best option is
> > > > to obtain a constant address for __kfence_pool. One option is to declare
> > > > a memory range in the memory layout to be dedicated to KFENCE (like is
> > > > done for KASAN), however, it is unclear if this is the best available
> > > > option. We would like to avoid touching the memory layout.
> > >
> > > Sorry for the delay on this.
> >
> > NP, thanks for looking!
> >
> > > Given that the pool is relatively small (i.e. when compared with our virtual
> > > address space), dedicating an area of virtual space sounds like it makes
> > > the most sense here. How early do you need it to be available?
> >
> > Yes, having a dedicated address sounds good.
> > We're inserting kfence_init() into start_kernel() after timekeeping_init().
> > So way after mm_init(), if that matters.
> 
> The question is though, how big should that dedicated area be?
> Right now KFENCE_NUM_OBJECTS can be up to 16383 (which makes the pool
> size 64MB), but this number actually comes from the limitation on
> static objects, so we might want to increase that number on arm64.

What happens on x86 and why would we do something different?

Will
