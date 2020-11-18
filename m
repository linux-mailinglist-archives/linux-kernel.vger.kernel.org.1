Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADD2B74D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKRDaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKRDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:30:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529D7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PcMAtrHwVt8y6geL+odDfrTIIzd4boDIlhOEr7BpkFc=; b=R5unZwDRZlSMIrgnPPLz2jUGur
        h/m2ml4fkanoXiEeMBLDQBm6B9EP2hWFocOiEbH1In77BNyrCmzuph8Iq8xPLVOe2Mq83WXCAKmhC
        D3QX71lgwPy02wFpwAs8osPAjd8gkZYey1JFNXddyKFNVxCgJjZlzdon26goV8999JweuNxnZA7Aj
        f7+RLZEAYc9odcnUQzwidU4+NxQ3UegKcxqA5z/w514xTxrIDkTtSxLK59SB8GnMFmqqC1GIwg99C
        UP1+L0z9DD41mq+0QitlM/rHOwQUQyFn3fZN094Z1m696mG0iXVIJVa3fRRAsPC2I2qnw2m3p496g
        +y/5qzcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfEAX-0006Ws-R5; Wed, 18 Nov 2020 03:30:05 +0000
Date:   Wed, 18 Nov 2020 03:30:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20201118033005.GD29991@casper.infradead.org>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R>
 <20201112092612.00a19239@gandalf.local.home>
 <20201112145251.GB17076@casper.infradead.org>
 <20201116085757.GB26078@X58A-UD3R>
 <20201116153729.GC29991@casper.infradead.org>
 <20201118014540.GA1278700@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118014540.GA1278700@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:45:40AM +0800, Boqun Feng wrote:
> Hi Matthew,
> 
> On Mon, Nov 16, 2020 at 03:37:29PM +0000, Matthew Wilcox wrote:
> [...]
> > 
> > It's not just about lockdep for semaphores.  Mutexes will spin if the
> > current owner is still running, so to convert an interrupt-released
> > semaphore to a mutex, we need a way to mark the mutex as being released
> 
> Could you provide an example for the conversion from interrupt-released
> semaphore to a mutex? I'd like to see if we can improve lockdep to help
> on that case.

How about adb_probe_mutex in drivers/macintosh/adb.c.  Most of
the acquires/releases are within the same task.  But adb_reset_bus()
calls down(&adb_probe_mutex), then schedules adb_reset_work() which runs
adb_probe_task() which calls up(&adb_probe_mutex).

Ideally adb_probe_mutex would become a mutex instead of the semaphore
it currently is.  adb_reset_bus() would pass ownership of the mutex to
kadbprobe since it's the one which must run in order to release the mutex.
