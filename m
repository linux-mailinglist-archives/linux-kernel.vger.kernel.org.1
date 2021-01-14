Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035232F56A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbhANBup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbhANA0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:26:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C5223343;
        Thu, 14 Jan 2021 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610583929;
        bh=hj0ttrtO+I7uIdrqBxjsOm+ixDPUVLqz2OSyRappDMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJrynKBlUsTQw0v28foD/IgUc4gJ2OmtsIZFGIRTHTQFZzt6Tvu93RQVOBU+cYY1X
         QtUU2ghc5pDKwAV22+5IjutSSMxU2epq1j3lmah0eEL+7JlyhTEBzLVF672TrOyXXw
         YbP3w+Z6VS90pvHH4wE3VMDhYDbG2/Scj8SiMSuEH4KkkJdy+OlGzE0qfNyQ9JPiIV
         33054vx3XbahWxJ+gcTGt99OBDQMC73MTO18eCQtMP91emYpcr7pIAHKSfLgkCOV7C
         t8U/qWzRcRviyw/rVgAZe90a8ytghNKTp8/4eeGfLRM+XZFhqrXA+SbAuj3dh2fUAZ
         gAwJXLFNLXNCw==
Date:   Thu, 14 Jan 2021 09:25:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
Message-Id: <20210114092525.5a2e78b404602fa82d6d6353@kernel.org>
In-Reply-To: <20210113174845.7b1da377@gandalf.local.home>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
        <20201130161850.34bcfc8a@gandalf.local.home>
        <20201202083253.9dbc76704149261e131345bf@kernel.org>
        <9dff21f8-4ab9-f9b2-64fd-cc8c5f731932@huawei.com>
        <20201215123119.35258dd5006942be247600db@kernel.org>
        <c584f7e2-1d95-4f6a-7e36-4ff2d610bc78@huawei.com>
        <20201222200356.6910b42c165b8756878cc9b0@kernel.org>
        <20210113174845.7b1da377@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 17:48:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Anything more on this?

I need Wangshaobo's confirmation, because this is essentially a kind of programming bug,
not a runtime bug. kprobes user must check the kprobe(kretprobe) must be unregistered
and cleaned up before reusing it. (I recommend to re-alloc new data structure each time)

For example, if you re-register your driver/filesystem without releasing, it will
break the kernel.

Thank you,

> 
> -- Steve
> 
> 
> On Tue, 22 Dec 2020 20:03:56 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 21 Dec 2020 21:31:42 +0800
> > "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com> wrote:
> > 
> > > Hi steven, Masami,
> > > We have encountered a problem, when we attempted to use steven's suggestion as following,
> > >   
> > > >>> If you call this here, you must make sure kprobe_addr() is called on rp->kp.
> > > >>> But if kretprobe_blacklist_size == 0, kprobe_addr() is not called before
> > > >>> this check. So it should be in between kprobe_on_func_entry() and
> > > >>> kretprobe_blacklist_size check, like this
> > > >>>
> > > >>> 	if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
> > > >>> 		return -EINVAL;
> > > >>>
> > > >>> 	addr = kprobe_addr(&rp->kp);
> > > >>> 	if (IS_ERR(addr))
> > > >>> 		return PTR_ERR(addr);
> > > >>> 	rp->kp.addr = addr;  
> > > 
> > > //there exists no-atomic operation risk, we should not modify any rp->kp's information, not all arch ensure atomic operation here.
> > >   
> > > >>>
> > > >>> 	ret = check_kprobe_rereg(&rp->kp);
> > > >>> 	if (WARN_ON(ret))
> > > >>> 		return ret;
> > > >>>
> > > >>>           if (kretprobe_blacklist_size) {
> > > >>> 		for (i = 0; > > +	ret = check_kprobe_rereg(&rp->kp);  
> > > 
> > > it returns failure from register_kprobe() end called by register_kretprobe() when
> > > we registered a kretprobe through .symbol_name at first time(through .addr is OK),
> > > kprobe_addr() called at the begaining of register_kprobe() will recheck and
> > > failed at following place because at this time we symbol_name is not NULL and addr is also.  
> > 
> > Good catch! Yes, it will reject if both kp->addr and kp->symbol are set.
> > 
> > > 
> > >    static kprobe_opcode_t *_kprobe_addr(const char *symbol_name,
> > >                           unsigned int offset)
> > >     {
> > >           if ((symbol_name && addr) || (!symbol_name && !addr))  //we failed here
> > > 
> > > 
> > > So we attempted to move this sentence rp->kp.addr = addr to __get_valid_kprobe() like this to
> > > avoid explict usage of rp->kp.addr = addr in register_kretprobe().
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index dd5821f753e6..ea014779edfe 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -1502,10 +1502,15 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
> > >   static struct kprobe *__get_valid_kprobe(struct kprobe *p)
> > >   {
> > >          struct kprobe *ap, *list_p;
> > > +       void *addr;
> > > 
> > >          lockdep_assert_held(&kprobe_mutex);
> > > 
> > > -       ap = get_kprobe(p->addr);
> > > +       addr = kprobe_addr(p);
> > > +       if (IS_ERR(addr))
> > > +               return NULL;
> > > +
> > > +       ap = get_kprobe(addr);
> > >          if (unlikely(!ap))
> > >                  return NULL;
> > > 
> > > But it also failed when we second time attempted to register a same kretprobe, it is also
> > > becasue symbol_name and addr is not NULL when we used __get_valid_kprobe().  
> > 
> > What the "second time" means? If you reuse the kretprobe (and kprobe) you must
> > reset (cleanup) the kp->addr or kp->symbol_name. That is the initial state.
> > I think the API should not allow users to enter inconsistent information.
> > 
> > > 
> > > So it seems has no idea expect for modifying _kprobe_addr() like following this, the reason is that
> > > the patch 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()")
> > > has telled us we'd better use symbol name to register but not address anymore.
> > > 
> > > -static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
> > > -                       const char *symbol_name, unsigned int offset)
> > > +static kprobe_opcode_t *_kprobe_addr(const char *symbol_name,
> > > +                       unsigned int offset)
> > >   {
> > > -       if ((symbol_name && addr) || (!symbol_name && !addr))
> > > +       kprobe_opcode_t *addr;
> > > +       if (!symbol_name)
> > >                  goto invalid;  
> > 
> > No, there are cases that the user will set only kp->addr, but no kp->symbol_name.
> > 
> > > 
> > > For us, this modification has not caused a big impact on other modules, only expects a little
> > > influence on bpf from calling trace_kprobe_on_func_entry(), it can not use addr to fill in
> > > rp.kp in struct trace_event_call anymore.
> > > 
> > > So i want to know your views, and i will resend this patch soon.  
> > 
> > OK, I think it is simpler to check the rp->kp.addr && rp->kp.symbol_name
> > because it is not allowed (it can lead inconsistent setting).
> > 
> > How about this code? Is this work for you?
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 41fdbb7953c6..73500be564be 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2103,6 +2103,14 @@ int register_kretprobe(struct kretprobe *rp)
> >         int i;
> >         void *addr;
> >  
> > +       /* It is not allowed to specify addr and symbol_name at the same time */
> > +       if (rp->kp.addr && rp->kp.symbol_name)
> > +               return -EINVAL;
> > +
> > +       /* If only rp->kp.addr is specified, check reregistering kprobes */
> > +       if (rp->kp.addr && check_kprobe_rereg(&rp->kp))
> > +               return -EINVAL;
> > +
> >         if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
> >                 return -EINVAL;
> >  
> > 
> > Thank you,
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
