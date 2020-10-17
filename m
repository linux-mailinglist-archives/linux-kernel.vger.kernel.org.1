Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B915290F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436749AbgJQFtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436732AbgJQFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:49:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC2C05BD11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:19:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j17so4902579ilr.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bJgUMZO3YTSbeM5AMCQb0/+aRiqChbCB39IRnkW7Nro=;
        b=j1Ea2sdeMEYWzpsqOCaXEkzCUYagNXrAn/nD1xOgdnU3Nk8EaZs6HLhgKerJQCTgaH
         uMuHf9RuOIta5gWWmc87pmEC1gYS/wbOPBwY3j6WTWAT03ylXTXpi2tXGH8I5no6HmS0
         xgZ0CpL/V2W7W/R829tYaS/blSkj2QiHcywnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJgUMZO3YTSbeM5AMCQb0/+aRiqChbCB39IRnkW7Nro=;
        b=nQ9zPN18YNXb8eM0/0KjckumW8w2c/XBH5En4NQquIzQdJZ9NJCEJr/Ft6NoelWu1r
         xVi9Dcn4Ko+PooU7JBqHOIrxiWRr5LvVcLBXj4jvLzI1ulDN8dzg12fH4J3pvCu/oRzC
         pqM1WOk7RNbGB1j4LO705YR/tCiCehaOrc1Yw3aQhDR38fkbt05K+V77eqdW3s5cbtfh
         XWSlUP84pxtiSaI4CeO43RdyAL5eYvYqqBd5KjeTMvnynxpOLHJ4YGX2nYqpvziRRyKf
         Bn3/1OI61YH03LON+0yUeOzEcEvbcJS6p0pMk5SulHOF5v85Fr7UYm28u8cvUxtJ6R3B
         aCXw==
X-Gm-Message-State: AOAM533xXyrcLgWZZUHtyDbsEC7wGJALEh+TEXuq2Noe8EbTASDMtq2V
        csWQBaKAeflRVTAFxWMl7kWYhg==
X-Google-Smtp-Source: ABdhPJwqqZuBXrStzbcWS274m3dqBdhvLdxCjevJYH0MQwp99RRhJ/egixNKM9ynkCNsjRgxu606+A==
X-Received: by 2002:a92:85d5:: with SMTP id f204mr5216560ilh.108.1602904783370;
        Fri, 16 Oct 2020 20:19:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id y75sm4132922iof.36.2020.10.16.20.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 20:19:42 -0700 (PDT)
Date:   Fri, 16 Oct 2020 23:19:41 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com, stern@rowland.harvard.edu
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201017031941.GD4015033@google.com>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017012753.GB4015033@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
[..]
> > > + *
> > > + * Memory barrier is needed after adding to length for the case
> > > + * where length transitions from 0 -> 1. This is because rcu_barrier()
> > > + * should never miss an update to the length. So the update to length
> > > + * has to be seen *before* any modifications to the segmented list. Otherwise a
> > > + * race can happen.
> > > + * P0 (what P1 sees)	P1
> > > + * queue to list
> > > + *                      rcu_barrier sees len as 0
> > > + * set len = 1.
> > > + *                      rcu_barrier does nothing.
> > 
> > So that would be:
> > 
> >       call_rcu()                    rcu_barrier()
> >       --                            --
> >       WRITE(len, len + 1)           l = READ(len)
> >       smp_mb()                      if (!l)
> >       queue                            check next CPU...
> > 
> > 
> > But I still don't see against what it pairs in rcu_barrier.
> 
> Actually, for the second case maybe a similar reasoning can be applied
> (control dependency) but I'm unable to come up with a litmus test.
> In fact, now I'm wondering how is it possible that call_rcu() races with
> rcu_barrier(). The module should ensure that no more call_rcu() should happen
> before rcu_barrier() is called.
> 
> confused

So I made a litmus test to show that smp_mb() is needed also after the update
to length. Basically, otherwise it is possible the callback will see garbage
that the module cleanup/unload did.

C rcubarrier+ctrldep

(*
 * Result: Never
 *
 * This litmus test shows that rcu_barrier (P1) prematurely
 * returning by reading len 0 can cause issues if P0 does
 * NOT have a smb_mb() after WRITE_ONCE(len, 1).
 * mod_data == 2 means module was unloaded (so data is garbage).
 *)

{ int len = 0; int enq = 0; }

P0(int *len, int *mod_data, int *enq)
{
	int r0;

	WRITE_ONCE(*len, 1);
	smp_mb();		/* Needed! */
	WRITE_ONCE(*enq, 1);

	r0 = READ_ONCE(*mod_data);
}

P1(int *len, int *mod_data, int *enq)
{
	int r0;
	int r1;

	r1 = READ_ONCE(*enq);

	// barrier Just for test purpose ("exists" clause) to force the..
	// ..rcu_barrier() to see enq before len
	smp_mb();		
	r0 = READ_ONCE(*len);

	// implicit memory barrier due to conditional */
	if (r0 == 0)
		WRITE_ONCE(*mod_data, 2);
}

// Did P0 read garbage?
exists (0:r0=2 /\ 1:r0=0 /\ 1:r1=1)

