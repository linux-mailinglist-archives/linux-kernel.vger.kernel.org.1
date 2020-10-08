Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021EF286E33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgJHFkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:40:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgJHFkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:40:35 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MdeSn-1kzjY12UwD-00ZgZ6; Thu, 08 Oct 2020 07:40:24 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v2 4/4] selftests/timens: added selftest for /proc/stat btime
Date:   Thu,  8 Oct 2020 07:39:44 +0200
Message-Id: <20201008053944.32718-5-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NU5P7vODRNT1dfXHANstL+0uvGeH9+2S5pGUnwWVsyjS6aalW0n
 W8l1uA9gmLJ2AdbyuqY0/tmmPPtE/TO54M/JzBGIJzT2xsuXMhPKAI1cgEnA6lWH6tIU+Xy
 PRJkkCYwEONdZRiFrYKDWZMcqe77aENgLoYRkeAZHn3JnYV2JSXHIpc98LaBHs3iMqjjG8a
 VwKW1nfmYtuDWuIbdQRrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7AAo7g3jNLU=:Np3Mx6eHitwF3Sw9qJaZp6
 Bw/S8NgQSkU3EuK357wt7RieiSP40ACq9rfb6W+sIOqUszWpmvY9opMUw/leeL5c6P1rjOI9X
 XOUNrs8IVlT4BUsuTYt+9wXThaOQ98zDUsdAKKit0BPo9XOJf1Ta977tTHcivgonrlG+j0pbF
 tPh6aYmDxA1345DaCbF6WMUhBKiUhZv0RROmSVFnrAt8PaCGS6fArpX0quCYJEtJ5kvgZ/xe9
 Y+eMReePdKjExyoGQcadmIRwElsTZC9ODSDXgHq8VwWXca/wztHam+q4x+mx9jVHpQqgj6TkO
 rgtVBau0bWK4LPAK1tqbhwdcSJiuWe06PcbgovxYvKx8LNklbXaDdk/ZyUwoizPlFGdV3H4eT
 31YHj3t1Oigo1G3KkK4XlchFSj4ZlIbMfPwK/tp1o3xWndPr0Rs/MbPxKOEXtZ99IVmncloGG
 mcHpNrdVDRGe2qtm2FDS0+qGYwky9wmBlK0wV0Xek/m9UlnwYM7nyl1dubKJMIcXnZBIXllOp
 LsTupwxX6oqFqdYXgFsWcDhq1ez5QFrrgYx33tCeGxodFwKV8V6U9Q9QZEjrn2cWRBueLFLx/
 On3w8KE/rZTBoiAYsrHCv6kz/zJqBFGUh6Y2lyeteiEiD0esdIPlkBxek/WIJIDHA0jIar+Jm
 RTLzsa/taYm35HPIMhzzSZVTg4zddY6qgtvzo7Pg0ttfhAF+V5/SV2sDhB9wZD6g85Gu7CSR4
 5lFFInMLnWdWLjyVc66bAdZqRU6VGmpbt/d2+SWl3Sh4bAMZ9jx00hI76f5ESIPDIiT/mVj7x
 Li10eAd1kc/DwlJV4TLtGv7GEoCEk/Pna+ij/65SnZTHUttnpE6XHv/O/UD++DKXaPXmCwxtT
 T/pKjEF/61kFIJvOdrEw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test that btime value of /proc/stat is as expected in the time namespace
using a simple parser to get btime from /proc/stat.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 7f14f0fdac84..f2519154208a 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -93,6 +93,33 @@ static int read_proc_uptime(struct timespec *uptime)
 	return 0;
 }
 
+static int read_proc_stat_btime(unsigned long long *boottime_sec)
+{
+	FILE *proc;
+	char line_buf[2048];
+
+	proc = fopen("/proc/stat", "r");
+	if (proc == NULL) {
+		pr_perror("Unable to open /proc/stat");
+		return -1;
+	}
+
+	while (fgets(line_buf, 2048, proc)) {
+		if (sscanf(line_buf, "btime %llu", boottime_sec) != 1)
+			continue;
+		fclose(proc);
+		return 0;
+	}
+	if (errno) {
+		pr_perror("fscanf");
+		fclose(proc);
+		return -errno;
+	}
+	pr_err("failed to parse /proc/stat");
+	fclose(proc);
+	return -1;
+}
+
 static int check_uptime(void)
 {
 	struct timespec uptime_new, uptime_old;
@@ -123,18 +150,47 @@ static int check_uptime(void)
 	return 0;
 }
 
+static int check_stat_btime(void)
+{
+	unsigned long long btime_new, btime_old;
+	unsigned long long btime_expected;
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (read_proc_stat_btime(&btime_old))
+		return 1;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (read_proc_stat_btime(&btime_new))
+		return 1;
+
+	btime_expected = btime_old - TEN_DAYS_IN_SEC;
+	if (btime_new != btime_expected) {
+		pr_fail("btime in /proc/stat: old %llu, new %llu [%llu]",
+			btime_old, btime_new, btime_expected);
+		return 1;
+	}
+
+	ksft_test_result_pass("Passed for /proc/stat btime\n");
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
 
 	nscheck();
 
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 
 	if (init_namespaces())
 		return 1;
 
 	ret |= check_uptime();
+	ret |= check_stat_btime();
 
 	if (ret)
 		ksft_exit_fail();
-- 
2.20.1

