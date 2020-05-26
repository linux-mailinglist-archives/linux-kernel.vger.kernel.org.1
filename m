Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A471CEEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgELIDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 04:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgELIDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:03:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2786206D6;
        Tue, 12 May 2020 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589270593;
        bh=uGqLN9OKnBbyA8w53Dt2jn5v0hokTKXjpPNu+Z3TREY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gi/XUHkXNrFoSQ58sTZCZX1aa/exW8DVu18vCuWkGZiq3bG4XgL5UFU3FLRvG9nw
         XBXiAOf0jpCMkwwS4TonwB1pU65RU0zs0/zyAB6l/9XQthn+pSLJjQIYFIk3K0+4c9
         cTY9kDPbli8nvOWtmaA9ORRulZ3/ilX7a4b0bv+M=
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
Subject: [PATCH -tip V6 4/6] kprobes: Remove redundant arch_disarm_kprobe() call
Date:   Tue, 12 May 2020 17:03:07 +0900
Message-Id: <158927058719.27680.17183632908465341189.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158927054236.27680.18209720730136003586.stgit@devnote2>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to remove redundant arch_disarm_kprobe() call in
force_unoptimize_kprobe(). This arch_disarm_kprobe()
will be invoked if the kprobe is optimized but disabled,
but that means the kprobe (optprobe) is unused (and
unoptimized) state.

In that case, unoptimize_kprobe() puts it in freeing_list
and kprobe_optimizer (do_unoptimize_kprobes()) automatically
disarm it. Thus this arch_disarm_kprobe() is redundant.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6d76a6e3e1a5..627fc1b7011a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -675,8 +675,6 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-	if (kprobe_disabled(&op->kp))
-		arch_disarm_kprobe(&op->kp);
 }
 
 /* Unoptimize a kprobe if p is optimized */

