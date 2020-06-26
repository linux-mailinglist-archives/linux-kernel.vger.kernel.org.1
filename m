Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376AC20AB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 06:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgFZEMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 00:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgFZEMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:12:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF2920767;
        Fri, 26 Jun 2020 04:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593144753;
        bh=mH3fgegvAMw88KIXqT9GoWN67oTIoBSRBIWsIiPCOXI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=oRA1sQ2M/IlPQMQjhu7uqq1gDrDoXQ/ZOv0I3w+Rk2Mq7zcoBn/rbU2wyrm4Gd/vD
         XZew+OupN+c8tZd0fC1u5KZMtKP1KCDCooey6WLgIOladrhtdBUW1hmwzrz1hkIR4i
         qr8xnxZinLvIPxpHcbbtKWu+4+86cYOzLqZ0mn7Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D342B3523611; Thu, 25 Jun 2020 21:12:32 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:12:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     peterz@infradead.org, x86@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [GIT RFC PULL rcu/urgent] Fix noinstr warnings for KCSAN
Message-ID: <20200626041232.GA10544@paulmck-ThinkPad-P72>
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

This pull request contains a single commit that uses "arch_" atomic
operations to avoid the instrumentation that comes with the non-"arch_"
versions.  In preparation for that commit, it also has another commit
that makes these "arch_" atomic operations available to generic code.

Without these commits, KCSAN uses can see pointless errors.

This pull request is currently RFC pending ongoing -next testing.
This was not entirely free of drama, with Stephen needing to handle
a merge conflict:

https://lore.kernel.org/lkml/20200626131425.73ee4e27@canb.auug.org.au/

However, the resolution looks straightforward to me.  In addition,
these two commits pass rcutorture testing and associated KCSAN testing.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent

for you to fetch changes up to b58e733fd774f3f4b49d9e7640d172a57e35200e:

  rcu: Fixup noinstr warnings (2020-06-25 08:24:32 -0700)

----------------------------------------------------------------
Peter Zijlstra (2):
      locking/atomics: Provide the arch_atomic_ interface to generic code
      rcu: Fixup noinstr warnings

 include/linux/atomic-fallback.h       | 236 +++++++++++++++++++++++++++++++++-
 include/linux/compiler.h              |   2 +-
 kernel/rcu/tree.c                     |  32 ++++-
 scripts/atomic/gen-atomic-fallback.sh |  31 +++++
 4 files changed, 292 insertions(+), 9 deletions(-)
