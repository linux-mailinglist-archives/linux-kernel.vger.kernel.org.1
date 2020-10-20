Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251182934AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392059AbgJTGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:17:03 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:54290 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392050AbgJTGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:17:02 -0400
X-IronPort-AV: E=Sophos;i="5.77,396,1596492000"; 
   d="scan'208";a="473405968"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 08:16:59 +0200
Date:   Tue, 20 Oct 2020 08:16:59 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Waiman Long <longman@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: slowdown due to reader-owned rwsem time-based spinning
In-Reply-To: <31a92ff6-280a-12f6-9b5a-a904501ceb04@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2010200804220.2736@hadrien>
References: <alpine.DEB.2.22.394.2010151315190.2869@hadrien> <ddbf4694-10c2-cd7e-b0ed-3ae54f262bde@redhat.com> <alpine.DEB.2.22.394.2010192143290.2781@hadrien> <31a92ff6-280a-12f6-9b5a-a904501ceb04@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Oct 2020, Waiman Long wrote:

> On 10/19/20 3:48 PM, Julia Lawall wrote:
> >
> > On Mon, 19 Oct 2020, Waiman Long wrote:
> >
> > > On 10/15/20 7:38 AM, Julia Lawall wrote:
> > > > Hello,
> > > >
> > > > Phoenix is an implementation of map reduce:
> > > >
> > > > https://github.com/kozyraki/phoenix
> > > >
> > > > The phoenix-2.0/tests subdirectory contains some benchmarks, including
> > > > word_count.
> > > >
> > > > At the same time, on my server, since v5.8, the kernel has changed from
> > > > using the governor intel_pstate by default to using intel_cpufreq.
> > > > Intel_cpufreq causes kworkers to run on all cores every 0.004 seconds,
> > > > while intel_pstate involves very few such stray processes.
> > > >
> > > > Suprisingly, all those kworkers cause the word_count benchmark to run
> > > > 2-3
> > > > times faster.  I bisected the problem back to the following commit,
> > > > whcih
> > > > was introduced in v5.3:
> > > >
> > > > commit 7d43f1ce9dd075d8b2aa3ad1f3970ef386a5c358
> > > > Author: Waiman Long <longman@redhat.com>
> > > > Date:   Mon May 20 16:59:13 2019 -0400
> > > >
> > > >       locking/rwsem: Enable time-based spinning on reader-owned rwsem
> > > >
> > > > Representative traces are attached.  word_count_5.9pwrsvpassive_1.pdf is
> > > > the one with the kworkers.
> > > >
> > > > I don't know the Phoenix code in detail, but the problem seems to be in
> > > > the infrastructure not the specific word count aplication, because most
> > > > of
> > > > the benchmarks seem to suffer similarly.  Some of the other benchmarks
> > > > seem to take a variable and long amount of time to get started in the
> > > > active mode, so perhaps the problem could be in reading the initial
> > > > dataset.
> > > >
> > > > Before I plunge into it, do you have any suggestions as to what could be
> > > > the problem?
> > > I am a bit confused as to what you are looking for. So you said this patch
> > > make the benchmark run 2-3 times faster. Is this a problem? What are you
> > > trying to achieve? Is it to make the passive case similar to the active
> > > case?
> > Sorry, it seems that I was not clear.  Prior to the commit above the
> > active case had good performance,  The patch caused the active case to
> > slow down by 2-3 times.  Adding lots of kworkers that interrupt the
> > threads eliminated the slowdown.
> >
> > > What this patch does is to allow writer waiting for a rwsem to spin for a
> > > while hoping the readers will release the lock soon to acquire the lock.
> > > Before that, the writer will go to sleep immediately when the rwsem is
> > > owned
> > > by readers. Probably because of that, the kworkers keep on running for a
> > > much
> > > longer time as long as there are no other tasks competing for the CPUs.
> > No, the kworkers don't run for a long time.  My hypothesis is that the
> > kworkers interrupt a thread that is spinning waiting for a lock and thus
> > allow the thread that is holding the lock to run.
> >
> Thanks for the clarification. Now I see what you mean by thinking this is a
> problem?
>
> However, the reader spinning is about 25us max. So I am puzzled by the long
> idle period in between busy period in the active chart. I will need to
> reproduce this condition myself to see what has gone wrong. What is
> configuration of your test machine as well as config option you used for the
> kernel and the boot command line parameters?

80 physical cores, 160 hardware threads.  4 sockets.  Intel(R) Xeon(R) CPU
E7-8870 v4 @ 2.10GHz

Boot options:  ro quiet intel_pstate=active

Benchmark suite: https://github.com/kozyraki/phoenix.git

phoenix-2.0/tests/word_count/word_count datasets/word_count/word_count_datafiles/word_100MB.txt

Traces from Linux 5.9 of several of the benchmarks are available at
https://pages.lip6.fr/Julia.Lawall/px.pdf

julia
