Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881833043AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392862AbhAZQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392769AbhAZQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:19:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E2C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bTVvC5dBR5FLlE9aUyJVC2BZBj2HyB/7vwwlQxUnBck=; b=C5keJZV7t+vZnW8XTMdFqGzzfn
        MVc5vqicYyZPKSy4dENoX77LyL3g3KjXZKd5IVEmEPUwwPLrQ8o2bvOQRW++UxJ4AzAFhpGyD8cCz
        gt/jNNPVkdtsYeuSRoqWTaimij6c/k3vzpEriSMovk4d78bobHpvRFW7VyYmI3VQoMP+n+u2gv9LG
        2PgZXzyM7CI46JEzMc+pYIBZoh1eGfFglfECV2US9ZQWBv8IsHdl1zaZJFVQFt3g2OfvCk7NfOI4y
        1APsxeqTel7ylYt8TlozliWM+u25T4/gevo40zgxFrKjlvVeLLkku2vRF+Ko8NRYmxVSFigcZP59n
        TFO51hUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4R3V-0000lO-0F; Tue, 26 Jan 2021 16:19:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79CC13019CE;
        Tue, 26 Jan 2021 17:18:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46C002C538ED8; Tue, 26 Jan 2021 17:18:59 +0100 (CET)
Date:   Tue, 26 Jan 2021 17:18:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix BUG: Invalid wait context in hrtimer_interrupt()
Message-ID: <YBBA81osV7cHN2fb@hirez.programming.kicks-ass.net>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <YA+em8XkTidYetGE@jagdpanzerIV.localdomain>
 <20210126145917.r64vzibgpiwyuake@e107158-lin>
 <874kj3lo3h.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kj3lo3h.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 04:28:42PM +0106, John Ogness wrote:
> On 2021-01-26, Qais Yousef <qais.yousef@arm.com> wrote:
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


> pl011_console_write() does:
> 
>     local_irq_save(flags);
>     spin_lock(&uap->port.lock);
> 
> This needs to be:
> 
>     spin_lock_irqsave(&uap->port.lock, flags);
> 
> Of course, it will be a trickier than that because of the
> @oops_in_progress madness. This bug has been around for quite a while.

Well yes, but that's not going to be fixing anything.

The problem is that sugov_work() is holding a raw_spin_lock, and you're
trying to acquire a spin_lock.

That's an invalid lock nesting.
