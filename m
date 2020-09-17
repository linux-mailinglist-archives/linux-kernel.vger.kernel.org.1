Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB226DFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgIQPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIQPXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:23:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487EFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:23:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a8so2684544ilk.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDcmF4WJhppM0lHyIvdxz0gJh69khnnRWTA8FPWPgGI=;
        b=dtvZTjXUcfn067/9BWaQBSxScPmC5w3FQMnw8bimy3anUFck3bfNDc1Ri+2bR5FN/F
         gxYOJS+vtvTElnrFQKMj3gFFl7dNaDZ57LvjGJIvIVcGDb0ln1ni3oqHrrcqEzQJCRNa
         ZHUYWFVfHnbtN47KJeTZK6EloLorQk37nS155MPSqufOiirpD79BXxOtBWC6h14aKHg4
         QYwQ/lo8GQojh5H4wR3/GWsBN3tFRHFlvY+jXDU8SQh0fKieGCoXWcbOSCG+O1nDwKrm
         +jkO+fw3LVmmk9a7T5AsxzbeOHOo8P7b2CW9NsrixfRHgt7/iJiLSdI5TS8Nk10b+cd1
         E0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDcmF4WJhppM0lHyIvdxz0gJh69khnnRWTA8FPWPgGI=;
        b=Tb0QSZIkfWhdy2NqS/urTEyfBq0ahENKUNT7Gpnz0FdMAqnMcxq+zs+rB9SOMTsRuC
         Orz2FKzKyL0jSmasTH/2NP5QHju3wBp/SiLm546UrxF8yUvhKiFrP0Ay+uQmLoP77yBV
         G3CWcP6PqadPb5enMZVsaxX6ZPJWgRV3dqiZM46YkxFEh7zyIPEhZ6a0RHmWrj+0cRuK
         8bwoV9FyRiYSirqPF4iWh+2lekdfK519YxnFiGAY7ReK9qs9JwASdghTKt435j+uZSKf
         CMXETm26SgMLilubQSRkCbd11QhEoBYcu6udiL0MyamGUbQQ1/OE+INgwsMJVM7axxNs
         z1wA==
X-Gm-Message-State: AOAM533ZM5oSeCZb9ZBIErL3/Y8e5kOM3UTxgxPxOxMGeg6cX9t8AO6d
        2/8GBWfGjLOHfJMhaD3h1yK3b62B0YtNHwJnP+s=
X-Google-Smtp-Source: ABdhPJw1q5iQzMlxOg83Zj4o0nrUCECrM6n3rMAuGxy4dpgFaYgkm5XxWXmzuO/g21ybAn24u5i6eSsRJ2CXXno1iMo=
X-Received: by 2002:a92:d28c:: with SMTP id p12mr25440369ilp.7.1600356185409;
 Thu, 17 Sep 2020 08:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153700.5572-1-ztong0001@gmail.com> <20200917083015.GB4595@lst.de>
In-Reply-To: <20200917083015.GB4595@lst.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 17 Sep 2020 11:22:54 -0400
Message-ID: <CAA5qM4BUirF=EZqdtXOAfvSwcGqQ9voFZqrxHedsB8ndF+bJUQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix doulbe irq free
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 4:30 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 16, 2020 at 11:37:00AM -0400, Tong Zhang wrote:
> > the irq might already been released before reset work can run
>
> If it is we have a problem with the state machine, as we shouldn't
> have two resets running at the same time.  Can you share your reproducer?
>

Hi Christoph,
Thanks for replying.

It is possible that pci_free_irq() can be called twice for the same IRQ,
the first call can be

[  124.413113] nvme nvme0: I/O 6 QID 0 timeout, disable controller
[  124.414317] Workqueue: kblockd blk_mq_timeout_work
[  124.414317] Call Trace:
[  124.414317]  dump_stack+0x7d/0xb0
[  124.414317]  nvme_suspend_queue.cold+0x11/0x58
[  124.414317]  nvme_dev_disable+0x116/0x7b0
[  124.414317]  nvme_timeout+0x309/0x320
[  124.414317]  ? nvme_shutdown+0x40/0x40
[  124.414317]  ? load_balance+0xe76/0x1450
[  124.414317]  ? deref_stack_reg+0x40/0x40
[  124.414317]  ? sched_clock_local+0x99/0xc0
[  124.414317]  blk_mq_check_expired+0x313/0x340
[  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
[  124.414317]  ? _find_next_bit.constprop.0+0x3e/0xf0
[  124.414317]  blk_mq_queue_tag_busy_iter+0x2e9/0x4a0
[  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
[  124.414317]  ? blk_mq_all_tag_iter+0x10/0x10
[  124.414317]  ? _raw_write_lock_irqsave+0xd0/0xd0
[  124.414317]  ? run_rebalance_domains+0x80/0x80
[  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
[  124.414317]  ? debug_object_deactivate.part.0+0x1c4/0x210
[  124.414317]  blk_mq_timeout_work+0xaa/0x1f0
[  124.414317]  ? __blk_mq_end_request+0x1f0/0x1f0
[  124.414317]  ? __schedule+0x581/0xc40
[  124.414317]  ? read_word_at_a_time+0xe/0x20
[  124.414317]  ? strscpy+0xbf/0x190
[  124.414317]  process_one_work+0x4ad/0x7e0
[  124.414317]  worker_thread+0x73/0x690
[  124.414317]  ? process_one_work+0x7e0/0x7e0
[  124.414317]  kthread+0x199/0x1f0
[  124.414317]  ? kthread_create_on_node+0xd0/0xd0
[  124.414317]  ret_from_fork+0x22/0x30

And the second call can be
[  149.763974] nvme nvme0: Failed to read smart log (error -4)
[  149.774307] Trying to free already-free IRQ 10
[  149.774385] Call Trace:
[  149.774385]  pci_free_irq+0x13/0x20
[  149.774385]  nvme_reset_work.cold+0x1be/0xa78
[  149.774385]  ? nvme_probe+0x8c0/0x8c0
[  149.774385]  ? check_preempt_curr+0x9d/0xf0
[  149.774385]  ? ttwu_do_wakeup.isra.0+0x176/0x190
[  149.774385]  ? try_to_wake_up+0x37c/0x900
[  149.774385]  ? migration_cpu_stop+0x1e0/0x1e0
[  149.774385]  ? __schedule+0x581/0xc40
[  149.774385]  ? read_word_at_a_time+0xe/0x20
[  149.774385]  ? strscpy+0xbf/0x190
[  149.774385]  process_one_work+0x4ad/0x7e0
[  149.774385]  worker_thread+0x73/0x690
[  149.774385]  ? process_one_work+0x7e0/0x7e0
[  149.774385]  kthread+0x199/0x1f0
[  149.774385]  ? kthread_create_on_node+0xd0/0xd0
[  149.774385]  ret_from_fork+0x22/0x30

and clearly something is not working as expected.


- Tong
