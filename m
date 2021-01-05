Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD56D2EB2E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbhAES5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbhAES53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609872963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9w/iMRNyhVoOowtKU0b635oOfM5KpwM2gcKc5R3Kfk=;
        b=Tti5AXQzJmuzB6nUn5ITkwHnD0KLlJq1CoUloD0cHhTq3ghv2D3AiR6uzYjEYlqcdsZbAG
        7+QWnsaK1aLYxPhBIq9guWaK92m8mfxW+I0gXHEF6HJMRgbKHhyGOVeTwAdP42cH4rT07d
        GhWR2LNEGXIulddlcJesWeuzGezNXqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-Qm2xffbMPtWHYTpnltJOOg-1; Tue, 05 Jan 2021 13:56:00 -0500
X-MC-Unique: Qm2xffbMPtWHYTpnltJOOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6110190B2A1;
        Tue,  5 Jan 2021 18:55:58 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5746A62677;
        Tue,  5 Jan 2021 18:55:55 +0000 (UTC)
Date:   Tue, 5 Jan 2021 13:55:54 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/S2OorGPInpjjhV@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210105150813.GB149908@xz-x1>
 <X/SrMIz50alPOp6i@redhat.com>
 <20210105184134.GD149908@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105184134.GD149908@xz-x1>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:41:34PM -0500, Peter Xu wrote:
> Agreed. I didn't mention uffd_wp check (which I actually mentioned in the reply
> to v1 patchset) here only because the uffd_wp check is pure optimization; while

Agreed it's a pure optimization.

Only if we used the group lock to fix this (which we didn't since it
wouldn't help clear_refs to avoid the performance regression), the
optimization would have become not an optimization anymore.

> the uffd_wp_resolve check is more critical because it is potentially a fix of
> similar tlb flushing issue where we could have demoted the pte without being
> noticed, so I think it's indeed more important as Nadav wanted to fix in the
> same patch.

I didn't get why that was touched in the same patch, I already
suggested to remove that optimization...

> It would be even nicer if we have both covered (all of them can be in
> unlikely() as Andrea suggested in the other email), then maybe nicer as a
> standalone patch, then mention about the difference of the two in the commit
> log (majorly, the resolving change will be more than optimization).

Yes, if you want to go ahead optimizing both cases of the
UFFDIO_WRITEPROTECT, I don't think there's any dependency on this. The
huge_memory.c also needs covering but I didn't look at it, hopefully
the code will result as clean as in the pte case.

I'll try to cleanup the tlb flush in the meantime to see if it look
maintainable after the cleanups.

Then we can change it to wait_pending_flush(); return VM_FAULT_RETRY
model if we want to or if the IPI is slower, at least clear_refs will
still not block on random pagein or swapin from disk, but only anon
memory write access will block while clear_refs run.

Thanks,
Andrea

