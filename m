Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9792B567D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKQCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:01:19 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:48033
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgKQCBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:01:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ6zHzz4BtGQBClpz4/RAoGiiwQ7k5225HnQvOZx0TZzYGobknPkVs5RfQXagqJ83RwrbX7K/JpCv24sH8ju99uaOeE2eQHoID0A78DFX5GWD2epL4H0VEjivnX9G1XYc+aQJSMXJcM4baFkQhquy2r+fGYZ5bIwJHBLAZvkF2KHBrXwk0b56gIzW+T35uXIFufkGpBmNXJLt+Khuggc3XXqT1EzE6AbRBNqIXLHJoXarMO2eK7yM3x2oCiU/Mes6LNr3XDpdz3E3cJcqZmYDykIFYIKzzZqCCTxT46uTUpwa/hLcwZXJ+1THuc15hLO8ubI58SQClI59OOBWEfhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlSEOumIphZcNfDi+Bff89lZWe32/oqmsSBe5w+KWJo=;
 b=SXNkbjg7Os9Bw8kOO2pPmxqTfZZArl7MX775K1mfU9y0uhKDflHxr2MEARM/XppqhMjDG49XPvNGkaArt22T6SUSFCc0JCwD7HhQG5v6/IQ/YP0k+iU2hiQu951vv6WA8BUdfdAAYn9MR72zLSSZko346frWomwFLUlX8NhzpeFhLdoqpSKdhlaY822XKxt3Z6vizToqwaBNIUZ9ZLcwREAVRoCzqmaHEeITDsZUZSbHCzinPyci0/8R+2RsR0mhaFIoFZWfwnkcg0MvYZ6ADMAZ4BdzS1MKZZ4kGdyqMEUMWX/8n80FbOoo3A/536grHg1XDkFLTe/6wzB7Mdl2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlSEOumIphZcNfDi+Bff89lZWe32/oqmsSBe5w+KWJo=;
 b=Kl0/H3F1NDgtGadWbENAnHedN70Jv9goPa23ADOwNivRbAbqTBjwDulUvD2JRyrQ6bS1dlolWKSnV/q5cL+81c9FgdfdfD/RY3Q3S0v1tYqlQtpl8vue72va/yT0bABrM+lckfa1nb+I7OX24NI6rRASNfWogaMb7c3zM8LUk+s=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 02:01:15 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 02:01:15 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de>
 <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
 <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
 <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com>
 <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
 <877dqtgkzb.fsf@nanos.tec.linutronix.de>
 <874klxghwu.fsf@nanos.tec.linutronix.de>
 <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
 <87y2j9exk2.fsf@nanos.tec.linutronix.de>
 <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org>
 <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
 <87tutwg76j.fsf@nanos.tec.linutronix.de>
 <5c86570ce3bedb90514bc1e73b96011660f520b0.camel@infradead.org>
 <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
 <6b44a048de974fb6e2ecb5bf688c122b3107537d.camel@infradead.org>
 <20d99e1f359b448d042d27112e55f8070bf460bb.camel@infradead.org>
 <13f8cb3c-713e-c26e-b2ef-4700f9f6ceac@amd.com>
 <05e3a5ba317f5ff48d2f8356f19e617f8b9d23a4.camel@infradead.org>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c2361f78-b739-2f71-562b-d2c5f20825e7@amd.com>
