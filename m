Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C677F2BB161
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgKTRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:25:29 -0500
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:25056
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbgKTRZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:25:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgpV9IW4nOcsy7+73cJTO2vZ4GZ5RyDTilk8S2njUz6l4oHGvdpNSSBeRhcE9j1khAjR5vGOFrerw6aUEYP8CjKwq12E+X7V8ldFyav9/52IztS8eI5NVisrpjwiGuvVCcJ4CKZQ710ADrrPkJZPTaFk6s3Oj6VNDPmprgiWW2TGPix4Zb8lIQVV9HQZYumNtMGN529NH9ucee3vXToGBEUlwBEduh2NRUlStE7eGwCWuWeHt0gJxlwOujUHJd2h9v4XanrZWMUG0DlR7H4WD1EYaPHpdaPFiDdBPhnvg6BgdwtHos4KM8nYOmO5eBfgIqMMXrnsdKMTHV+3VX59aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFCq/yMqPe52Vv8/azZVD6IVCEunYx9E6ninPpbvfBI=;
 b=YGflsHaPGCYnHXQhCVFYLiAiPeM1D/iFnQQHN8hfTUQWhUiPxAE+u78FMHUkbGfOlQEbeIXwPP3fMK59Jcl+O3f8LthnO9kaY9tKVUSVrX/bRiCgqU/Z7sqPzoYhPjmYRweAEFIsnZaQWfDUWw3Pu7PPLCQlKjVonGlmKryv0BS5qRNFKxlr42NJt0pJrMCS0VvKkrPieuk0h9qw+dhrM7BPrOw/ikszGV8k6TEpxFCQITdUZwGV5OW7G2szc6kZA8jXui596k89NP29lgJScjP+FJ4feB13DeF/nEmbpiWXmeHylOqQP3rPtfC6TSlnPthBOrCzpqqpbksZiUSqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFCq/yMqPe52Vv8/azZVD6IVCEunYx9E6ninPpbvfBI=;
 b=paCgMiKvvt/XAOf+PeG91sFbmakHz3fYs94xU6XDn93fTg/P8/TS9e2xurxDjc/gKTbDTDWQMobpIpaHW1WqIDjKLZdnwRjVhdK4tnsKl3iDslkwAZHq4nhAndM5MtlmGyEipn2bsGEfQ6BlIxbZCS31vJu3T12k+Qe9djP2z+Q=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 17:25:25 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece%3]) with mapi id 15.20.3589.025; Fri, 20 Nov 2020
 17:25:25 +0000
