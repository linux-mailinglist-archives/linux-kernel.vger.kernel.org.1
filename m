Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0308F294E56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443355AbgJUOP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442646AbgJUOP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:15:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DB722248;
        Wed, 21 Oct 2020 14:15:23 +0000 (UTC)
Date:   Wed, 21 Oct 2020 10:15:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        tglx@linutronix.de, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, guoren@kernel.org, atishp@atishpatra.org,
        mhiramat@kernel.org, greentime.hu@sifive.com,
        colin.king@canonical.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
Message-ID: <20201021101522.3d1f3865@gandalf.local.home>
In-Reply-To: <20201021101216.4d840e15@gandalf.local.home>
References: <20201021073839.43935-1-zong.li@sifive.com>
        <20201021101216.4d840e15@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 10:12:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> > Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> > multi_cpu_stop()")  
> 
> I really do not like to add "notrace" to core functions because a single
> architecture has issues with it. Why does RISCV have problems with these
> functions but no other architecture does?
> 
> NACK from me until it is shown that these are issues for a broader set of
> architectures.

After looking at the two above fixes, I take back my NACK ;-)

One of them duplicates an already notraced function, so that looks fine.
The other makes a static function global, which could cause issues as well.

After further review:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

