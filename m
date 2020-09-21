Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6862728B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgIUOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:45:02 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:1953
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgIUOon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As3PdPLCALfFonOF0Qh0eUaVaI17bN2yqWkkvWyann85kQjJufG49x+vGcJEUqBZ4I8HGXSWypi8s+S5eVrgT+BOZKmA//A9H6qcu3KWGo//bDwtm+91e37gFF+vcrrQk1ldNOsESzXImQcpVxXuovxT105E2JtPfytE3RejcayBJKhxMEplWuODegrgt/212gHuGAeZ4sT1FsJ6613YoTHtYWdgazJKnOVt4ObAsFwP1pBnQLM2JuiRJci7ZOXglZDq0F33RCY6nfH8K1huD0g5fbVL4Ekk6OdfTCbyPtVSqBlevOOdPAANNfrWqo1PnDDjIa9hua/8GGlxKPiZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avpbUtFfNAPm/83+6Vwwc1b0/ywmB7zIgfQ/lc6MYgQ=;
 b=KxOzozLyOPw42ODy9xBS6U8CLPCyAUcq/fXXYDAkT7tJJyojPDcGSuBp8tjE01FFlHfEXbM/s6iL6EluJgiRAnj+xaU93rq6yKSKfXCFyAkCyvw5Ph8EKSpd2+tyx038W1rBON2b9N1UJuCKkmqIzL5Pril+jwIbbGYXygjzNPIo9phBv4FUXeTQxOoUPGPUH5H0D+mHrE3Blm8k5aB3pgZba37FkenzDtC7yGzt9tCyDHj33IaO/rLXm2XLRYU/6J7jcAcaNENwNLeAPiIljmyNEim/+3M+RiK89T9K9jX+N5DxsWSq4+HHMHHXD+NIgOx4psLrKkQO021GhF84ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avpbUtFfNAPm/83+6Vwwc1b0/ywmB7zIgfQ/lc6MYgQ=;
 b=YUWO/eEEg2Hn+reWVYVAh+AEJK5Mq5UYyI3vCJSrIXkqP9KbkMYXKC6YE+oyQvpHmBL9wb/zUTyFPe9jNdxVPgJwCjpXNM7GcdIsbc5pWm1PbxwHOP59ndGpmc72kGtZVFGEMeMohmA5iQxHzwahHmvES4KnrCePJfJnzIHo+HQ=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 14:44:39 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 14:44:39 +0000
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
Subject: [PATCH 4/4] perf/amd/uncore: Inform the user how many counters each uncore PMU has
Date:   Mon, 21 Sep 2020 09:43:30 -0500
Message-Id: <20200921144330.6331-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200921144330.6331-1-kim.phillips@amd.com>
References: <20200921144330.6331-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0031.namprd07.prod.outlook.com
 (2603:10b6:803:2d::34) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by SN4PR0701CA0031.namprd07.prod.outlook.com (2603:10b6:803:2d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17 via Frontend Transport; Mon, 21 Sep 2020 14:44:36 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed230634-986c-4082-29ca-08d85e3cddf5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1459B64D9BC1BEEBB9FF9F0C873A0@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pKo63iI3kCZrd0KZgMPk51i/DTGqXEXEl9ueU9OCynVOAs6qkjuzMnofyhwbqfs/GKD33HBcZeQ/Tr6z8g8cFOVMaY/POQLl0yTFZSINix0n/ataHLVeoyluj1aW5Cp+Z6m1CT/WBst2bihGz+nm21UZM5xCH03NfZrSM/AZo8M9AEnKW5eYBwYxc61CamCL+OokLVtW2uj7NikfDuVLUCR6vRuJin7HYkJCIZ/oJMOns3X6T9ky969lghsz4T/4aHf4GJUoSzZk0shXUNk4a1p9R06/Izw8/vtxuacfuVSG9MurSzp/nT9zPjczdw8nxf9F4Ij82abD06rvnyCtpy6A+lYcDm0rtUakdhQCiDIzG+QhVC+4g6V4uUIKgGE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(66556008)(956004)(2616005)(8936002)(7049001)(44832011)(8676002)(4326008)(6486002)(110136005)(83380400001)(54906003)(186003)(16526019)(7696005)(52116002)(26005)(86362001)(478600001)(2906002)(316002)(36756003)(5660300002)(7416002)(6666004)(1076003)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xWjgFMEABpJ3PsRDtEWDOpe6gMpNg7t7GKEhThJ/12vuACATEiExf5IuPd5iKRTexFswvgeRYz+JCZd13u0q1QJNwY4X9qFcSsbM2AkY7WXLbrvxz9sjOSm+4uqV8+udNns1LdXIn84wZ+t2A64U61VFlukClEnP5b7KO8QTIIRozblxQumkuQs/zrlgT7+I9fSna5K7hZSfwr418TjT6zjY9jQRp6QYadQQPtfOx9789gVNTW4PXh3/SbbCHv0CUs3zU/ujUzq806hx5r/m7jCohDU6Gx2rt9hOdvQ+eTI0hymXohfu4nYUs8HK1GwJVFQaHwRvOaJEE3zNj3k6iC+YUr7F18UYdN7LSkyKS7uORmcVf2RggZKFXdP5Au5RzpVxTBnvxT+5KmRMOU2d6XEAuvJCdZb4ovw6yRKgp4aPcWAoGf5nSaQV1/FIPrfLiHcHs1vjSPmdmojBOAAa+Qn4Xf+stXiDr4HTG/l14fNNKXGv+sX0sRCotj2LUtQxb++piHSq+xaF9SuELuK89oLCf7eplz2tRMh4OgMrKCrzPLmuMNztCXzTtwBtNOIsxSNvOfkgpNsu1SE7ultZ4BpOTNJT3tgLPDeKg4tBEgNE42+Tny9hhIpMnltYxughJBVdOyEbBLUK5StjHioL/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed230634-986c-4082-29ca-08d85e3cddf5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:44:39.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ogwaq1rwiQ6vpxi+f6Dh6U3cqN0dhUCS1ewv2gXWpZY/3M6JC1vJDiok7eRyETODepBMVwDUQ9gG58ct+l5j+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the uncore driver would say "NB counters detected" on F17h
machines, which don't have NorthBridge (NB) counters.  They have Data
Fabric (DF) counters.  Just use the pmu.name to inform users which pmu
to use and its associated counter count.

F17h dmesg BEFORE:

amd_uncore: AMD NB counters detected
amd_uncore: AMD LLC counters detected

F17h dmesg AFTER:

amd_uncore: 4 amd_df counters detected
amd_uncore: 6 amd_l3 counters detected

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
 arch/x86/events/amd/uncore.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f026715a39d2..7f014d450bc2 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -595,9 +595,10 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_nb;
 
-		pr_info("%s NB counters detected\n",
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
-				"HYGON" : "AMD");
+		pr_info("%d %s %s counters detected\n", num_counters_nb,
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+			amd_nb_pmu.name);
+
 		ret = 0;
 	}
 
@@ -626,9 +627,9 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_llc;
 
-		pr_info("%s LLC counters detected\n",
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
-				"HYGON" : "AMD");
+		pr_info("%d %s %s counters detected\n", num_counters_llc,
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+			amd_llc_pmu.name);
 		ret = 0;
 	}
 
-- 
2.27.0

