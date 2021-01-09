Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699E92EFD34
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAICvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:51:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbhAICvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610160625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpRaGiHP2x0MED8zknWz53VS2At9Ea/8p/aSfJfhtNw=;
        b=izCxJzg1CRPpbEob5AqCGrGJPVH+79R7pUDk8Iy0ovSFkW8J1YDqBl9QzfJuwSrNZOcQPr
        jAr6C2zfigWmhneMNf7lDcQ5wAVHtlDFQ19AxEpHHdKLS+JI+6soLdQM9qnB2nPU8sf5N4
        Ocp/7Wmlhs4uw7mTFa96jaRh1AltQ5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-WJTO5fA8O7WiRKOY3qs-LA-1; Fri, 08 Jan 2021 21:50:21 -0500
X-MC-Unique: WJTO5fA8O7WiRKOY3qs-LA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4434410054FF;
        Sat,  9 Jan 2021 02:50:18 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71A1A19C48;
        Sat,  9 Jan 2021 02:50:09 +0000 (UTC)
Date:   Fri, 8 Jan 2021 21:50:08 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <X/kZ4ETE6LR8jpug@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
 <X/jgLGPgPb+Xms1t@redhat.com>
 <20210109004255.GG504133@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109004255.GG504133@ziepe.ca>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jason,

On Fri, Jan 08, 2021 at 08:42:55PM -0400, Jason Gunthorpe wrote:
> There is already a patch series floating about to do exactly that for
> FOLL_LONGTERM pins based on the existing code in GUP for CMA migration

Sounds great.

> The ship sailed on this a decade ago, it is completely infeasible to
> go back now, it would completely break widely used things like GPU,
> RDMA and more.

For all those that aren't using mmu notifier and that rely solely on
page pins, they still require privilege, except they do through /dev/
permissions.

Just the fact there's no capability check in the read/write/ioctl
doesn't mean those device inodes can be opened any luser: the fact the
kernel allows it, doesn't mean the /dev/ permission does too. The same
applies to /dev/kvm too, not just PCI device drivers.

Device drivers that you need to open in /dev/ before you can take a
GUP pin require whole different checks than syscalls like vmsplice and
io_uring that are universally available.

The very same GUP long term pinning kernel code can be perfectly safe
to use without any permission check for a device driver of an iommu in
/dev/, but completely unsafe for a syscall.

> If we want to have a high speed copy_from_user like thing that is not
> based on page pins but on mmu notifiers, then we should make that
> infrastructure and the various places that need it should use common
> code. At least vhost and io_uring are good candidates.

Actually the mmu notifier doesn't strictly require pins, it only
requires GUP. All users tend to use FOLL_GET just as a safety
precaution (I already tried to optimize away the two atomics per GUP,
but we were naked by the KVM maintainer that didn't want to take the
risk, I would have, but it's a fair point indeed, obviously it's safer
with the pin plus the mmu notifier, two is safer than one).

I'm not sure how any copy-user could obviate a secondary MMU mapping,
mappings and copies are mutually exclusive. Any copy would be breaking
memory coherency in this environment.

> Otherwise, we are pretending that they are DMA and using the DMA
> centric pin_user_pages() interface, which we still have to support and
> make work.

vhost and io_uring would be pure software constructs, but there are
hardware users of the GUP pin that don't use any DMA.

The long term GUP pin is not only about PCI devices doing DMA. KVM is
not ever using any DMA, despite it takes terabytes worth of very long
term GUP pins.

> > In any case, the extra flags required in FOLL_LONGTERM should be
> > implied by FOLL_LONGTERM itself, once it enters the gup code, because
> > it's not cool having to FOLL_WRITE in all drivers for a GUP(write=0),
> > let alone having to specify FOLL_FORCE for just a read. But this is
> > going offtopic.
> 
> We really should revise this, I've been thinking for a while we need
> to internalize into gup.c the FOLL_FORCE|FOLL_WRITE|FOLL_LONGTERM
> idiom at least..

100% agreed.

> > > simply because it is using the CPU to memory copy as its "DMA".
> > 
> > vmsplice can't find all put_pages that may release the pages when the
> > pipe is read, or it'd be at least be able to do the unreliable
> > RLIMIT_MEMLOCK accounting.
> 
> Yikes! So it can't even use pin_user_pages FOLL_LONGTERM properly
> because that requires unpin_user_pages(), which means finding all the
> unpin sites too :\

Exactly.

> > To make another example a single unprivileged pin on the movable zone,
> > can break memhotunplug unless you use the mmu notifier. Every other
> > advanced feature falls apart.
> 
> As above FOLL_LONGTERM will someday migrate from movable zones.

Something like:

1) migrate from movable zones contextually to GUP

