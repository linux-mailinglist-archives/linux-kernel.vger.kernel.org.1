Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B328A3C4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbgJJW43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:56:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59418 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgJJTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:32:08 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 09ACwE6u074439;
        Sat, 10 Oct 2020 21:58:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sat, 10 Oct 2020 21:58:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 09ACwEaG074433
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 10 Oct 2020 21:58:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
Message-ID: <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
Date:   Sat, 10 Oct 2020 21:58:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzkaller continues various test cases until the kernel crashes,
syzkaller tends to examine more locking dependencies than normal systems.
As a result, syzbot is reporting that the fuzz testing was terminated
due to hitting upper limits lockdep can track [1] [2] [3].

Peter Zijlstra does not want to allow tuning these limits via kernel
config options, for such change discourages thinking. But currently we
are not actionable, for lockdep does not report the culprit for hitting
these limits [4].

Therefore, I propose this patch again, with a caveat that this patch is
expected to be reverted after lockdep becomes capable of reporting the
culprit, for I consider that "postpone fixing lock related problems in
existing code" is less painful than "not detecting lock related problems
introduced by new patches".

[1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
[2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
[3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
[4] https://lkml.kernel.org/r/CACT4Y+agTiEF-1i9LbAgp-q_02oYF0kAPZGAAJ==-wx2Xh7xzQ@mail.gmail.com

Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/locking/lockdep.c           |  2 +-
 kernel/locking/lockdep_internals.h |  8 +++---
 lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2facbbd146ec..2144708a867c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1349,7 +1349,7 @@ static int add_lock_to_list(struct lock_class *this,
 /*
  * For good efficiency of modular, we use power of 2
  */
-#define MAX_CIRCULAR_QUEUE_SIZE		4096UL
+#define MAX_CIRCULAR_QUEUE_SIZE		(1UL << CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS)
 #define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
 
 /*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index b0be1560ed17..cf7752847eb7 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -96,16 +96,16 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
 #else
-#define MAX_LOCKDEP_ENTRIES	32768UL
+#define MAX_LOCKDEP_ENTRIES	(1UL << CONFIG_LOCKDEP_BITS)
 
-#define MAX_LOCKDEP_CHAINS_BITS	16
+#define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
 
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
-#define MAX_STACK_TRACE_ENTRIES	524288UL
-#define STACK_TRACE_HASH_SIZE	16384
+#define MAX_STACK_TRACE_ENTRIES	(1UL << CONFIG_LOCKDEP_STACK_TRACE_BITS)
+#define STACK_TRACE_HASH_SIZE	(1 << CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS)
 #endif
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0c781f912f9f..41d083be7ec3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1311,6 +1311,46 @@ config LOCKDEP
 config LOCKDEP_SMALL
 	bool
 
+config LOCKDEP_BITS
+	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 15
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
+
+config LOCKDEP_CHAINS_BITS
+	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 16
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
+
+config LOCKDEP_STACK_TRACE_BITS
+	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 19
+	help
+	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
+
+config LOCKDEP_STACK_TRACE_HASH_BITS
+	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 14
+	help
+	  Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
+
+config LOCKDEP_CIRCULAR_QUEUE_BITS
+	int "Bitsize for elements in circular_queue struct"
+	depends on LOCKDEP
+	range 10 30
+	default 12
+	help
+	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
+
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
-- 
2.18.4


