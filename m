Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C297A2F8DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbhAPRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbhAPRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA47C06138D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LVmTpyaDUYYU77ebxo6jkzUi32557khoLNpH/skJ208=; b=wERDfYvSXygoKCK80kbfKZw8hd
        8uaeW0BzpJmQBXDckTiCLqYPef3sC6paHvutDzO1G44LIz9k8BqWJaHClKHJx8wp6c4ps78fh6l5F
        r9ZisDckgN4SKhiAHKFwKhbGxhppBq3JUpJL8uGCQvsg/9g2J+kzVcIiUxikjQnfuERmTMn5gZFfu
        9FnOBjfuryhF5hG5j9Zh83vB/i4oebv6QYPhklkpQCK6Aql+1J25V4dU8xqru7yFkAdo05nPVAx2e
        IgzE56/Gvr0zHC0c+9oEZN/sMyqMMX5xZYfp/gdbZ/bLoOE9OcPPnh1B0L/bzvKUT2I++vg5v+Q3+
        6cgbBwuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0nJa-00AOVx-FA; Sat, 16 Jan 2021 15:16:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F12C43010CF;
        Sat, 16 Jan 2021 16:16:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D42BF202A3F5A; Sat, 16 Jan 2021 16:16:33 +0100 (CET)
Date:   Sat, 16 Jan 2021 16:16:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <YAMDUQ7JX2Fr8D+/@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
 <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
 <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
 <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
 <CAJhGHyDT2FWsn15-_DQ4b_bkrRi74MzNnWt7YWTO49cSv4yjbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDT2FWsn15-_DQ4b_bkrRi74MzNnWt7YWTO49cSv4yjbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 10:45:04PM +0800, Lai Jiangshan wrote:
> On Sat, Jan 16, 2021 at 8:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > It is also the exact sequence normal per-cpu threads (smpboot) use to
> > preserve affinity.
> 
> Other per-cpu threads normally do short-live works. wq's work can be
> lengthy, cpu-intensive, heavy-lock-acquiring or even call
> get_online_cpus() which might result in a deadlock with kthread_park().

kthread_park() is called by the migration thread running the
workqueue_online_cpu() callback.

kthread_parkme() is called by the worker thread, after it completes a
work and has no locks held from that context.


