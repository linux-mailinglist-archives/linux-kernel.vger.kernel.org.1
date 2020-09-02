Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100CC25A4B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBEt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 00:49:56 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:3904
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgIBEty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR2z7xRQBoG2YBsAZW7QN0OhmxL8Sz4K67PA38AkiJiPN7Evkb48fFGfdjQvzdtNEA2ww5XTJNQHzE4utfc96foj7600ybjBgvnC6jdfvE/woQzrR10MAZ+VAIOwBKULCZGfKLW50dHYaKRe4wqnM0Wr1ApYLS3wiMrckGKnaUI4c2z3wNKs1qfKId5JaZyQxwc4YEGyh+TD5K9pJ05IWMJPcfkprZBtyTyLfTMsDHS6EOOaqw6XfliinHC8200MkYeBNWtN3NY0STcRrsXwHqG18gqL1irx7CkE1gvKzuFeIBOa0Ct/bmNHDAMsQlzpM7+JtvfKNhqvkPYjW+FWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yAKRequ8oNmVcfARXpYHwl6V88V45F98DxZXk/4ui8=;
 b=Cj3vG1FwteqHM1DTHCigjBlNBw+kMKDQGDtmZnZoCpUZK7TvMNEGi5410+hiC91Aw8h/6AYZZ8ve/vHmccgSSp7K2VoeYBGTd/8aeGVXxk9zSdsQgsZCMC2aLl6FW1ZNHDns2+D0yzVOuk5NmcyebuW5zd46Fx+KJl9N01cag8ugOawHcLHeweKfnKl+NrzOwRfX5bIdqsSOExaFCceuD3UUcJIKNLM2UXFOR1S5dst+ufwgbHdYB7CAfS3DXfzH0YX3pZZawfoLmrUCEY41YicirTqmqmGj3JI1u3y0EiB4kc1kBiiZVobjfh3NVQe2K3HzN95clQ6H/h5XFpXSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yAKRequ8oNmVcfARXpYHwl6V88V45F98DxZXk/4ui8=;
 b=kUCUYJlM+R/wsD8MmQt/A6mpOnmaFo0lNrWuT9BOWbQcEkJgeF/2nlOl4pLg7PKwOemhCU9exa8hz1eI75P50EXGzZ9KEFT8PK7Su1ENsUjg62uMfLqr5aM0KidkGeH8ixkf442cjZLOWA0ndqOzMKL6g4G/7Dh5mkVTEDBueY8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 04:49:49 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 04:49:48 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, sean.m.osborne@oracle.com,
        james.puthukattukaran@oracle.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] iommu: amd: Restore IRTE.RemapEn bit after programming IRTE
Date:   Wed,  2 Sep 2020 04:51:09 +0000
Message-Id: <20200902045110.4679-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
References: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 04:49:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e48a417-59ce-402d-310f-08d84efb9ef3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2795CA64CF345DAA182FD1B1F32F0@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8WqwxGnkGPUxRNbo7vlR2K0f84d+1I7HZ5Sq/0r7Wdlbcz8o5bXomIJBnH8kFZHX8AbrAdVQT2jG/IDqRzbr75rSY4D9eNjUcSjBYcAyNw6ljdAtwlKprkEAE+UjwjnLacO8s04ppHCx7sONuoPI6tbsgZoAlp8UyQpqWg+WV+Q1R84tWwG/sOc/NVYgnoLFgu5CrIJFsgRvhnA+xbkiwf4NHs9IBUSGdDHEDeNxojJOiv1kOaSlGONLuFx6SEiKsT3j1OKq3E7p4RmCAeBVruN5/46P5JmDx3mlhR0r2F8c12UnnJHtiYytZJXnApz5Y9GpWRsLu45JDFOnJsLbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(4326008)(8936002)(2616005)(956004)(86362001)(498600001)(26005)(16576012)(44832011)(8676002)(2906002)(5660300002)(36756003)(66556008)(66476007)(66946007)(186003)(6666004)(1076003)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NFRFEbBZDmdt+rnNrQIScOEyEmc2bxYSWovjRKVB5t/bVQDoHcNL2N0/lcHmDDGz6yHXtIFQE/YLEI7ZUyJ+HWjV3i29AXJor7ToaGzVv0rQDFEIdjAYnsF6ERtDtSu2ZyB386OU3XtlcgpaFzV4dcTsw8ZHlD1mXtekr64VwDRBBqp6ru4209/1Z40mc3s0947v/5kzMk1aEE7yzpAnaVgGw79HEJXHqs2TsM5We+aemEmcIGhgjixgVivsI2KQPA+06dBijnecqWQ5s7/FWonQ1etX1kzx0m3sDewlrM5Cba8fIbx4q/wSK+D9PXUQlTmXD9Ezqmxw+jYG5hMSuze2ECs4aB9pQ5D+dqnIIJqoX8KKMYMiQf+UrZIeeItgx6rlz2xBK85cqZxeI//pEhCxzLnoBT6jJ0hc+GZCYBIFrzr+b5AmQAc/rnzjL599pngcfmKUta0XNt8PWYQskPtU2Nb4xzDkN7EHdBNFDUsN9dsfeLFf7YQrWxrbCArGjOoU4Fl6mJVV/DnaksDCeOxSORqw/6X1o+N8d976fLEpNZO/nsqpDqGz7m6uvMUKRNeofy88FfgO3wPQ3E2uIgCcFEw52IEj+Qvvx/LAhxCp7JEmIaiZPZx3cHwDt9eDnq3EVPMbDffxReywkw86Tw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e48a417-59ce-402d-310f-08d84efb9ef3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 04:49:48.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdJB8cvs9CC5vl/C1/SsPIgGmjjuubkOo+xrfcmDnG1qCJ9pN1rCe5a7qe6lZKWLFIbu2DFHUIvRi3L9XVpaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the RemapEn (valid) bit is accidentally cleared when
programming IRTE w/ guestMode=0. It should be restored to
the prior state.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ba9f3dbc5b94..967f4e96d1eb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3850,6 +3850,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	struct irq_cfg *cfg = ir_data->cfg;
+	u64 valid = entry->lo.fields_remap.valid;
 
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
 	    !entry || !entry->lo.fields_vapic.guest_mode)
@@ -3858,6 +3859,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->lo.val = 0;
 	entry->hi.val = 0;
 
+	entry->lo.fields_remap.valid       = valid;
 	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
 	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
-- 
2.17.1