2) be accounted on the compound_order not on the number of GUP
   (io_uring needs fixing here)

3) maybe account not only in rlimit, but also expose the total worth
   of GUP pins in page_order units (not pins) to the OOM killer to be
   added to the rss (will double count though).

Maybe 3 is overkill but without it, OOM killer won't even see those
GUP pin coming, so if not done it's still kind of unsafe, if done
it'll risk double count.

Even then a GUP pin, still prevents optimization, it can't converge in
the right NUMA node the io ring just to make an example, but that's a
secondary performance concern.

The primary concern with the mmu notifier in io_uring is the
take_all_locks latency.

Longlived apps like qemu would be fine with mmu notifier. The main
question is also if there's any short-lived latency io_uring
usage... that wouldn't fly with take_all_locks.

The problem with the mmu notifier as an universal solution, for
example is that it can't wait for I/O completion of O_DIRECT since it
has no clue where the put_page is to wait for it, otherwise we could
avoid even the FOLL_GET for O_DIRECT and guarantee the I/O has to be
completed before paging or anything can unmap the page under I/O from
the pagetable.

Even if we could reliably identify all the put_page of transient pins
reliably, it would need to be always on. Currently we go the extra
mile to require zero exclusive cachelines when it's unregistered and
that makes the registering a latency outlier.

> The fact that people keep adding MM features that are incompatible
> with FOLL_LONGTERM is troublesome.

Ehm in my view it's actually FOLL_LONGTERM without ability to use the
mmu notifier that is troublesome :). It's funny how we look at the two
opposite sides of the same coin.

I'm sure there will be devices doing that will for a very long time,
but they don't need to be perfect, the current handling is
satisfactory, and we can do a best effort to improve things are
described above but it's not critical.

> However, the people who want hot-pluggable DIMMS don't get to veto the
> people who want RDMA, GPU and so on out of the kernel. (or vice versa)
>
> It seems we will end up with a MM where some work loads will be
> incompatible with some MM features.

I see the incompatibility you describe as problem we have today, in
the present, and that will fade with time.

Reminds me when we had >4G of RAM and 32bit devices doing DMA. How
many 32bit devices are there now?

We're not talking here about any random PCI device, we're talking here
about very special and very advanced devices that need to have "long
term" GUP pins in order to operate, not the usual nvme/gigabit device
where GUP pins are never long term.

> We also don't do a good job uniformly tracking rmlimit/etc. I'd
> ideally like to see that in the core code too. Someone once tried that
> a bit but we couldn't ge agreement what the right thing was because
> different drivers do different things. Sigh.

Consolidating would be great I agree.