Subject: [PATCH v2] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
From:   Babu Moger <babu.moger@amd.com>
To:     bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        babu.moger@amd.com, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, reinette.chatre@intel.com
Date:   Fri, 20 Nov 2020 11:25:24 -0600
Message-ID: <160589301962.26308.4728709200492788764.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 17:25:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e4f7d13-de27-4728-8ba7-08d88d794482
X-MS-TrafficTypeDiagnostic: SA0PR12MB4464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44649EEED903169B9CC1351A95FF0@SA0PR12MB4464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbYRD8S/d+QcxSI1KfedE3X1atqCoLw4D7ZlaqIlcpjCaYEauOLCLqQ6NtXO8KUKpoOjb92Z7IYDwBln30G0cHUJF+AQwgh/7kC4z6z3KHxxMy5DPq9Tb3sy8fJ66lDueaBNO1NLR8HzEJthWxLFLjm6iCPZGA1g2Sdup+iAfDoWZByit1xxsCVQaoBtRKvWIGexW/mhTJj4onFoI5ynbyQNwxeu0d2z07ccRIQ3sbjwHZzNNifJ1GFqb0gP47vuMD7b5aaW1bLPKI6HxtzV3CJpvAXxW9X7C9mpsOYrP4I2+wZmUMH/i8Gy3p71HxPq5PwckyFYslHK1P2DHpE2I2iv0iUq7QspHyHoIvKmUeZy9PBDyn96FvAfKhZEGrAO68pzoNbUexAVtOrrWR4Bdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(83380400001)(8676002)(6486002)(186003)(66476007)(966005)(16526019)(478600001)(66946007)(66556008)(26005)(33716001)(103116003)(5660300002)(9686003)(86362001)(4326008)(52116002)(8936002)(2906002)(316002)(956004)(16576012)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HZGpIAq8V8fhCWoPqAoUbU+2Bhv9yTkBBZDB2ttCZT4OYr0+uvuobIhuhwwfNfJHumx7Jy4rED2gdkfbkeK2bXIGAsefDWFd3OB86ObjbB6+jcatekoSuNp4Szvf9j1nvAJEHnDbxfnz9RUV1+z1bkptKW94tDWal7nVr70fLaVDSfYlj2Tfy4sbmIdZkbpnhb4Pl30xfqqIByD9sBC1At1x6TIFLfQb/4fwrBLTORZIuf8w5SSFVQWfqnW9r51O2S5WaYmTBMzqD0z3iJdTWIK05im1lWWFCnfQ1NkIcwGTVlfQok8m4jxURHtom4AeKRM58o06q9k5Fr8kmyq3zAKCXDmUkaTpn3n/r+e82H89eDVUeXLbPOooJUAjW5P9Jw9fjH255SNcYLQn6MRPul6vRDFVPpwQV9dbcjl6KU6PMrt+rAyjfYj+YWj/dfPmO83FSoOh2yhC+tvx2AmRJgJQCdLCXDr4gp8JsP4oXV9LeqDbPMZvmofcYwIoI7PM2045GWg5mAWlqjtSdYYgB4FGRbBLLF17DKsenaAqnGD8kT7IZIKI6TrRhpCs+JBnxJTkOYag8PrG11jI0EaWVdc7ImpXtDuz3IiNt7L4GWyeYrx1U728P1xsVEHr7GkY2cAqCfCqmOgo09SK8gxFsg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f7d13-de27-4728-8ba7-08d88d794482
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 17:25:25.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0Uv8/+4HflWzjZAwKmcW7YNcefERtgID88AfA7dVUzg0/HBDhnJkR0i9uN2YSsd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the AMD QoS feature CDP(code and data prioritization) is enabled
or disabled, the CDP bit in MSR 0000_0C81 is written on one of the
CPUs in L3 domain(core complex). That is not correct. The CDP bit needs
to be updated all the logical CPUs in the domain.

This was not spelled out clearly in the spec earlier. The specification
has been updated. The updated specification, "AMD64 Technology Platform
Quality of Service Extensions Publication # 56375 Revision: 1.02 Issue
Date: October 2020" is available now. Refer the section: Code and Data
Prioritization.

Fix the issue by adding a new flag arch_has_per_cpu_cfg in rdt_cache
data structure.

The documentation can be obtained at the links below:
https://developer.amd.com/wp-content/resources/56375.pdf
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Taken care of Reinette's comments. Changed the field name to
    arch_has_per_cpu_cfg to be bit more meaningful about the CPU scope.
    Also fixed some wordings.

v1: https://lore.kernel.org/lkml/160469365104.21002.2901190946502347327.stgit@bmoger-ubuntu/

 arch/x86/kernel/cpu/resctrl/core.c     |    4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 +++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e5f4ee8f4c3b..e8b5f1cf1ae8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -570,6 +570,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
+		if (r->cache.arch_has_per_cpu_cfg)
+			rdt_domain_reconfigure_cdp(r);
 		return;
 	}
 
@@ -923,6 +925,7 @@ static __init void rdt_init_res_defs_intel(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_empty_bitmaps = false;
+			r->cache.arch_has_per_cpu_cfg = false;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
@@ -943,6 +946,7 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
+			r->cache.arch_has_per_cpu_cfg = true;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997fae60..bcd9b517c765 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -360,6 +360,8 @@ struct msr_param {
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
  * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
+ * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
+ * 				level has CPU scope.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -369,6 +371,7 @@ struct rdt_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmaps;
 	bool		arch_has_empty_bitmaps;
+	bool		arch_has_per_cpu_cfg;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2e3100..6abd8ef9a674 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1905,8 +1905,13 @@ static int set_cache_qos_cfg(int level, bool enable)
 
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
-		/* Pick one CPU from each domain instance to update MSR */
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
+		if (r_l->cache.arch_has_per_cpu_cfg)
+			/* Pick all the CPUs in the domain instance */
+			for_each_cpu(cpu, &d->cpu_mask)
+				cpumask_set_cpu(cpu, cpu_mask);
+		else
+			/* Pick one CPU from each domain instance to update MSR */
+			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
 	cpu = get_cpu();
 	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */

