Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC262EE66F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbhAGT63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:58:29 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E863CC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 11:57:48 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxbPa-0087OV-49; Thu, 07 Jan 2021 19:57:34 +0000
Date:   Thu, 7 Jan 2021 19:57:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Message-ID: <20210107195734.GL3579531@ZenIV.linux.org.uk>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
 <20210107190445.GK3579531@ZenIV.linux.org.uk>
 <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:33:36AM -0800, Linus Torvalds wrote:

> In fact, even some threaded app that does what I suspect it could do
> would likely be ok with it 99% of the time. Because the situation
> where you change the fd in the poll array is likely not the common
> case, and even if some -1 file descriptor gets overwritten by a valid
> one by the poll() system call again, it probably ends up being very
> hard to see a failure.
> 
> Which just makes me even more nervous.

Hmm...  But anything like that will have another problem - we do
copyin only once.  And we repeat fdget() on each iteration of
do_poll() loop.  Sure, we don't actually put anything on the
queues after the first time around, and __pollwait() keeps the
ones we are actually waiting for pinned, but...  If another
thread stores -1 to ->fd, then closes what used to be there
and moves on, what will it see?  ->poll() calls will be done
for whatever file we'd reused the descriptor for.  Sure,
the kernel won't break, but the caller of poll() would need
to be very careful about what it sees...

Frankly, I'd consider seeing that kind of games in the userland
as a big red flag; I'm not saying it's OK to break the suckers
even worse than they are now, but I'm curious whether anything
in the userland does it *and* how many bugs does it have around
those uses of poll()...
