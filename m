Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F11F5077
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFJImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 04:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFJImw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:42:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4944AABE3;
        Wed, 10 Jun 2020 08:42:53 +0000 (UTC)
Date:   Wed, 10 Jun 2020 10:42:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: blk->id read race: was: [PATCH v2 2/3] printk: add lockless
 buffer
Message-ID: <20200610084248.GA4311@linux-b0ei>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609071030.GA23752@linux-b0ei>
 <87tuzkuxtw.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuzkuxtw.fsf@vostro.fn.ogness.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-09 16:18:35, John Ogness wrote:
> On 2020-06-09, Petr Mladek <pmladek@suse.com> wrote:
> >> --- /dev/null
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> +/*
> >> + * Given a data ring (text or dict), put the associated descriptor of each
> >> + * data block from @lpos_begin until @lpos_end into the reusable state.
> >> + *
> >> + * If there is any problem making the associated descriptor reusable, either
> >> + * the descriptor has not yet been committed or another writer task has
> >> + * already pushed the tail lpos past the problematic data block. Regardless,
> >> + * on error the caller can re-load the tail lpos to determine the situation.
> >> + */
> >> +static bool data_make_reusable(struct printk_ringbuffer *rb,
> >> +			       struct prb_data_ring *data_ring,
> >> +			       unsigned long lpos_begin,
> >> +			       unsigned long lpos_end,
> >> +			       unsigned long *lpos_out)
> >> +{
> >> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> +	struct prb_data_blk_lpos *blk_lpos;
> >> +	struct prb_data_block *blk;
> >> +	unsigned long tail_lpos;
> >> +	enum desc_state d_state;
> >> +	struct prb_desc desc;
> >> +	unsigned long id;
> >> +
> >> +	/*
> >> +	 * Using the provided @data_ring, point @blk_lpos to the correct
> >> +	 * blk_lpos within the local copy of the descriptor.
> >> +	 */
> >> +	if (data_ring == &rb->text_data_ring)
> >> +		blk_lpos = &desc.text_blk_lpos;
> >> +	else
> >> +		blk_lpos = &desc.dict_blk_lpos;
> >> +
> >> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
> >> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
> >> +		blk = to_block(data_ring, lpos_begin);
> >> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
> >
> > This would deserve some comment:
> >
> > 1. Compiler could not optimize out the read because there is a data
> >    dependency on lpos_begin.
> >
> > 2. Compiler could not postpone the read because it is followed by
> >    smp_rmb().
> >
> > So, is READ_ONCE() realy needed?
> 
> I agree that it is not needed. Both the READ_ONCE() and its countering
> WRITE_ONCE() (data_alloc:B) only document the lockless shared access. I
> will remove both for the next version.

Sounds good.

> Do we still need a comment? Is it not obvious that there is a data
> dependency on @lpos_begin?

Sigh, I just wonder why I am always confusedby this. See below.


>         blk = to_block(data_ring, lpos_begin);
>         id = blk->id;
> 
> > Well, blk->id clearly can be modified in parallel so we need to be
> > careful. There is smp_rmb() right below. Do we needed smp_rmb() also
> > before?
> >
> > What about the following scenario?:
> >
> >
> > CPU0						CPU1
> >
> > 						data_alloc()
> > 						  data_push_tail()
> >
> > 						blk = to_block(data_ring, begin_lpos)
> > 						WRITE_ONCE(blk->id, id); /* LMM(data_alloc:B) */
> >
> > desc_push_tail()
> >   data_push_tail()
> >
> >     tail_lpos = data_ring->tail_lpos;
> >     // see data_ring->tail_lpos already updated by CPU1
> >
> >     data_make_reusable()
> >
> >       // lpos_begin = tail_lpos via parameter
> >       blk = to_block(data_ring, lpos_begin);
> >       id = blk->id
> >
> > Now: CPU0 might see outdated blk->id before CPU1 wrote new value
> >      because there is no read barrier betwen reading tail_lpos
> >      and blk->id here.
> 
> In your example, CPU1 is pushing the tail and then setting the block ID
> for the _newly_ allocated block, that is located is _before_ the new
> tail. If CPU0 sees the new tail already, it is still reading a valid
> block ID, which is _not_ from the block that CPU1 is in the process of
> writing.

Ah, I see. I wrongly assumed that both CPO0 and CPU1 are working with
the same block address. But if CPU0 sees the new tail_lpos, it is
already looking at another block. And it is the classic fight against
yet another potential CPUs that try to push the tail as well.

I wonder if the comment might look like:

/*
 * No barrier is needed between reading tail_lpos and the related
 * blk->id. Only CPU that modifies tail_lpos via cmpxchg is allowed
 * to modify the related blk->id. CPUs that see the moved tail_lpos
 * are looking at another block related to the new tail_lpos.
 * It does not mater when the previous winner modifies the previous
 * block.
 */

I am not sure how many people are confused like me. It is possible
that it is not worth it. I just know that I did this mistake
repeatedly ;-)

Best Regards,
Petr
