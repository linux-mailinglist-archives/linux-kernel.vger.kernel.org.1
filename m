Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6951CEEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgELICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 04:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELIC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:02:28 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B1420733;
        Tue, 12 May 2020 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589270548;
        bh=pVizV8s8ToXA46EbYb4ZCvJRdiyFn9Hc7gKNyOAnDbM=;
        h=From:To:Cc:Subject:Date:From;
        b=JRLibpgPxs1CVo11Dxn3vN3PAJOghmaSTxDrulbnLeMtBDMW3DR2l1KAGOF6jNdyN
         1j4nagVa7nN27G9NR5YwIR8bi4f/rSzf0+FEQkaM3BuKns76eYUh4g6CWYqQKy+HNl
         yyKF0rr+nc36L0xWNBBx3tB67JmhKZqs1RsnhLFQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>
Subject: [PATCH -tip V6 0/6] kprobes: Fixes mutex, rcu-list warnings and cleanups
Date:   Tue, 12 May 2020 17:02:22 +0900
Message-Id: <158927054236.27680.18209720730136003586.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Here is the 6th version of the series for kprobes. The previous
version is here.

 https://lore.kernel.org/lkml/158583483116.26060.10517933482238348979.stgit@devnote2/

In this version, I picked 2 patches[1][2] which has been reviewed
on LKML but not merged to tip tree yet.

[1] https://lore.kernel.org/lkml/20200408164641.3299633-1-jolsa@kernel.org/
[2] https://lore.kernel.org/lkml/20200507185733.GA14931@embeddedor/

You can also pull this series from kprobes/core branch from

 https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/

Thank you,

---

Gustavo A. R. Silva (1):
      kprobes: Replace zero-length array with flexible-array

Jiri Olsa (1):
      kretprobe: Prevent triggering kretprobe from within kprobe_flush_task

Masami Hiramatsu (4):
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible
      kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
      kprobes: Remove redundant arch_disarm_kprobe() call


 arch/x86/kernel/kprobes/core.c |   16 ++--------
 include/linux/kprobes.h        |    6 +++-
 kernel/kprobes.c               |   61 +++++++++++++++++++++++++++++++---------
 3 files changed, 56 insertions(+), 27 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
