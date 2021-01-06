Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31032EC17D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbhAFQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbhAFQwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:52:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E8122313A;
        Wed,  6 Jan 2021 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951930;
        bh=NU6sVwBU+rX1yOug4JMJ05CisnfqwFMj6wVt/23uDcQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KS2k8ZWESGEi4wrTDcj8iA8hn3jfPD/7yvZZ0i0TGupLcYV17h/TFG4ift5DdHh02
         ygYeAl/Q7rXH5799JFvWpXu3vIgVwz49ZTDREdOlrr4DwMjVPDkDKXEf9AOKrDNAeW
         vNf9fZklZDmsvz46R6hzXLEJ6SDDXcO+R3ukoikMQ0k7WYOG4UlWm48fa6f/WVhWyd
         T155S4E93il6asdlBgEQFqpPDVU99V7GVdRg0Z/Ye77UKiNxXOZFZb08qwgaK/TUJU
         VxHvnsuS5Rfejs9H9alwML+GhYIXxWDaM7YN6/6U8sdGHEId3rbsE0OqlmKMW9vLG8
         DlHVQJ/t0lqGw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1AB5735225EC; Wed,  6 Jan 2021 08:52:10 -0800 (PST)
Date:   Wed, 6 Jan 2021 08:52:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Stall-warning updates for v5.12
Message-ID: <20210106165210.GA20296@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series enhances RCU CPU stall-warning messages.

1.	Mark obtuse portion of stall warning as internal debug.

2.	For RCU grace-period kthread starvation, dump last CPU it ran on.

3.	Do not NMI offline CPUs.

4.	Check and report missed fqs timer wakeup on RCU stall, courtesy
	of Neeraj Upadhyay.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/stallwarn.rst |   23 +++++++++++++++
 kernel/rcu/tree.c               |   25 ++++++++++-------
 kernel/rcu/tree_exp.h           |    2 -
 kernel/rcu/tree_stall.h         |   58 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 90 insertions(+), 18 deletions(-)
