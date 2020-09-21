Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74452272889
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIUOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:03 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:2464
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727779AbgIUOoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFbwkQikKklx5U6DQYcTXq8B9ZNGG9AaMFmQdMKb35xnIOid8Jn55iUj4/J0wrNj7sXdfn4De8E5zHKr7Jj+4a+Nc8ygVi+z7e7wgJw78TzT6EhZT8LI/IlDpHdvlUKxczP7k6L+vtKRZkdv3eeeV2SAiIH+NgX4yb7KlQ3fxWiabFc0QPjqwtRydbOAAT5AVhjoMUOEm4DNgdsY1ZrVdNcuz/GIzUOhOXymDiOsPAc4sfIjKhm18KgNPbMSAefU7RtMTEZFNixrDFN/PECTLHnUDPBGlBM4XJNGeFRsvjmSQrXWWsSYHT4WmBOg9a3gYFoDThibiFBaqoSyClOOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P77Irbt0wkTXGAKunIG3ch/P0CvE+Vcnwa2h2HH7bzs=;
 b=RaLuo+5io0w54NnVeRQVlzZ9ehghUocEl7eFj0kcgw+eROd2sqmq/Q+PM3KZZr+1lHE2gmsDazLwxdXxBpuUHP46+MbFElxCnd7fDR3FRmWTGfqEvF7lDTMQAHm0EMHYPI+jfeCSo682XBd8Uho6sks4DoZ4oAHVkOn3Wdo9YbvDFytjEO/FTsfFJyFm7tQiTnXi+uWzcbvd/XuKy/eZ0Dv1+Dc91OUKFrN4VY7gLCARa1O9Awy5KZrUwd2D3550i5P+mhfYQCS9OCNzZuXsqVQkxEmZyUvxQAljQRqI40mNvtc7H6UxoLFAEwoGa83mC5CR5wCgucSqQ03zPWEnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P77Irbt0wkTXGAKunIG3ch/P0CvE+Vcnwa2h2HH7bzs=;
 b=fLxejK1Vf831ZnoxR2TpVS91HRarAIdsgms7lG1NliSyNs1mgMgOG4vIGjGfZOnxRJnfNgaUYLBuRi6fbQmbG+7gzHTDlEIgM9HeBztAUOEF3gN1mQNR0HXEf1CcCPWjUA2+DoYNvQyHnXOz98to9BF3PumSaCork9KqC5bV2ls=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Mon, 21 Sep
 2020 14:43:56 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 14:43:56 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf/amd/uncore: Prepare to scale for more attributes that vary per family
