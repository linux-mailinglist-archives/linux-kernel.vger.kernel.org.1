Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4434C26CCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgIPUtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgIPQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:56:52 -0400
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe45::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB572C0A88AC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkOcGAk6VGtv/HDQnpb2MgMFF52iCw6XZwsnN9QzkaQNztevGZeCjkjtOgRoKLHjzPm/W1qbtPo5MzdhSH5D1eE7EHb8JxCjEJMmmmU1uUZu+meMrHc3Qs5nV4NTIkiUk8NhIh6Gm/J7i16XZR6M8CCcxDZDhsoa9kKtGKhfeW3d8zIj8O/ZRxbF3lQiEHj3md+AWl+Xo/wni7rRiqAIOMhcZjAG9efQ56y5mklqPxgRXuVxMqhOVCOBiSCX8KRSCgQn2ICRyN2TtngizHgOW7eo4cwsKZ3znLISPXyoSt8H6DBsovYPL4kxjgf2S2iPLEO9ylbBD1PG/xVRfbQKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtsfjhDT8+PY9GJlwx24BcaBzC9mY7YUEj4kwlDvPmg=;
 b=MIBniRYxoK8ldJdLXC3D43JmPVPau+2bMgAizJmYBuT/fB1r9QvmUbvBQwYFi2K45uXRNLR6Zfrb9IqqizBahiwM7XdprZWySijn24IgDeM/gFyASxLWeuLoVnsz65P/oi7MHdGF8JugKpBizdh+aiBO3xeQeSno3sEdC1tJ1OUQCqZUSmd+WlPv2yJ4ogJBjlyqDakKQdNd51sgSZd457jxgJEeBgSwSqaXegtJVzZZ+rqNOXVG8knUXwTXf1QL8jmrz0hQqnQa9oULyFH48o81ulmFuPGB2l1gz6LfGWQnWNPU0xEXX8g19Qqz9ZUOQFBvpwSLVbMfirxGnKTCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtsfjhDT8+PY9GJlwx24BcaBzC9mY7YUEj4kwlDvPmg=;
 b=NGHKk4uwiKolDkE35Uj2bQpDeT5gqdNS2mscupK7VgthANkBP2Qo/jqgFyPuaV3eDqo4/CulQgHrSCneJYb13kdVjVtKf+istv9FePI6sYs3x/edk7qTGV7o7S8dSggyD8Z++gEOkweKihffhZDJe8APdhj1X4j8THnsJ0BFB9E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 11:15:33 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 11:15:33 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     mlevitsk@redhat.com, joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2] iommu/amd: Restore IRTE.RemapEn bit for amd_iommu_activate_guest_mode
Date:   Wed, 16 Sep 2020 11:17:20 +0000
Message-Id: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19)
 To DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Wed, 16 Sep 2020 11:15:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eae1a376-068a-4734-5563-08d85a31d41f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB289251A964EA01E7915BEDB7F3210@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsmHyvQJXkuj10TLRA433RpH8V1o/8ykrH74UY9FJ2qU9eLqzKOPkONXzdQ95syCQAdErPgYEUb6Er7PXYZLOT4qaELzK9RIzfhtgReco/yMIYcuJkjGXaTHrHTl1ypd/CYsAMN/Pir/IZY0YoKUVUQSBbXKuxV/3Y8LJj5JXlnTTPkkBXesRgeGuq2a1uo8TeLzruLfsTesi3+NoyMdKrglh0dq2GqJ2Y7WIBhq/1QlFiMfqasjL5ongjX9A+8+Bp404viD0aKGKjU2Y6tLzDy5wTjCGS9Vw7yoBkD4n1cosk/nkJgB+2pxl8OVeGw6zC7IOkxcC+F2crfExO1YUSdkJ3cdzLL2mP14J3pDHtHnus3zpmAqE/vDhz9guYG+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(186003)(36756003)(66476007)(66556008)(86362001)(7696005)(52116002)(66946007)(5660300002)(2906002)(8676002)(1076003)(478600001)(83380400001)(16526019)(26005)(6666004)(2616005)(956004)(44832011)(316002)(54906003)(8936002)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KiXGM8DyBllXuqAyaaSzEN0CfVXK9+ClBwKTAruh/RIoRv3Eed7RXsTLkBWIV5+TygtbiNqRAXWVMCMeEuZC5Ao8I1e7bif9IO3zoKHhPcvDHmsQGINhuzwrnEEJaFwuzGMi/mM5DcV3werfaV5Sah831vrjFou58PZ8GroiP3Yq49n48oX5vcfZ4L+YsmHylAianFnzOlsOrWfjtPlz9TKTIX8sL6RjqffMWLmNEMeysK1+Tc4Y+Tzq3WMmeMTftSS/1q5OdkKub5I62Zjp1BYpjGFVvsHMFfEFrd0S+1nlytJal2IxUYYaEl9ZiWOvARuxEkF4u0B0S4tHC/vvC3Gt1vP254F5XjyUsvZ+Dfez5OVtLbIJTYM1abEXI8XI2B9/s03WPKQHYxijr8K7OLNVISxJzRRjVS+iBSUcmluM/DvrEwIZ9OFZ6EA164I2yhvw/UfpzRLfdABrIDIV0d/F2EbHkU2tz+3QVx01/5nR1taD9DK4NviFVUlLJM/sxL0VCM5ROprxVLnEn2dehFb0nQQiEnlcDn4utvikJeu42CsuNDACzl2ckhJX28c75losM82fq57j/srA2XiiSXYGq7vZ6FQs/4ynuOrnTqiefQOI1fLQU7RuUWJHwIIJpnN9AhVNo5+CfPRCfro0qg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae1a376-068a-4734-5563-08d85a31d41f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 11:15:33.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2GkHXbPcvj9XKucKbG8y5ZEKacF1hZzrOMKcTHmTWGEtiBaDmbBgebssqyFx6blbvfqhsZVIEj82TY7C22yCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating
128-bit IRTE") removed an assumption that modify_irte_ga always set
the valid bit, which requires the callers to set the appropriate value
for the struct irte_ga.valid bit before calling the function.

Similar to the commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn
bit after programming IRTE"), which is for the function
amd_iommu_deactivate_guest_mode().

The same change is also needed for the amd_iommu_activate_guest_mode().
Otherwise, this could trigger IO_PAGE_FAULT for the VFIO based VMs with
AVIC enabled.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e938677af8bc..db4fb840c59c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3900,14 +3900,18 @@ int amd_iommu_activate_guest_mode(void *data)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
+	u64 valid;
 
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
 	    !entry || entry->lo.fields_vapic.guest_mode)
 		return 0;
 
+	valid = entry->lo.fields_vapic.valid;
+
 	entry->lo.val = 0;
 	entry->hi.val = 0;
 
+	entry->lo.fields_vapic.valid       = valid;
 	entry->lo.fields_vapic.guest_mode  = 1;
 	entry->lo.fields_vapic.ga_log_intr = 1;
 	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
-- 
2.17.1

