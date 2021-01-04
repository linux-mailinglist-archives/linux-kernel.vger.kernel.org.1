Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA46D2E9EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbhADUVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbhADUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609791604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHG8PYLjaqUlV4xnF924RfJu2w8NSfaaPiEISSrHtOc=;
        b=ETS2/By4C4AKAPnQeYPgXI5/mj7rW6krv4JLWHgCLM+0ZfZSOC3OFVNUifpzJr5vfMlKZV
        ToGfdDkmiqyBsd8caBaAp8mag514eZFYXjG4uF8gbKslAgraNCiu3OojBUJ0zD+4/HYNgF
        2dvkyU2MexCEM3G6b+x6pcMooHOElhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-ITELSFJ3NtGEu36vk7ubOw-1; Mon, 04 Jan 2021 15:20:00 -0500
X-MC-Unique: ITELSFJ3NtGEu36vk7ubOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A0DE107ACE3;
        Mon,  4 Jan 2021 20:19:58 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4CD37086C;
        Mon,  4 Jan 2021 20:19:54 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:19:54 -0500
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
Message-ID: <X/N4aqRgyxffhMSs@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 07:35:06PM +0000, Nadav Amit wrote:
> > On Jan 4, 2021, at 11:24 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > 
> > Hello,
> > 
> > On Mon, Jan 04, 2021 at 01:22:27PM +0100, Peter Zijlstra wrote:
> >> On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> >> 
> >>> The scenario that happens in selftests/vm/userfaultfd is as follows:
> >>> 
> >>> cpu0				cpu1			cpu2
> >>> ----				----			----
> >>> 							[ Writable PTE
> >>> 							  cached in TLB ]
> >>> userfaultfd_writeprotect()
> >>> [ write-*unprotect* ]
> >>> mwriteprotect_range()
> >>> mmap_read_lock()
> >>> change_protection()
> >>> 
> >>> change_protection_range()
> >>> ...
> >>> change_pte_range()
> >>> [ *clear* “write”-bit ]
> >>> [ defer TLB flushes ]
> >>> 				[ page-fault ]
> >>> 				...
> >>> 				wp_page_copy()
> >>> 				 cow_user_page()
> >>> 				  [ copy page ]
> >>> 							[ write to old
> >>> 							  page ]
> >>> 				...
> >>> 				 set_pte_at_notify()
> >> 
> >> Yuck!
> > 
> > Note, the above was posted before we figured out the details so it
> > wasn't showing the real deferred tlb flush that caused problems (the
> > one showed on the left causes zero issues).
> 
> Actually it was posted after (note that this is v2). The aforementioned
> scenario that Peter regards to is the one that I actually encountered (not
> the second scenario that is “theoretical”). This scenario that Peter regards
> is indeed more “stupid” in the sense that we should just not write-protect
> the PTE on userfaultfd write-unprotect.
> 
> Let me know if I made any mistake in the description.

I didn't say there is a mistake. I said it is not showing the real
deferred tlb flush that cause problems.

The issue here is that we have a "defer tlb flush" that runs after
"write to old page".

If you look at the above, you're induced to think the "defer tlb
flush" that causes issues is the one in cpu0. It's not. That is
totally harmless.


> 
> > The problematic one not pictured is the one of the wrprotect that has
> > to be running in another CPU which is also isn't picture above. More
> > accurate traces are posted later in the thread.
> 
> I think I included this scenario as well in the commit log (of v2). Let me
> know if I screwed up and the description is not clear.

Instead of not showing the real "defer tlb flush" in the trace and
then fixing it up in the comment, why don't you take the trace showing
the real problematic "defer tlb flush"? No need to reinvent it.

https://lkml.kernel.org/r/X+JJqK91plkBVisG@redhat.com

See here the detail underlined:

deferred tlb flush <- too late
XXXXXXXXXXXXXX BUG RACE window close here

This show the real deferred tlb flush, your v2 does not include it
instead.