Date:   Mon, 21 Sep 2020 09:43:27 -0500
Message-Id: <20200921144330.6331-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200921144330.6331-1-kim.phillips@amd.com>
References: <20200921144330.6331-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26 via Frontend Transport; Mon, 21 Sep 2020 14:43:54 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d161b83-6896-4fb1-b2da-08d85e3cc499
X-MS-TrafficTypeDiagnostic: BN8PR12MB2947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2947C315166EE7CA93DC0A8D873A0@BN8PR12MB2947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrVy5HsbUxmjfUHIguBPGE9x/3h3L5jBrNkgViS7IX8oSENhnyQkMSlVI0C0ISeAVKeM52+WbCO8+ijlnznPWQVfQPFEcW8Lnc0jD/qANIMFqeNRlRCDT71cf3L/uui6/mCqKHzEUBbhWB9VNE4jovl0SONOVd7n5t2kAa27t6Dr38zgHnzBMeuXwupHAko7J+85YIjhGtycVcJwCYY1ddLHv3B1RQDfUjq/h5Luc5DdYNyBwT14BQWGxWsLHuXj1wlqQnefVnOZ3UBQJGfJVrkEK39BTY0Utx5WPzIbjRInB35ta0CPCCVNE3ySsD6efJgofvQjlYFOQTv5u47iY/iM8g1mm4tDnrcKsvc8aapidNvMY2UemyC5elrUzWGj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(478600001)(2906002)(26005)(86362001)(7049001)(44832011)(6666004)(66556008)(4326008)(2616005)(66476007)(8936002)(956004)(66946007)(186003)(36756003)(16526019)(8676002)(6486002)(316002)(7696005)(110136005)(54906003)(1076003)(52116002)(7416002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3x0xcsuYgXoNte48kaUYdWt//VgC1EveiNx60u9p2OGKnL98joUvRwtJmM8l9a5bqyRumLZX2HhTNl3LHTrbYsh1+ILkNV45otNiumPGtrmZV+wprx4X6nsJYdg7ra3LDdvnHiSAkHlJigx4dtM+LgkH3uzycYUZFz9ow1qt7nSjJJ6wplOjRm5Z7VUCxt8D1RSnT66V9QdpCvga8nzG8V40lxKviNzcAQXREgiQ9C7E588xC6dazuPyYGuaijovtSgRlXzfaK3vQDTXePphJ/pQ4M2Q/DWSJ1T1Y6DfSpF8j8LTr0ZwjakB7zJxXYjGCyxTgCFwIRexelrV0WfTANAwStClpNQmfauHSm6e5JCiWjrR3M30COAPncOKFutq9JOt7RRftsETwsRTS+OPfxuCzQXJP2Vhsu+oD9BKuIKK0jg+MgLtNJKBoWbrOlzvolmhkqqwQbLUC7/DfHCOQ/v6KJHTLpvRsq7pSJcu1umRANQX/Hgt8/EjELPCCj3CxUOM2727q0wZ6sAyZ/HZlaQUQ2A5EA2RXl8n8HGuPg15diVuVft7AUySF3H9UBubCKI6ReHnJCoXX8GzyVthTgJTWcHrdz2OqC+Ac7OyJKKxxIS4ob2g0ySHXShV20qJrMsZcrbSf3+JlO6PrEWMGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d161b83-6896-4fb1-b2da-08d85e3cc499
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:43:56.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv6yUdzbklCByAwJpgGJTaWHOyXT9J/1W/CyO1/aZkXB0i9/0WegmxAYvg5kZtgH5YcqIyrRuyVtYQeU6HdclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace AMD_FORMAT_ATTR with the more apropos DEFINE_UNCORE_FORMAT_ATTR
stolen from arch/x86/events/intel/uncore.h.  This way we can clearly
see the bit-variants of each of the attributes that want to have
the same name across families.

Also unroll AMD_ATTRIBUTE because we are going to separately add
new attributes that differ between DF and L3.

Also clean up the if-Family 17h-else logic in amd_uncore_init.

This is basically a rewrite of commit da6adaea2b7e
("perf/x86/amd/uncore: Update sysfs attributes for Family17h processors").

No functional changes.

Tested F17h+ /sys/bus/event_source/devices/amd_{l3,df}/format/*
content remains unchanged:

/sys/bus/event_source/devices/amd_l3/format/event:config:0-7
/sys/bus/event_source/devices/amd_l3/format/umask:config:8-15
/sys/bus/event_source/devices/amd_df/format/event:config:0-7,32-35,59-60
/sys/bus/event_source/devices/amd_df/format/umask:config:8-15

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/amd/uncore.c | 111 +++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 50 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e7e61c8b56bd..15c7982b1c58 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -262,47 +262,60 @@ static struct attribute_group amd_uncore_attr_group = {
 	.attrs = amd_uncore_attrs,
 };
 
-/*
- * Similar to PMU_FORMAT_ATTR but allowing for format_attr to be assigned based
- * on family
- */
-#define AMD_FORMAT_ATTR(_dev, _name, _format)				     \
-static ssize_t								     \
-_dev##_show##_name(struct device *dev,					     \
-		struct device_attribute *attr,				     \
-		char *page)						     \
-{									     \
-	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			     \
-	return sprintf(page, _format "\n");				     \
-}									     \
-static struct device_attribute format_attr_##_dev##_name = __ATTR_RO(_dev);
-
-/* Used for each uncore counter type */
-#define AMD_ATTRIBUTE(_name)						     \
-static struct attribute *amd_uncore_format_attr_##_name[] = {		     \
-	&format_attr_event_##_name.attr,				     \
-	&format_attr_umask.attr,					     \
-	NULL,								     \
-};									     \
-static struct attribute_group amd_uncore_format_group_##_name = {	     \
-	.name = "format",						     \
-	.attrs = amd_uncore_format_attr_##_name,			     \
-};									     \
-static const struct attribute_group *amd_uncore_attr_groups_##_name[] = {    \
-	&amd_uncore_attr_group,						     \
-	&amd_uncore_format_group_##_name,				     \
-	NULL,								     \
+#define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
+static ssize_t __uncore_##_var##_show(struct kobject *kobj,		\
+				struct kobj_attribute *attr,		\
+				char *page)				\
+{									\
+	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
+	return sprintf(page, _format "\n");				\
+}									\
+static struct kobj_attribute format_attr_##_var =			\
+	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
+
+DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
+DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
+DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
+DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+
+static struct attribute *amd_uncore_df_format_attr[] = {
+	&format_attr_event12.attr, /* event14 if F17h+ */
+	&format_attr_umask.attr,
+	NULL,
+};
+
+static struct attribute *amd_uncore_l3_format_attr[] = {
+	&format_attr_event12.attr, /* event8 if F17h+ */
+	&format_attr_umask.attr,
+	NULL,
+};
+
+static struct attribute_group amd_uncore_df_format_group = {
+	.name = "format",
+	.attrs = amd_uncore_df_format_attr,
+};
+
+static struct attribute_group amd_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = amd_uncore_l3_format_attr,
 };
 
