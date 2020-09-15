Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5866726A22B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIOJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIOJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:30:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC03CB2FC;
        Tue, 15 Sep 2020 09:30:30 +0000 (UTC)
Date:   Tue, 15 Sep 2020 11:30:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 5/6] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200915093012.GE11154@alley>
References: <20200914123354.832-1-john.ogness@linutronix.de>
 <20200914123354.832-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914123354.832-6-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-14 14:39:53, John Ogness wrote:
> Add support for extending the newest data block. For this, introduce
> a new finalization state (desc_finalized) denoting a committed
> descriptor that cannot be extended.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

There seems to be possible a small clean up, see below. But I would do
it in a followup patch to avoid yet another respin.


> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 911fbe150e9a..4e526c79f89c 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> +/*
> + * Try to resize an existing data block associated with the descriptor
> + * specified by @id. If the resized data block should become wrapped, it
> + * copies the old data to the new data block. If @size yields a data block
> + * with the same or less size, the data block is left as is.
> + *
> + * Fail if this is not the last allocated data block or if there is not
> + * enough space or it is not possible make enough space.
> + *
> + * Return a pointer to the beginning of the entire data buffer or NULL on
> + * failure.
> + */
> +static char *data_realloc(struct printk_ringbuffer *rb,
> +			  struct prb_data_ring *data_ring, unsigned int size,
> +			  struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> +{
> +	struct prb_data_block *blk;
> +	unsigned long head_lpos;
> +	unsigned long next_lpos;
> +	bool wrapped;
> +
> +	/* Reallocation only works if @blk_lpos is the newest data block. */
> +	head_lpos = atomic_long_read(&data_ring->head_lpos);
> +	if (head_lpos != blk_lpos->next)
> +		return NULL;
> +
> +	/* Keep track if @blk_lpos was a wrapping data block. */
> +	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
> +
> +	size = to_blk_size(size);
> +
> +	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
> +
> +	/* If the data block does not increase, there is nothing to do. */
> +	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
> +		blk = to_block(data_ring, blk_lpos->begin);
> +		return &blk->data[0];
> +	}
> +
> +	if (!data_push_tail(rb, data_ring, next_lpos - DATA_SIZE(data_ring)))
> +		return NULL;
> +
> +	/* The memory barrier involvement is the same as data_alloc:A. */
> +	if (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &head_lpos,
> +				     next_lpos)) { /* LMM(data_realloc:A) */
> +		return NULL;
> +	}
> +
> +	blk = to_block(data_ring, blk_lpos->begin);
> +
> +	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
> +		struct prb_data_block *old_blk = blk;
> +
> +		/* Wrapping data blocks store their data at the beginning. */
> +		blk = to_block(data_ring, 0);
> +
> +		/*
> +		 * Store the ID on the wrapped block for consistency.
> +		 * The printk_ringbuffer does not actually use it.
> +		 */
> +		blk->id = id;

Small cleanup: The "id" should already be there when the block has
already been wrapped before. By other words, even the above
need to be done only when (!wrapped).

> +
> +		if (!wrapped) {
> +			/*
> +			 * Since the allocated space is now in the newly
> +			 * created wrapping data block, copy the content
> +			 * from the old data block.
> +			 */
> +			memcpy(&blk->data[0], &old_blk->data[0],
> +			       (blk_lpos->next - blk_lpos->begin) - sizeof(blk->id));
> +		}
> +	}
> +
> +	blk_lpos->next = next_lpos;
> +
> +	return &blk->data[0];
> +}
> +
>  /* Return the number of bytes used by a data block. */
>  static unsigned int space_used(struct prb_data_ring *data_ring,
>  			       struct prb_data_blk_lpos *blk_lpos)

Best Regards,
Petr
