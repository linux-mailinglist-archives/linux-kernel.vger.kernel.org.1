Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB1285CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgJGKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728045AbgJGKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602066053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5L7RqrTGay7HbZcNQSWbJzLb7RkfE/YXz+TNWyeK64k=;
        b=F0YMkeoNvLE4CN0EBEJAEwFEVkPUHeG/Hme/8OVU1YcVOvcjIOrFK9rjZ+LmHnh1WH1z9b
        YeMgiZPXOW1OBQctfGXOGXdXT1oy/Iv+nu049AoUcquZF54UPoCCp/J2MTbtelqdvSKzXV
        s1HRJNGL/AY4anBZ5KvpyK1mkzAKiBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-CPKgesjlOUG72MwykUnfGg-1; Wed, 07 Oct 2020 06:20:49 -0400
X-MC-Unique: CPKgesjlOUG72MwykUnfGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C587357051;
        Wed,  7 Oct 2020 10:20:46 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-154.ams2.redhat.com [10.36.113.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E4B88CD22;
        Wed,  7 Oct 2020 10:20:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: Control Dependencies vs C Compilers
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
        <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
        <20201007093243.GB2628@hirez.programming.kicks-ass.net>
Date:   Wed, 07 Oct 2020 12:20:41 +0200
In-Reply-To: <20201007093243.GB2628@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 7 Oct 2020 11:32:43 +0200")
Message-ID: <87k0w2gww6.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> On Tue, Oct 06, 2020 at 11:20:01PM +0200, Florian Weimer wrote:
>> * Peter Zijlstra:
>> 
>> > Our Documentation/memory-barriers.txt has a Control Dependencies section
>> > (which I shall not replicate here for brevity) which lists a number of
>> > caveats. But in general the work-around we use is:
>> >
>> > 	x = READ_ONCE(*foo);
>> > 	if (x > 42)
>> > 		WRITE_ONCE(*bar, 1);
>> >
>> > Where READ/WRITE_ONCE() cast the variable volatile. The volatile
>> > qualifier dissuades the compiler from assuming it knows things and we
>> > then hope it will indeed emit the branch like we'd expect.
>> >
>> >
>> > Now, hoping the compiler generates correct code is clearly not ideal and
>> > very dangerous indeed. Which is why my question to the compiler folks
>> > assembled here is:
>> >
>> >   Can we get a C language extention for this?
>> 
>> For what exactly?
>
> A branch that cannot be optimized away and prohibits lifting stores
> over. One possible suggestion would be allowing the volatile keyword as
> a qualifier to if.
>
> 	x = *foo;
> 	volatile if (x > 42)
> 		*bar = 1;
>
> This would tell the compiler that the condition is special in that it
> must emit a conditional branch instruction and that it must not lift
> stores (or sequence points) over it.

But it's not the if statement, but the expression in it, right?  So this
would not be a valid transformation:

 	x = *foo;
        bool flag = x > 42;
 	volatile if (flag)
 		*bar = 1;

And if we had this:

 	unsigned x = *foo;
 	volatile if (x >= 17 && x < 42)
 		*bar = 1;

Would it be valid to transform this into (assuming that I got the
arithmetic correct):

 	unsigned x = *foo;
 	volatile if ((x - 17) < 25)
 		*bar = 1;

Or would this destroy the magic because arithmetic happens on the value
before the comparison?

>> But not using READ_ONCE and WRITE_ONCE?
>
> I'm OK with READ_ONCE(), but the WRITE_ONCE() doesn't help much, if
> anything. The compiler is always allowed to lift stores, regardless of
> the qualifiers used.

I would hope that with some level of formalization, it can be shown that
no additional synchronization is necessary beyond the load/conditional
sequence.

>> I think in GCC, they are called __atomic_load_n(foo, __ATOMIC_RELAXED)
>> and __atomic_store_n(foo, __ATOMIC_RELAXED).  GCC can't optimize relaxed
>> MO loads and stores because the C memory model is defective and does not
>> actually guarantee the absence of out-of-thin-air values (a property it
>> was supposed to have).
>
> AFAIK people want to get that flaw in the C memory model fixed (which to
> me seemd like a very good idea).

It's been a long time since people realized that this problem exists,
with several standard releases since then.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

