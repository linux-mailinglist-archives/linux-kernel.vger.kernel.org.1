Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583A02DA5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 02:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgLOBgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 20:36:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38790 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbgLOBgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:36:23 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGcrkEthfl20AAA--.1046S2;
        Tue, 15 Dec 2020 09:35:33 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2] perf callchain: Return directly when use '--call-graph dwarf' under !HAVE_DWARF_SUPPORT
Date:   Tue, 15 Dec 2020 09:35:31 +0800
Message-Id: <1607996131-9340-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxGcrkEthfl20AAA--.1046S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3ZF4DAr1xXrWDZrW5KFg_yoW8trW8pa
        1DCr1ftrs0qryF93ZF9FWFgFy5CrykJr1Y9ryjyw15uws7XrykJF48t3WYg345Xwn5tw10
        v3ZxWr1rCwn8ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoPEfUU
        UUU
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

v2: Use HAVE_DWARF_SUPPORT to check

 tools/perf/util/callchain.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1b60985..ad08554 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -18,6 +18,7 @@
 #include <math.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <sys/utsname.h>
 
 #include "asm/bug.h"
 
@@ -276,6 +277,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 
 		/* Dwarf style */
 		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
+#ifdef HAVE_DWARF_SUPPORT
 			const unsigned long default_stack_dump_size = 8192;
 
 			ret = 0;
@@ -290,6 +292,15 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 				ret = get_stack_size(tok, &size);
 				param->dump_size = size;
 			}
+#else
+			struct utsname uts;
+
+			ret = uname(&uts);
+			pr_err("DWARF is not supported for architecture %s\n",
+				ret ? "unknown" : uts.machine);
+
+			return -ENOTSUP;
+#endif
 		} else if (!strncmp(name, "lbr", sizeof("lbr"))) {
 			if (!strtok_r(NULL, ",", &saveptr)) {
 				param->record_mode = CALLCHAIN_LBR;
-- 
2.1.0

