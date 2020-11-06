Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85A52A9E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKFUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:14:16 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:57320
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728140AbgKFUOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:14:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8F28ltE4GM1f183HmcODILFxMY3L1cMx3v6S71EYgGlEEWjQb+3FENK6ZUiJez00Eb20iNjd6maQ3enxk3MkV3GdDkqKImmjvWsLQCAY44D4W+LzUhcd93gTHtqI17esqNAh4KBHu6NDNbASoFn+VVdXbNFKaJrFnKbkPP4P6Spk+C7jFl6aCTFla5Fk36rNgIbuIQMlUMvclP6KIc+AjReHDYK2/Sa+JuDGUkTDZb3Ct9mCv9gJGA8A7jxoeIF2QnCi3+04HkhdLahGHrN9J1Hp9NBK8t85888vnhusVA6h4k/hWH86CA1xGln4gxKFxfC/Xz3gMac3QKJEj14Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wpvJzV+eSebcPfM7aa5nRa73SffZYSaLD2Oo+TR9s=;
 b=BniMXgAbe/NW27O+/aG8XyV1jyx7MXB2JVfKInw1j1ozgvLfbmd7pWd9MpagFcT+iQi2rw6DgZDiuh4I+r3GvF80DxtJHzWN628TG/HvQ8S/apEgSTlppwRIzFef+phfGG/ua1SmII4c6GvUzUGwQAtkWAvrZIRvczCPyfme1UV4dlTu75WrcYv4ACyk8QvAenJaJs3RxKDtwVK/BOP134byu2xeoiX0uLteX+XFYBmX8nsaStDBUamuhumT8m3WyCtIYmWsNfSCuQcmSGYxI88R0uVNbP9m6JUTledDud/dSlxJSi5Ib1lmZvjwVAMAZ275FPqrl2uGLxVyWCLv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wpvJzV+eSebcPfM7aa5nRa73SffZYSaLD2Oo+TR9s=;
 b=O3kyNx617GF8j4rQ6AMio6W1vHTSlYeIMozGuZ2SffSl5UqwBL778q0jq2LU70ckRv+5Qwaid4/73K9siM9eKOpf/dXwCxPJe0/Xd87OB15qv5Ml2ms7tqUnBfU3+Kux3Evq3j5VdiCLMNv5XK4gg8KRIhbYhjHhODhDrkEMF8s=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 20:14:13 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece%3]) with mapi id 15.20.3541.022; Fri, 6 Nov 2020
 20:14:13 +0000
