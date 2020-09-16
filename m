Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C026C9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgIPT3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:29:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:20490 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgIPT1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:27:40 -0400
IronPort-SDR: 1Qx75iJKrlyWJtj0gcLG1YTJBrv515Vcb+5/2dsvuzTbKbWEdcO+HjRXYhhX2u0IUGCc9qxxcR
 BZudqAGU8HEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="156957194"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="156957194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 12:27:01 -0700
IronPort-SDR: 0JaK1SGWxxf7ZPF6mJyYULlV+6jY+MJtwhM1biAqoS8x1cnX0+rfc3zYquTU84M7O1+QfdKR7U
 fXhaInOjoe9w==
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="483437355"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 12:27:00 -0700
Date:   Wed, 16 Sep 2020 12:26:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Message-ID: <20200916192659.GA30252@agluck-desk2.amr.corp.intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-6-tony.luck@intel.com>
 <20200916105336.GF2643@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916105336.GF2643@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:53:36PM +0200, Borislav Petkov wrote:
> On Tue, Sep 08, 2020 at 10:55:16AM -0700, Tony Luck wrote:
> >  2:	mov %ecx,%eax
> >  	ASM_CLAC
> >  	ret
> > +3:	xorl %eax,%eax	/* pretend we succeeded? */
> 
> Hmm, but copy_*_user returns the uncopied bytes in eax. Users of this
> need to handle the MC case properly but if you return 0, they would
> think that they copied everything but there's some trailing stuff they
> didn't manage to take.
> 
> And it's not like they *should* have to retry to copy it because they
> will walk right into the faulty region and cause more MCEs.
> 
> So how is this "I-got-an-MCE-while-copying-from-user" handled on the
> higher level?

I got stuck on this part of the series for a long time. This code
was pretty subtle before I came to make it even more confusing.

In a normal copy from user operation the expectation is that there
will be some page faults. If a #PF happens the kernel either fixes
the fault and provides a good mapping, or finds that it can't and
doesn't map anything. Either way the extable fixup jumps to the
error return of the low level copy function which returns the number
of bytes still to be copied.

The subtle part is that the iterator that calls into the low level
copy calls fault_in_pages_readable().  I thought this was just some
optimization to prefault the pages, but actually it turns out to be
critical to how -EFAULT gets returned to a user when they pass a
bad address.

When the low level copy stops at a page fault, the next call to
fault_in_pages_readable() checks if the fault was fixed and returns
-EFAULT if it wasn't.

Interesting back story ... now look at what happens if we take a
machine check instead of a page fault.

The machine check handler will invoke the extable fixup to move
the RIP for the copy function to the early return path. Machine
check handler also set up some task_work for the application
to call memory_failure() which will unmap the page. But that work
won't happen until we try to return to the user. So the page (and
the poison) are still mapped.

So we take a another machine check on the same address when
fault_in_pages_readable() does __get_user().  That ought to break
us out ... but for some reason I still don't understand didn't.
But even if it did ... the second machine check is not at all
a good idea.

Returning zero bytes left to say we completed avoids that. The
user is guaranteed a SIGBUS when the task_work does fire. So whatever
system call was in progress is not going to see the apparent
successful return.

Both the code and the commit comment need much more of this
description.

Unless you have some better way out of the dilemmma that the
real fixup is only scheduled at the point that the extable
fixup just arranges for a simple local return from the copy.

> 
> Your 7/8 says:
> 
> "Add code to recover from a machine check while copying data from user
> space to the kernel. Action for this case is the same as if the user
> touched the poison directly; unmap the page and send a SIGBUS to the
> task."
> 
> So how are users of copy_*_user() expected to handle the page
> disappearing from under them?

When the return to user happens the task_work that was scheduled
in the machine check handler takes care of the error return to the
user.

-Tony
