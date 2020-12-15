Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11DA2DA863
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgLOHIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:08:36 -0500
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:65280
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgLOHIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:08:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As0m6NpjF2zXmP4Ld5k46Fv2xo1VQefdOGlCgPwCCX+yavJWrgvBXxhr9abjw+vKx+vJ24sLXhG9FF/3Fwde47X3J4Cn0og9kuQyodbeW7hMBCDDgWZL2pCz8Z0Sm5HC6MegiB1pb20vwo+AocmHWLkRK6Q6TenbUZ9IvBIVEITU2eLYCE8wmii03pks4DXtkSgeJDwNFeH3k9CUjKgHD32N6qB/w7LvvsmHG5IV8niiQEjYc438IAlH0has0t3P8NiImbdDYCLD151nwpdX5mGnIyJ/Uy2Ei36tBC4fpuT2KBcwL0FfVt8eQN+IcTV+CHDqfwgn2FxYaxGWyjGfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niQbZCeCUeeryXYP+UvJZTD5g5xoLwHvMLWVJztO2N0=;
 b=CVCaIWsLsiAQk51zy7Xusi17GZa3sbI8ksI71sy6fiZ/ct0nU8MWVP5HcPG7yvjP7pFM5sQK9W0POW8Bo6cphttI+kvEE2hlnlGy7M8fxZKPcHH4RQGJfly1Q5CaT37WxJuYX3f/uMVq22YSry26e8GFozwEN74RK/C3J8kDJ2LAH5vuQIdp5nzfH3qXi+onuYsJsykE/qoBEifyIBEW92+a6sVJF//qBVbPTWVrntqn+W6UqGWuyfEN7lMwv3aLPA/l4PpjyQYFIk9Rdz2fN7ECQxMukfTwUEyYc8CAtwZwqL+zY1IB/zrjqlc+gB2y2v2uZK95JmSAvRkQ0zwYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niQbZCeCUeeryXYP+UvJZTD5g5xoLwHvMLWVJztO2N0=;
 b=yj+ZoecnHnpy0C2MQmMrTJgXDk1YLOIpKr2nqi8TeDULptWLFMjgLlONUZQ4TLKrOaRgO102pERpnNmk1fJZJbqQLwuZAWzI98zazI0tL0GwZqMsYROJwmjZLQeqkMEO2gWDgjbB5jp2NTNNfaBnWD2FvKHFde8zUhcMyzNH6F0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.26; Tue, 15 Dec
 2020 07:07:19 +0000
