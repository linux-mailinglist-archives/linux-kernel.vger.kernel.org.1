Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4949125802C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgHaSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgHaSDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:03:49 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E682083E;
        Mon, 31 Aug 2020 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897028;
        bh=sBQktVgfiJR+zkrFUXEtlcEbz7yhs8v7mNvhO30mbgA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=aO3BNq3AsyMTopF9yR+4643ygwT7FWmtR/QZioMOvqmKqfWgU4r9smEO5eUNRj4KF
         6fZ/mTdqOGZdIkBiBUuE5rsUJNQbfj+iZy3xAnO2xqDlJJHigHXC2lp+N153QWNl0z
         VoArXg+rthfMnGRkvfrb/14rd6BFltI8qQREsGQk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2E36D35230F1; Mon, 31 Aug 2020 11:03:48 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:03:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/14] Torture-test updates for v5.10
Message-ID: <20200831180348.GA416@paulmck-ThinkPad-P72>
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

This series provides torture-test updates for v5.10:

1.	Remove KCSAN stubs from rcutorture.c.

2.	Output number of elapsed grace periods.

3.	document --allcpus argument added to the kvm.sh script.

4.	Make function torture_percpu_rwsem_init() static.

5.	Replace HTTP links with HTTPS ones.

6.	Update initrd documentation.

7.	Add CONFIG_PROVE_RCU_LIST to TREE05.

8.	Add kvm.sh --help and update help message.

9.	Properly set rcu_fwds for OOM handling.

10.	Properly synchronize with OOM notifier.

11.	Avoid null pointer dereference when buf fails to allocate.

12.	Hoist OOM registry up one level.

13.	Allow pointer leaks to test diagnostic code.

14.	Add gdb support.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt           |   12 ++
 kernel/locking/locktorture.c                              |    2 
 kernel/rcu/rcutorture.c                                   |   61 +++++++++-----
 kernel/rcu/refscale.c                                     |    8 +
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh  |   33 +++++--
 tools/testing/selftests/rcutorture/bin/kvm.sh             |   30 ++++++
 tools/testing/selftests/rcutorture/configs/rcu/TREE05     |    1 
 tools/testing/selftests/rcutorture/doc/initrd.txt         |   36 +-------
 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt |   41 +++++++--
 9 files changed, 154 insertions(+), 70 deletions(-)
