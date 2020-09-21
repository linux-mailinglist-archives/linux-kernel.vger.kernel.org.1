Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4127289B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIUOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:20 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:59990
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbgIUOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE1HENjJyK4SqvaCFWEuzjD91ZXaVUgGGA2THaAwM4vT0fALLRiaIHYFFiC4fR5/p1Q/eMJhkPMK+0hEe9whhw20XRTTdsbKFNbOF82TAu6/YEMc4E+Ss6A2mjx0ie8WeLlPeXBvfn5xXcvRP/U5HqWP/OKcrHgXAQR40jkkH57PROw0Lj/LaMpQ4gPrjnvrCqHl++sUUgDGDH16VRSxswVWBnpvAit3G41gp2YCcmf+P6f7na6uAjHPoe+n1pFz9uM/sowww+TQHLSm1G2hUwFmlU9Va469mffU/oi3TVqyFgmOYUdP0A5SPQs8mlFnawZSmZTCn1ZcgQeYld+zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X92rRNQw6MYuSSt2IVAtFby+slTA3ntrr28q/n7Y4AM=;
 b=En+2RZoJKup3wQxfIF0fE7xeBwYUAX32KyM0RLjbpme6sTiQMtk39EXPzH/z0LRUYu7FEYVfyxY9VFFjskVnWRdYPTo3wkLlkGfIP29enPdue5k9/cLX1fNB6noFVlMdwKmMO0dssaKnwDE+oUcpj+LAKTM8sNLJVJAoWCinLhwgNz294VCppCxf6V9llq3raVlW1ec1/qWRH4c0iUM2ng4mflrL/0Re+cjnJopLDcTtS8T8404a7+Bfu5bwFA/PE3jqxVc7KorgsjUpYwv0oJcQORPaA7CCvrH3AVN3g1FT3N9VYR2hgLlw9aE1TTnVLSzEu2dEzBo9ij1O1NMuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X92rRNQw6MYuSSt2IVAtFby+slTA3ntrr28q/n7Y4AM=;
 b=YQ93CZV54wYqeOryAUD34b7p7NJwc2inDbnL1U0xZYryWw0vMQw7r0+Rqq4jDtHbtfVci+iDNW1DGRt/+92U0puOujRJXVHh7Oi6wNLBTCCJ1Y1nMf1pf/lAW6rqnVoNMDEHQTXjGjGGWDr+oJzA32QQpCTAytXrTlkbM/dcyEY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 14:44:10 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 14:44:10 +0000
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
Subject: [PATCH 2/4] perf/amd/uncore: Allow F17h user threadmask and slicemask specification
Date:   Mon, 21 Sep 2020 09:43:28 -0500
Message-Id: <20200921144330.6331-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200921144330.6331-1-kim.phillips@amd.com>
References: <20200921144330.6331-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 14:44:08 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8abd1b0d-6d9d-4dec-a3b7-08d85e3ccccb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB14594C12CC092291C20BA82D873A0@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upbfWgVBWLnBUEuFSjXd4bphQa9YC/8Rp1Q06BbDfwpL+YXe2t0lB0ChjjYYsOP0TTdKpwj9MRt0ApPgkSY1u9va1J4caZtd+Xfv6ruehJrO+Z24gnuLQcrODDPdK1NR8YUQeZXt1QTyC48u0qzOjArlr4iCCIZiOi4MbI6dqSlsqFF3iCaSOTjOPz5aOkERf++vt+bfnol1z1OAv1v/Wc4EtTMn8OKmbpuCKvthiXAfkc9mBJuu+JeVnH55NrN1wv66vyjC2mQhAktGhQBwr+ihCh+USxmUfacfSVEaLg6wvP7RF3fRmsp3wn9T5NOOYYpwzHIvjVHg5daHd5CAtc5uPRPLHFKnSy+rb9Snl0imu9Pi1979ZQQg86kTvrbN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(66556008)(956004)(2616005)(8936002)(7049001)(44832011)(8676002)(4326008)(6486002)(110136005)(83380400001)(54906003)(186003)(16526019)(7696005)(52116002)(26005)(86362001)(478600001)(2906002)(316002)(36756003)(5660300002)(7416002)(6666004)(1076003)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GZIPjWUVJjCOaVSSLIbnGNKc3UmJOivqZ4qCBdbCgFssDCVBn5rEmyWj0+7+ycZmH304CyIEP0a4Itbnh2iXf/ksUmbXP6z0fuJtF38n8L+zNN1a/2aLY+6VZpnt4r3hVt+7XxelHCx1GSAsvOUHNo/Oe3vrTk+4tixyDhWLjXBu5dNLz5rpjvsfr6TwDdbCUbdVs9ghng031D4q/0flRofRoGc7nzQal7ghfnRvx1pzl6i5BxQKWH0P+ij2wMu6EE/CMFvt+gP0kSXHBv71M3xsTfTArQXVuzgtzearS6u3ggy1zusiU9uXFtgJUSJw1jc+Nfsq7RMpmZsfYR9aa7R5U9E/35TL61DK9n8lEWMUOhAqMSBjy+WPddQ1MKmats4nGwi1Ww0eT+upEzIYszCCb8K8qyTs/NZJLdoOUkh8mvhQ8mQekL1OD4EuBcqUQkqebxYykTuJdvroq/HtBd17lMNPrJwLUU0/fDr27N+DsMNu/R0rH36JlS0pJ8hfYraCj1nODkkZ7jsEY/hgjX98AQcFj76gcmxg9oKrwBH6G8/Uu6dcowi/sT5/sGWYfWxsRBfYCrVxxZY3Jhzwf4Xn6e17onWoqcG96thSM9t/WpUO3UgTHCgLZZGFbExu0GfuxKUHhCToxjKr5bUJ5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abd1b0d-6d9d-4dec-a3b7-08d85e3ccccb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:44:10.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr8gqFLCpHf3gm669wdB0Mfcv/WPMXGyQc8pPhOLzC3eFrlCW/FRvcOX8xCQYxftyRnSVOQUd4UF/KcO+1Z3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue to fully populate either one of threadmask or slicemask if the
user doesn't.

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
 arch/x86/events/amd/uncore.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 15c7982b1c58..1e35c934fe7c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -181,13 +181,14 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 }
 
 /*
- * Return a full thread and slice mask until per-CPU is
- * properly supported.
+ * Return a full thread and slice mask unless user
+ * has provided them
  */
