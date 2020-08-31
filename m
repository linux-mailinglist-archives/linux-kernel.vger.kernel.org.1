Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01440258081
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgHaSN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHaSN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:13:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9532068E;
        Mon, 31 Aug 2020 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897636;
        bh=DF0izavjdmeGeaXgA0B2pSC/Buesr/ysHUDE0xFp5m4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=bDk3gdg/OnvlYX8v8+tw2nR0ufAB8Bu5ASufxJrGy8dRGVyvSds35w5R3iAHvB7W/
         /Dt7emqhgmtnFfaUgJUFDAe+2AjrPYm/NsPfVgyEk3soesubW/YEr0a7CoUZWalHBh
         ECOI6XriDy4CRyT5n0ZiN1eUyJe11zlmsJMEBouI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6ED5035230F1; Mon, 31 Aug 2020 11:13:56 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:13:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Add smp_call_function() debugging for v5.10
Message-ID: <20200831181356.GA1224@paulmck-ThinkPad-P72>
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

This series adds debugging code for stalled smp_call_function() handlers:

1.	Add backtrace_idle parameter to force backtrace of idle CPUs.

2.	Add source and destination CPUs to __call_single_data.

3.	kernel/smp: Provide CSD lock timeout diagnostics.

4.	Make symbol 'csd_bug_count' static.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    4 
 include/linux/smp.h                             |    3 
 include/linux/smp_types.h                       |    3 
 kernel/smp.c                                    |  136 +++++++++++++++++++++++-
 lib/Kconfig.debug                               |   11 +
 lib/nmi_backtrace.c                             |    6 -
 6 files changed, 161 insertions(+), 2 deletions(-)
