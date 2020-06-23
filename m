Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3377C2045F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbgFWAnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731823AbgFWAnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9FBD206C1;
        Tue, 23 Jun 2020 00:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872990;
        bh=UYfkObX4mEplJeJU21X6rRuMo1ZXq66iS6uSaTW5y4Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=REx5tHWKvg1kC3XeDb56FGMUXPA9hKVSUyztrFXb0dkXrfCs8PPNtkBo8eJwikAF+
         Vrgu4g5mI0adnrOQt1x9cil+uO/Fd6JScbHkmoGCnWjyUJOLODfs3EYJKspapWjJ/+
         s5xhWSfW1TCRLOSNYaCqHtBCx4SUTFEwRvoS1dkw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A9304352306A; Mon, 22 Jun 2020 17:43:10 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:43:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/10] KCSAN updates for v5.9
Message-ID: <20200623004310.GA26995@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates:

1.	Annotate a data race in vm_area_dup(), courtesy of Qian Cai.

2.	x86/mm/pat: Mark an intentional data race, courtesy of Qian Cai.

3.	Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu().

4.	Add test suite, courtesy of Marco Elver.

5.	locking/osq_lock: Annotate a data race in osq_lock.

6.	Prefer '__no_kcsan inline' in test, courtesy of Marco Elver.

7.	Silence -Wmissing-prototypes warning with W=1, courtesy of Qian Cai.

8.	Rename test.c to selftest.c, courtesy of Marco Elver.

9.	Remove existing special atomic rules, courtesy of Marco Elver.

10.	Add jiffies test to test suite, courtesy of Marco Elver.

							Thanx, Paul

------------------------------------------------------------------------

 arch/x86/mm/pat/set_memory.c |    2 
 include/linux/rculist.h      |    2 
 kernel/fork.c                |    8 
 kernel/kcsan/Makefile        |    5 
 kernel/kcsan/atomic.h        |    6 
 kernel/kcsan/core.c          |    9 
 kernel/kcsan/kcsan-test.c    | 1111 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/kcsan/selftest.c      |    1 
 kernel/locking/osq_lock.c    |    6 
 lib/Kconfig.kcsan            |   23 
 10 files changed, 1161 insertions(+), 12 deletions(-)
