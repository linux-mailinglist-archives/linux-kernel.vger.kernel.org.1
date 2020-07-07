Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12E3216901
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGGJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:27:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8FC061755;
        Tue,  7 Jul 2020 02:27:10 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:27:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594114028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLBTzIwDXRw8Ngy3frJIgWMDMydSG5GmWktyqhaqBeo=;
        b=MO7Ppzm9g4auQbN/35wAZgxdqPFOCGkJIsA1FU6fXW8rDsAD8z98NHJL4EpFs1MWQnqT0Z
        UX6AaIaphrgEw7cpzAqVHdV0VsaUoT3XlakzRjgZrWgyiuhTEi26xzLuvYLakLjK+w/LZS
        y6x6ShETS2+aKEkISOeG49AJBOS3SfNknmo3MqnZ2WBEt+9t7LQuw3pNcSQrP+oehQMTwh
        GXkDJTuKLDh1rQrDqQUH/lmmkyg3VUU5IHG4OmkDnQCxk6LSsFZEv18p4qryygjCNZnEWS
        VU0O4OxM761HgnjDn8/3wKBniuB2CRFu6m53V+6Tn2EcPUyAZum7sERzjKS2bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594114028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLBTzIwDXRw8Ngy3frJIgWMDMydSG5GmWktyqhaqBeo=;
        b=qaqbbubx9fvSPosR3yx7SvkqXwsNksqEypCk+pQW1mWQ0c7qkSnxMlduSpzkWLB7IvJMLB
        9ZBQWb3vznwTUxCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200707092707.eos6yiq5t6h7d7ko@linutronix.de>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702194506.GA31478@pc636>
 <20200706194232.GA233429@google.com>
 <20200706195557.GA24082@pc636>
 <20200706202949.GB233429@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706202949.GB233429@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 16:29:49 [-0400], Joel Fernandes wrote:
> Anyway, I think as we discussed on IRC, your proposal will work for both
> kernels while allowing us to keep the internal lock as raw.

Why can't we use the migrate_disable() and spinlock_t?

> thanks,
> 
>  - Joel

Sebastian
