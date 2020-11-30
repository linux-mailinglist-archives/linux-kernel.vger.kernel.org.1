Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9DC2C88CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgK3P6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:58:18 -0500
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:20526
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728534AbgK3P6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:58:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATr1AeIcFnwWipViuwYigfcOv5LiNfitMD8p7asB+6gpngBuOfanFRdz17R2TPCbB4XDr1a2ArZ+myw9nkCsSqEyHGE9FdrdzAZ9XQRCvJ03mypXfpOQkT3x0aynN9x6KkBAbG9wLu/Y+XpdC0yPnnD+XSB+2njHhc0IAF4hK9lWeZEiU5TfPHt/BMHIzy3MLU61G99Jcrb7r4SIVTzj6D6XAZJQ9qnHBYr2EDW3m8kVYCG786kaDtvbMwezckK1gogdaq6BvJ/ZnXQBuvivvrWFZQ+ox82AgnDWtvs3HswWpqPTkfoRxKS9WfgLm8irXu5bVEcEJyt8bWWKmB5WIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MbtF3KgfVivlMIMkcYH5YDDKJsI0EMA2bYWSHa5I64=;
 b=Xdmwmcv20O/bgT9aCbXs/wz+le3aDdv6ii7erpWpgOI40d06Dx16aP30E8qny3dvRlHoTqFQB03xvZChMC/mzcEFOxLAmC1uhgOY8HsYMN7FYeVqozWgp8soVEzamVkQwxHeMQUGi45VWa/CRIXgCCa+tAxqzDc210EtAIGh7PG/vfT3iVfLa17+CoXWY9Io7WdfkgzQ6jON1BgbJKdHr11/JTG0gkSDWf0D+4v0U58QZSkt0iyceyWu0qghPpGOroHJ0XjHUuiXKpO7uFgw3wdIQr2PFd5xgDUUklHj54lZUkojYK55ZdTT39bCPjHML2YZvrkriZK+vN9QtgufTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MbtF3KgfVivlMIMkcYH5YDDKJsI0EMA2bYWSHa5I64=;
 b=1eKj4eCitJsJYwum69XVRJ+ilVVt4Uv+ixIUbfZJoUC3knztoT0ZMNsEcji2IfZwo2H0tQyoqYIkzj/8uH876pKavpVrriWNeVpwz2UQyKnRv8WpA0B2tlZL1Vc5yjFwOqM5Hg3K4kxHA4oCQt5NhD/eObg7HW4rmqMkhg9o1do=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 15:57:22 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece%3]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 15:57:22 +0000
