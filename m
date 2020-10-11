Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A375F28A7E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgJKPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:00:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388078AbgJKPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:00:25 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqsL3-1k5VLl2fL7-00mq9v; Sun, 11 Oct 2020 16:59:52 +0200
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
Subject: [PATCH v3 3/3] selftests/timens: added selftest for /proc/stat btime
Date:   Sun, 11 Oct 2020 16:59:24 +0200
Message-Id: <20201011145924.6554-4-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
References: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gvjsb65TtbiiZJJJ2nqBuwln2tTYb40OkRR15jPO4tfsMOeKxR3
 crqg1W5si3GbdUjW6RwpI0P5318mZC1Y6JgohipPPGoYMXh0733e+Kn/OILldgQRBRFQj9r
 5wEj+yAoM/hh2LtcwpSzOCL/3qIOAtiSK3r7YlPPZwprfqWUzNUIrtOFUCFqGcwpdXLZ7qd
 SLXG7qnNz5mHVwc2cfdUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w54krb4iBHI=:W44X1SXxVWMgkFE4Tavnuu
 DhZlivZVGITM5G5vjAQFLpV8kTqQhEUoNC52P6hK7G4Wv2lkAeIRSLYt9dK88W+VWxmudzX+h
 d1xocWM6HQJvtJoX211hjC6+mz896oYvMv2xgb4/u/VNF0SNGJI6cDuDvSHFV4AzBRTTMtYHq
 M8SZKYKbzDV1OAoKvxiJPsWr4znox3FLKPv5XRUJ7Z/Psp4j+Yo9k7DI4DK1rF0CONyahlO8A
 hRz5dXmnanR5PUZKDaDUCAp48WHE5RCyRgEPXl/wGc4wlW++C9spF3GPNVnPn2Icxq439R7Ix
 6EP4AdoCJUHVgqCcEaFdCRnJJTmt5xwuZh6uhQz8e49EXahZPc7yQOL5ZVH05G7wVnbRhfbTL
 yAGAw1ExpCcBsofEJUKFnJAQThH9NytBE1dQLXDYCVUsB5VKnDQUrefMvfjfq08usgGZBuxyM
 Grvj8pEFEd05xI6WRG7CLTCEF0g1YnD9W2+W+BEgBvhFbminrB9pJ1TLKHxiryLRi04phzAR0
 TKgGAh6f7Zp2UAzqb+nQCl+IIYuyjGhKiqAIQ/AcpVpEYDR0pjrLsFPI8QTjfwm6DmHyzrAsL
 gz8TaS7RolgoLkF/e34n8som2y275qaNF14LQviPHoNPJbnJQYFEPZZaNHxA2pt+TD/Y7DdNP
 wbnJdt187j7Y8KwwYxhAINnEyWN5+rQ4IQo/nPqnNLfvd9NnLueZJw6R7ck6ZKUuaSNGrLhfr
 s0Uu0i+dmjxm2Nky8qjdleCt3+09Bh+5E4roVSXzlmEXyE1ze32TMMEPZse1o+PCAUS+1UkoO
 5sR4TXZQNCTHW80lonsQfKlvUYzQ8j7evEWkSBGynASPamBcDNQ49cNttu3jCck6lt/liTlMx
 XwMfPmqhKAHnAb7bSf+w==
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

