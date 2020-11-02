Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50532A370F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKBXSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBXSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:18:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9407CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 15:18:30 -0800 (PST)
Date:   Tue, 3 Nov 2020 00:18:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604359108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVJlgI2Jg2jaYgAMQidX6deypd1QfekkTNPC7CxbpzQ=;
        b=mRP53UFQTqDKOQYHH0J/Ll3N7qtXQL4HgQwnaphvUQbnJ8ZZByCQJhsGiIMZpQLpH4Knw3
        xK9nWzlpLqN1w+8DpL2+KjTsKSnDeLUL/xDrsqn483LUJQtAc7JtbKBnPZTUVdj+/mxg7y
        sXtuZQwLQrnfrXUUresWpyNAgUiH3O1Sd8N5j2hoVuW92ohCd0HG88DwcWUCX7WfasW1YH
        gQ0VUirYVADtovgEE8ajyC0ERY9e89HKHek9q2ChpTTwFzd1lag6AlUoEFU2YCQKc20dp1
        EdKseBelNT3FQSKfr2nFbvYSCin+6EA8ak1oVd5sIfSSp+hYJui3CMyUGXZEgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604359108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVJlgI2Jg2jaYgAMQidX6deypd1QfekkTNPC7CxbpzQ=;
        b=yfbdBEdU/ow879IuX+su1cP+Z7unJs/HOWIARjR8Nr0VrMZTbrpHwBWdoNAQY9v0bF2gJS
        VDhc9OyqRHVAHyAg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/2] Add a seqcount between gup_fast and
 copy_page_range()
Message-ID: <20201102231821.GA51715@lx-t490>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201102221945.GA48454@lx-t490>
 <CAHk-=wj2jtBhfgpxCkgXcyOPn3YFFWeJ-vHsppocBjdFQ2F6Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2jtBhfgpxCkgXcyOPn3YFFWeJ-vHsppocBjdFQ2F6Og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:39:49PM -0800, Linus Torvalds wrote:
> On Mon, Nov 2, 2020 at 2:19 PM Ahmed S. Darwish <a.darwish@linutronix.de> wrote:
> >
> > Disabling preemption for seqcount_t write-side critical sections was
> > never a new requirement. It has always been this way, for the reasons
> > explained at Documentation/locking/seqlock.rst, "Introduction" section.
>
> Note that that is only true if you spin on the reading side (either of
> the two kinds of spinning: (a) spinning to wait for it to become even,
> or (b) repeating if they don't match)
>
> Which this code doesn't do, it just fails.
>
> I'm not sure how to perhaps document that.
>

Sure, and this is one of the reasons the lockdep non-preemptibility
check is only added to the non-raw variants of the seqcount write APIs.

Presumably, users of the raw_*() part of the API know what they're
doing, and they don't need to read seqlock.rst :)

(I'm in progress of replying to patch #2, which touches a bit on this
 and other points)..

>              Linus

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
