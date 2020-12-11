Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93D2D6D32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404716AbgLKBT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404583AbgLKBTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:19:48 -0500
Date:   Thu, 10 Dec 2020 17:19:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607649547;
        bh=3W2W+rGIeNaXbjG1HP2s6JLeC/WjEnIZHx99yIMnGxA=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eFBlm2QilwBLfidOTSf9nn5IOkFe9eBzVFRC9CwL3sMEoaQiCNEuU9C73V5MaHaa9
         TXB5SR7Ax3mGhdRLNzF62m619jpVH20mROtOICVErLbWBz5EctUV7hCkNRKUfML9Wi
         YYHC3lnR+Cd/zMHPmyUq0+UeFuWoMSOrH9huurL4mGnmQ44HkSKWwCYnlTneK9NfVD
         hSj1NXX8nsGM2c0qHjJwgz2yw7VgNGT1SMpi1mn91zxlutTTEsxrDhV/zGqLmVuP8f
         nyb2sKM1y8wxe6GhZ46iwvxDfj9P6tzV/wjdyYtlVFIIUaGkYU53NbkDfvepf5DY5M
         INKx3jGRMp9TQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC v2 sl-b] Export return addresses etc. for better
 diagnostics
Message-ID: <20201211011907.GA16110@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
 <20201209011124.GA31164@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209011124.GA31164@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is v3 of the series the improves diagnostics by providing access
to additional information including the return addresses, slab names,
offsets, and sizes collected by the sl*b allocators and by vmalloc().
If the allocator is not configured to collect this information, the
diagnostics fall back to a reasonable approximation of their earlier
state.

One use case is the queue_rcu_work() function, which might be used
by any number of kernel subsystems.  If the caller does back-to-back
invocations of queue_rcu_work(), this constitutes a double-free bug,
and (if so configured) the debug-objects system will flag this, printing
the callback function.  In most cases, printing this function suffices.
However, for double-free bugs involving queue_rcu_work(), the RCU callback
function will always be rcu_work_rcufn(), which provides almost no help to
the poor person trying to find this double-free bug.  The return address
from the allocator of the memory containing the rcu_work structure can
provide an additional valuable clue.

Another use case is the percpu_ref_switch_to_atomic_rcu() function,
which detects percpu_ref reference-count underflow.  Unfortunately,
the only data that this function has access to doesn't have much in the
way of identifying characteristics.  Yes, it might be possible to gain
more information from a crash dump, but it is more convenient for the
needed hints to be in the console log.

Unfortunately, printing the return address in this case is of little help
because this object is allocated from percpu_ref_init(), regardless of
what part of the kernel is responsible for the reference-count underflow
(though perhaps the slab and offsets might help in some cases).  However,
CONFIG_STACKTRACE=y kernels (such as those enabling ftrace) using slub
with debugging enabled also collect stack traces.  This series therefore
also provides a way of extracting these stack traces to provide additional
information to those debugging percpu_ref reference-count underflows.

The patches are as follows:

1.	Add mem_dump_obj() to print source of memory block.

2.	Make mem_dump_obj() handle NULL and zero-sized pointers.

3.	Make mem_dump_obj() handle vmalloc() memory.

4.	Make mem_obj_dump() vmalloc() dumps include start and length.

5.	Make call_rcu() print mem_dump_obj() info for double-freed
	callback.

6.	percpu_ref: Dump mem_dump_obj() info upon reference-count
	underflow.

Changes since v2:

o	Apply more feedback from Joonsoo Kim on naming and code structure.

o	Based on discussions with Vlastimil Babka, added code to print
	offsets and sizes where available.  This can help identify which
	structure is involved.

Changes since v1:

o	Apply feedback from Joonsoo Kim, mostly around naming and
	code structure.

o	Apply fix suggested by Stephen Rothwell for a bug that was
	also located by kbuild test robot.

o	Add support for vmalloc().

o	Add support for special pointers.

o	Additional rework simplifying use of mem_dump_obj(), which
	simplifies both the RCU and the percpu_ref uses.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/mm.h      |    2 +
 include/linux/slab.h    |    2 +
 include/linux/vmalloc.h |    6 +++
 kernel/rcu/tree.c       |    7 +++-
 lib/percpu-refcount.c   |   12 +++++--
 mm/slab.c               |   20 ++++++++++++
 mm/slab.h               |   12 +++++++
 mm/slab_common.c        |   74 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slob.c               |    6 +++
 mm/slub.c               |   36 +++++++++++++++++++++++
 mm/util.c               |   45 ++++++++++++++++++++++++-----
 mm/vmalloc.c            |   15 +++++++++
 12 files changed, 224 insertions(+), 13 deletions(-)
