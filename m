Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032CF2B301E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKNTYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgKNTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:24:18 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976DE22265;
        Sat, 14 Nov 2020 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605381858;
        bh=oAUh7waXSZLaP9xaixIDertHYoeWyt+PRxnBjA/2DWU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Irn1YITZ6QNPml7NRgb0h06X3+Jd2sRRsCwE1XexZFjsBpYnodCUF68GEAeQ3Wdrt
         zuDfdEavBc1F8Ix0mREctGn/w+cz2DNRbZRPZEatF/lsrltAzW2DGFHXRRx9yFwJl0
         8JKIPfSNdzKRAJfUc2JUrlDffGuQn5ibicvfQp2w=
Message-ID: <0936e53c297ef3202ce3a48a135053f468c427af.camel@kernel.org>
Subject: Re: [PATCH RT 1/5] net: Properly annotate the try-lock for the
 seqlock
From:   Tom Zanussi <zanussi@kernel.org>
To:     Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Date:   Sat, 14 Nov 2020 13:24:16 -0600
In-Reply-To: <6209c8773bb1d361266046323f266526a810f850.camel@gmx.de>
References: <20201110153853.463368981@goodmis.org>
         <20201110154024.958923729@goodmis.org>
         <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
         <aa57c01bceaaac362d4da6e25427827fabe4d37a.camel@kernel.org>
         <6209c8773bb1d361266046323f266526a810f850.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-14 at 20:00 +0100, Mike Galbraith wrote:
> On Fri, 2020-11-13 at 14:14 -0600, Tom Zanussi wrote:
> > 
> > This patch seems to fix it for me:
> 
> If there was any discussion about this patch, I missed it.

There wasn't, just this thread.

> 
> > From 4855377d0cb34b1b67a5c6d84cc8609c9da0bc3e Mon Sep 17 00:00:00
> > 2001
> > Message-Id: <
> > 4855377d0cb34b1b67a5c6d84cc8609c9da0bc3e.1605297603.git.zanussi@kernel.org
> > >
> > From: Tom Zanussi <zanussi@kernel.org>
> > Date: Fri, 13 Nov 2020 13:04:15 -0600
> > Subject: [PATCH] net: Add missing __raw_write_seqcount_end() and
> >  seqcount_release()
> > 
> > The patch ('net: Properly annotate the try-lock for the seqlock")
> > adds
> > __raw_write_seqcount_begin() in qdisc_run_begin() but omits the
> > corresponding __raw_write_seqcount_end() and seqcount_release() in
> > qdisc_run_end().
> > 
> > Add it unconditionally, since qdisc_run_end() is never called
> > unless
> > qdisc_run_begin() succeeds, and if it succeeds,
> > __raw_write_seqcount_begin() seqcount_acquire() will have been
> > called.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  include/net/sch_generic.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 112d2dca8b08..c5ccce4f8f62 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -192,7 +192,11 @@ static inline bool qdisc_run_begin(struct
> > Qdisc *qdisc)
> >  static inline void qdisc_run_end(struct Qdisc *qdisc)
> >  {
> >  #ifdef CONFIG_PREEMPT_RT
> > +	seqcount_t *s = &qdisc->running.seqcount;
> > +
> >  	write_sequnlock(&qdisc->running);
> > +	__raw_write_seqcount_end(s);
> > +	seqcount_release(&s->dep_map, 1, _RET_IP_);
> >  #else
> >  	write_seqcount_end(&qdisc->running);
> >  #endif
> 
> __raw_write_seqcount_end() is an integral part of write_sequnlock(),
> but we do seem to be missing a seqcount_release() in 5.4-rt.
> 

Yep, you're right, it's just the missing seqcount_release() - I'll
resubmit with just that.

Thanks,

Tom

> 	-Mike
> 