Date:   Tue, 17 Nov 2020 09:00:51 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
In-Reply-To: <05e3a5ba317f5ff48d2f8356f19e617f8b9d23a4.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::27) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:820:4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Tue, 17 Nov 2020 02:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ddcc82f-997c-4bd6-c470-08d88a9caa2d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB430844994F8E66B0946C881BF3E20@BY5PR12MB4308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxlHxG8GXf5/4mZjW+xN5m9wo5ysrjHplmQEqldNbrfkVNe0FdDDEeefiJ78+klm0zMWoNodBa05MoSLECR1C6JK93rOXN+7U9dUt1CdkiJDffrvOXM17sbXfENO6ygs0vLIrx6Ac7z9gCyBkguxMTblq4NsoIUABmCjW6qb13qgQ5eCKVD0i2cHTKytf5kGsJv8/mW+Lnf+ASjBlWZl7yFVZOvnWMi5J+osOsUtAFI6IybXCyTtFKFoh/uLvRJwxDgta1hA8MyXcTY4YqQCu4BQ5B2WYc7HbeaqmHYGrFLOfw9gLDSzMuncn9mAgwRklT1nZG4Vqj+VlC2SC4j38+0xIlL9cZO+EC9u10uEwl8RsF+y/o3Mfr7A8+9x0W4k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(36756003)(5660300002)(83380400001)(6666004)(478600001)(44832011)(66476007)(66556008)(66946007)(6506007)(31686004)(53546011)(6512007)(16526019)(86362001)(26005)(956004)(2616005)(31696002)(52116002)(186003)(6486002)(8676002)(4001150100001)(4326008)(8936002)(316002)(2906002)(110136005)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7AHhRFLnpBqItiQvIIl5gADXorSEC4jo1Bu4bEkGDzi5HUfUlCeDbCWTg5Aac0x+/4SllxUsU5ZoDtpnKmg7QcLsphWrRbmH2b1Dyvo2lVhW/McIl/qPcVYTbJB621Cq1X6Wh/8zNiYr9yG+9xM3yX9Jk3LbeC4Ena+CKsPD1uqzdEfc0e/aISRXcJtqJXJrCY9EAbH+A5t75fvCwv3DyethRUkO+fJzYTttfsPsczbLicWcjtE79F05jGsc+iK5aKVSq6qIh/NzbMDBirnJAco8HURYWSuf+Gv2Acrcx6Z0oquZX/cV1bvIIiBrD9tuEJIu4YsISgCSzGAIPpCHgU2i03VRrEUTVD7dwX4U4GDHCl3cnDY04NMxfecEmfM2soyvFsF+NDmsA5qlj/nD3RI91NJKci3YMdYVl8cQxzzz5l3Tr2/Ngxdw7MDhED8I/CkhSNdJVUhBkrvYkLMOe8xQvv/dqFcvxwSQl6B/RHlY7CElqK2XCtUaRQVYvCFKFvMRlSAP4b0vQf0/xgOBugLY8DbG6Y8P9jRjHMJEneikZuECCGBLHNc4yymI+jyO6DKp2IJnlfTkcofHthUneriwm0fcCrnXxmKpI06U9wxgc+lGw4JuDDb6IRLgPlDbmQVm9cEW/ZyLjmkoDic0Eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddcc82f-997c-4bd6-c470-08d88a9caa2d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 02:01:15.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4374dL2s+7kJDJqM+0UaRtlR039jPp3kwmgANT29vAUIPnri9O5s6nMlpIAImYf9B4ppeC8TOWy7ZWx4s5rGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On 11/13/20 10:14 PM, David Woodhouse wrote:
> On Wed, 2020-11-11 at 14:30 -0600, Tom Lendacky wrote:
>> I had trouble cloning your tree for some reason, so just took the top
>> three patches and applied them to the tip tree. This all appears to be
>> working. I'll let the IOMMU experts take a closer look (adding Suravee).
> 
> Thanks. I see Thomas has taken the first two into the tip.git x86/apic
> branch already, so we're just looking for an ack on the third. Which is
> this one...
> 
>  From 49ee4fa51b8c06d14b7c4c74d15a7d76f865a8ea Mon Sep 17 00:00:00 2001
> From: David Woodhouse <dwmw@amazon.co.uk>
> Date: Wed, 11 Nov 2020 12:09:01 +0000
> Subject: [PATCH] iommu/amd: Fix IOMMU interrupt generation in X2APIC mode
> 
> The AMD IOMMU has two modes for generating its own interrupts.
> 
> The first is very much based on PCI MSI, and can be configured by Linux
> precisely that way. But like legacy unmapped PCI MSI it's limited to
> 8 bits of APIC ID.
> 
> The second method does not use PCI MSI at all in hardawre, and instead
> configures the INTCAPXT registers in the IOMMU directly with the APIC ID
> and vector.
> 
> In the latter case, the IOMMU driver would still use pci_enable_msi(),
> read back (through MMIO) the MSI message that Linux wrote to the PCI MSI
> table, then swizzle those bits into the appropriate register.
> 
> Historically, this worked because__irq_compose_msi_msg() would silently
> generate an invalid MSI message with the high bits of the APIC ID in the
> high bits of the MSI address. That hack was intended only for the Intel
> IOMMU, and I recently enforced that, introducing a warning in
> __irq_msi_compose_msg() if it was invoked with an APIC ID above 255.
> 
> Fix the AMD IOMMU not to depend on that hack any more, by having its own
> irqdomain and directly putting the bits from the irq_cfg into the right
> place in its ->activate() method.
> 
> Fixes: 47bea873cf80 "x86/msi: Only use high bits of MSI address for DMAR unit")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

I'm still working on testing this series using IO_PAGE_FAULT injection to trigger the IOMMU interrupts. I am still 
debugging some issues, and I'll keep you updated on the findings.

Thanks,
Suravee