> > Any transient GUP pin no matter which fancy API you use to take it, is
> > enough to open the window for the above attack, not just FOLL_LONGERM.
> 
> Yes, that is interesting. We've always known that the FOLL_LONGTERM
> special machinery is techincally needed for O_DIRECT and basically all
> other cases for coherence, but till now I hand't heard of a security
> argument. It does make sense :(

The security argument is really specific to such case described, and
ideally whatever fix we do to close all windows, would cover all
O_DIRECT too.

> > For those with the reproducer for the bug fixed in
> > 17839856fd588f4ab6b789f482ed3ffd7c403e1f here's the patch to apply to
> > reproduce it once on v5.11 once again:
> 
> So this is still at least because vmsplice is buggy to use plain
> get_user_pages() for it's long term usage, and buggy to not use the
> FOLL_FORCE|FOLL_WRITE idiom for read :\
> 
> A small patch to make vmsplice set those flags on its gup would at
> least robustly close this immediate security problem without whatever
> side effects caused the revert of commit forcing that in GUP iteself.

Exactly, if we fix vmsplice, and we close the biggest window, what
remains is so small it shouldn't be practical.

We still have to close all windows then.

> > You're thinking at your use case only.
> 
> I'm thinking about the rules to make pin_user_pages(FOLL_LONGTERM)
> sane and working, yes. It is an API we have that is used widely, and
> really needs a solid definition. This idea we can just throw it out
> completely is a no-go to me.
> 
> There are other similar APIs, like normal GUP, hmm_range_fault, and so

hmm depends on mmu notifier so there's no VM interference there.

> on, but these are different things, with different rules.

I'm not suggesting to throw out anything.

It's like if you got a 32bit device, you did bounce buffers. If you
got a CPU without MMU you got to deal with MMU=n. How many Linux VM
features you can use MMU=n? Is it mlock accounting required with Linux
built with MMU=n? (I'd be shocked if it can actually build but still)

You have to live with the limitations the hardware delivers.

vmsplice and io_uring have no limitation and zero hardware constraint,
so they've not a single valid justification, unlike device drivers, in
addition their access cannot be controlled through /dev/ permission
like it happens regularly for all device drivers.

> > Thinking long term GUP pin is read-write DMA is very reductive.
> >
> > There doesn't need to be DMA at all.
> > 
> > KVM and a shadow MMU can attach to the RAM in readonly totally
> > fine. And if it writes, it'll write not through the PCI bus, still
> > with the CPU access.
> 
> That is not gup FOLL_LONGTERM, that is mmu notifiers..

Correct. Although KVM initially used the equivalent of FOLL_LONGTERM
back then. Then KVM become the primary MMU Notfifier user of course.

The only difference between FOLL_LONGTERM and mmu notifier, is if the
hardware is capable of handling it. There is no real difference other
than that.

> mmu notifier users who are using hmm_range_fault() do not ever take any
> page references when doing their work, that seems like the right
> approach, for a shadow mmu?

They all can do like HMM or you can take the FOLL_GET as long as you
remember put_page.

Jerome also intended to optimize the KVM fault like that, but like
said above, we were naked on that attempt.

If there is the pin or not makes zero semantical difference, it's
purely an optimization when there is no pin, and it's a bugcheck
safety feature if there is the pin.

By the time it can make a runtime difference if there is the pin or
not, put_page has been called already.

> > Nothing at all can go wrong, unless wp_copy_page suddenly makes the
> > secondary MMU go out of sync the moment you wrprotect the page with
> > clear_refs.
> 
> To be honest, I've read most of this discussion, and the prior one,
> between you and Linus carefully, but I still don't understand what
> clear_refs is about or how KVM's use of mmu notifiers got broken. This
> is probably because I'm only a little familiar with those areas :\

KVM use of mmu notifier is not related to this.

clear_refs simply can wrprotect the page. Of any process. echo
.. >/proc/self/clear_refs. Then you check in /proc/self/pagemap looking
for soft dirty (or something like that).

The point is that if you do echo ... >/proc/self/clear_refs on your
pid, that has any FOLL_LONGTERM on its mm, it'll just cause your
device driver to go out of sync with the mm. It'll see the old pages,
before the spurious COWs. The CPU will use new pages (the spurious
COWs).

> Is it actually broken or just inefficient? If wp_copy_page is going
> more often than it should the secondary mmu should still fully track
> that?

It's about the DMA going out of sync and losing view of the mm.

In addition the TLB flush broke with the mmu_read_lock but that can be
fixed somehow.

The TLB flush, still only because of the spurious COWs, has now to
cope with the fact that there can be spurious wp_page_copy right after
wrprotecting a read-write page. Before that couldn't happen, fork()
couldn't run since it takes mmap_write_lock, so if the pte was
writable and transitioned to non-writable it'd mean it was a exclusive
page and it would be guaranteed re-used, so the stale TLB would keep
writing in place.

The stale TLB is the exact same equivalent of your FOLL_LONGTERM,
except it's the window the CPU has on the old page, the FOLL_LONGTERM
is the window the PCI device has on the old page. The spurious COW is
what makes TLB and PCI device go out of sync reading and writing to
the old page, while the CPU moved on to a new page. The issue is
really similar.

> To be clear, here I am only talking about pin_user_pages. We now have
> logic to tell if a page is under pin_user_pages(FOLL_LONGTERM) or not,
> and that is what is driving the copy on fork logic.

fork() wrprotects and like every other wrprotect, was just falling in
the above scenario.

> secondary-mmu drivers using mmu notifier should not trigger this logic
> and should not restrict write protect.

That's a great point. I didn't think the mmu notifier will invalidate
the secondary MMU and ultimately issue a GUP after the wp_copy_page to
keep it in sync.

The funny thing that doesn't make sense is that wp_copy_page will only
be invoked because the PIN was left by KVM on the page for that extra
safety I was talking about earlier.

Are we forced to drop all the page pins to be able to wrprotect the
memory without being flooded by immediate COWs?

So the ultimate breakpoint, is the FOLL_LONGTERM and no mmu notifier
to go out of sync on a wrprotect, which can happen if the device is
doing a readonly access long term.

I quote you earlier:

"A long term page pin must
use pin_user_pages(), and either FOLL_LONGTERM|FOLL_WRITE (write mode)
FOLL_LONGTERM|FOLL_FORCE|FOLL_WRITE (read mode)"

You clearly contemplate the existance of a read mode, long term. That
is also completely compatible with wrprotection. Why should we pick a
model that forbids this to work? What do we get back from it? I only
see unnecessary risk and inefficiencies coming back from it.
 
> > Ultimately, what do we really gain from all this breakage?
> 
> Well, the clean definition of pin_user_pages(FOLL_LONGTERM) is very
> positive for DMA drivers working in that area.

I was referring to page_count in do_wp_page, not pin_user_pages sorry
for the confusion.

Thanks,
Andrea

