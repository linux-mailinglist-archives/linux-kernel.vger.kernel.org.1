Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035022EB793
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbhAFB0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAFB0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:26:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFCFC22CB9;
        Wed,  6 Jan 2021 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896341;
        bh=UT74fBmbCViSCvuVn+wHay+sQ7VvlXVZ8ATzd0Nm6LA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Ca/XyxpwrZVvSRUOQC5lGSK8JC+VZsKBa+E2V7wRhXaSIjKvxvn5F9v/aNOGYSKV5
         7bjXZCN8IxGHyHkGzJA8UkHL0uBu1/8rHp45CDtflijWRhTESSGmhl2ha9qNQFbn8A
         7GWlbaegyPOujvZN6/oo2Q57QkzOuWBZs/p5jNX1VdoSwN0nlwkqVIcHyANaYCRDT3
         04ZuN6NEXjkfIJwVPrP5W73XMe5kzUWPKMMeruylD1F64TGf/vZcEdZmpGoshXGikY
         WKl2zhhfJk9qxX/+iVb3XP6Y5Gww0QRbo4z2sKSHz074kStEYgnSa5pDP78s2d3oJ+
         c0ZHHaSGU+Hkw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 903D235228C6; Tue,  5 Jan 2021 17:25:41 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:25:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/6] Track callbacks on a per-segment basis
Message-ID: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds counts to the rcu_segcblist structure that track the
number of callbacks in each segment, allowing RCU to distinguish between
(for example) a need to get grace periods done or get callbacks invoked
(or, for that matter, both).

1.	Make rcu_do_batch count how many callbacks were executed,
	courtesy of "Joel Fernandes (Google)".

2.	Add additional comments to explain smp_mb(), courtesy of "Joel
	Fernandes (Google)".

3.	Add counters to segcblist datastructure, courtesy of "Joel
	Fernandes (Google)".

4.	segcblist: Remove redundant smp_mb()s, courtesy of "Joel Fernandes
	(Google)".

5.	Add tracing for how segcb list changes, courtesy of "Joel
	Fernandes (Google)".

6.	Add debug checks for segment lengths, courtesy of "Joel Fernandes
	(Google)".

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcu_segcblist.h |    1 
 include/trace/events/rcu.h    |   26 +++++
 kernel/rcu/rcu_segcblist.c    |  203 +++++++++++++++++++++++++++++++-----------
 kernel/rcu/rcu_segcblist.h    |    6 -
 kernel/rcu/srcutree.c         |    5 -
 kernel/rcu/tree.c             |   29 ++++--
 6 files changed, 209 insertions(+), 61 deletions(-)