Received: from BY5PR12MB4163.namprd12.prod.outlook.com
 ([fe80::e920:46d3:92b:9450]) by BY5PR12MB4163.namprd12.prod.outlook.com
 ([fe80::e920:46d3:92b:9450%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 07:07:18 +0000
From:   Ying-Tsun Huang <ying-tsun.huang@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Ying-Tsun Huang <ying-tsun.huang@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Toshi Kani <toshi.kani@hp.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Lapik <dmitry.kolyadintsev@nyriad.com>,
        James Lee <James.Lee@amd.com>
Subject: [PATCH v2] x86/mtrr: Correct the returned MTRR type of mtrr_type_lookup.
Date:   Tue, 15 Dec 2020 15:07:20 +0800
Message-Id: <20201215070721.4349-1-ying-tsun.huang@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To BY5PR12MB4163.namprd12.prod.outlook.com
 (2603:10b6:a03:202::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ytubuntu20.amd.com (165.204.134.251) by HK2PR02CA0211.apcprd02.prod.outlook.com (2603:1096:201:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:07:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84ee7e4a-1c2d-4e4a-1980-08d8a0c80fa5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB43064BCBDDAC72515113A498AEC60@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SDG8sOt2RtoUcNXugq0QgpMMlqfJmo9+k0SgN1XrxeEbowhbDsXtfcR/QMOUW1Y2cw93DaDlRWEkZJJZj8TbbI2MjOZO9u8RfxYkR8wPdfaevhBs6JdJ032XsesZhhczNxRYG0HTjgu0I4qcLjywQA4S9qpJgH/oZWBwRkaCs+LBiggXb6l33EOiGyUfxssuxsS3ELwDy1A83Cnr9IjuvoeeEFtNGr9M5gnHqrPr5T0wnQVRsAeNkFqTrR8DXDJkCK86IxExIU1f0M3w4SkyosmrFoEgZ51+m0kwXl2exCYav//YLxKDiYw95OK1LwGExP3Ru50b0cUuJrouYcRfwf4Dpu8StrELqaYQG5cHmHWL9cFxOpFXTzx99m5laQNuWcp26PjLNCraMYOV80fpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(186003)(6666004)(83380400001)(86362001)(4326008)(7416002)(956004)(2906002)(921005)(2616005)(66946007)(52116002)(7696005)(66476007)(16526019)(8676002)(36756003)(8936002)(26005)(34490700003)(6486002)(5660300002)(110136005)(66556008)(54906003)(1076003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ers5p/9bz38k4fsnDW8/prsoF5TqFuSaa5RlXRFibpGflRezjlWsvr528GWdaxeDN4ZF2G8rNngRwLoCIxLdbmWmBytf9C6OU8frpYFuI35RONIIusJDnRGrjaGvr7Mp2qt4i1qdevxPi3yOAKURmcrKC7l+Xf4BrA0sCNfHGmSOgSkboyh8SKT7M2PyB0r5jPMH/rvj0WFQL+fe6lq7b89X/YpJ/HBaHU6XOgw0mJ7aNoXx+Svv/oviPZb6EDnGwzSkeodJPa76+tcGKfjeUKDX18F4tHbmSHY7BKkn1QVhvzwS5kn7i0aC5mLhAGCGY4qx7TBnv++VlPUbOwIz+pxVahLJEeiXPbmNOwQFsJcFyNOZ4GmPD2tU51NE91JNeZHCQT9BG9eP5JcAAV417arrMnwFeoQxGRZBXuMpv9w5SwFC16Hg3/Kbu8dRH4xP4IFA4OWQ2+HehutEftVUSfZKhpBphwBavd5/lSXo6BQ438n64z7QPjy7S3ldCjhTbgLMraHtQneN+myGQUccRIwIwDCMqhNtFSfPVQYQQ6D1zi5a/lePBv1Q+M63r5xK/R3k94HPIg8D3hC1iODh0app8fOdMy0+xz5lSd1qbjDabqu1BTE2IvTuO34bS+3x6Szu5VKUX4E+mgPB8ifxedlxqEPsKc3imaDKY0+s3LTbWAYGz+Fz/00gKvERpkC06RQsdrReQkA0QBH6WlYL8U51Kh4UizTcO4Ie16DL2sesSa3Ad0yAqLXTuSgBE9nE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:07:18.7434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ee7e4a-1c2d-4e4a-1980-08d8a0c80fa5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdDeAP3cks0MiheAvnRuJG+WEx1pKJsz9+AEx8zpqKSGcKRbl/Cx/NvrUcAZStKy6JKyaASbWMAegOComjHhzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtrr_type_lookup, if the input memory address region is not in the
MTRR, over 4GB, and not over the top of memory, write-back attribute
is returned. These condition checks are for ensuring the input memory
address region is mapped to the physical memory actually.

However, if the end address is just aligned with the top of memory,
the condition check treats the address is over the top of memory, and
write-back attribute is not returned.

There is a real case of NVDIMM. The nd_pmem module tries to map
NVDIMMs as cacheable memories when NVDIMMs are connected. If a NVDIMM
is the last of the DIMMs, the performance of this NVDIMM becomes very
low since it aligned with the top of memory and its memory type is
uncached-minus.

The input end address should be changed to inclusive to be checked
for the top of memory.

Fixes: 0cc705f56e40 ("x86/mm/mtrr: Clean up mtrr_type_lookup()")
Signed-off-by: Ying-Tsun Huang <ying-tsun.huang@amd.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 23ad8e953dfb..a29997e6cf9e 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -167,9 +167,6 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	*repeat = 0;
 	*uniform = 1;
 
-	/* Make end inclusive instead of exclusive */
-	end--;
-
 	prev_match = MTRR_TYPE_INVALID;
 	for (i = 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
@@ -261,6 +258,9 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 	int repeat;
 	u64 partial_end;
 
+	/* Make end inclusive instead of exclusive */
+	end--;
+
 	if (!mtrr_state_set)
 		return MTRR_TYPE_INVALID;
 
-- 
2.25.1

