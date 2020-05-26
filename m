Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9B1B087E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgDTL5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgDTL5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:57:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BA0218AC;
        Mon, 20 Apr 2020 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383833;
        bh=LzTpe3nRXWzu7leUSs8VdFuPvTxItUjuILYM/9xUqZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3qOL2LE73dmD/UROVpo3jL3BAnKMa918iFrIvktwf4a0ykh018y0P3MVnQZY99PJ
         jEIG2219ku6UMLwyrorF0RptzkD/NQs91RBDUpYowQ9gsgwXO13/wZ3G2dKzv4qIaj
         +pgYrl3dGePDzS5gTNgTVqJMRXfWwiravgRKIxPM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 51/60] perf machine: Factor out lbr_callchain_add_lbr_ip()
Date:   Mon, 20 Apr 2020 08:53:07 -0300
Message-Id: <20200420115316.18781-52-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Both caller and callee needs to add ip from LBR to callchain.
Factor out lbr_callchain_add_lbr_ip() to improve code readability.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-9-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 143 +++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a7f75fd43b0f..f9d69fce584a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2224,6 +2224,74 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	return 0;
 }
 
+static int lbr_callchain_add_lbr_ip(struct thread *thread,
+				    struct callchain_cursor *cursor,
+				    struct perf_sample *sample,
+				    struct symbol **parent,
+				    struct addr_location *root_al,
+				    u64 *branch_from,
+				    bool callee)
+{
+	struct branch_stack *lbr_stack = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int lbr_nr = lbr_stack->nr;
+	struct branch_flags *flags;
+	int err, i;
+	u64 ip;
+
+	if (callee) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL,
+				       *branch_from);
+		if (err)
+			return err;
+
+		/* Add LBR ip from entries.from one by one. */
+		for (i = 0; i < lbr_nr; i++) {
+			ip = entries[i].from;
+			flags = &entries[i].flags;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	/* Add LBR ip from entries.from one by one. */
+	for (i = lbr_nr - 1; i >= 0; i--) {
+		ip = entries[i].from;
+		flags = &entries[i].flags;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL,
+				       *branch_from);
+		if (err)
+			return err;
+	}
+
+	/* Add LBR ip from first entries.to */
+	ip = entries[0].to;
+	flags = &entries[0].flags;
+	*branch_from = entries[0].from;
+	err = add_callchain_ip(thread, cursor, parent,
+			       root_al, &cpumode, ip,
+			       true, flags, NULL,
+			       *branch_from);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2240,14 +2308,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
-	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip, branch_from = 0;
-	struct branch_stack *lbr_stack;
-	struct branch_entry *entries;
-	int lbr_nr, j, k;
-	bool branch;
-	struct branch_flags *flags;
-	int mix_chain_nr;
+	u64 branch_from = 0;
 	int err;
 
 	for (i = 0; i < chain_nr; i++) {
@@ -2259,21 +2320,6 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
-	lbr_stack = sample->branch_stack;
-	entries = perf_sample__branch_entries(sample);
-	lbr_nr = lbr_stack->nr;
-	/*
-	 * LBR callstack can only get user call chain.
-	 * The mix_chain_nr is kernel call chain
-	 * number plus LBR user call chain number.
-	 * i is kernel call chain number,
-	 * 1 is PERF_CONTEXT_USER,
-	 * lbr_nr + 1 is the user call chain number.
-	 * For details, please refer to the comments
-	 * in callchain__printf
-	 */
-	mix_chain_nr = i + 1 + lbr_nr + 1;
-
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
@@ -2282,57 +2328,14 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		if (err)
 			goto error;
 
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
-		branch = true;
-		flags = &entries[0].flags;
-		branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       branch, flags, NULL,
-				       branch_from);
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
+					       root_al, &branch_from, true);
 		if (err)
 			goto error;
 
-		/* Add LBR ip from entries.from one by one. */
-		for (j = i + 2; j < mix_chain_nr; j++) {
-			k = j - i - 2;
-			ip = entries[k].from;
-			branch = true;
-			flags = &entries[k].flags;
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
 	} else {
-		/* Add LBR ip from entries.from one by one. */
-		for (j = 0; j < lbr_nr; j++) {
-			k = lbr_nr - j - 1;
-			ip = entries[k].from;
-			branch = true;
-			flags = &entries[k].flags;
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
-
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
-		branch = true;
-		flags = &entries[0].flags;
-		branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       branch, flags, NULL,
-				       branch_from);
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
+					       root_al, &branch_from, false);
 		if (err)
 			goto error;
 
-- 
2.21.1

