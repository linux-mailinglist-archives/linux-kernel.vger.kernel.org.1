Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D8290624
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407335AbgJPNRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:17:34 -0400
Received: from mail-am6eur05on2095.outbound.protection.outlook.com ([40.107.22.95]:40976
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405262AbgJPNRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECg6oQusulF5tv4Jr89PVMAqXBth32w/HegKERzLmtDm8ElgEEgwYerBazkHGcqBP3XUr9qPn/kw6jsoaF4/4IniKsS7j/vDmWQ6Vj/SK4NprV9edJCaYKqlTOflUmG+ibQSAsAiKqcESX0oRn1lauXr0Ckdc/lt8fQliZbmoZ/6ubspMHJFruEpCtNG3qd1VlP72gfe1uP5CczOJwUE2jfSseFSFxNU+5Qc7hz5DJvMzd4Nmtkzr09b2FfoJHttFSLWFx9mxNZXlPtKIcyaONsgQSaFh9v1nNfiCj7TCocCn6sSkP+3gOg9BLOoTFCrhGmpUsWd/2Vo/73JhgZFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDrWW+Ykc2Q4lk+vKTeEB6/MO4mOYBhch7ipnF33eNQ=;
 b=EMYK7qlIIzX/JQPDog3lnRlbziDMS2Jmp8q2NEkbwZEyNtMw+TMsuWoJc2SqPz0Hz2o8NV9bE5Ck1tKcSOOUNWhst/A5G3K+mEfmMDFLcj7z4pehmPLCjqLtY+h0FQ4Xym20hqRJoPlfB2xOTnKN8ghC6aOXu2XR+3zSWgMdfWIHPyXNErQd0zP6BhOQPB0s3nVhN1eagbFNXetch5xNeGUxOHSaCdJ7hU+JuHVOiwNJudlZK+LqpTnJHzWzLQ1JQWQrmkKPCj8HDyLps7caGWGDZfzCtK7kznZfFJARfrBGReg4DzDuKcbLYrm4leADx8Tb5yeyCkOpXeEadtENXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDrWW+Ykc2Q4lk+vKTeEB6/MO4mOYBhch7ipnF33eNQ=;
 b=H/q8tQPy6MV8GXcT6RyKl+Sf8eMwX3yW3bSEU4vhbRgMK5MLqR0dOD8vPijCOwX6LUscW4/wzr03NjwC8Y+xrIwl4AGwJ0D+xzAzQxmtnwecuJ/cC0Etam8pI06spIuPMLJBfSbAjTTa9aGh88SYoY6Tw1QrDm1tXxOGLXgwbHk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0702MB3706.eurprd07.prod.outlook.com (2603:10a6:7:8d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Fri, 16 Oct 2020 13:17:29 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3477.019; Fri, 16 Oct 2020
 13:17:29 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH] perf test: Implement skip_reason callback for watchpoint tests
Date:   Fri, 16 Oct 2020 16:16:50 +0300
Message-Id: <20201016131650.72476-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [131.228.2.26]
X-ClientProxiedBy: HE1PR0901CA0045.eurprd09.prod.outlook.com
 (2603:10a6:3:45::13) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.26) by HE1PR0901CA0045.eurprd09.prod.outlook.com (2603:10a6:3:45::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Fri, 16 Oct 2020 13:17:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b456e3a2-9027-41a3-b55c-08d871d5d562
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3706A7312AE998A5AA0F92DEB4030@HE1PR0702MB3706.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZkEoaY3xnl/PaZX2IFgWmR9JDvfArApCRS0jzS/3/Smp4RLNU8pW4UGploaJciTUNDT0zBfcjUUvnXLUNkXAlgIqTKOZ96M+/4bWmuW+GY1FFTQ+bruW92ftPjjvzozzcmS3rvS4i9vPN8r31k7WoifbFri4QImYtN2Yh+dtMSMhE2mUEMbeRa3SEZiY4FMAUA9yoOk0Z+AC2xZNmJNltlK7cFjvKqxoxEQsuOPdApdjXnwRp6khmK8NWcgkMh2mQJIj5+mztuOt37laUifLzXCmN0XilPRlnuYtMrTai4V9Rv/kRGdd9vmrzAMIJiowlA5wEBnFBzPNSlDFSnJtLw1qVjIAnl+0maCJGkoObj0dyEFYaXHKppkSnpr/bO+jsYz3iSp79fyx3apxgzdhe/85XNIP+3JXrTnvBn8AA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(8936002)(2616005)(956004)(1076003)(6512007)(16526019)(36756003)(34490700002)(186003)(103116003)(6506007)(478600001)(6666004)(86362001)(52116002)(2906002)(107886003)(6486002)(5660300002)(66476007)(8676002)(66556008)(66946007)(26005)(83380400001)(110136005)(316002)(4326008)(171213001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cKax6MiGr7aWMBHXvlavCbMqNGfoGSUslBROPqZ9MoXabSCegIeH1rm2vUXdQ2WMyFOdP5AV3fQBkH8rznp/+9YNSJe5ryhVRMXdRX0gYZ8U1k8X0gDQTbF5DuPXhRTUDdNfjTSbNeizZaZEn/ZSUQ8wKVV8DtLff4fOQok0j7tDzqTfJKwrCuvO0y6GdHInhMnBgZFmiNRFkg2gj4TEMnOmurN9WB+pptByNyTwlZEaE70WHnZbKcuEKnxk4axy0xZAvZ4TMxkJiZ+LQ4is14HAmtBgjQBsctOl1rA8WXdkkMMfh3iWcKWT09f8XDvcryvj2fZFOX5mfhCR/g/cA/DR8Fbsk7NNQOs2oIPghuyHpOAlA3GsDRQzZhT2J06WXkLvF9bAKMVt/GQg5lVdahAf/qlEjijpYAl6BBtAEVieN1G6+UwqPqAxH6PeBa8GqEpf5WxKFLRqqJtyWXV4i2Xrie+FVguaMf9WuT3b4QNTCOwfcPD2c0AK2QRP6uMNU/crRbn3DBCIARnF6v5rtrnoXONOVV0eyO2hv1MUMngKn9arOQ07pi+YHiI5YiO3/HiuiKXmWzvpMUEeU9GlKX8TpZohje3r9y014KuGi/ueBXeZkZ7yiW9FX6Do/RrRekT1kOARBGKOO6pGwBd+ow==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b456e3a2-9027-41a3-b55c-08d871d5d562
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 13:17:29.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Azrf//EoOFlYRuEwJksNpWClaPSpcDnb6cTM/RK3JpsynZ/dGEgwQNPmTIqTB7ZnUUCcf4sg2LXUreQb+Uf4y123XycJz98XokMgc1lVkAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently reason for skipping the read only watchpoint test is only seen
when running in verbose mode:

  $ perf test watchpoint
  23: Watchpoint                                            :
  23.1: Read Only Watchpoint                                : Skip
  23.2: Write Only Watchpoint                               : Ok
  23.3: Read / Write Watchpoint                             : Ok
  23.4: Modify Watchpoint                                   : Ok

  $ perf test -v watchpoint
  23: Watchpoint                                            :
  23.1: Read Only Watchpoint                                :
  --- start ---
  test child forked, pid 60204
  Hardware does not support read only watchpoints.
  test child finished with -2

Implement skip_reason callback for the watchpoint tests, so that it's
easy to see reason why the test is skipped:

  $ perf test watchpoint
  23: Watchpoint                                            :
  23.1: Read Only Watchpoint                                : Skip (missing hardware support)
  23.2: Write Only Watchpoint                               : Ok
  23.3: Read / Write Watchpoint                             : Ok
  23.4: Modify Watchpoint                                   : Ok

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/tests/builtin-test.c |  1 +
 tools/perf/tests/tests.h        |  1 +
 tools/perf/tests/wp.c           | 21 +++++++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d328caaba45d..3bfad4ee31ae 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -142,6 +142,7 @@ static struct test generic_tests[] = {
 			.skip_if_fail	= false,
 			.get_nr		= test__wp_subtest_get_nr,
 			.get_desc	= test__wp_subtest_get_desc,
+			.skip_reason    = test__wp_subtest_skip_reason,
 		},
 	},
 	{
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 4447a516c689..0630301087a6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -66,6 +66,7 @@ int test__bp_signal_overflow(struct test *test, int subtest);
 int test__bp_accounting(struct test *test, int subtest);
 int test__wp(struct test *test, int subtest);
 const char *test__wp_subtest_get_desc(int subtest);
+const char *test__wp_subtest_skip_reason(int subtest);
 int test__wp_subtest_get_nr(void);
 int test__task_exit(struct test *test, int subtest);
 int test__mem(struct test *test, int subtest);
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index d262d6639829..9387fa76faa5 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -174,10 +174,12 @@ static bool wp_ro_supported(void)
 #endif
 }
 
-static void wp_ro_skip_msg(void)
+static const char *wp_ro_skip_msg(void)
 {
 #if defined (__x86_64__) || defined (__i386__)
-	pr_debug("Hardware does not support read only watchpoints.\n");
+	return "missing hardware support";
+#else
+	return NULL;
 #endif
 }
 
@@ -185,7 +187,7 @@ static struct {
 	const char *desc;
 	int (*target_func)(void);
 	bool (*is_supported)(void);
-	void (*skip_msg)(void);
+	const char *(*skip_msg)(void);
 } wp_testcase_table[] = {
 	{
 		.desc = "Read Only Watchpoint",
@@ -219,16 +221,23 @@ const char *test__wp_subtest_get_desc(int i)
 	return wp_testcase_table[i].desc;
 }
 
+const char *test__wp_subtest_skip_reason(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
+		return NULL;
+	if (!wp_testcase_table[i].skip_msg)
+		return NULL;
+	return wp_testcase_table[i].skip_msg();
+}
+
 int test__wp(struct test *test __maybe_unused, int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
 		return TEST_FAIL;
 
 	if (wp_testcase_table[i].is_supported &&
-	    !wp_testcase_table[i].is_supported()) {
-		wp_testcase_table[i].skip_msg();
+	    !wp_testcase_table[i].is_supported())
 		return TEST_SKIP;
-	}
 
 	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
 }
-- 
2.26.2

