Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484892B07D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKLOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:53:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21283C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bYXx/yhniIZz+4OfdLqK3N+IFZ7LdA6KsRXCgxZgdcs=; b=wJR5ritcMGFifgOEJQS79xYv0O
        7xMJ3qQBkYzcUHIl66LdWLpdxiWqMt1UMGerhGK0l0ERJZ2OwsQijNwngo2g9IagZz6AWwj8Pa/Qd
        F71QrjMj7thTSCGDnj2ebxZR2cSiLyO7wuq4/HCCee46b4NZ4ZUF7ZUGawLR+iFUqxbV0QpqxPGn+
        vVWKaop0P+Aq6AcT1qv7YW5aIZTrbLHukLLuTKzEsPMxB/pn8tkxq+RU8Hb0rWIF2XzaP0lf+q2qZ
        QnLMj0HC+jJE99Z6qAGHyANPN5c7hKWV5aXo1+UA16TyfaIeTKc0H3K7wzWgOxeFpfrgZaUtPfiLD
        srFS3e1w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdDxz-000824-HL; Thu, 12 Nov 2020 14:52:51 +0000
Date:   Thu, 12 Nov 2020 14:52:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201112145251.GB17076@casper.infradead.org>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R>
 <20201112092612.00a19239@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112092612.00a19239@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:12AM -0500, Steven Rostedt wrote:
> > FYI, roughly Lockdep is doing:
> > 
> >    1. Dependency check
> >    2. Lock usage correctness check (including RCU)
> >    3. IRQ related usage correctness check with IRQFLAGS
> > 
> > 2 and 3 should be there forever which is subtle and have gotten matured.
> > But 1 is not. I've been talking about 1. But again, it's not about
> > replacing it right away but having both for a while. I'm gonna try my
> > best to make it better.
> 
> And I believe lockdep does handle 1. Perhaps show some tangible use case
> that you want to cover that you do not believe that lockdep can handle. If
> lockdep cannot handle it, it will show us where lockdep is lacking. If it
> can handle it, it will educate you on other ways that lockdep can be
> helpful in your development ;-)

Something I believe lockdep is missing is a way to annotate "This lock
will be released by a softirq".  If we had lockdep for lock_page(), this
would be a great case to show off.  The filesystem locks the page, then
submits it to a device driver.  On completion, the filesystem's bio
completion handler will be called in softirq context and unlock the page.

So if the filesystem has another lock which is acquired by the completion
handler. we could get an ABBA deadlock that lockdep would be unable to see.

There are other similar things; if you look at the remaining semaphore
users in the kernel, you'll see the general pattern is that they're
acquired in process context and then released in interrupt context.
If we had a way to transfer ownership of the semaphore to a generic
"interrupt context", they could become mutexes and lockdep could check
that nothing else will cause a deadlock.
