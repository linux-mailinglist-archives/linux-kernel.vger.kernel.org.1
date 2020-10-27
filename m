Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0629BF13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814929AbgJ0RAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793873AbgJ0PIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:08:49 -0400
Received: from localhost.localdomain (i16-lef01-ix2-212-195-25-126.ft.lns.abo.bbox.fr [212.195.25.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A80206E5;
        Tue, 27 Oct 2020 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811328;
        bh=ji2nueDyFlaJc2i0cHxEefk0VAf9O16YPXiMwU/GjRY=;
        h=From:To:Cc:Subject:Date:From;
        b=1TIYYP80bCV0QcwfNdq302eWpWxxCxtNcfKaL34+47UeIRRa3Jg7JKH/VHpY0W0Tt
         BJwdY/LEcudt13ZaWQ4ylTKHSuby3Y/wb/a/3AhfpUa+lbi0UVcVhHQgatK4b6ZKTt
         keFFy9CECMCl8aLUDrXHe+FGAw39qF5/WVKLl94c=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/5] context_tracking: Flatter archs not using exception_enter/exit() v2
Date:   Tue, 27 Oct 2020 16:08:22 +0100
Message-Id: <20201027150827.148821-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to turn on/off nohz_full at runtime, we'll need
the archs to give up saving the context tracking state on the task stack
because this forces context tracking to run system wide, even on CPUs
that don't have nohz_full enabled.

Now being able to do so require sane entry code meeting some
requirements that at least x86 just achieved recently (I haven't checked
other archs yet).

Changes since v2:

- Rebase against v5.10-rc1
- Use SCHED_WARN_ON() instead of WARN_ON_ONCE() for the context tracking
  sanity check on schedule().

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	core/isolation-v2

HEAD: 79f60f3dd0e0aea8b17c825371d8697444ae5faf

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
