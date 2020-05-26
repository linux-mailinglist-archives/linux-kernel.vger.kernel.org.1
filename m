Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3781DBD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:44:27 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07EC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:44:27 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ee19so1829716qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qOfQCDp2HCW/1be9NabwoRwd9cyNa6cUtRAtXPrtw2Q=;
        b=b1JgVhbtcDcRNeATwCgHH5AGRGpf3saVLNB3dDZvn+H/h35zl6CsrNZ+GxBXTR2aeg
         cVoYL05pM/HKI9vVU2OSY4TmyQA09Zff5DL7CULZseWaFfE213rT0lt98yjN3oqAKEIu
         MWlW4j4S+ldfXObUm/4Ha8Jij9Ij7PgpI/lhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qOfQCDp2HCW/1be9NabwoRwd9cyNa6cUtRAtXPrtw2Q=;
        b=tVY0dKWuSO24jV0EqyAW0Izremv217GUs2vGXTQSzyZaKuKvKxqRXRq+TKXh0gR3jA
         KXAWDBItHtYxqIAPnHA2AIUEbvCq3xMzRXY5qg0ndb/SFhBduxAruEVvN4Stf5g5bqmG
         HDoNb4LNi5tgGpuUZg8LkzYVpiZIIvqlZD3klJz/77TH8YM3/skl4i6TuXyXs7TsYpxU
         Xd8Qevjduszey/jBbgxx2u8wO7KNVOKR7u3YxjNlxcHmhnifYFntFHq6IMWcfYGcIpqQ
         t+fnzjSUEsiQm1colCRqElNhzSBRBNg85U4/TauWvlOXkqstfEj+SygpY81niPyoVmmI
         JaWw==
X-Gm-Message-State: AOAM531ZRZ3AGRppvbr+6D2e1ce6UYgmeKmukXIUqH4D70d35xd9hat+
        +7HdoyV+KKKS49eWs8BKHddbrg==
X-Google-Smtp-Source: ABdhPJxNBIVSAm0uep+3KJcPcEhvTbKTZVvSyElPmhQoJlY9o5W1rPI2gSIRz5Z5i7syUzAvNn35+w==
X-Received: by 2002:a0c:fe88:: with SMTP id d8mr6045164qvs.208.1590000266269;
        Wed, 20 May 2020 11:44:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d196sm2926006qkg.16.2020.05.20.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:44:25 -0700 (PDT)
Date:   Wed, 20 May 2020 14:44:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20200520184425.GA261674@google.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520174259.GA247557@google.com>
 <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
 <20200520183529.GR317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520183529.GR317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:35:29PM +0200, Peter Zijlstra wrote:
> On Wed, May 20, 2020 at 08:28:00PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-05-20 13:42:59 [-0400], Joel Fernandes wrote:
> > > Hi Sebastian,
> > Hi Joel,
> > 
> > > For pointer stability, can we just use get_local_ptr() and put_local_ptr()
> > > instead of adding an extra lock? This keeps the pointer stable while keeping
> > > the section preemptible on -rt. And we already have a lock in rcu_data, I
> > > prefer not to add another lock if possible.
> > 
> > What is this get_local_ptr() doing? I can't find it anywhere…
> 
> I suspect it is ({ preempt_disable(); this_cpu_ptr(ptr); }), or
> something along those lines.
> 
> But yeah, I can't find it either.

I actually found it in RT 4.4 kernel, I thought this was also on newer RT
kernels as well (is that not true anymore?). But yes it was exactly what
Peter said.

In 4.4 RT there's code similar to:

#ifdef CONFIG_PREEMPT_RT_FULL

# define get_local_ptr(var) ({          \
                migrate_disable();      \
                this_cpu_ptr(var);      })

# define put_local_ptr(var) do {        \
        (void)(var);                    \
        migrate_enable();               \
} while (0)

#else

#define get_local_ptr(var)      get_cpu_ptr(var)
#define put_local_ptr(var)      put_cpu_ptr(var)

#endif


thanks,

 - Joel