Subject: [PATCH v3] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
From:   Babu Moger <babu.moger@amd.com>
To:     bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        babu.moger@amd.com, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, reinette.chatre@intel.com
Date:   Mon, 30 Nov 2020 09:57:20 -0600
Message-ID: <160675180380.15628.3309402017215002347.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:5:174::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend Transport; Mon, 30 Nov 2020 15:57:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b0900de-dc8c-46e6-dbf8-08d895489fb7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4479F4BAB96CC4D338CB11C395F50@SA0PR12MB4479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLRBJBZbr3qBLAh7Kt7l0TxYvRYjGWWCw43xLgF6IoVOgwrxhVut1OCR7SXUy/KqEIHWfgahtrCryUg6feKpsldJXPWzsdc5DHR6/3ggmBJ0qPLyQQlgOGUs9BCSxdtnVLskFTj6fzMl3skE1tstG1uouojewSuR9r1klscT+w0In6Pz41eiZPbbjCDq4LRJswMb8kVcmUZGVoKdlOGBngVShs/nLuw+eNdU8Bqjge7bCHW0mOjTnJUVgwGQgWOZ71uJh2FCLVeKIzLIPBRzaVOZyPS2sOx+zefOivZqkCNXIWmJZGZfKc79Ed8Vs67RAMpIj9sLPVA7aL4Mn6C5RVpzkXWE4rlNsHNLGfpFaZ1c9OJyAfVm3p9O5zZhfJ8yMXOrLt1J+NyxHPRAQZD4Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(5660300002)(66476007)(66556008)(8676002)(103116003)(6916009)(8936002)(66946007)(478600001)(44832011)(186003)(6486002)(33716001)(52116002)(26005)(966005)(4326008)(956004)(16526019)(316002)(86362001)(9686003)(83380400001)(16576012)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTd6bTlDN05jcC9HV3dLQk5ocCtUSzk0TGhTOXdxQ1lSbWlFdzNuU3dZSk9k?=
 =?utf-8?B?b004NE43NTNPei9qZlZhVUMwclJEd1k1a25WZUlwdm1Ka3Uxc3JQUHQ2Njdm?=
 =?utf-8?B?QVVCQWo0VmNKSjZyWGU2a1BZNERpR0xqMVB1Z2V2VUFTV1hkQ1hLWThOQkU3?=
 =?utf-8?B?YW1KWDRyMUJJdEhrU0JhTjU0RGtaM1pXdDIreWNFaHA1VGxYTEthSk1NSFBR?=
 =?utf-8?B?QVRpOWtuTi90Z3FnSlpmYUtreC9tNzd0ekRwSTBHSDZCWXpzd0ZsVFBKaHNt?=
 =?utf-8?B?UEE2QVMzbEtENHlWZEpCREYySjBNQW5ESFdxVm1DVlRQOTYwTy8raHVsVXlU?=
 =?utf-8?B?RjBmUDBDT3hnYXNvMzFCbzIzcTFmVWs1WStHVktsek9ERHFvZmVDbStVY1NO?=
 =?utf-8?B?S1pyRXo0VFFhdlBFTlE0RmpPVFhiQ2RhSkpzeWpjQ250RmtFNUVOM2syWkpD?=
 =?utf-8?B?Ri9vcldMS0trMDdjOTZaL0NjdmVmRk9EaWZ0dlJOTVZHS3R3c1BzNXlyWncz?=
 =?utf-8?B?LzU4Qkl1dXM0ZnlPaFEvT3E1SG9hMGJlSUhua3FMRkEyTG5VL21XQW8vdVVQ?=
 =?utf-8?B?U0N4aGxLdXdLUWNZaC9ZK3J2Y2hneUNxMytuWUJKQ041K2lGVjJveEVJOXM2?=
 =?utf-8?B?TkxOREpnOWxjSDJQMnB2TGVGOU9qV1Q1WUpaMitNVml2czZWRVhmRVVXNnRJ?=
 =?utf-8?B?b0dTZjN2T1dobUJ1Ti8ybDdxTE5kVysrRWptSGRuOG5YZm54b1UzRXVodDNI?=
 =?utf-8?B?cEVYOElaODhSdUhMbXJaeGt6Z3kxeGNUUUpoMU8zY1FKcGpiS2MwWWJYUFEv?=
 =?utf-8?B?OW45Mm1IaUhhUDF2K0lQaWc2OXZKaWJacERFNWI0em1SQ21SRFlIL0xNVGtG?=
 =?utf-8?B?ajd0dy9QcUN3SC9ycnFsTkRwQ25yenQ3dEZJNGNPNU5QT3Z4Snc5eUJmQlkr?=
 =?utf-8?B?aWNVcTE1bTJQTWV4cUhDMklSOGpEY05UNVVxV2dFUGw4Mzlmck9mMlZJeEh6?=
 =?utf-8?B?WDRvSFFuSmgrSWw5L0VpQ0RIWEJramxJQjhzMndNTWdaRFJSMm83dzNlOFM3?=
 =?utf-8?B?ZkFsL3BMUnhBTEpoYzZBODk5V2dDMmVGMDE5bnhyRW9xRmFsT0xtUERVZjJm?=
 =?utf-8?B?RW0rSVBrd21YM1VSS2hUUjlFbVk5UmdDalBwZUJJWVd3aklsczhTV2pqVW9H?=
 =?utf-8?B?ckVRSmlBZVMrWGhJUWplZ2F0eEdXU0l4QmJ2RG5JOEZRV1BxZlorbGxTWGsv?=
 =?utf-8?B?NzM1QXFzUEN3QVdYc21tTHNHU3dMSVlNMEc0Vy9GWDd6dHBDaEJ4UWMwYlJT?=
 =?utf-8?Q?JUw/Mo2G3AEwZAGmbisKbZ7NKwwixEU6bO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0900de-dc8c-46e6-dbf8-08d895489fb7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:57:22.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZInJmRT8ixmWgdb+1B++csoLLPYzmjj2ziZAlp6F7arX2KuzOdoOrDr6g1jheO+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v3: Fixed checkpatch suggestions. Addred Reviewed-by from Reinette. 

v2: Taken care of Reinette's comments. Changed the field name to
    arch_has_per_cpu_cfg to be bit more meaningful about the CPU scope.
    Also fixed some wordings.
    https://lore.kernel.org/lkml/160589301962.26308.4728709200492788764.stgit@bmoger-ubuntu/

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
index 80fa997fae60..f65d3c0dbc41 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -360,6 +360,8 @@ struct msr_param {
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
  * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
+ * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
+ *				level has CPU scope.
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

