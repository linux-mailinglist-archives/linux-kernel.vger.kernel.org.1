Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4811729A01B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442677AbgJ0A1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:27:53 -0400
Received: from one.firstfloor.org ([193.170.194.197]:59534 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442659AbgJ0A1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:27:51 -0400
Received: from firstfloor.org (c-71-237-255-61.hsd1.or.comcast.net [71.237.255.61])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by one.firstfloor.org (Postfix) with ESMTPSA id BE45686766;
        Tue, 27 Oct 2020 01:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1603758465;
        bh=G+lqBRTHiouhxMe8FHDWSn2UPqjt5ZSlhdYeSW2DEgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFrN0inelfb1qMJa1X5SlXwHwjJUiU5JCJMITLrTMX5NdoWxshDeyGVR07oI4rc6I
         kcqcP3jNTJE85dM3lkqmOK9jBnEnSvRcOHKcZeis4A98JquBwQOEhTmIPYXURlLtC/
         80rnVfZDCfv8IP1APOHJWSKSPxc+03vfvYvgtrwQ=
Received: by firstfloor.org (Postfix, from userid 1000)
        id 0ADECA074A; Mon, 26 Oct 2020 17:27:42 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com, Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] perf tools: Support -x for perf stat report
Date:   Mon, 26 Oct 2020 17:27:37 -0700
Message-Id: <20201027002737.30942-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027002737.30942-1-andi@firstfloor.org>
References: <20201027002737.30942-1-andi@firstfloor.org>
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
 tools/perf/builtin-stat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 743fe47e7a88..31e7bd877f1d 100644
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
@@ -2002,6 +2004,11 @@ static int __cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+	if (stat_config.csv_sep) {
+		stat_config.csv_output = true;
+		stat_config.big_num = false;
+	}
+
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
-- 
2.28.0

