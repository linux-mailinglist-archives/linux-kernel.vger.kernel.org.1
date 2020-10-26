Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF5298C78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774545AbgJZLzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:55:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422402AbgJZLzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:55:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1179AC8B;
        Mon, 26 Oct 2020 11:55:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B3F9A1E10F5; Mon, 26 Oct 2020 12:55:41 +0100 (CET)
Date:   Mon, 26 Oct 2020 12:55:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Filipe Manana <fdmanana@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201026115541.GC28769@quack2.suse.cz>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026114009.GN2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-10-20 12:40:09, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 11:26:49AM +0000, Filipe Manana wrote:
> > Hello,
> > 
> > I've recently started to hit a warning followed by tasks hanging after
> > attempts to freeze a filesystem. A git bisection pointed to the
> > following commit:
> > 
> > commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Fri Oct 2 11:04:21 2020 +0200
> > 
> >     lockdep: Fix lockdep recursion
> > 
> > This happens very reliably when running all xfstests with lockdep
> > enabled, and the tested filesystem is btrfs (haven't tried other
> > filesystems, but it shouldn't matter). The warning and task hangs always
> > happen at either test generic/068 or test generic/390, and (oddly)
> > always have to run all tests for it to trigger, running those tests
> > individually on an infinite loop doesn't seem to trigger it (at least
> > for a couple hours).
> > 
> > The warning triggered is at fs/super.c:__sb_start_write() which always
> > results later in several tasks hanging on a percpu rw_sem:
> > 
> > https://pastebin.com/qnLvf94E
> > 
> > What happens is percpu_rwsem_is_held() is apparently returning a false
> > positive,
> 
> That smells like the same issue reported here:
> 
>   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> 
> Make sure you have commit:
> 
>   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> 
> (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?

Hum, I am at 5.10-rc1 now and above mentioned commit doesn't appear to be
there? Also googling for the title doesn't help...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
