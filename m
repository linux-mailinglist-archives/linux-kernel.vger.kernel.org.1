Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A842728A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgIUOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:33 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:44256
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbgIUOo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAUTKefs0SxrghQL6Qb1wbh0rYPhaa3VddW+lOfhH9oNTF2Ni2+kR2z+luqlvao9C2dSFnBOVkak6ZJwzLlYtIUba7gk+ziW1ZWO9qJAWZSYZG03DRwwfCvTeJYClJCjk2/MgxXLQXg+wGFN5yYvtFMsBZ1sm73gCWCzs7csAKGeTA5gXmw9FSf7BxKS4Xfj+WGFfmyq/oljfInYtgRwLwWs7LIDGpn5Pbh29RFfXKycET+c+teBji44Q3rh7PiulKmCPP+2Rb3VYPEAv6z9YrzXtN8xHLJa4o2j4Rz4JIpQsyn7eLwfEutvW/Jl4RAb2cCUI4L6qtLvT+tx63gtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISem+08TrjTGiVNiWpIP/jYLSsL1F4Ds5Ukp9K45uNI=;
 b=VKYmMJKQ7dvcBrC6EWqC8ckDOggkBm/MNUzS6BYA6ni3c5XdYEOnLbzqLfqv2NUUUMU9KG0GYInbdvET8r1LWQJ/9RKfE+bKzCs0w4614ojkJYrW4WBOib8M6xa4JE4Gr99NxfHh0zwJcU0p9lkDkYwhoJBAVz1MkS24+bIldobh6STc191T4Mpe8nVLwpg3cRA1ohXJUq83J1tGsUwDutqQvZw8Bz3Z5oAVYti+8zyv9Ts7rqAiMmp8KO9GBe4A4WFioA4WyR2ItgmJ1pBJEngyGgndZPwcucAs/OFW719rI1qPNiR0RDV1NaJNOgy42jkHsk2qcLY3hYOfOE6S8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISem+08TrjTGiVNiWpIP/jYLSsL1F4Ds5Ukp9K45uNI=;
 b=tta9Ui/NXMFWl/MXQ/pEhWouZyTX2LBGy+YQ1Sp35R+JbYzmJbMpXen3aXHnaVrjzU4K1LG5ClQadpKRcdjy3yq6Qs29ZT+xnJn5S6XLrkYYFWgizPinY6um0qiL1A04Uhi4H4b+0ka8Pw8YKXupBK5Uwk+wp4AGna/n41fywEM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 14:44:24 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 14:44:24 +0000
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
Subject: [PATCH 3/4] perf/amd/uncore: Allow F19h user coreid, threadmask, and sliceid specification
Date:   Mon, 21 Sep 2020 09:43:29 -0500
Message-Id: <20200921144330.6331-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200921144330.6331-1-kim.phillips@amd.com>
References: <20200921144330.6331-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0040.namprd04.prod.outlook.com
 (2603:10b6:803:2a::26) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by SN4PR0401CA0040.namprd04.prod.outlook.com (2603:10b6:803:2a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 14:44:21 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0052757b-316c-4bf6-4bc6-08d85e3cd4f2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1459DA13C91AAD5A8C355504873A0@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZspdDkbWLIg+ky8vpbVkItxAKoiN9O6AXiTf+lY8LcjldbQ/VcmVszF1RNv37xfAi4E5vihwufox6afFiydvy6fKnhl6kdU00CiorKVjEQ0lg09JE9yikXIabxGIv3TAFF372e6b+o8nSmFeVvrswnpO7Ll+WFjxVLgWvxfgjZRvpE77CFdU299bcpj/fGG1YYnPEa5ApTykeLlZWcTzvcMadkBarc1QJidgd5ydMEFd23EZAkbLK2hEKH/TxdOjGdTagwhVxzb99FkzxYoXSv6KT5OhW50qXhZu/Ss+1IWefMdufWY0WAjQiqkdmCOD7nOTtb/ELRmpRcm/cqQV1jRY/5Qnmptd78g1sBaDogjYnx80ix5VfKU6dDFxVUUK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(66556008)(956004)(2616005)(8936002)(7049001)(44832011)(8676002)(4326008)(6486002)(110136005)(83380400001)(54906003)(186003)(16526019)(7696005)(52116002)(26005)(86362001)(478600001)(2906002)(316002)(36756003)(5660300002)(7416002)(1076003)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zqGaKOUSsAhGb2emLg9+31mUm+rELwxGepUrMI4VmdrocgXOPhbq1wgLi1iNyVKVk9ocuRRk18YpwIN9SIzvHeTryF83nk1zIhvFDh1+ge0gJxm/NvzLPuZiDRzSPzqEeVY7bO7wiPswim76E6vr1pvkGomA76d/9oJdyIXRUd95scJMBrlzvLYKe6bcWrGScDvuzNqLVu70FgESOI2DNqX/WEvEBce9F111Ui1nnktbBJ0c+8QZWk35Jb2NuV2ST/nqKVxIDwDmhFanlXwPP30eQ2miGiPTGCkM5/VilZ0l13DAEmWZcVVnFLv++vV5IftatA2T0qotfsNCMrJvzxohwE6dki875XUf2/8bA3g6q2J13wEL4O6cMRAFqcYeHdS4vab8HHvD1cDGsLAC97TGu6nDY9T7IjugxiktOMWeLfbRfSg+IFlf48CKWvcIozuAx/6ct/MgS8e5hBWB0sGbyAbj4uYPyYiJyYYG9UCXMcQeuYUVDEP99wZBXt6e9ZSmIZcyY1wXXCvvizaFPz7WDB+5wJqGvSYPzAqBgNnA+AsUPbn3voRferNXzKU6o4y5vbAsMb98ozfCfJ0zJD/NMlzkqjLpUJpiyuh0Hyy+o9R1yl5m7P42USEbcld6y53y+UH53e664VbFbwfYjg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0052757b-316c-4bf6-4bc6-08d85e3cd4f2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:44:23.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9OCT9hd0WCOVVIAE6xopY2wkScnJKwCpI1NIRA5qsqkwqcZUc8DKuOznYA1sbG/VokR7ZQTp3fROzdTvTssSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Family 19h, the driver checks for a populated 2-bit threadmask in
order to establish that the user wants to measure individual slices,
individual cores (only one can be measured at a time), and lets
the user also directly specify enallcores and/or enallslices if
desired.

Example F19h invocation to measure L3 accesses (event 4, umask 0xff)
by the first thread (id 0 -> mask 0x1) of the first core (id 0) on the
first slice (id 0):

perf stat -a -e instructions,amd_l3/umask=0xff,event=0x4,coreid=0,threadmask=1,sliceid=0,enallcores=0,enallslices=0/ <workload>

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
 arch/x86/events/amd/uncore.c | 37 +++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 1e35c934fe7c..f026715a39d2 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -190,8 +190,19 @@ static u64 l3_thread_slice_mask(u64 config)
 		return ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
 		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
 
-	return AMD64_L3_EN_ALL_SLICES | AMD64_L3_EN_ALL_CORES |
-	       AMD64_L3_F19H_THREAD_MASK;
+	/*
+	 * If the user doesn't specify a threadmask, they're not trying to
+	 * count core 0, so we enable all cores & threads.
+	 * We'll also assume that they want to count slice 0 if they specify
+	 * a threadmask and leave sliceid and enallslices unpopulated.
+	 */
+	if (!(config & AMD64_L3_F19H_THREAD_MASK))
+		return AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
+		       AMD64_L3_EN_ALL_CORES;
+
+	return config & (AMD64_L3_F19H_THREAD_MASK | AMD64_L3_SLICEID_MASK |
+			 AMD64_L3_EN_ALL_CORES | AMD64_L3_EN_ALL_SLICES |
+			 AMD64_L3_COREID_MASK);
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
@@ -278,8 +289,13 @@ DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
 DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(slicemask,	slicemask,	"config:48-51");	   /* F17h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(threadmask8,	threadmask,	"config:56-63");	   /* F17h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(threadmask2,	threadmask,	"config:56-57");	   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr, /* event14 if F17h+ */
@@ -290,8 +306,11 @@ static struct attribute *amd_uncore_df_format_attr[] = {
 static struct attribute *amd_uncore_l3_format_attr[] = {
 	&format_attr_event12.attr, /* event8 if F17h+ */
 	&format_attr_umask.attr,
-	NULL, /* slicemask if F17h */
-	NULL, /* threadmask8 if F17h */
+	NULL, /* slicemask if F17h,	coreid if F19h */
+	NULL, /* threadmask8 if F17h,	enallslices if F19h */
+	NULL, /*			enallcores if F19h */
+	NULL, /*			sliceid if F19h */
+	NULL, /*			threadmask2 if F19h */
 	NULL,
 };
 
@@ -583,7 +602,15 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		if (boot_cpu_data.x86 >= 0x17) {
+		if (boot_cpu_data.x86 >= 0x19) {
+			*l3_attr++ = &format_attr_event8.attr;
+			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_coreid.attr;
+			*l3_attr++ = &format_attr_enallslices.attr;
+			*l3_attr++ = &format_attr_enallcores.attr;
+			*l3_attr++ = &format_attr_sliceid.attr;
+			*l3_attr++ = &format_attr_threadmask2.attr;
+		} else if (boot_cpu_data.x86 >= 0x17) {
 			*l3_attr++ = &format_attr_event8.attr;
 			*l3_attr++ = &format_attr_umask.attr;
 			*l3_attr++ = &format_attr_slicemask.attr;
-- 
2.27.0

