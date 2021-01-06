Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876152EC251
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbhAFRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbhAFRcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D9B02332A;
        Wed,  6 Jan 2021 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954283;
        bh=QVfF3D1YZcAxjQWQdTPvzaC6hZRrOG885qV2lsTdNm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1uuy0qslxXctH8MdWa3YuqqpGd6R2Bno4FVmztKjdHXnei2y5AcSUVDVGzMoMPqq
         9dqVQjwLp6TZhynHk0rtI0S2TqdGmRgPKNaQicBZNKxIf7DVOLjcs/Hsb7eFN0Ou89
         GCDfTM10Gn2IR5UFJG2zRD9nT4ebIJLcFyEvd+SqyA3TSjzx03zKhDCbMTzXaeY/ur
         hw9KjVl4zdDuboSbxZMyaBSE8HeAdwBCFm+tTQdAQzmhK9F1kf6EnfKaNq7mFWuV61
         CqItcny2uZ82GjAjU5iy9pMw8pfk3cBymrR9xsFfJxldpB/bWZR7gpiL3ngESBs/pt
         I7cvVyco8Er7A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/18] torture: Make torture.sh throttle VERBOSE_TOROUT_*() for refscale
Date:   Wed,  6 Jan 2021 09:31:13 -0800
Message-Id: <20210106173119.23159-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes torture.sh to use the torture.verbose_sleep_frequency
kernel boot parameter to throttle verbose refscale output on large systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e2c97f9..f2f9140 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -282,7 +282,7 @@ fi
 for prim in $primlist
 do
 	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS" --trust-make
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
-- 
2.9.5

