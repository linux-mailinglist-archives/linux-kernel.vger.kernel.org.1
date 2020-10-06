Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83D12853CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgJFVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727301AbgJFVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602019216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNBCHKIIUAK6GMtL6RxhuqViZ7dVLOsyPe4fpK0/CX0=;
        b=CdH746+Ec3ZrwooTmXfoSm4g62L91jTmPYZasNxPEJhZOXbJej6s9oVNQjwbW0ScDdOD/f
        esYY1FPZgKnFxBiWrO8G4R0YCbLwwGGrQ1vLw7GvRa7zVi9nPlq62EpVpl1BZlWG+RUbes
        7/BoPv6d0LieVUmmZOSMM/NXcIwVYI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-Nxs8XvEZMwqHpGeuTbpfJg-1; Tue, 06 Oct 2020 17:20:10 -0400
X-MC-Unique: Nxs8XvEZMwqHpGeuTbpfJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B49E804039;
        Tue,  6 Oct 2020 21:20:07 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-154.ams2.redhat.com [10.36.113.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F886EF42;
        Tue,  6 Oct 2020 21:20:03 +0000 (UTC)
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
Date:   Tue, 06 Oct 2020 23:20:01 +0200
In-Reply-To: <20201006114710.GQ2628@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 6 Oct 2020 13:47:10 +0200")
Message-ID: <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> Our Documentation/memory-barriers.txt has a Control Dependencies section
> (which I shall not replicate here for brevity) which lists a number of
> caveats. But in general the work-around we use is:
>
> 	x = READ_ONCE(*foo);
> 	if (x > 42)
> 		WRITE_ONCE(*bar, 1);
>
> Where READ/WRITE_ONCE() cast the variable volatile. The volatile
> qualifier dissuades the compiler from assuming it knows things and we
> then hope it will indeed emit the branch like we'd expect.
>
>
> Now, hoping the compiler generates correct code is clearly not ideal and
> very dangerous indeed. Which is why my question to the compiler folks
> assembled here is:
>
>   Can we get a C language extention for this?

For what exactly?

Do you want a compiler that never simplifies conditional expressions
(like some people want compilers that never re-associate floating point
operations)?

With a bit of effort, we could prototype such a compiler and run
benchmarks against a kernel that was built using it.  But I'm not sure
if that's a good use of resources.

> And while we have a fair number (and growing) existing users of this in
> the kernel, I'd not be adverse to having to annotate them.

But not using READ_ONCE and WRITE_ONCE?

I think in GCC, they are called __atomic_load_n(foo, __ATOMIC_RELAXED)
and __atomic_store_n(foo, __ATOMIC_RELAXED).  GCC can't optimize relaxed
MO loads and stores because the C memory model is defective and does not
actually guarantee the absence of out-of-thin-air values (a property it
was supposed to have).  Obviously, actual implementations want to
provide this guarantee.  So it's really impossible right now to argue
about this in any formal way and determine the validity of optimizations
(which is why there are none, hopefully).

In standard C, there is <stdatomic.h>, but its relaxed MO loads and
stores can of course be optimized, so you'll need a compiler extension
here.

A different way of annotating this would be a variant of _Atomic where
plain accesses have relaxed MO, not seq-cst MO.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

