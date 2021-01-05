Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EB2EB39D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbhAETrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728630AbhAETrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609875957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDQ3f1Bz+DgAubnbVzGBFyj256LtO1Sf/sJvuZ9kXFY=;
        b=aTpmULomtJwGFllyI4EKtN9piqLRb1qfqAskJ189t1FmV2e9NIw6swqKGFLOTSI3mVcq5y
        pVKFRI8ts/m78Clj6tRhxUNFWTe6DUV8N/im7IRP2Eyvy1Xao0nSia0JgqHk+43mI7iYZ9
        aACBJdh9jU3qVr8hcJTaNFCHzdnLGVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-3jSJ7scBN7G90PU-NrNdHA-1; Tue, 05 Jan 2021 14:45:53 -0500
X-MC-Unique: 3jSJ7scBN7G90PU-NrNdHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4203800D55;
        Tue,  5 Jan 2021 19:45:51 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF2145D6CF;
        Tue,  5 Jan 2021 19:45:47 +0000 (UTC)
Date:   Tue, 5 Jan 2021 14:45:47 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/TB6ztitnESl3qZ@redhat.com>
References: <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
 <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
 <X/SzzjREaoR9u7Ua@redhat.com>
 <BABCB1DE-C41E-4C3E-90D1-5893585FB68A@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BABCB1DE-C41E-4C3E-90D1-5893585FB68A@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:05:22PM +0000, Nadav Amit wrote:
> > On Jan 5, 2021, at 10:45 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > I just don't like to slow down a feature required in the future for
> > implementing postcopy live snapshotting or other snapshots to userland
> > processes (for the non-KVM case, also unprivileged by default if using
> > bounce buffers to feed the syscalls) that can be used by open source
> > hypervisors to beat proprietary hypervisors like vmware.
> 
> Ouch, that’s uncalled for. I am sure that you understand that I have no
> hidden agenda and we all have the same goal.

Ehm I never said you had an hidden agenda, so I'm not exactly why
you're accusing me of something I never said.

I merely pointed out one relevant justification for increasing kernel
complexity here by not slowing down clear_refs longstanding O(N)
clear_refs/softdirty feature and the recent uffd-wp O(1) feature, is
to be more competitive with proprietary software solutions, since
at least for uffd-wp, postcopy live snapshotting that the #1 use
case.

I never questioned your contribution or your preference, to be even
more explicit, it never crossed my mind that you have an hidden
agenda.

However since everyone already acked your patches and I'm not ok with
your patches because they will give a hit to KVM postcopy live
snapshotting and other container clear_refs users, I have to justify
why I NAK your patches and remaining competitive with proprietary
hypervisors is one of them, so I don't see what is wrong to state a
tangible end goal here.

Thanks,
Andrea