-AMD_FORMAT_ATTR(event, , "config:0-7,32-35");
-AMD_FORMAT_ATTR(umask, , "config:8-15");
-AMD_FORMAT_ATTR(event, _df, "config:0-7,32-35,59-60");
-AMD_FORMAT_ATTR(event, _l3, "config:0-7");
-AMD_ATTRIBUTE(df);
-AMD_ATTRIBUTE(l3);
+static const struct attribute_group *amd_uncore_df_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_df_format_group,
+	NULL,
+};
+
+static const struct attribute_group *amd_uncore_l3_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_l3_format_group,
+	NULL,
+};
 
 static struct pmu amd_nb_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
+	.attr_groups	= amd_uncore_df_attr_groups,
+	.name		= "amd_nb",
 	.event_init	= amd_uncore_event_init,
 	.add		= amd_uncore_add,
 	.del		= amd_uncore_del,
@@ -314,6 +327,8 @@ static struct pmu amd_nb_pmu = {
 
 static struct pmu amd_llc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
+	.attr_groups	= amd_uncore_l3_attr_groups,
+	.name		= "amd_l2",
 	.event_init	= amd_uncore_event_init,
 	.add		= amd_uncore_add,
 	.del		= amd_uncore_del,
@@ -517,6 +532,8 @@ static int amd_uncore_cpu_dead(unsigned int cpu)
 
 static int __init amd_uncore_init(void)
 {
+	struct attribute **df_attr = amd_uncore_df_format_attr;
+	struct attribute **l3_attr = amd_uncore_l3_format_attr;
 	int ret = -ENODEV;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
@@ -526,6 +543,8 @@ static int __init amd_uncore_init(void)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
+	num_counters_nb	= NUM_COUNTERS_NB;
+	num_counters_llc = NUM_COUNTERS_L2;
 	if (boot_cpu_data.x86 >= 0x17) {
 		/*
 		 * For F17h and above, the Northbridge counters are
@@ -533,27 +552,16 @@ static int __init amd_uncore_init(void)
 		 * counters are supported too. The PMUs are exported
 		 * based on family as either L2 or L3 and NB or DF.
 		 */
-		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L3;
 		amd_nb_pmu.name		  = "amd_df";
 		amd_llc_pmu.name	  = "amd_l3";
-		format_attr_event_df.show = &event_show_df;
-		format_attr_event_l3.show = &event_show_l3;
 		l3_mask			  = true;
-	} else {
-		num_counters_nb		  = NUM_COUNTERS_NB;
-		num_counters_llc	  = NUM_COUNTERS_L2;
-		amd_nb_pmu.name		  = "amd_nb";
-		amd_llc_pmu.name	  = "amd_l2";
-		format_attr_event_df	  = format_attr_event;
-		format_attr_event_l3	  = format_attr_event;
-		l3_mask			  = false;
 	}
 
-	amd_nb_pmu.attr_groups	= amd_uncore_attr_groups_df;
-	amd_llc_pmu.attr_groups = amd_uncore_attr_groups_l3;
-
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
+		if (boot_cpu_data.x86 >= 0x17)
+			*df_attr = &format_attr_event14.attr;
+
 		amd_uncore_nb = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_nb) {
 			ret = -ENOMEM;
@@ -570,6 +578,9 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
+		if (boot_cpu_data.x86 >= 0x17)
+			*l3_attr = &format_attr_event8.attr;
+
 		amd_uncore_llc = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_llc) {
 			ret = -ENOMEM;
-- 
2.27.0

