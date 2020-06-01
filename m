Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465011EA68F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgFAPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:10:24 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:11440
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgFAPKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:10:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdVQD8NquBeK0qMAmrEJRWqC94+Zr7G/4osQm9zg/nYtyD8rbqWszW4fnbftHObCMaqC6vIBGaldBkimbDluyODsfS2P2uUYL76XWNl72z8jTLMvlll0aBt5SzL9kEyNRoapp8Er5ShV4H3mQvOfc49pbD3YKIRWdCUQICnZupM2QHMZUWwiVoFIfzypITu6XQwvkHVUr1VobAOvkWJ93XzaY7iYoCDAnaW6jLtUHgnb7lB1gXClzTxqhXGuysm09PJmPtS3v3OydnevqzprFzIzcAcUn8qPIPgiX5E9d6VxYOVxnWuI1SdN3WnOGmmxS/zQpSHm79A1TqbzlpD5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD2eh1CPQgq5WZtKTM8iOqAiWRByeGoYlZSVRJuimXk=;
 b=lusMBK5V4QHkBKOtlLSAtYw5vdn9VAJys4CYkbZhttdmQBJZ4O94OSROJlgd3qKbcBCLHIZSDMk+xvNwgWIRjm72aNa8j2HNPujO7MVcjSjHv6eVgKW/dFpnDZFeUmokdlYFPUpvkMw4/X9JXhFHv1uuvYLw5RX3CNoXnbLvYd3lGP6QUjTeFikhimKlhQiRxxpjGO95bQamiofEZefzwY+x5j6aptq/l5CS6PQfqg8tF0E08BQICAbq3KB+m2M6LUKN+RcpfekQvgEfuEwsfR+5EVpweGjD6Z2D8JpFYHiiFBHC4VY0eMfRgmqePd8ImBKDxXQyenLP8j1tuHxLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD2eh1CPQgq5WZtKTM8iOqAiWRByeGoYlZSVRJuimXk=;
 b=hn7OgSH7Xq9DhoCCbZNtQqFcjqG2/zf3YQafJQkWDVQ89BnwnI1/RZc09gBAaCCmGmznTSGg6706d7Ja2juGPKeGo6xVYNpPR8BKsZYEC/TsAyrf/n3qWb6LZVg0dpDv1ZosUCK7lcITtCBeHT8sM8+jtaQ68Vz9zi+A7jBhYK4=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 15:10:20 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 15:10:20 +0000
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
Date:   Mon, 1 Jun 2020 22:10:09 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0023.namprd04.prod.outlook.com
 (2603:10b6:803:21::33) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.77.11) by SN4PR0401CA0023.namprd04.prod.outlook.com (2603:10b6:803:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 15:10:17 +0000
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b24fa0f8-c74f-46af-7f6a-08d8063de682
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24884B76DA9009C0D1B75F78F38A0@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNaXHFW8APlrUGDDkxs9lnRksdG4R7+TkMYWbfihdyA1I80W0f1ogIFAzw72API/w8aU2aexQZgPOjd7qGjcdE9xzJHlRGrE0efq93W3j+yPgsoyZOaRuC7XVmm+Ij4Rk1nFv9CrZYTF8xd8Or0hvGNROMoWmmGpfMitXgqmmO3LK4ea/I1rg+8zbP/yrnQwfIhcX3gSqo/jTO5sM6uMFyF5eqVh0pmJls0S23/vx6PkLz1Oph+2+j+ncJG7OH7bO7+UF2KDW6CGccZfAmzez2KXcph1XKa6NKcrxsq77E+Yc7CH8SCCce4EnMJXJkOnk8F6JQAvMb04nfQ4kuZNzRdz6sssCHCiyqUqiR7da4pCReVUL2xvf9zASk2y4WgK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(53546011)(86362001)(4326008)(83380400001)(6506007)(8936002)(8676002)(956004)(478600001)(44832011)(36756003)(6486002)(2616005)(2906002)(316002)(26005)(6512007)(31696002)(52116002)(5660300002)(6916009)(31686004)(66946007)(186003)(66476007)(6666004)(16526019)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xfy3rky8cSDwAxAobB2eKn6rGYOhyeANH5/c7AYyBZawYJIcb/4ePWA4uCa2J1snkDAoAemSxGP5iv3n5GwdbPM/pQmY1QNQAszCElbf+jIWoB2gL3QT+hWkg0uGyfY6gOkTFlVVR1wcS+NhpGwLaje0bANzZTQCUnZ6OJH08iMlSVZYxtaRbK47sN6LtZpSaxjTyvSizhBzv1+IhfF2531S7w8vx4BwOrUT1G/Z/4amxogVrNBSHVZ6ZnbZp6crtPpWrH6FuugFdOxwvuULlia7dzhVJnPthIU2CptZab9+iui5C3wJXout1r+kTAVfbdMuLU3E40KD11fYvMUNNezc0PI3WUdewxaIQJiEZND6O7ZH21vXsUKkOkBmHgNuOpewld5v6OLmMPNO8uT0gd/0jACVF2uWBUajHlkQNyqSZwZy/63gQu0wXUVnT5LlEpgvIc2ttew4NVIN8joXZ9F8DEBvc4vpaer90ZDD8PD0wephL9qAzanPvp1D8GRg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24fa0f8-c74f-46af-7f6a-08d8063de682
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 15:10:20.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx8GfwduvtQCg1PMyskd+ZKjZDhcIgfJz8uzeAHZ0wgFTpXZXbRHv8h5uLtN2YKLCNPpjobV83PHVo3ZKEemQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander

On 6/1/20 4:01 PM, Alexander Monakov wrote:
> On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:
> 
>>> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
>>> the issue. This is the earliest point in amd_iommu_init_pci where the
>>> call succeeds on my laptop.
>>
>> According to your description, it should just need to be anywhere after the
>> pci_enable_device() is called for the IOMMU device, isn't it? So, on your
>> system, what if we just move the init_iommu_perf_ctr() here:
> 
> No, this doesn't work, as I already said in the paragraph you are responding
> to. See my last sentence in the quoted part.
> 
> So the implication is init_device_table_dma together with subsequent cache
> flush is also setting up something that is necessary for counters to be
> writable.
> 
> Alexander
> 

Instead of blindly moving the code around to a spot that would just work,
I am trying to understand what might be required here. In this case,
the init_device_table_dma()should not be needed. I suspect it's the IOMMU
invalidate all command that's also needed here.

I'm also checking with the HW and BIOS team. Meanwhile, could you please give
the following change a try:

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5b81fd16f5fa..b07458cc1b0b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1875,6 +1875,8 @@ static int __init amd_iommu_init_pci(void)
                 ret = iommu_init_pci(iommu);
                 if (ret)
                         break;
+               iommu_flush_all_caches(iommu);
+               init_iommu_perf_ctr(iommu);
         }

         /*
--
2.17.1

Thanks,
Suravee
