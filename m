Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D157D2868C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgJGUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:01:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgJGUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:01:13 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGxYh-1kCnD23hRL-00E6t7; Wed, 07 Oct 2020 22:01:03 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH 4/4] selftests/timens: added selftest for /proc/stat btime
Date:   Wed,  7 Oct 2020 22:00:15 +0200
Message-Id: <20201007200015.30868-5-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
References: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FgTrGpeHQrRfG65lLTx+YffpR+XLlCqQ4sYTOqKpip06j+yKXBy
 CDRt0dMtSPpPb8JN55tROQaQ7nEjgVBqASUn3yX30zuQXDMEhJuwk3Bhn1bsUlqXqY2QSZM
 U5AEg04h3kHKOeNmSiXMTp4CJBz0oY0hg2xjrtbCcLpzidZYVQzq0A6SkSLtWhhqa5jg/ia
 C3d07uVtl7NXJ2Nc6V5Ww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dVkN4KU9ANI=:8GoHeJ5nbLUOx6LIlWQXpZ
 Gd1f+yBtYv45dPRH31Idv+W193bzuK4q0MTFROwDPCdJuXVXwDQCLyXeFBQOx2sRqz5WFTlKZ
 AxGE7uyLtu/QCHczDvmnHf+eWu2pIONGKgRy1nNU1WIBIqZoG6K5GPieUNat6dGmBENNf0/Sj
 9fvbyIvfA8nroAu5tAq/MfxLLuJ81/CUr68LfZxa0DAJ8P5jbkXrlnP0TETqp9XekOEFLhIW7
 Ln3ooAr0SC7cL7ghJ39LNle0uSYAQAVSbspzTGheFffU3vLtuVU190vv3KB3pxqtd5omw7hwZ
 5VIztQZrljpsF5oEfRNV5iDEDfvdCXlxI/staTQXrOAa8Jp/SzVcPZt9oms+/fbc65o/4PcGl
 JQchuVfJVBUm3rfQsSZqSyioSAxRUBk/TBvDnRZpLKZu2YuYKoTe9F+6E40xSijYnFIV3uUyZ
 ptDhEvfqqgDfmb4MlgiRy3t/7j9MIuq4+TcVhYAojH2ZFY1FZMKMuM9KGIvSt0MpdjgFuppjA
 W4DDM2sAx64SiciMBEH+00AgxyPx2d5rOk5bkzbPkAIUrPn6fAETU7cTl/G+maqNMjQyywzSQ
 /Ia0B4mVsLwShFP76gv9G6kVbPxCk6m8/Zd5CMUYcuKk62FW9wtH8nHoZCUPX2JkxdZw2xFpP
 VLNPRdE0yK6T/QC3VkUZKo36rUiW9MZOyt7D0lTGdAxNbH+SkOB4/gMHuU8ZLvPRBt5NG33Hy
 TpJ9Wcs4gxP2HFIlqXU+DKES1Wb3GSC0n0bHOLDhNpFdkWukeFksWanYetuAH/DOWouEqIoPe
 8U2wsJ6Ju06/cFZXNbMWt990vkkJQOh+dc+83cvDHJgJW9zFI8k0Ezr6Y39h/lynohO2SmiDY
 xI97DTYAPB0/t+VgnsBA==
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

