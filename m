Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BAD2B6C63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKQRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:54:49 -0500
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:43150
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbgKQRys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:54:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5hfk1nmYHI1NNT/LcbVASjIANpKJ0I3kZh2bjlrNkXrtUr1EMEv5cxIbCYnLIV44ouHgPIsi/ytwr77hDmMJsIqIJl007w53K0G7cM+CtSIN6ET+l3yVmlWua7i0WAmYnddjGzPCqYPF8FyrwL5Qm1WHxUtjBuA/Rz2yMHObB44KXebzalP7LsTn5oMjzaycxgf+HQbdIR/G1hvJ79mtJ4YGfrOkgmejYI4Lew6g+5mKljlhGrZjH7l+djlChec6k4OK3mgA4+zZhe6In7VPWKMlkMQTg4QnbKDHLxRpmLMjJRLJoZuJ+/PETDEGqFG4NqWCqVQliRcQ3NxPWytMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJMxUBSDEc9yaU3I+CzwY0Z+k+Tk4ORw9qFrXzqGAU0=;
 b=XJq7Boj+NhSzNxYED4aOwa7R/ugmkLVRpPBc+3f38M6HEdl7cjj4dnOsgrZRjipXHE77MItdo3+X+UlgmvAIFv2HAuLrJC5eaTuoUVErx2n6Cv7MDU7GuLiHesosWJrTlQZkgE8vd7VncQY034OAfDsY1VhSsd4u0lyC5tTHL+gk0r/jBHe+Evb8KL9FcPK0H+fCS+T+Vd2nBJNw5ZYk4gIiVUyzviuj23yM2A9luizGoor+2yTWSY6VxSxZhB63g0ld0lOEfLMigl9W5D6M97PtCpzlraDVMLx9jcZONeRxsqyRJ4ltJzCZw8GRpsCVSfKJCG/sqkqaOUeWNk2w4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJMxUBSDEc9yaU3I+CzwY0Z+k+Tk4ORw9qFrXzqGAU0=;
 b=Nw05bFViUGgLNdBZI1g7Xj24GCznlebTDTiR4IIuK/GwUBX0VHMyYV8avNdfPwTe+DDDTifIBNxvxUtegW8BEpUnqdG9UnwLdjZmhuv10+/uT/42NQPimuDH4QuDWM7Ay7Os5Mj/wbRJFCvErBslm3Uk+6UNf8bZHAqSXE7El/c=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 17:54:44 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 17 Nov 2020
 17:54:44 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     konrad.wilk@oracle.com
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, jon.grimm@amd.com,
        rientjes@google.com
Subject: [PATCH v4] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date:   Tue, 17 Nov 2020 17:54:32 +0000
Message-Id: <20201117175432.21910-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:0:50::12) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by DM3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:0:50::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 17 Nov 2020 17:54:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8c63782-4bcb-4598-8a0e-08d88b21ddcd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4559FA9996FC4574221B9B018EE20@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zysfxLDhlxC12e0j0/Mg7PX9ptnvtWA65awgAnhgCQ1odXq/kfK/8jbr2q6RIoGBbfOos7VxeNO13nB/69Gi1Kdwl3cRyczNH8WZXgN4ub9WY1Je+eR09C9AZsV2lgRiU8ohD/NtFaGwEOomy5khOVpSgKOQ2hFI3emoda6xgTkBXznKm7CFskop3b4hj1wpxlCdCXzqQNi8vwU153wzN2SZ7QiKlNvcfKlCV19UXXldHl8K49eRzrRkC313qarZrJDc05Y4+CCX4DFXoEpbNRWxdmaTU14B+L/yXAaCe8fpmbY6TldxHW5YVCyonjJIbB+xlviXiWXFBEfKMcKFtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(4326008)(5660300002)(6916009)(83380400001)(2616005)(6666004)(7416002)(1076003)(8936002)(956004)(8676002)(2906002)(36756003)(7696005)(316002)(66946007)(86362001)(186003)(478600001)(6486002)(66476007)(52116002)(26005)(66556008)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ir95k6zY7nsklgsBJlMKYjYCvDDc4M6NP0aSTAA5z5Cp5+Tt6mU5nXT1k+imAoBHyQRSiXedD3WFtVt9QgF2rP8PL9Vio4p6CPu9H0Cqs9GlqqnAYLFtex9luMlrRNMkscN4PYw/ouPlt0evxRclVlNff7uk/tfPPJT8NZSGeXLi30JHABDoFZnT++mR3dQeMy6Z3Giw22cwJZFwN8D0BXVlVSI4B9CsKLHldjFhnKsbVlfZBblevhsUTj9BjuvfjxsC0FolvhpFGvR+LWQUteRUa3U1PZkhDjTpzV71iMrTqYAvl54bXuWoJAiurgGemnRzS/NlzHqXa49qsGc17h0cQkR2CwursXPJvRkusvHOQcNq62aVyKl4J65W3Y4/tLooNLqIBn0g8I5RHYj9QaEn0d1uWvDiwjIj5pztlGHBuVEhbvwu5u3SYEYSIlPIzCr+0yNnkPeqr/ZE+Kn2+3k2WpnPuv2/PIxOu1A+O/MvfARjICyd7dV0X/EqekJYAUseNqQnat89JMXli7wwyPt2CJssmbuFW5+VgwMxZTSA+YAA1lKjbuslPXGsqyhWcQLgcpgzqszZkT/s2qqwt/FfJfGbNQaafIZW6MwBGGUcaS6xWYyVFJgB9rZ4AWo9GcDmQPKOQYqguw6a1g/kCmxvGpEoyBqFOB9opg1RvWO+ugX2l9Z+ZJM3IbhkjnMGOG7NQHch5/tI5sOpd3N1CdnLSARyX4V7SBajuEw6qJ5ngJf3FVLI2/QA3Y3uL9S48sH9JQNMDcNGewznS8EfEc5tzIsJEP5FLcHt8lxSaCnOWxYXJ9uWTujnlwE8p//4gQq/i5VDof2IeWK+I5Hy8hZ8p+i9ELAGbfN09mPbvrfaSIbLsDKQtjO7YBQURPBknhG46F8bnWl2KeUt/vCSYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c63782-4bcb-4598-8a0e-08d88b21ddcd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 17:54:44.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSrM2/lo8ddMYa7hZiAxayHE+kYH00vqf9AnYvJAnrHUB7XbtiwMY/XGkwqcuzHSXsGyug3P7h+gyDb96DuzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