Subject: [PATCH] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
From:   Babu Moger <babu.moger@amd.com>
To:     bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        babu.moger@amd.com, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, reinette.chatre@intel.com
Date:   Fri, 06 Nov 2020 14:14:11 -0600
Message-ID: <160469365104.21002.2901190946502347327.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:4:ae::39) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 6 Nov 2020 20:14:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ffa5d98-3174-4b7e-db97-08d88290877d
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704C0E5D82F4EF10691E96A95ED0@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4QaI+YfvOWOIAVX/TKeY6rX4NuBjkiZj4NYgAk4IsLG1hqgq8He5iIjQfHsvUeG1W82surI6F+K7tlCNiR6URKq/95LV+FkZVlw0a2lQzbzAua2iYdy10M/QojJD7qVyc9OjCTrUO3Bf1L4gr4YUyNbp9LM74+0OeCEYdulxsIGOy8nuDnLlJKxxCq2YK5pc2yLC1bqdWLYZzw18jx+1t/P6einw6+gxHW+K69BMrvwEYR5lj2Yh/7ox0h1iPVdfJOOSvETuiOcyfNj8ap1wAn4beNsETiy4vrvWzxJNOI+okknj9kQnqJdsKam92i+AaFo7lPXCsBRRqD2AZ84uxPoypQkNMdWOGalIY3mwm6UHnw2biWu43dGIpg05eBaMu9KhHW2+Ix/tK161/BEhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(316002)(6486002)(956004)(16576012)(66556008)(66476007)(66946007)(4326008)(103116003)(86362001)(2906002)(44832011)(16526019)(186003)(26005)(83380400001)(52116002)(9686003)(8936002)(33716001)(478600001)(966005)(8676002)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AX0Gf+hFyLJvZ0z6endeXRpO8glXwqEQgOYpDr8AWH0syK5qODMQHuinPfdJl+Cudx/hmBLk+65r7ffG46Svi3tu6P/mvtGNaWaTknkxOAikcnAgS0PHusO+N+r9QDQQdkdHmdfO5THCMI//GKmIWGt4usVutwqHnW3ESaYA+c02W6InYyCib7nlYnzW+D4CMnRmPrt8ibeFxrJ1QSZFjWk+tB0+h0d1o5TCMSmyfsgnoY8cQfK8gaBwpwK8jjhNe5Z6gTfVBltN+xpVg/fcRCa1iDiZOEqE8w7kcXcfLig8v4v8Pji9yyCe3aak7B7/hY47ez5YPHC635n3ilPhZ4IX2D6dKTVqauHrcaJ7f1Uf6iwBLQkndYZRtO5eWAbQoee7r7kh5Muf+QOaNXifQCVFOgxxEqv+pXt+G6Rs03sqUNjoRu36LrUa6FtKKMJWcKZt3NpNzNFt+cR/YFjxxb2HkffKWv6LuMkICs5ntCeFafv91cF/vfr2DwRmV49VHevHhX9t9/0Rm8NIkRIAoxpR9uF5tw4Xtah+RjKGV3xyBL4QIrbWwlH203y+N12R0z97y4PGA8YDXz2W9nRcUNplRLsi800uhaclxCKzDPL0bhs81LnrRErwp9OXXwi9pm/rQv607cuP2B3BCvWqiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffa5d98-3174-4b7e-db97-08d88290877d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 20:14:13.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr2CY1ZZNPHDTFrKe2v0JskyUeYHBVO7Fbqbq0QDFv7gu/WIsvht3OupTmPV0xVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the AMD QoS feature CDP(code and data prioritization) is enabled
or disabled, the CDP bit in MSR 0000_0C81 is written on one of the
cpus in L3 domain(core complex). That is not correct. The CDP bit needs
to be updated all the logical cpus in the domain.

This was not spelled out clearly in the spec earlier. The specification
has been updated. The updated specification, "AMD64 Technology Platform
Quality of Service Extensions Publication # 56375 Revision: 1.02 Issue
Date: October 2020" is available now. Refer the section: Code and Data
Prioritization.

Fix the issue by adding a new flag arch_needs_update_all in rdt_cache
data structure.

The documentation can be obtained at the links below:
https://developer.amd.com/wp-content/resources/56375.pdf
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     |    3 +++
 arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 +++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e5f4ee8f4c3b..142c92a12254 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -570,6 +570,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
+		if (r->cache.arch_needs_update_all)
+			rdt_domain_reconfigure_cdp(r);
 		return;
 	}
 
@@ -943,6 +945,7 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
+			r->cache.arch_needs_update_all = true;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997fae60..d23262d59a51 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -360,6 +360,8 @@ struct msr_param {
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
  * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
+ * @arch_needs_update_all:	True if arch needs to update the cache
+ *				settings on all the cpus in the domain.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -369,6 +371,7 @@ struct rdt_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmaps;
 	bool		arch_has_empty_bitmaps;
+	bool		arch_needs_update_all;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2e3100..a005e90b373a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1905,8 +1905,13 @@ static int set_cache_qos_cfg(int level, bool enable)
 
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
-		/* Pick one CPU from each domain instance to update MSR */
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
+		if (r_l->cache.arch_needs_update_all)
+			/* Pick all the cpus in the domain instance */
+			for_each_cpu(cpu, &d->cpu_mask)
+				cpumask_set_cpu(cpu, cpu_mask);
+		else
+			/* Pick one CPU from each domain instance to update MSR */
+			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
 	cpu = get_cpu();
 	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */

