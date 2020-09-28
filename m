Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8538727B0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgI1PTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgI1PTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:19:19 -0400
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A6D2158C;
        Mon, 28 Sep 2020 15:19:18 +0000 (UTC)
Date:   Mon, 28 Sep 2020 11:19:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: KASAN: global-out-of-bounds in console_unlock
Message-ID: <20200928151911.GA964@home.goodmis.org>
References: <CACT4Y+a8yAm2HFJkz+pgYDm4QV+5S8K5FH3wVn4e8kgbMzcXdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a8yAm2HFJkz+pgYDm4QV+5S8K5FH3wVn4e8kgbMzcXdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 11:12:23AM +0200, Dmitry Vyukov wrote:
> Hi printk maintainers,
> 
> I've got the following out-of-bounds in printk code.
> This is on next-20200925. Config is attached.
> This is just on pr_cont("\n"). Something overreads the string.
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in memchr+0x65/0x80 lib/string.c:1058
> Read of size 1 at addr ffffffff8c68c860 by task swapper/0/0

Would be helpful to show the text before this, so we have a better idea of
where it happened.

-- Steve


> 
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc6-next-20200925+ #43
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x14b/0x18f lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x4c5 mm/kasan/report.c:385
>  __kasan_report mm/kasan/report.c:545 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
>  memchr+0x65/0x80 lib/string.c:1058
>  memchr include/linux/string.h:450 [inline]
>  record_print_text+0x22d/0x310 kernel/printk/printk.c:1369
>  console_unlock+0x350/0xbc0 kernel/printk/printk.c:2477
>  vprintk_emit+0x348/0x4b0 kernel/printk/printk.c:2021
>  vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:393
>  printk+0xba/0xed kernel/printk/printk.c:2069
>  show_pwq+0x74d/0x7ee kernel/workqueue.c:4745
>  show_workqueue_state.cold+0xd0/0x3c9 kernel/workqueue.c:4784
>  wq_watchdog_timer_fn+0x2e5/0x370 kernel/workqueue.c:5798
>  call_timer_fn+0x38/0x2d0 kernel/time/timer.c:1413
>  expire_timers kernel/time/timer.c:1458 [inline]
>  __run_timers kernel/time/timer.c:1755 [inline]
>  __run_timers kernel/time/timer.c:1731 [inline]
>  run_timer_softirq+0xad2/0x1440 kernel/time/timer.c:1770
>  __do_softirq+0x1f0/0x6c4 kernel/softirq.c:298
>  asm_call_irq_on_stack+0xf/0x20
