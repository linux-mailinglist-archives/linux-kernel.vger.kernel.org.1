Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501AA29CA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373158AbgJ0UoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:44:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505096AbgJ0Unz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:43:55 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M3DFj-1kWgzv3G7p-003ght; Tue, 27 Oct 2020 21:43:22 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v5 3/3] selftests/timens: added selftest for /proc/stat btime
Date:   Tue, 27 Oct 2020 21:42:58 +0100
Message-Id: <20201027204258.7869-4-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
References: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9CP25kbZ74AldUWvhVfiGp5J7jAhXx83pCAIIo00hQFDtdaCUXU
 L0GHWd5P3d5vG0Eir5MtS9LhLr1qezt0fHu/PmpwsvqHRdmsaUzpA15xYEqPbwd6pde442f
 kz1/32kv3OR4+1gCWTVDyti59J8mTiuhtQ3fzYPOydCaEi+yoo6MovSb3V7BHopjSigvpP6
 j6MARluLrVxf0ko9aiH2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BugYU5DyraE=:XAbSuaMT5DwoZ8ODcnhOV5
 BRB2BxBUFtxJMhqxh5PXIT1yviqbck7hve0C16/BGBabC0wpgBFyv5ZzIHb8CA29xx4A8XZ8p
 aV3F9vPtLveuxcKDZLR8Ln/vscTSCrsKxZPccVZcqgm6dN0+RdLb6GreOSsVo+D4bPJAAtuop
 PI+yIP+1/aSRgGttyGWdb5dmEQGLMSSDuWBQpiRwubVm2ByWv96wJRWewY4s5fCyHE3KTVbv2
 K2aYrQxknZG3hEXUhhenKV/Scr/c0O2dovf7J0TA/tNE9lEchSl9slolpCbl9NkVnQapxXfLW
 R2ez1/vaSEswOXG0S1jZr1jAjw/EuuKXGE/TlxHRLEONcBzy2x6aHq5FmQiJypG2jcITtvx5b
 IHMB9SYLkbE39GkV+MkKomkr3tWbkIwkhKfm9HkSKSF+BWQcUkih1XLwj7mxiSsMZDIT8houO
 +bV4rJ03so40gLJkEns3repM/ADwTuc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test that btime value of /proc/stat is as expected in the time namespace
using a simple parser to get btime from /proc/stat.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Reviewed-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
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

