Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CEC1DBD77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgETTAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:00:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E6C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:59:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so3434187qts.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ARORx90bNZfE3lIvpSPFr7pFGC2F13RJPiz07NfvAWg=;
        b=xqOCj1hi7zsdkF4h7T7VpVsacljZUmQ98KBXk4BC/Dbn1LZa5faEmx2QjtoDIrVUFb
         P6lu0RuOXjmco5U/CykEp8x4g7RdNl7UvG4m0sChWHzGk3hIX45vYFUqw7L/RamVwzoI
         IUgUbP9dHwHRi8zBAlVHX2JlNghk6esJwZciA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ARORx90bNZfE3lIvpSPFr7pFGC2F13RJPiz07NfvAWg=;
        b=neFNAP24ryIy3PzhAIkk2ntfqyysmbbF7C9TPgjZc/2jlvyR4lHbGkvpaMjSKuNDix
         Yh2/IuWBPmit+LzmJf0rb+og8rzeVSDecK4ORnx/YxorMjj2fw2fSVHFD/7twZUPDykq
         Gs23AUTsRJunsxzKHZbPeu+YtNXF6dn2taAiTmEAa/6fYKVLfKwJpCCEXfTuRGl9jopF
         iz1GFsqUua/W/1qPbclTpFqlJWY38qbk51lcLOFZynwuNwKkAZXVhI87oms3lSocAxh9
         lN1ZhSdM2BXnzK/M+pxqRHaN7JvdBCC7txSU/QvOwT6USnHJhgzVB6WsL+T2bXNWuMOZ
         PhEg==
X-Gm-Message-State: AOAM5321TE3TMtDszOTRs7NRU3T2VPqWrLc6CpS/Xj5Bo16rNDGT254w
        l7HSnLs0Cpy17fhHfwvqNC9s4Q==
X-Google-Smtp-Source: ABdhPJxKFQ4mBEMmbP/Kvr56rfPGG/twBhTQVRIoKgmz5lGIunly4e1J2W2rXX4eFpW+AV4T6MpO7A==
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr6859997qtr.7.1590001198693;
        Wed, 20 May 2020 11:59:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h12sm3428451qte.31.2020.05.20.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:59:58 -0700 (PDT)
Date:   Wed, 20 May 2020 14:59:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520185957.GB261674@google.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520174259.GA247557@google.com>
 <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:28:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 13:42:59 [-0400], Joel Fernandes wrote:
> > Hi Sebastian,
> Hi Joel,
> 
> > For pointer stability, can we just use get_local_ptr() and put_local_ptr()
> > instead of adding an extra lock? This keeps the pointer stable while keeping
> > the section preemptible on -rt. And we already have a lock in rcu_data, I
> > prefer not to add another lock if possible.
> 
> What is this get_local_ptr() doing? I can't find it anywhere…

I replied about it in the other thread.

 
> > > I remember Paul looked at that patch a few years ago and he said that
> > > that disabling interrupts here is important and matches the other part
> > > instance where the interrupts are disabled. Looking at it now, it seems
> > > that there is just pointer stability but I can't tell if
> > > rcu_segcblist_pend_cbs() needs more than just this.
> > 
> > Which 'other part' are you referring to? Your patch removed local_irq_save()
> > from other places as well right?
> 
> The patch converted hunks.
> 

So then there are no other local_irq_save() to match with. Or may be I did
not understand your concern, could you share any threads from past
discussions about disabling interrupts in this code? You mentioned about a
discussion from few years ago.

> > 
> >  - Joel
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 8ff71e5d0fe8b..5f49919205317 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -778,13 +778,17 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> >  	unsigned long tlast;
> >  
> >  	/* If the local srcu_data structure has callbacks, not idle.  */
> > -	local_irq_save(flags);
> > -	sdp = this_cpu_ptr(ssp->sda);
> > +	sdp = get_local_ptr(ssp->sda);
> > +	spin_lock_irqsave_rcu_node(sdp, flags);
> 
> You acquire the node lock which was not acquired before. Is that okay?
> How is get_local_ptr() different to raw_cpu_ptr()?

get_cpu_ptr() disables preemption which you might not want, right?

Most (all?) other paths are accessing the cblist under lock so I added it
here to be safe. This is anyway called from a slowpath. Do you see a problem?

thanks,

 - Joel

