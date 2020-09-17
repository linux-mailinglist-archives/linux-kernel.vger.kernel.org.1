Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1F26DFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgIQP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgIQP1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:27:46 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB44E22205;
        Thu, 17 Sep 2020 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600356419;
        bh=lNZ+wDCGRwl2RgYgYdqOE4yhTOTo4PPg1G62cF0rD2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gauOaHn00mrNr38BGlQG5UGWBDtwd4H8L5WsXTsTCWynpSX3iG49blVZUOh61uxao
         Z7+ES3aCFZn6eKqj+/dUZ2FBvZ8L+jgt9FQl4qBOCZIFC8Jefy7x22rnt5x1N41RfQ
         pRrTxPUBg1aBbJ3fgEcfQrNvjplElHMT9A7HuH3Y=
Date:   Thu, 17 Sep 2020 08:26:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix doulbe irq free
Message-ID: <20200917152656.GA3766534@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153700.5572-1-ztong0001@gmail.com>
 <20200917083015.GB4595@lst.de>
 <CAA5qM4BUirF=EZqdtXOAfvSwcGqQ9voFZqrxHedsB8ndF+bJUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4BUirF=EZqdtXOAfvSwcGqQ9voFZqrxHedsB8ndF+bJUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:22:54AM -0400, Tong Zhang wrote:
> On Thu, Sep 17, 2020 at 4:30 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Sep 16, 2020 at 11:37:00AM -0400, Tong Zhang wrote:
> > > the irq might already been released before reset work can run
> >
> > If it is we have a problem with the state machine, as we shouldn't
> > have two resets running at the same time.  Can you share your reproducer?
> >
> 
> Hi Christoph,
> Thanks for replying.
> 
> It is possible that pci_free_irq() can be called twice for the same IRQ,
> the first call can be
> 
> [  124.413113] nvme nvme0: I/O 6 QID 0 timeout, disable controller
> [  124.414317] Workqueue: kblockd blk_mq_timeout_work
> [  124.414317] Call Trace:
> [  124.414317]  dump_stack+0x7d/0xb0
> [  124.414317]  nvme_suspend_queue.cold+0x11/0x58
> [  124.414317]  nvme_dev_disable+0x116/0x7b0
> [  124.414317]  nvme_timeout+0x309/0x320
> [  124.414317]  ? nvme_shutdown+0x40/0x40
> [  124.414317]  ? load_balance+0xe76/0x1450
> [  124.414317]  ? deref_stack_reg+0x40/0x40
> [  124.414317]  ? sched_clock_local+0x99/0xc0
> [  124.414317]  blk_mq_check_expired+0x313/0x340
> [  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
> [  124.414317]  ? _find_next_bit.constprop.0+0x3e/0xf0
> [  124.414317]  blk_mq_queue_tag_busy_iter+0x2e9/0x4a0
> [  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
> [  124.414317]  ? blk_mq_all_tag_iter+0x10/0x10
> [  124.414317]  ? _raw_write_lock_irqsave+0xd0/0xd0
> [  124.414317]  ? run_rebalance_domains+0x80/0x80
> [  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
> [  124.414317]  ? debug_object_deactivate.part.0+0x1c4/0x210
> [  124.414317]  blk_mq_timeout_work+0xaa/0x1f0
> [  124.414317]  ? __blk_mq_end_request+0x1f0/0x1f0
> [  124.414317]  ? __schedule+0x581/0xc40
> [  124.414317]  ? read_word_at_a_time+0xe/0x20
> [  124.414317]  ? strscpy+0xbf/0x190
> [  124.414317]  process_one_work+0x4ad/0x7e0
> [  124.414317]  worker_thread+0x73/0x690
> [  124.414317]  ? process_one_work+0x7e0/0x7e0
> [  124.414317]  kthread+0x199/0x1f0
> [  124.414317]  ? kthread_create_on_node+0xd0/0xd0
> [  124.414317]  ret_from_fork+0x22/0x30
> 
> And the second call can be
> [  149.763974] nvme nvme0: Failed to read smart log (error -4)
> [  149.774307] Trying to free already-free IRQ 10
> [  149.774385] Call Trace:
> [  149.774385]  pci_free_irq+0x13/0x20
> [  149.774385]  nvme_reset_work.cold+0x1be/0xa78
> [  149.774385]  ? nvme_probe+0x8c0/0x8c0
> [  149.774385]  ? check_preempt_curr+0x9d/0xf0
> [  149.774385]  ? ttwu_do_wakeup.isra.0+0x176/0x190
> [  149.774385]  ? try_to_wake_up+0x37c/0x900
> [  149.774385]  ? migration_cpu_stop+0x1e0/0x1e0
> [  149.774385]  ? __schedule+0x581/0xc40
> [  149.774385]  ? read_word_at_a_time+0xe/0x20
> [  149.774385]  ? strscpy+0xbf/0x190
> [  149.774385]  process_one_work+0x4ad/0x7e0
> [  149.774385]  worker_thread+0x73/0x690
> [  149.774385]  ? process_one_work+0x7e0/0x7e0
> [  149.774385]  kthread+0x199/0x1f0
> [  149.774385]  ? kthread_create_on_node+0xd0/0xd0
> [  149.774385]  ret_from_fork+0x22/0x30
> 
> and clearly something is not working as expected.

And the problem is that nvme_hwmon_init() doesn't return an error, so it
returns to continue initialization on a disabled controller. That's the
bug that needs to be fixed.
