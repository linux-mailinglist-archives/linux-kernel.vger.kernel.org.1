Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14410292EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgJSTx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:53:56 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgJSTxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:53:55 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5fdC-1kXM6f2hpa-007A7d; Mon, 19 Oct 2020 21:53:27 +0200
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
Subject: [PATCH v4 3/3] selftests/timens: added selftest for /proc/stat btime
Date:   Mon, 19 Oct 2020 21:52:57 +0200
Message-Id: <20201019195257.10728-4-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nl2dvX4zFSAVzwvxlN6nYoPS592a+k6MDbAi3ODL7tfQ//ErVYQ
 R0Fln767N60MfPGlvNCmqG7VnkcSfpBoJEkVPL7CK8CGlkvQzuOnpuwdz07C8VCbGjPQYOH
 zr1+RNJDd79dWX4GZzLmF4pQ4Hr29h4X0wig6AR32NOBpGr+mCviLbeWnxbY595dExE2fpu
 isP/Nc5OYiGM/v2kwwysg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmjBRYLfLBI=:poJ4n7+UIi1TYRMti3llSC
 9fe4PsA8vKsRLRXvHg3M07YugHzf5wSltjMG6Chud7vA98Sgt7ccvlYDeQUAL7J2gjzrS7NrF
 38Y1SB/HLDj5JnvWA8Vc881COf/oUoGJng8Dj2EgHDBetFL68QedPveVq4+k8PFdkEK9bZ1SG
 Nu3pMMq8t15r1kXCfYp9lrFeoAHb2G80TZ/WmmEkL47FzmDRDKpnYL8tdesfoFdtgIZXwRGca
 9ulp0yxSOscpN0iptaijoj6mnb0MxQcgCkIZ3xrxTuVVTEroCBnpZhexuMqujaLX6Df0VSpFZ
 40oUDeeq5GgIQ1OzjBgLKZHnWdmmH9LbE3E4q1azsU2nhB9kGOY7RNL8PGCERI8iAFZTFNxes
 DWJrvk2rMxor7h+PSmwk0qkTQ7IpmEKT8NcWAzO1enZdSYU21zBv8eHp+UOvTVlhu+tj6a0Iv
 dIudrPYhLF0kH0rtlUs1qFYUgGl6sbY=
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