-static u64 l3_thread_slice_mask(void)
+static u64 l3_thread_slice_mask(u64 config)
 {
 	if (boot_cpu_data.x86 <= 0x18)
-		return AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK;
+		return ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
+		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
 
 	return AMD64_L3_EN_ALL_SLICES | AMD64_L3_EN_ALL_CORES |
 	       AMD64_L3_F19H_THREAD_MASK;
@@ -220,7 +221,7 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * For other events, the two fields do not affect the count.
 	 */
 	if (l3_mask && is_llc_event(event))
-		hwc->config |= l3_thread_slice_mask();
+		hwc->config |= l3_thread_slice_mask(event->attr.config);
 
 	uncore = event_to_amd_uncore(event);
 	if (!uncore)
@@ -277,6 +278,8 @@ DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
 DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(slicemask,	slicemask,	"config:48-51");	   /* F17h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(threadmask8,	threadmask,	"config:56-63");	   /* F17h L3 */
 
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr, /* event14 if F17h+ */
@@ -287,6 +290,8 @@ static struct attribute *amd_uncore_df_format_attr[] = {
 static struct attribute *amd_uncore_l3_format_attr[] = {
 	&format_attr_event12.attr, /* event8 if F17h+ */
 	&format_attr_umask.attr,
+	NULL, /* slicemask if F17h */
+	NULL, /* threadmask8 if F17h */
 	NULL,
 };
 
@@ -578,8 +583,12 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		if (boot_cpu_data.x86 >= 0x17)
-			*l3_attr = &format_attr_event8.attr;
+		if (boot_cpu_data.x86 >= 0x17) {
+			*l3_attr++ = &format_attr_event8.attr;
+			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_slicemask.attr;
+			*l3_attr++ = &format_attr_threadmask8.attr;
+		}
 
 		amd_uncore_llc = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_llc) {
-- 
2.27.0

