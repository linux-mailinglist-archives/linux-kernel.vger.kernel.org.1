Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088272D9876
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407839AbgLNM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:58:18 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50526 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439411AbgLNM56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:57:58 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxNuAaYddf1yUAAA--.556S2;
        Mon, 14 Dec 2020 20:56:58 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] perf callchain: Return directly when use '--call-graph dwarf' under !CONFIG_DWARF
Date:   Mon, 14 Dec 2020 20:56:55 +0800
Message-Id: <1607950615-11825-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxNuAaYddf1yUAAA--.556S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3ZF4DAr1xXrWDZrW5KFg_yoW8ZrWfpa
        1DCryftrsYqr1F93ZF9FySgFy5WrykXryY9ryUAw1Y9ws7Wr97Jr4Iq3WFg345Xwn5ta10
        v3ZxWr1rGrW5ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5JwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjq2NtUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DWARF register mappings have not been defined for some architectures,
at least for mips, so we can print an error message and then return
directly when use '--call-graph dwarf'.

E.g. without this patch:

[root@linux perf]# ./perf record --call-graph dwarf cd
Error:
The sys_perf_event_open() syscall returned with 89 (Function not implemented) for event (cycles).
/bin/dmesg | grep -i perf may provide additional information.

With this patch:

[root@linux perf]# ./perf record --call-graph dwarf cd
DWARF is not supported for architecture mips64

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

        --call-graph <record_mode[,record_size]>
                          setup and enables call-graph (stack chain/backtrace):

				record_mode:	call graph recording mode (fp|dwarf|lbr)
				record_size:	if record_mode is 'dwarf', max size of stack recording (<bytes>)
						default: 8192 (bytes)

				Default: fp

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/util/callchain.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1b60985..a8cf456 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -18,6 +18,7 @@
 #include <math.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <sys/utsname.h>
 
 #include "asm/bug.h"
 
@@ -278,6 +279,16 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
 			const unsigned long default_stack_dump_size = 8192;
 
+			if (system("grep -q 'CONFIG_DWARF=y' .config-detected") != 0) {
+				struct utsname uts;
+
+				ret = uname(&uts);
+				pr_err("DWARF is not supported for architecture %s\n",
+					ret ? "unknown" : uts.machine);
+
+				return -ENOTSUP;
+			}
+
 			ret = 0;
 			param->record_mode = CALLCHAIN_DWARF;
 			param->dump_size = default_stack_dump_size;
-- 
2.1.0

