Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239432B3F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKPJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:11:00 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:50697 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgKPJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:10:59 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 923C71C43BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:10:57 +0000 (GMT)
Received: (qmail 12950 invoked from network); 16 Nov 2020 09:10:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 09:10:56 -0000
Date:   Mon, 16 Nov 2020 09:10:54 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Loadavg accounting error on arm64
Message-ID: <20201116091054.GL3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got cc'd internal bug report filed against a 5.8 and 5.9 kernel
that loadavg was "exploding" on arch64 on a machines acting as a build
servers. It happened on at least two different arm64 variants. That setup
is complex to replicate but fortunately can be reproduced by running
hackbench-process-pipes while heavily overcomitting a machine with 96
logical CPUs and then checking if loadavg drops afterwards. With an
MMTests clone, I reproduced it as follows

./run-mmtests.sh --config configs/config-workload-hackbench-process-pipes --no-monitor testrun; \
    for i in `seq 1 60`; do cat /proc/loadavg; sleep 60; done

Load should drop to 10 after about 10 minutes and it does on x86-64 but
remained at around 200+ on arm64.

The reproduction case simply hammers the case where a task can be
descheduling while also being woken by another task at the same time. It
takes a long time to run but it makes the problem very obvious. The
expectation is that after hackbench has been running and saturating the
machine for a long time.

Commit dbfb089d360b ("sched: Fix loadavg accounting race") fixed a loadavg
accounting race in the generic case. Later it was documented why the
ordering of when p->sched_contributes_to_load is read/updated relative
to p->on_cpu.  This is critical when a task is descheduling at the same
time it is being activated on another CPU. While the load/stores happen
under the RQ lock, the RQ lock on its own does not give any guarantees
on the task state.

Over the weekend I convinced myself that it must be because the
implementation of smp_load_acquire and smp_store_release do not appear
to implement acquire/release semantics because I didn't find something
arm64 that was playing with p->state behind the schedulers back (I could
have missed it if it was in an assembly portion as I can't reliablyh read
arm assembler). Similarly, it's not clear why the arm64 implementation
does not call smp_acquire__after_ctrl_dep in the smp_load_acquire
implementation. Even when it was introduced, the arm64 implementation
differed significantly from the arm implementation in terms of what
barriers it used for non-obvious reasons.

Unfortunately, making that work similar to the arch-independent version
did not help but it's not helped that I know nothing about the arm64
memory model.

I'll be looking again today to see can I find a mistake in the ordering for
how sched_contributes_to_load is handled but again, the lack of knowledge
on the arm64 memory model means I'm a bit stuck and a second set of eyes
would be nice :(

-- 
Mel Gorman
SUSE Labs
