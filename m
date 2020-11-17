Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF402B6875
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgKQPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbgKQPQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:16:48 -0500
Received: from localhost.localdomain (unknown [176.167.180.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2809124198;
        Tue, 17 Nov 2020 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605626207;
        bh=T+zglwTSaKT1Oy/VUNqM5qfAwKuwu4cmh4SCTRct9Zw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRMyToxIR7yEwGtbSm/ls4iV+HPir19TbNB6Ea56nuiA5av7awCjF8Xuj2/BjkP59
         xddLjjlw7I3Fche0WzCKj5gQVWv8NRHdSlR1Gk9y9s/TBRmFuDXHWUUdMRimSBXAJy
         9wNjmLnNOH3fNSSgdFMyQSfHxpkC2WbrYnuK45E4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/5] context_tracking: Flatter archs not using exception_enter/exit() v3
Date:   Tue, 17 Nov 2020 16:16:32 +0100
Message-Id: <20201117151637.259084-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this new version, I fixed the changelogs according to peterz's review.
Especially on the 2nd patch where I added lots of details to better
understand what exception_enter/exit() do and what is required to get
rid of it.

Also rebased against -rc4.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	core/isolation-v3

HEAD: b358a96584150feacc20d7d10410fd1b7c7c19fe

Thanks,
	Frederic
---

Frederic Weisbecker (5):
      context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
      context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
      sched: Detect call to schedule from critical entry code
      context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
      x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK


 arch/Kconfig                     | 17 +++++++++++++++++
 arch/x86/Kconfig                 |  1 +
 include/linux/context_tracking.h |  6 ++++--
 kernel/sched/core.c              |  3 ++-
 4 files changed, 24 insertions(+), 3 deletions(-)
