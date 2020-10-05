Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA428342B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJEKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJEKtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:49:25 -0400
Received: from localhost.localdomain (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38192075A;
        Mon,  5 Oct 2020 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894965;
        bh=7Mo/rbupLA5iByzcgS5bcb5Wmp/CdScuRgPoST20Tgw=;
        h=From:To:Cc:Subject:Date:From;
        b=FiWeedAEDIDxz4bESfPoG8L2VUgLPM0gR+0XT2jC6yytZi/lp+aeymh0j2ap+IdVO
         tyZM5ED8WfkSLeqKME4V0/7VFQpvwikQTKALfuKNAprgJT8FMw060C6auafBaf8GEL
         MmhYfMClNtyuTpr29Kr0uZELpP+10SN6yR5KgnmA=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/5] context_tracking: Flatter archs not using exception_enter/exit()
Date:   Mon,  5 Oct 2020 12:49:14 +0200
Message-Id: <20201005104919.5250-1-frederic@kernel.org>
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

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	core/isolation

HEAD: d52271b6d5d02ead1916d65b013d11a7d90501b9

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
