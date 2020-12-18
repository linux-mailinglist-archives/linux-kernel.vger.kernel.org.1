Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261CC2DDF53
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbgLRIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:00:24 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54376 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732367AbgLRIAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:00:23 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX8teYdxf_t8BAA--.5208S3;
        Fri, 18 Dec 2020 15:59:27 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 1/4] perf tools: Move syscall.tbl check into check-headers.sh for powerpc
Date:   Fri, 18 Dec 2020 15:59:21 +0800
Message-Id: <1608278364-6733-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxX8teYdxf_t8BAA--.5208S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13ur4xGw45Ar13AFW3trb_yoW8Kr17pa
        1vkr1Syw48ZF4kAw1IyF47WFWjgw4kAF10gay09rZ0vFnxWrnrtryfZF98tFnrXr95G3yI
        vr4fWryYy3W8W3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8a9aDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to check syscall.tbl for powerpc in check-headers.sh, it is
similar with commit c9b51a017065 ("perf tools: Move syscall_64.tbl check
into check-headers.sh").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/arch/powerpc/Makefile | 7 -------
 tools/perf/check-headers.sh      | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index e58d00d..840ea0e 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -14,7 +14,6 @@ PERF_HAVE_JITDUMP := 1
 out    := $(OUTPUT)arch/powerpc/include/generated/asm
 header32 := $(out)/syscalls_32.c
 header64 := $(out)/syscalls_64.c
-syskrn := $(srctree)/arch/powerpc/kernel/syscalls/syscall.tbl
 sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
 sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
@@ -23,15 +22,9 @@ systbl := $(sysprf)/mksyscalltbl
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header64): $(sysdef) $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-	(diff -B $(sysdef) $(syskrn) >/dev/null) \
-	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
 
 $(header32): $(sysdef) $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-	(diff -B $(sysdef) $(syskrn) >/dev/null) \
-	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
 
 clean::
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 15ecb18..3c96fd3 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -144,6 +144,7 @@ check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
+check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
 
 for i in $BEAUTY_FILES; do
   beauty_check $i -B
-- 
2.1.0

