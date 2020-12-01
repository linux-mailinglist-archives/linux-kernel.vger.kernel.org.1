Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F42CB0D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgLAXdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgLAXdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:33:39 -0500
Date:   Wed, 2 Dec 2020 08:32:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606865578;
        bh=RjV/+djLvuKYAFobW56Ovd1Zp//PoPVTo3mRtOOeIX0=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=e0g8qDNqfCmXG96P152wtio6CtzFbaIJJ25PYUN+JAXuaq+VVoGLwLJympieK3mKN
         RLZZZ9q/BR0Swzs3DA9ycfnAnn3gdsW/fOGO/dK0MYDVGgiTsByRYGqSmpnx/q0hXt
         nKffPhXuCuUInObTP4g0EL0RPP4kNmXK6NvUReNc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
Message-Id: <20201202083253.9dbc76704149261e131345bf@kernel.org>
In-Reply-To: <20201130161850.34bcfc8a@gandalf.local.home>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
        <20201130161850.34bcfc8a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 16:18:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Masami,
> 
> Can you review this patch, and also, should this go to -rc and stable?
> 
> -- Steve

Thanks for ping me!

> On Tue, 24 Nov 2020 19:57:19 +0800
> Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
> 
> > Our system encountered a re-init error when re-registering same kretprobe,
> > where the kretprobe_instance in rp->free_instances is illegally accessed
> > after re-init.

Ah, OK. Anyway if re-register happens on kretprobe, it must lose instances
on the list before checking re-register in register_kprobe().
So the idea looks good to me.


> > Implementation to avoid re-registration has been introduced for kprobe
> > before, but lags for register_kretprobe(). We must check if kprobe has
> > been re-registered before re-initializing kretprobe, otherwise it will
> > destroy the data struct of kretprobe registered, which can lead to memory
> > leak, system crash, also some unexpected behaviors.
> > 
> > we use check_kprobe_rereg() to check if kprobe has been re-registered
> > before calling register_kretprobe(), for giving a warning message and
> > terminate registration process.
> > 
> > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> > ---
> >  kernel/kprobes.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 41fdbb7953c6..7f54a70136f3 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2117,6 +2117,14 @@ int register_kretprobe(struct kretprobe *rp)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Return error if it's being re-registered,
> > +	 * also give a warning message to the developer.
> > +	 */
> > +	ret = check_kprobe_rereg(&rp->kp);
> > +	if (WARN_ON(ret))
> > +		return ret;

If you call this here, you must make sure kprobe_addr() is called on rp->kp.
But if kretprobe_blacklist_size == 0, kprobe_addr() is not called before
this check. So it should be in between kprobe_on_func_entry() and
kretprobe_blacklist_size check, like this

	if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
		return -EINVAL;

	addr = kprobe_addr(&rp->kp);
	if (IS_ERR(addr))
		return PTR_ERR(addr);
	rp->kp.addr = addr;

	ret = check_kprobe_rereg(&rp->kp);
	if (WARN_ON(ret))
		return ret;

        if (kretprobe_blacklist_size) {
		for (i = 0; > > +	ret = check_kprobe_rereg(&rp->kp);


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
