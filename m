Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B95302250
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 08:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbhAYHIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 02:08:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:14296 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbhAYHFN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:05:13 -0500
IronPort-SDR: c8dzb7cUqH5gaw83rIHHQvKXb3RYfwZhAgK9rK21vG0dfkBN2zlJO5h8gGj1aA4kzAW69jFwJG
 nkKSvAL+E6pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="178897348"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="178897348"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 23:03:07 -0800
IronPort-SDR: mEXk7vd4GADwCCO/0I4jlRlt8+4tH1/y8TGDPqL3IG5JinDEAiuiao1X+fKB6kWG0fYihOCURC
 HCSikIMZmkeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="471907615"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2021 23:03:02 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/2] perf script: Support dso filter
Date:   Mon, 25 Jan 2021 07:27:50 +0800
Message-Id: <20210124232750.19170-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210124232750.19170-1-yao.jin@linux.intel.com>
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other perf tool builtins have already supported dso filter.

For example,
perf report --dso, which only considers symbols in these dsos.

Now dso filter is supported for perf-script.

root@kbl-ppc:~# ./perf script --dso "[kernel.kallsyms]"
            perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075109:        273   cycles:  ffffffff9ca7730a native_write_msr+0xa ([kernel.kallsyms])
            perf 18123 [000] 6142863.075110:       7684   cycles:  ffffffff9ca3c9c0 native_sched_clock+0x50 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075112:     213017   cycles:  ffffffff9d765a92 syscall_exit_to_user_mode+0x32 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 3 +++
 tools/perf/builtin-script.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 0ef2261baeb9..6e32b2f9b828 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -444,6 +444,9 @@ include::itrace.txt[]
 	[0x4007a0, 0x0x4007a9]:
 	perf script -S 0x4007a0 --addr-range 10
 
+--dsos=::
+	Only consider symbols in these dsos.
+
 --call-trace::
 	Show call stream for intel_pt traces. The CPUs are interleaved, but
 	can be filtered with -C.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e0feda33dbb9..f8d3d8582ea2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3523,6 +3523,8 @@ int cmd_script(int argc, const char **argv)
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
+	OPT_STRING(0, "dsos", &symbol_conf.dso_list_str, "dso[,dso...]",
+		   "only consider symbols in these dsos"),
 	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
 	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
-- 
2.17.1

