Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D02C8FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbgK3VTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbgK3VTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:19:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A82C2076A;
        Mon, 30 Nov 2020 21:18:51 +0000 (UTC)
Date:   Mon, 30 Nov 2020 16:18:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
Message-ID: <20201130161850.34bcfc8a@gandalf.local.home>
In-Reply-To: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami,

Can you review this patch, and also, should this go to -rc and stable?

-- Steve


On Tue, 24 Nov 2020 19:57:19 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> Our system encountered a re-init error when re-registering same kretprobe,
> where the kretprobe_instance in rp->free_instances is illegally accessed
> after re-init.
> 
> Implementation to avoid re-registration has been introduced for kprobe
> before, but lags for register_kretprobe(). We must check if kprobe has
> been re-registered before re-initializing kretprobe, otherwise it will
> destroy the data struct of kretprobe registered, which can lead to memory
> leak, system crash, also some unexpected behaviors.
> 
> we use check_kprobe_rereg() to check if kprobe has been re-registered
> before calling register_kretprobe(), for giving a warning message and
> terminate registration process.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  kernel/kprobes.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 41fdbb7953c6..7f54a70136f3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2117,6 +2117,14 @@ int register_kretprobe(struct kretprobe *rp)
>  		}
>  	}
>  
> +	/*
> +	 * Return error if it's being re-registered,
> +	 * also give a warning message to the developer.
> +	 */
> +	ret = check_kprobe_rereg(&rp->kp);
> +	if (WARN_ON(ret))
> +		return ret;
> +
>  	rp->kp.pre_handler = pre_handler_kretprobe;
>  	rp->kp.post_handler = NULL;
>  	rp->kp.fault_handler = NULL;

	