For SEV, all DMA to and from guest has to use shared
(un-encrypted) pages. SEV uses SWIOTLB to make this
happen without requiring changes to device drivers.
However, depending on workload being run, the default
64MB of SWIOTLB might not be enough and SWIOTLB
may run out of buffers to use for DMA, resulting
in I/O errors and/or performance degradation for
high I/O workloads.

Increase the default size of SWIOTLB for SEV guests
using a minimum value of 128MB and a maximum value
of 512MB, determining on amount of provisioned guest
memory.

Using late_initcall() interface to invoke
swiotlb_adjust() does not work as the size
adjustment needs to be done before mem_encrypt_init()
and reserve_crashkernel() which use the allocated
SWIOTLB buffer size, hence calling it explicitly
from setup_arch().

The SWIOTLB default size adjustment is added as an
architecture specific interface/callback to allow
architectures such as those supporting memory
encryption to adjust/expand SWIOTLB size for their
use.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/setup.c   |  2 ++
 arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/swiotlb.h   |  1 +
 kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736fbc74..b073d58dd4a3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
+	swiotlb_adjust();
+
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 3f248f0d0e07..f6c04a3ac830 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
 }
 
 /* Architecture __weak replacement functions */
+unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
+{
+	unsigned long size = 0;
+
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 * Increase the default size of SWIOTLB for SEV guests using
+	 * a minimum value of 128MB and a maximum value of 512MB,
+	 * depending on amount of provisioned guest memory.
+	 */
+	if (sev_active()) {
+		phys_addr_t total_mem = memblock_phys_mem_size();
+
+		if (total_mem <= SZ_1G)
+			size = max(iotlb_default_size, (unsigned long) SZ_128M);
+		else if (total_mem <= SZ_4G)
+			size = max(iotlb_default_size, (unsigned long) SZ_256M);
+		else
+			size = max(iotlb_default_size, (unsigned long) SZ_512M);
+
+		pr_info("SEV adjusted max SWIOTLB size = %luMB",
+			size >> 20);
+	}
+
+	return size;
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 046bb94bd4d6..01ae6d891327 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
+extern void __init swiotlb_adjust(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern void __init swiotlb_update_mem_attributes(void);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..66a9e627bb51 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
+unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
+{
+	return 0;
+}
+
+void __init swiotlb_adjust(void)
+{
+	unsigned long size;
+
+	/*
+	 * If swiotlb parameter has not been specified, give a chance to
+	 * architectures such as those supporting memory encryption to
+	 * adjust/expand SWIOTLB size for their use.
+	 */
+	if (!io_tlb_nslabs) {
+		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
+		if (size) {
+			size = ALIGN(size, 1 << IO_TLB_SHIFT);
+			io_tlb_nslabs = size >> IO_TLB_SHIFT;
+			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+
+			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
+				io_tlb_nslabs);
+		}
+	}
+}
+
 void swiotlb_print_info(void)
 {
 	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
-- 
2.17.1

