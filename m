Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C83043D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405494AbhAZQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403906AbhAZQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD5DC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PJYWXwMWP1LD0/QSSlqke6xEpoOmE1VjNufMYxAn5C8=; b=R3VGehCt+c/X3Wzpdu2MkeZZ+Z
        UIy+VMXkOAMWilbuzy3PtEnIBal23BmYtaqwzY1WWYarJLmDFKvDcENbDEZ+PCiOHvSZ2sO9cQEEQ
        +z1oR5rdgMMC1gRXx6CYB2/ClpiXkCTW9xz3hO4VAaBis4Wwh9iH3mbDBRaAJfbEkvo6pQiht4Tkh
        nw6VAi/UCRRiecZpB9W6CjQ3ozLF/QBOVfI6EzurEeeL6YE5VoBrN5g6EARxGy5IXkR2E0Vil8BG7
        EaQQlaBH8IuGqczEy8hXfADsWpF6D5UDLU1YA12kbDhwP+5bCwySiH6OUxJUSnajhB4e846AI0lLX
        RDsRkuGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4R85-005u6O-1C; Tue, 26 Jan 2021 16:24:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25B573010C8;
        Tue, 26 Jan 2021 17:23:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1378F2029059B; Tue, 26 Jan 2021 17:23:44 +0100 (CET)
Date:   Tue, 26 Jan 2021 17:23:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix BUG: Invalid wait context in hrtimer_interrupt()
Message-ID: <YBBCDw8tBpgMSY3L@hirez.programming.kicks-ass.net>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <YA+em8XkTidYetGE@jagdpanzerIV.localdomain>
 <20210126145917.r64vzibgpiwyuake@e107158-lin>
 <YBA8KTyANXe0v1kR@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBA8KTyANXe0v1kR@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:58:33AM +0900, Sergey Senozhatsky wrote:
> On (21/01/26 14:59), Qais Yousef wrote:

> > 	# [67628.388606] hrtimer: interrupt took 304720 ns
> > 	[67628.393546]
> > 	[67628.393550] =============================
> > 	[67628.393554] [ BUG: Invalid wait context ]
> > 	[67628.393557] 5.11.0-rc3-00019-g86be331946f7 #37 Not tainted
> > 	[67628.393560] -----------------------------
> > 	[67628.393563] sugov:0/192 is trying to lock:
> > 	[67628.393566] ffff000800b1d898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x138/0x218
> > 	[67628.393581] other info that might help us debug this:
> > 	[67628.393584] context-{2:2}
> > 	[67628.393586] 4 locks held by sugov:0/192:
> > 	[67628.393589]  #0: ffff0008059cb720 (&sg_policy->work_lock){+.+.}-{4:4}, at: sugov_work+0x58/0x88
> > 	[67628.393603]  #1: ffff800015446f20 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x34/0xb0
> > 	[67628.393618]  #2: ffff8000152aaa60 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x12c/0x310
> > 	[67628.393632]  #3: ffff8000152aab88 (console_owner){-.-.}-{0:0}, at: console_unlock+0x190/0x6d8

> > Did I miss something?
> 
> printk() is not permitted to sleep/schedule/etc and it never does.
> Generally it should be OK to call it from IRQ (module recursion paths).

The report is that it is trying to acquire spin_lock() while holding
raw_spin_lock(), which is an invalid lock nesting.

Note that this is CONFIG_PROVE_RAW_LOCK_NESTING=y which specifically
checks for this.

On current (mainline) kernel configs this is not yet a problem, but the
moment we do land PREEMPT_RT this order will be problematic.
