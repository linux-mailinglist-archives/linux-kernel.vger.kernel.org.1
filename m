Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E904D291FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgJRUpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJRUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:45:42 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E5AC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:45:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so6799510iod.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKTSMKnBBntskJxXCHe76M5UvhP9W2JrsVKUQLedmmI=;
        b=gSlJQdAZ4uRNPlxTg1d7933cdn+aa5kzZcwLRqa8Xxy0I7vEYbx4279qB7CHilU9gq
         yXt61p8z80hdL9ZvY9f6mpXL6Do7/DStrNEirxobGGhpASOiMSlvclbx30Q/h4IrLZT0
         MtxkROOfgJa+B5Wqu2BCrl1xgbpCAUs6aXYj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKTSMKnBBntskJxXCHe76M5UvhP9W2JrsVKUQLedmmI=;
        b=AeGMxqiCD3GOtR9WRuRpO0UF/uRvP062nuWedvGmgQWtesiXiIedpE/miggG7wVIVn
         YPk6MFTJP+Gy5PUGAeZuFyySYemKnl4uJxXhc+6fCIikyh2HmDp4Ohj6N2P6DX5zZSZa
         P1+nWaIOhb5jq3zLW3SWaJ+qEsR1qzGbiEYYEF/IpeUGqh2RTbncwfE0x2lpjSlvtCj6
         YlsRFHSlc2YnwP7USfTLxNcUugKGf0MkZIkEkPLEEG8rbB24HPLyCUtrO/p1HJbhGn4s
         /y6e2MdZ9C2VUnETRrc8hZ+P8V1Hwi6ZKgvcPEA/0+yM8PP16ssXEN94d5pFBkBlczVV
         oH6Q==
X-Gm-Message-State: AOAM531RXP9535piNQRCRfJb9AHZaLZ5N+4+tZiqLmP3Mufync/xAD1N
        usNNlv/4LN7MVQJYgSGORbx5P/I/FmO8OxGGFmEWKg==
X-Google-Smtp-Source: ABdhPJyvswYMlE/NLEgBEsM43jwQMOUtPWjuE2EPgiPd9BV6keR8ujjPzfoMnM3/tB7tJjrjd2OAuy8ze3yN57/Lfew=
X-Received: by 2002:a02:ec3:: with SMTP id 186mr1585910jae.92.1603053941905;
 Sun, 18 Oct 2020 13:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org> <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com> <20201017031941.GD4015033@google.com> <20201017202411.GC842001@rowland.harvard.edu>
In-Reply-To: <20201017202411.GC842001@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Oct 2020 13:45:31 -0700
Message-ID: <CAEXW_YQ--s-0aYGFtO46ptf9y9LjoRhXvv3Ksk-QTYpLQYGaJg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain smp_mb()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks Alan for your replies.

On Sat, Oct 17, 2020 at 1:24 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> [I sent this reply earlier, but since it hasn't shown up in the mailing
> list archives, I may have forgotten to include the proper CC's.  At the
> risk of repeating myself, here it is again.]

Np, I did get your first reply and wanted to take a deep look before
replying. Also things here have been crazy.

>
> On Fri, Oct 16, 2020 at 11:19:41PM -0400, joel@joelfernandes.org wrote:
> > So I made a litmus test to show that smp_mb() is needed also after the update
> > to length. Basically, otherwise it is possible the callback will see garbage
> > that the module cleanup/unload did.
> >
> > C rcubarrier+ctrldep
> >
> > (*
> >  * Result: Never
> >  *
> >  * This litmus test shows that rcu_barrier (P1) prematurely
> >  * returning by reading len 0 can cause issues if P0 does
> >  * NOT have a smb_mb() after WRITE_ONCE(len, 1).
> >  * mod_data == 2 means module was unloaded (so data is garbage).
> >  *)
> >
> > { int len = 0; int enq = 0; }
> >
> > P0(int *len, int *mod_data, int *enq)
> > {
> >       int r0;
> >
> >       WRITE_ONCE(*len, 1);
> >       smp_mb();               /* Needed! */
> >       WRITE_ONCE(*enq, 1);
> >
> >       r0 = READ_ONCE(*mod_data);
> > }
> >
> > P1(int *len, int *mod_data, int *enq)
> > {
> >       int r0;
> >       int r1;
> >
> >       r1 = READ_ONCE(*enq);
> >
> >       // barrier Just for test purpose ("exists" clause) to force the..
> >       // ..rcu_barrier() to see enq before len
> >       smp_mb();
> >       r0 = READ_ONCE(*len);
> >
> >       // implicit memory barrier due to conditional */
> >       if (r0 == 0)
> >               WRITE_ONCE(*mod_data, 2);
> > }
> >
> > // Did P0 read garbage?
> > exists (0:r0=2 /\ 1:r0=0 /\ 1:r1=1)
>
> Is this exists clause really what you meant?  Not only can it not be
> satisfied, it couldn't even be satisfied if you left out the 0:r0=2
> part.  And smp_mb() is stronger than neessary to enforce this.

This is indeed what I meant.

Maybe the exists clause can be simplified, but I just wanted to
enforce that P1 saw P0's write to enq before seeing anything else.

Per my test, if you remove the smp_mb() in P0, the test will fail.

What I wanted to show was P0() seeing mod_data == 2 is bad and should
never happen (as that implies rcu_barrier() saw len == 0 when it
should not have). Maybe you can point out what is my test missing?

> However, some memory barrier is needed.  If the smp_mb() in P1 were
> omitted then P1 would be free to reorder its reads, and the exists
> clause could be satisfied as follows:
>
>         P0                      P1
>         ------------------------------------------
>                                 Read len = 0
>         Write len = 1
>         smp_mb();
>         Write enq = 1
>                                 Read enq = 1
>                                 Write mod_data = 2
>         Read mod_data = 2

Right, so I think I got it right then. I want to show that the control
dependency in P1 provides the needed ordering. The extra smp_mb() I
added was just so that I could force P1 to see P0's enqueue.

Thanks!

 - Joel
