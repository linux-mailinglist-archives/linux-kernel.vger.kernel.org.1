Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD61DB852
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgETPeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 11:34:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgETPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:34:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KF3sjO071121;
        Wed, 20 May 2020 11:33:59 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312bg8mjyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 11:33:59 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04KFEx3N023183;
        Wed, 20 May 2020 15:33:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 313wgrkdh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 15:33:58 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04KFWueZ25100762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 15:32:57 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F926E052;
        Wed, 20 May 2020 15:32:56 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1EA6E04C;
        Wed, 20 May 2020 15:32:56 +0000 (GMT)
Received: from localhost (unknown [9.65.222.154])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 May 2020 15:32:56 +0000 (GMT)
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH] perf config: Add stat.big-num support
Date:   Wed, 20 May 2020 10:32:55 -0500
Message-Id: <1589988775-9995-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_10:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

Add support for new "stat.big-num" boolean option.

This allows a user to set a default for "--no-big-num" for "perf stat"
commands.

$ perf config stat.big-num
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           803,684      cycles                                                      
[...]
$ perf config stat.big-num=0
$ perf config stat.big-num
stat.big-num=0
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

            790448      cycles                                                      
[...]

There is an interaction with "--field-separator" that must be
accommodated, such that specifying "--big-num --field-separator={x}"
still reports an invalid combination of options.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
Testing results with a matrix of:
- nothing in .perfconfig, stat.big-num=0, stat.big-num=1
- --field-separator not set, --field-separator=:
- no "--big-num", --big-num, --no-big-num

$ perf config stat.big-num
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           803,684      cycles                                                      

       0.000592761 seconds time elapsed

       0.000672000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           809,599      cycles                                                      

       0.000576090 seconds time elapsed

       0.000627000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            793870      cycles                                                      

       0.000574928 seconds time elapsed

       0.000625000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
790255::cycles:346960:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
764548::cycles:335938:100.00::
$ perf config stat.big-num=0
$ perf config stat.big-num
stat.big-num=0
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

            790448      cycles                                                      

       0.000567659 seconds time elapsed

       0.000619000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           751,377      cycles                                                      

       0.000534888 seconds time elapsed

       0.000587000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            803738      cycles                                                      

       0.000576151 seconds time elapsed

       0.000657000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
774897::cycles:339986:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
814619::cycles:358260:100.00::
$ perf config stat.big-num=1
$ perf config stat.big-num
stat.big-num=1
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           787,680      cycles                                                      

       0.000555401 seconds time elapsed

       0.000623000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           783,287      cycles                                                      

       0.000562255 seconds time elapsed

       0.000636000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            748802      cycles                                                      

       0.000525658 seconds time elapsed

       0.000586000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
785868::cycles:344508:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
794273::cycles:349600:100.00::
$ 
--
 tools/perf/builtin-stat.c |  6 ++++++
 tools/perf/util/config.c  | 13 +++++++++++++
 tools/perf/util/stat.h    |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0c1ad23c768..c39305907940 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -821,10 +821,16 @@ static void sig_atexit(void)
 	kill(getpid(), signr);
 }
 
+void perf_stat__set_big_num(int set)
+{
+	stat_config.big_num = (set != 0);
+}
+
 static int stat__set_big_num(const struct option *opt __maybe_unused,
 			     const char *s __maybe_unused, int unset)
 {
 	big_num_opt = unset ? 0 : 1;
+	perf_stat__set_big_num(!unset);
 	return 0;
 }
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index ef38eba56ed0..8e65f1fa421f 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -17,6 +17,7 @@
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
+#include "util/stat.h"  /* perf_stat__set_big_num */
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
@@ -452,6 +453,15 @@ static int perf_ui_config(const char *var, const char *value)
 	return 0;
 }
 
+static int perf_stat_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "stat.big-num"))
+		perf_stat__set_big_num(perf_config_bool(var, value));
+
+	/* Add other config variables here. */
+	return 0;
+}
+
 int perf_default_config(const char *var, const char *value,
 			void *dummy __maybe_unused)
 {
@@ -473,6 +483,9 @@ int perf_default_config(const char *var, const char *value,
 	if (strstarts(var, "buildid."))
 		return perf_buildid_config(var, value);
 
+	if (strstarts(var, "stat."))
+		return perf_stat_config(var, value);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..4bd6dc6cb6aa 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -132,6 +132,8 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 };
 
+void perf_stat__set_big_num(int set);
+
 void update_stats(struct stats *stats, u64 val);
 double avg_stats(struct stats *stats);
 double stddev_stats(struct stats *stats);
-- 
2.18.2
