Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF51F5724
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFJO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgFJO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:57:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6413CC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:57:03 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jj29v-0006vJ-83; Wed, 10 Jun 2020 16:56:55 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
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
Subject: Re: redundant check in make_data_reusable(): was [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <20200609093103.GB23752@linux-b0ei>
        <87lfkwuwg1.fsf@vostro.fn.ogness.net>
        <20200610093835.GB4311@linux-b0ei>
        <87o8prp6bi.fsf@vostro.fn.ogness.net>
Date:   Wed, 10 Jun 2020 16:56:53 +0200
In-Reply-To: <87o8prp6bi.fsf@vostro.fn.ogness.net> (John Ogness's message of
        "Wed, 10 Jun 2020 12:24:01 +0200")
Message-ID: <87d067otoq.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-10, Petr Mladek <pmladek@suse.com> wrote:
>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>> +			       struct prb_data_ring *data_ring,
>> +			       unsigned long lpos_begin,
>> +			       unsigned long lpos_end,
>> +			       unsigned long *lpos_out)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	struct prb_data_blk_lpos *blk_lpos;
>> +	struct prb_data_block *blk;
>> +	unsigned long tail_lpos;
>> +	enum desc_state d_state;
>> +	struct prb_desc desc;
>> +	unsigned long id;
>> +
>> +	/*
>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>> +	 * blk_lpos within the local copy of the descriptor.
>> +	 */
>> +	if (data_ring == &rb->text_data_ring)
>> +		blk_lpos = &desc.text_blk_lpos;
>> +	else
>> +		blk_lpos = &desc.dict_blk_lpos;
>> +
>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>> +		blk = to_block(data_ring, lpos_begin);
>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>> +
>> +		/*
>> +		 * Guarantee the block ID is loaded before checking the tail
>> +		 * lpos. The loaded block ID can only be considered valid if
>> +		 * the tail lpos has not overtaken @lpos_begin. This pairs
>> +		 * with data_alloc:A.
>> +		 *
>> +		 * Memory barrier involvement:
>> +		 *
>> +		 * If data_make_reusable:A reads from data_alloc:B, then
>> +		 * data_make_reusable:C reads from data_push_tail:D.
>> +		 *
>> +		 * Relies on:
>> +		 *
>> +		 * MB from data_push_tail:D to data_alloc:B
>> +		 *    matching
>> +		 * RMB from data_make_reusable:A to data_make_reusable:C
>> +		 *
>> +		 * Note: data_push_tail:D and data_alloc:B can be different
>> +		 *       CPUs. However, the data_alloc:B CPU (which performs
>> +		 *       the full memory barrier) must have previously seen
>> +		 *       data_push_tail:D.
>> +		 */
>> +		smp_rmb(); /* LMM(data_make_reusable:B) */
>> +
>> +		tail_lpos = atomic_long_read(&data_ring->tail_lpos
>> +					); /* LMM(data_make_reusable:C) */
>> +
>> +		/*
>> +		 * If @lpos_begin has fallen behind the tail lpos, the read
>> +		 * block ID cannot be trusted. Fast forward @lpos_begin to the
>> +		 * tail lpos and try again.
>> +		 */
>> +		if (lpos_begin - tail_lpos >= DATA_SIZE(data_ring)) {
>> +			lpos_begin = tail_lpos;
>> +			continue;
>> +		}
>> +
>> +		d_state = desc_read(desc_ring, id,
>> +				    &desc); /* LMM(data_make_reusable:D) */
>> +
>> +		switch (d_state) {
>> +		case desc_miss:
>> +			return false;
>> +		case desc_reserved:
>> +			return false;
>> +		case desc_committed:
>> +			/*
>> +			 * This data block is invalid if the descriptor
>> +			 * does not point back to it.
>> +			 */
>
> Here again the comments describe what the check does but not why.
> I would write something like:
>
> 			/*
> 			 * The block might have already been
> 			 * reused. Make sure that the descriptor really
> 			 * points back to the checked lpos. It covers
> 			 * both situations. Random data might point to
> 			 * a valid descriptor just by chance. Or the block
> 			 * has been already reused by another descriptor.
> 			 */

Originally this check was needed because the descriptor would be read
even if there was a data race reading the ID from the data
block. Validating the lpos value was a kind of protection against
reading random data that by chance yielded an ID of a committed/reusable
descriptor.

However, after you pointed out that this check was not enough, the code
now re-checks the data tail to make sure that no data race happened. So
actually it is not possible that a descriptor in the committed/reusable
state will point anywhere else. We know the ID is not random garbage or
recycled, so the state can be trusted.

I recommend to either remove this sanity check (for committed and
reusable) or at least change it to:

			WARN_ON_ONCE(blk_lpos->begin != lpos_begin);

Or can you see any possibility of this case?

>> +			if (blk_lpos->begin != lpos_begin)
>> +				return false;
>> +			desc_make_reusable(desc_ring, id);
>> +			break;
>> +		case desc_reusable:
>> +			/*
>> +			 * This data block is invalid if the descriptor
>> +			 * does not point back to it.
>> +			 */
>> +			if (blk_lpos->begin != lpos_begin)
>> +				return false;
>> +			break;
>> +		}
>> +
>> +		/* Advance @lpos_begin to the next data block. */
>> +		lpos_begin = blk_lpos->next;
>> +	}

John Ogness
