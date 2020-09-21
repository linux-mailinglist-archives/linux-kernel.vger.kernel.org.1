Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9980272883
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIUOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:43:49 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:13089
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbgIUOnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi105R7PTyiPDN0AI33iaVomRbWM+spAx3YUOn9bzK3PfH0P9SVbkBmjxD6VtdUumDQm/XzuHn9ZIzcpFz9yTUsWMhyMmOZ6D7Jl6ATPeX3LU/3bQMLL+Qj9B8Ti2iO3J2GTm1UPc7HTWCSgFzTG9fc5iKg/xYR3wJ+8udfwasj5qJvT06drghXrMtjVYbxTQRc3dDubAP74DAm0mMZJDuT5TKfJWZRnv+/aMHyaYLSycWoUfvyYXfF1b6YmFLoHGHhNQfvbgXekzer3JAMrkLuT1a8qGbuOfgQ/hWaxpAoBcETqomw2KFN4uUri5hqMr0DCuJO0dch4nFAa7gLIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0WY4IolWWdotZQh1DRpvaAbL1IxYg+MNYZEW0UBYdA=;
 b=MMZQzQ+CqFYkkLpsQy19zOEijHE2VvaH+xDBSAV+DORJTSDQmBaU99PmJno8SgR9tb7MUAU+hAN7A513v8N1Cd/xGX4tkjYdviO3EqMZ4StkMmQI3Z7J4W2Y0OruoPem7mPpHCGr0DZI5StXdtdJGzUIRfqcqCJL/oGMBpNI/J/xmtV0BGwjRdIZObj7qqLLR4nJcGjd38xHIXBr4eRmME/PaU8B5o+M5+HHB4+zFqGNzl8fRc52mZSxw06XmZhimiW0SeAumuLmC2Rm+yPK8lGg0XCh6lF6G6YWbrr8QoE0LBtkftWm6ZsPLJsI7NZKY0FUOKzK/pMeODEAWggbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0WY4IolWWdotZQh1DRpvaAbL1IxYg+MNYZEW0UBYdA=;
 b=mtyx3EANlgdQ0j15xOl077BDUUecXah+YOe2QsTfXUg7q8PblcV3xgZm1VesOufZPhgQ2iYpU8ak/Jr0LN+MJ9KH/Mr9Enz7vhxz+Z956i4R4rqr76olTKzhf/RADQHuTFOUCpv4Ek8LhcnPSlncjob6k+xCVL5/1OL7u3C2Iy8=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 14:43:42 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 14:43:42 +0000
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
Subject: [PATCH 0/4] perf/amd/uncore: Support user core/thread and slice specification
Date:   Mon, 21 Sep 2020 09:43:26 -0500
Message-Id: <20200921144330.6331-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0068.namprd05.prod.outlook.com
 (2603:10b6:803:41::45) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by SN4PR0501CA0068.namprd05.prod.outlook.com (2603:10b6:803:41::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.11 via Frontend Transport; Mon, 21 Sep 2020 14:43:39 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e99e9616-5d9a-42e3-0d73-08d85e3cbc34
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB14596E3CFC106966ABBA5FA4873A0@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWT85HV4uhJKAUr7RaY7GUNvtwb4pMV6BwwWC+9P9fnbdUOc+D2u3tfnGByTn2bpCtw69EjGQtDf/WS6RXr/DY3MEvogSKiSbMITlFsMqlDDCv9osf8I11J52BU8xlU4sg/qcVMxhOUdBUEPFHo7tAZ6XwdCRmZ6MoSi81O+nyoPs7AvFWIH/Iyy7qxo49pBbcwqQjE7IuzfqL5vVXoF1MGt4ofOMVI2iK+1ttIx/UVlMQx40LZr4m5Xq3o9WvZ3rJ0Nb8gjfaJ6Mj5CbAYMzX/NIpqHb7dKyV4nnwQp8X7Al0WKWxQO+jNbVpLVKVSv0zRh1y8RjJcR2wToF8FcdAR8xOhJNWKAWyPpM7O5J6dVCrS3eo2reKYrVacKkGFU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(66556008)(956004)(2616005)(8936002)(7049001)(44832011)(8676002)(4326008)(6486002)(110136005)(83380400001)(54906003)(186003)(16526019)(7696005)(52116002)(26005)(86362001)(478600001)(2906002)(316002)(36756003)(5660300002)(7416002)(6666004)(1076003)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZPU5nZuMneXNe40EEEKjoohc2pZZ06eX/ncIfGllaqRTEitcpvO2GKQLHjbYzthhO5bgTp7dXgOs3b6P27PdaJCgH4ZcDGLZ+hQtHw6LPpa1nj7HtalK7dBbKgtkNpE0Rp9FAZIpgCQ7jKeFwDRERwq2HkSbslzw3a2T9hH5UAh9QNhPCGhECEZpHC7DVIe7TRojVmdszApNwlSlSENMk4fbcsYeg0HVkgOHX+zEwdGqc+7Fy6C5SvC2wZath1CV6PwLOzkU1S3A1lpBTyUxqTPdSbYZvAT8lTMjj5TByiK/EUkAllgVAZrqYTS9U5VmMUajmIRLDUVZQ2g5dcDxIVXnd2K21KW6u8VMEaczcPub026qY0QKZ48J93/v7v51o2L5NX0XQS4tmSV/pgaXQ77Wo/JE2Mv6clRi1zFUBZXTGM0x27DchWet4YjfBoyeHj5OBMKSq2btwbY+Sr/gMmXqaXhGpyrl/rWT0KgNt3E6wfJb89HPr6MMDvmopNa7et1UQMSLFOHMhxM9N5A0BFkyWswmQ6Wz7+ct7D3699zg9hD3C3wmCidPhh62V89AWvriiyI/ULRP+J17gGv1lT1TdK4gz/+PPSoETJNbWvAFVjs5nBaKhgbnfIlR6aF6kkfCwNJb/cDZt8DNLBG+oA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e9616-5d9a-42e3-0d73-08d85e3cbc34
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:43:42.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWWIAlUMcEpOelpIwkLr6RQyVv9HRj+GtR9q3bz4Avwqw2byByRseiNXlrPhk2UCQq35Ehd/K/bCWdoZHQXNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for AMD's uncore L3 PMUs to count events by core/thread
and/or by L3 slice.

The first patch rewrites most of the initial F17h support to enhance
readability and to prepare for the new upcoming attributes.

The second patch adds support for F17h's threadmask and slicemask.

The third patch adds support for F19h's threadmask, coreid, sliceid,
enallcores, and enallslices.  F19h hardware can only count one core
or slice, or all of them at one time.

The last patch makes the driver's dmesg output more useful.

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

Kim Phillips (4):
  perf/amd/uncore: Prepare to scale for more attributes that vary per
    family
  perf/amd/uncore: Allow F17h user threadmask and slicemask
    specification
  perf/amd/uncore: Allow F19h user coreid, threadmask, and sliceid
    specification
  perf/amd/uncore: Inform the user how many counters each uncore PMU has

 arch/x86/events/amd/uncore.c | 174 ++++++++++++++++++++++-------------
 1 file changed, 111 insertions(+), 63 deletions(-)

-- 
2.27.0

