Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC72EC168
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbhAFQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbhAFQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:48:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0412023135;
        Wed,  6 Jan 2021 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951667;
        bh=UV0tZhfkA5omdOxfPApW2a6F+GY9ELXTOfg24VU/ocs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=kRUC5uiXYnrMa6GjpOWRa6djCWhHA0qRpyplL+8Y7esFW44Bn3Rmr9uRy9aLp98gI
         110LIwzeNMBjwtHG12gGpbx/Qnj2H6l5/15gA020snE1ZsDdw9O84Vj46N2GRLJ4po
         TXRhUN7PD08TYB3BOfME4JrCACu3BL6I5A8ww4yFioqNb2+t2UmCLlM+3ZMVYVIALx
         IvphIupJqEONF+P22uUbcY4iHg9J62C/6lyZXB3s9zm/imLJtuS4pkPorIHkhL0YGb
         rF/2ZVipLYqM12TfmH/JWbjVirCH//DB4w2CmEstW/j6jDr8lSNMD8CLlr5tb9dpHC
         96LMYoh3SvT1Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BB4F035225EC; Wed,  6 Jan 2021 08:47:46 -0800 (PST)
Date:   Wed, 6 Jan 2021 08:47:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] Real-time updates for v5.12
Message-ID: <20210106164746.GA19969@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides some real-time enhancements:

1.	Make RCU_BOOST default on CONFIG_PREEMPT_RT, courtesy of Sebastian
	Andrzej Siewior.

2.	Unconditionally use rcuc threads on PREEMPT_RT, courtesy of
	Scott Wood.

3.	Enable rcu_normal_after_boot unconditionally for RT, courtesy
	of Julia Cartwright.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |   11 +++++++++++
 kernel/rcu/Kconfig                              |    4 ++--
 kernel/rcu/tree.c                               |    4 +++-
 kernel/rcu/update.c                             |    4 +++-
 4 files changed, 19 insertions(+), 4 deletions(-)
