Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EFF2EB2C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbhAESrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:47:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbhAESrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609872342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8NqIDdXSh85bSTJED9R3b+J4jB6hK4TgsX+QO5RGH1Q=;
        b=BheIjQNTFlDF2/d9hroGp4T55KNVX6baqLShyR4Wro2tqnztxx2ZdFU75cC52Q9wJX/cfZ
        phaGD2h5fUnXeCmqUmUfHvX74B4dDYK1sO7GyxkrsmS6nT6ZoADcoA7wC2C33CdhcK/Uii
        rI77A8rOvX5Yt7KHGx4dIpHxuPoS4Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-GcXd1e0VOCKWNn2417F0Pg-1; Tue, 05 Jan 2021 13:45:40 -0500
X-MC-Unique: GcXd1e0VOCKWNn2417F0Pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A53800050;
        Tue,  5 Jan 2021 18:45:38 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0992D71CA4;
        Tue,  5 Jan 2021 18:45:35 +0000 (UTC)
Date:   Tue, 5 Jan 2021 13:45:34 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/SzzjREaoR9u7Ua@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
 <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:26:33PM +0000, Nadav Amit wrote:
> I would feel more comfortable if you provide patches for uffd-wp. If you
> want, I will do it, but I restate that I do not feel comfortable with this
> solution (worried as it seems a bit ad-hoc and might leave out a scenario
> we all missed or cause a TLB shootdown storm).
>
> As for soft-dirty, I thought that you said that you do not see a better
> (backportable) solution for soft-dirty. Correct me if I am wrong.

I think they should use the same technique, since they deal with the
exact same challenge. I will try to cleanup the patch in the meantime.

I can also try to do the additional cleanups to clear_refs to
eliminate the tlb_gather completely since it doesn't gather any page
and it has no point in using it.

> Anyhow, I will add your comments regarding the stale TLB window to make the
> description clearer.

Having the mmap_write_lock solution as backup won't hurt, but I think
it's only for planB if planA doesn't work and the only stable tree
that will have to apply this is v5.9.x. All previous don't need any
change in this respect. So there's no worry of rejects.

It worked by luck until Aug 2020, but it did so reliably or somebody
would have noticed already. And it's not exploitable either, it just
works stable, but it was prone to break if the kernel changed in some
other way, and it eventually changed in Aug 2020 when an unrelated
patch happened to the reuse logic.

If you want to maintain the mmap_write_lock patch if you could drop
the preserved_write and adjust the Fixes to target Aug 2020 it'd be
ideal. The uffd-wp needs a different optimization that maybe Peter is
already working on or I can include in the patchset for this, but
definitely in a separate commit because it's orthogonal.

It's great you noticed the W->RO transition of un-wprotect so we can
optimize that too (it will have a positive runtime effect, it's not
just theoretical since it's normal to unwrprotect a huge range once
the postcopy snapshotting of the virtual machine is complete), I was
thinking at the previous case discussed in the other thread.

I just don't like to slow down a feature required in the future for
implementing postcopy live snapshotting or other snapshots to userland
processes (for the non-KVM case, also unprivileged by default if using
bounce buffers to feed the syscalls) that can be used by open source
hypervisors to beat proprietary hypervisors like vmware.

The security concern of uffd-wp that allows to enlarge the window of
use-after-free kernel bugs, is not as a concern as it is for regular
processes. First the jailer model can obtain the uffd before dropping
all caps and before firing up seccomp in the child, so it won't even
require to lift the unprivileged_userfaultfd in the superior and
cleaner monolithic jailer model.

If the uffd and uffd-wp can only run in rust-vmm and qemu, that
userland is system software to be trusted as the kernel from the guest
point of view. It's similar to fuse, if somebody gets into the fuse
process it can also stop the kernel initiated faults. From that
respect fuse is also system software despite it runs in userland.

In other words I think if there's a vm-escape that takes control of
rust-vmm userland, the last worry is the fact it can stop kernel
initiated page faults because the jailer took an uffd before drop privs.

Thanks,
Andrea

