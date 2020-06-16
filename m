Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B01FB46A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgFPOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgFPOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:30:21 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372C9C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:30:21 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so6732023qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t0uezNPIA4DPn1fMOU/HGmpbf/fUK67RnoGEU6y3XpE=;
        b=eD+sNKEycQE63Edi/DqlPL+CemWI16ocqKlFZcPoyewIYkKTRL/RgZxMsWCJ1js/OJ
         FN+NCpL2bjYGKRbD+GhdeUoKtnIJZeCJr2ImkDgTmUuP3yUyqqKfLkMaUv4WMkBgZkQ6
         ca3m7G6KhDolNWboNm58b6BXvluWbOB/g9qVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t0uezNPIA4DPn1fMOU/HGmpbf/fUK67RnoGEU6y3XpE=;
        b=ua+u0SYxh/68rS+CMdItFHUhlbopu43PO9n3mhaQgNsVjrRZPY//IFWrJEFjcNKxRH
         Q4qKwf4FzJlTtzwIV9zwrAbFuT/NbpYCcUaY8rQdlwiSY3/ciRHKe1ClsEAAwU39HguA
         1nYRGJSHmLtcwpWZucsOC+B16/Rvq5MWHiZxLcGxJTbfCuzHd+A36oW9BagJJwMsxBZq
         j0ZPPkkcw6o0vLRuqJwFZYHiy7tlFy0O0dlwvlIWjFlBseHe8QFr6yic8Y/Y4EGZ+lOB
         wLHt7BNgW6kZI6bmyNtifxK1tPGOXum13CH3dWKxPcqvEDLLi/y9krbmqYOWIaazTiPU
         WXcQ==
X-Gm-Message-State: AOAM530kBi3DcXXX9lkDC2gfKuY73cQMm72S6RzfRxh4vv13EFP2obKd
        hmx+2gvpeDS4pYqALmPvuoU8og==
X-Google-Smtp-Source: ABdhPJywrL0y9Qnl17gxOSVSUuXxYDLpAiXTNObZD2/Uwi6Lrx3GSj0S6iTFmAZdcPbwOFcdkqcbLg==
X-Received: by 2002:a05:6214:10e5:: with SMTP id q5mr2550328qvt.47.1592317820204;
        Tue, 16 Jun 2020 07:30:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 126sm14401177qkj.89.2020.06.16.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:30:19 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:30:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
Message-ID: <20200616143018.GD12037@google.com>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
 <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
 <871rmkzcc8.fsf@nanos.tec.linutronix.de>
 <87wo4cxubv.fsf@nanos.tec.linutronix.de>
 <20200615201647.GC12037@google.com>
 <871rmfcskb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rmfcskb.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:40:04AM +0200, Thomas Gleixner wrote:
> Joel,
> 
> Joel Fernandes <joel@joelfernandes.org> writes:
> > On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
> >> This is also correct vs. user mode entries in NOHZ full scenarios because
> >> user mode entries bring RCU out of EQS and force the RCU irq nesting state
> >
> > I had to re-read this sentence a couple of times. The 'user mode entries'
> > sounds like 'entry into user mode'. It would be good to reword it to 'IRQ
> > entry in user mode'.
> 
> :)
> 
> > My knowledge predates the rcu-watching reworks so apologies on the below
> > question but I still didn't fully follow why when the idle task behaves
> > differently from being in user mode. Even with user mode we should have:
> >
> > <user mode>  (in EQS)
> >   <irq entry>   <---------- exits EQS so now rcu is watching
> >      <softirq entry in the exit path>
> >         <timer tick irq entry>  <-- the buggy !watching logic prevents rcu_irq_enter
> > 	    -> report QS since tick thinks it is first level.
> >
> > Is there a subtlety here I'm missing? I checked the RCU code and I did not
> > see anywhere that rcu_user_enter() makes it behave differently. Both
> > rcu_user_enter() and rcu_idle_enter() call rcu_eqs_enter().
> 
> The interrupt hit user mode entry does:
> 
>     idtentry_enter_cond_rcu()
>       if (user_mode(regs))
>          enter_from_user_mode()
>            user_exit_irqoff()
>              __context_tracking_exit(CONTEXT_USER)
>                rcu_user_exit()
>                  rcu_eqs_exit(1)
>                    ...
>                    WRITE_ONCE(rdp->dynticks_nmi_nesting,
>                               DYNTICK_IRQ_NONIDLE);
> 
> i.e. for interrupts which enter from user mode we are not invoking
> rcu_irq_enter() at all.
> 
> The return from interrupt path has nothing to do with that because
> that's an entry in kernel mode.

Hi Thomas,
Ah, IRQ entry in user mode triggers the context-tracking path. Makes sense now, thanks.

This will help me when I have to propose to get rid of dynticks_nmi_nesting again :)

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

