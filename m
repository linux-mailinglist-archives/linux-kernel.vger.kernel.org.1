Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7402A1C6F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 07:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKAGbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 01:31:45 -0500
Received: from one.firstfloor.org ([193.170.194.197]:37774 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKAGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 01:31:45 -0500
Received: from firstfloor.org (c-71-237-255-61.hsd1.or.comcast.net [71.237.255.61])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by one.firstfloor.org (Postfix) with ESMTPSA id AA69886852;
        Sun,  1 Nov 2020 07:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1604212299;
        bh=V4DrmFTkLBlHOQBNLWIAG+nNolwSM9etfOEXIbs2x5g=;
        h=From:To:Cc:Subject:Date:From;
        b=lkXCrgztThl36bLsTapVtVCaN4WF/ETfmExblJ61Y1bGXneRMy5R8OdEJuf74VXOz
         nMlRYDC6DCWNLUuaaIYxmJjrDIworbI/RvC7FvYTnRmacpAihlwEByR12zTEc5DOdx
         70cf0NXoBPNiZFBwEEVZCaQECcgrsssm5iQni46c=
Received: by firstfloor.org (Postfix, from userid 1000)
        id 511D4A0E64; Sat, 31 Oct 2020 23:31:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3] perf tools: Support -x for perf stat report
Date:   Sat, 31 Oct 2020 23:31:33 -0700
Message-Id: <20201101063133.32179-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the -x, option to enable CSV output with perf stat
report. Useful to parse the information with other programs.

% perf stat record --quiet -a -I 1000 sleep 5
% perf stat report -x,
     1.000838672,4003.55,msec,cpu-clock,4003548736,100.00,,
     1.000838672,11243,,context-switches,4003631885,100.00,0.003,M/sec
     1.000838672,1682,,cpu-migrations,4003672150,100.00,0.420,K/sec
     1.000838672,13244,,page-faults,4003697471,100.00,0.003,M/sec
     1.000838672,2953214077,,cycles,4003715495,100.00,0.738,GHz
     1.000838672,4380820799,,instructions,4003738270,100.00,1.48,insn per cycle
     1.000838672,809865653,,branches,4003760616,100.00,202.287,M/sec
     1.000838672,12439843,,branch-misses,4003780785,100.00,1.54,of all branches
...

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Fix default output (Jiri). Also handle \t as special value like the
original parser (Andi)
v3: Use DEFAULT_SEPARATOR
---
 tools/perf/builtin-stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 743fe47e7a88..9fcc7351ce43 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1988,6 +1988,8 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per numa node", AGGR_NODE),
 	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
 		     "disable CPU count aggregation", AGGR_NONE),
+	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
+		   "print counts with custom separator"),
 	OPT_END()
 	};
 	struct stat st;
@@ -2002,6 +2004,13 @@ static int __cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+	if (strcmp(stat_config.csv_sep, DEFAULT_SEPARATOR)) {
+		stat_config.csv_output = true;
+		if (!strcmp(stat_config.csv_sep, "\\t"))
+			stat_config.csv_sep = "\t";
+		stat_config.big_num = false;
+	}
+
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
-- 
2.28.0

