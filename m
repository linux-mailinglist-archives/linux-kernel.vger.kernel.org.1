Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A92C9525
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgLACYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgLACY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:24:29 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC61220809;
        Tue,  1 Dec 2020 02:23:48 +0000 (UTC)
Date:   Mon, 30 Nov 2020 21:23:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 01/14] ftrace: Fix updating FTRACE_FL_TRAMP
Message-ID: <20201130212346.31e2a8b7@oasis.local.home>
In-Reply-To: <56c113aa9c3e10c19144a36d9684c7882bf09af5.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
        <56c113aa9c3e10c19144a36d9684c7882bf09af5.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 23:38:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On powerpc, kprobe-direct.tc triggered FTRACE_WARN_ON() in
> ftrace_get_addr_new() followed by the below message:
>   Bad trampoline accounting at: 000000004222522f (wake_up_process+0xc/0x20) (f0000001)
> 
> The set of steps leading to this involved:
> - modprobe ftrace-direct-too
> - enable_probe
> - modprobe ftrace-direct
> - rmmod ftrace-direct <-- trigger
> 
> The problem turned out to be that we were not updating flags in the
> ftrace record properly. From the above message about the trampoline
> accounting being bad, it can be seen that the ftrace record still has
> FTRACE_FL_TRAMP set though ftrace-direct module is going away. This
> happens because we are checking if any ftrace_ops has the
> FTRACE_FL_TRAMP flag set _before_ updating the filter hash.
> 
> The fix for this is to look for any _other_ ftrace_ops that also needs
> FTRACE_FL_TRAMP.

I'm applying this now and sending this for -rc and stable.

The code worked on x86 because x86 has a way to make all users use
trampolines, so this was never an issue (everything has a trampoline).
I modified the kernel so that x86 would not create its own trampoline
(see the weak function arch_ftrace_update_trampoline(), and I was able
to reproduce the bug.

I'm adding:

Cc: stable@vger.kernel.org
Fixes: a124692b698b0 ("ftrace: Enable trampoline when rec count returns back to one")

Thanks!

-- Steve


> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/trace/ftrace.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8185f7240095f4..9c1bba8cc51b03 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1629,6 +1629,8 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
>  static struct ftrace_ops *
>  ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
>  static struct ftrace_ops *
> +ftrace_find_tramp_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude);
> +static struct ftrace_ops *
>  ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
>  
>  static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> @@ -1778,7 +1780,7 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  			 * to it.
>  			 */
>  			if (ftrace_rec_count(rec) == 1 &&
> -			    ftrace_find_tramp_ops_any(rec))
> +			    ftrace_find_tramp_ops_any_other(rec, ops))
>  				rec->flags |= FTRACE_FL_TRAMP;
>  			else
>  				rec->flags &= ~FTRACE_FL_TRAMP;
> @@ -2244,6 +2246,24 @@ ftrace_find_tramp_ops_any(struct dyn_ftrace *rec)
>  	return NULL;
>  }
>  
> +static struct ftrace_ops *
> +ftrace_find_tramp_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude)
> +{
> +	struct ftrace_ops *op;
> +	unsigned long ip = rec->ip;
> +
> +	do_for_each_ftrace_op(op, ftrace_ops_list) {
> +
> +		if (op == op_exclude || !op->trampoline)
> +			continue;
> +
> +		if (hash_contains_ip(ip, op->func_hash))
> +			return op;
> +	} while_for_each_ftrace_op(op);
> +
> +	return NULL;
> +}
> +
>  static struct ftrace_ops *
>  ftrace_find_tramp_ops_next(struct dyn_ftrace *rec,
>  			   struct ftrace_ops *op)

