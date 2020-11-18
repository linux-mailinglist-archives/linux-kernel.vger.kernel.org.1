Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E28C2B8257
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKRQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:51:26 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:63323
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbgKRQvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:51:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxPcI7235jFGV0R8uAsps1lZK5mhwwACEZaetDJq58YEMzu4TZO2ge7LTN4OM/PklkRf1Z1u+Ywh98a/aiDJRjcSkTkA1NBvvVH0DmH4HWpHperqbetP4j9KVhW0q0dWcHCsVAAkH1KAypdjGlXN19EM+oqanG49jvLZ1C8DEJH1Mw8NGLIggXlnihtMKM9DniPo4BjGSH6Fn9abXpT0jbkAkOf8+qYSGpzmJdfr1jCu5LCCHbr/NTrML6LJQnL5vP/aXnHXSQbzUJA5IccZgm3hWF0meuLKTS/rsesssFhvRcYyTZy4LT0H6t8TbWLfdaiqPgs0lzW9WpGBLMAzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17cXEJ4CkTkLou+wMw/xDqWedHYYlX4F/9cZ+y6goWs=;
 b=GHdTrdeENmj2HnjmbIk/WwwFnkScifIycKnC+K492fWBGSMhdZFNIUi6eHtxUCw/aD5kSOwbEnCcuhmWVVZFc+DyzfWomovf6ihFrVMEM4NZxViAKWdVpYS39VHEfLVfVFx53uklIZGVT+y/f7+zudjePl2TOGr4QmuR4y9WKdr6thToUynYlvvARRfUpXZYaqAgg5rNRwTS/Zc4MUqQHePr0vjsiGN61nsgpDAwvbry5f9WGqbLa6FMvv2/+bGgmnKNFh9MaPqQSOkHFgZq0bfcNflWBDXV5gHXfsA6ciBCzIKXvUUcyW3Pioeh5qR3P957lLVMqEEVGWK/2ZxS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17cXEJ4CkTkLou+wMw/xDqWedHYYlX4F/9cZ+y6goWs=;
 b=M8zsZyR2H3LTlTz+p+FQuTQy7fk7EBR7NiUQaPit0Id2+qV19McGwg7a9Cqp3y/b7k1NHdMhIfPAWGtVx0BvB1s6fdBK9PYLgvVHske5jGUvXsw/pgGVrCsWta4oMZuZdvyEL0YxZD/yccVMT7O0Eba1T1NrAK/+1TRlxa0hjXE=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 16:51:21 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3564.033; Wed, 18 Nov 2020
 16:51:21 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
To:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
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
 <c2361f78-b739-2f71-562b-d2c5f20825e7@amd.com>
 <79d2e4ee-bfe1-7e86-6f35-f6fda1ce17fa@amd.com>
 <877dqirc7k.fsf@nanos.tec.linutronix.de>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <9f2f7088-a64d-df82-073e-9acff995d29f@amd.com>
Date:   Wed, 18 Nov 2020 23:51:10 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <877dqirc7k.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1P15301CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::27) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1P15301CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:820:6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4 via Frontend Transport; Wed, 18 Nov 2020 16:51:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44fcb6e9-7b0f-4bd4-986d-08d88be22d62
X-MS-TrafficTypeDiagnostic: BYAPR12MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3237CDEA1D3F49487BF390EBF3E10@BYAPR12MB3237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qM+pjDBPV9wYhoTr1Q7sKHzd39bwCBD0w9X8IRR66h9AGJm0gcQpyeO65kJUw7XsC2ihHjC1E0/kpRiPFM4Wre0j7cKtBcDIwCDqHpVJHPGyQZigvnUvN0RlEL/C3zpp3u2l4f0voMJ3/X3KNZTJzAVJFeAgQymQJgbMcoYHjnf1VW7xg5c7PD/n6GfgXqlUYZuAlDcOh3mIXRN6pgCnCAcFHgqD1So7TSkXBpk5Y7bNj4n8ND8PP7omp5AGoR6bhH5SBb/8/AoeoTPvY+79iZvq1fWo7FmzXJdhbybfoTzBF2KqqkpuFEuFAameTjgvriRFn2a/1QuG212OwKliYkb/94MTVsRizmCG6wrnzCXJ8PUo722Yu9yypgFqqCU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(53546011)(6666004)(5660300002)(8676002)(6506007)(478600001)(83380400001)(36756003)(4326008)(2616005)(31696002)(66556008)(31686004)(44832011)(66946007)(956004)(86362001)(16526019)(52116002)(2906002)(316002)(66476007)(186003)(6486002)(6512007)(54906003)(8936002)(26005)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: z2nYLcUIbbDrCWceppArH/1/5MGlJI8lBOE+ORHbF3TbmFajJbCTdslAWfsg15C0jGcMFeS/cjL2yOBQwYstrP3/w62UwHqXFYJU7ScL5J0N9DFTYVO70jPt6II7dQv/Q2aekYDpeNnbg21FLGSE6UHj5igQwWPTLkgk+TKszUQz35X954SwvETvdgFQtQ7TEgpH0bczGAbx5VR71BVohgLz5bsXaVA05fI3dWsjUX5EiU+E/qudkGwU4YR0sig8hCoj+3VFWbvNvGe4T3zBaXzOn+mLF7Sq2O0rRL/Nup98COIgkhvOxlEYWUPq7x980z9rvcn5iaOHVtdQxLNSeDLsEkyh8qyGFH35JOOeXlVfS49oHhkgKZybDaXfdNSbaBiAVFgKmf9hnB+Dary0Yr4HS8Gv0HJ9welSRF12YoxqEecwt8LkBsvCFVbmoFd68Oq6c2Ux95vkpJ5tL+MHRICxAWzuVbgcRXUGOnGSMsSmW1ZMsZbn1Zojjqsah2vnL1xYNKuPmLT6RWd6O950I8xiOYSwUz2QFA74jhvLZR8q4bEmA7g4D2+0W3qRVpUv0zsAnqrZgsGW6f+Q2bYo2Dvwh+nUWoV5I7Qny1EmY5TDGOmlwLGJoF5tRkR8GVTCpR6g6S1qWQTXuHr9WK3s5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fcb6e9-7b0f-4bd4-986d-08d88be22d62
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:51:21.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQEvNas7URwVhOiBIubq/kfi7Q+tffC3juOZMcETyfi/WmsI/gsq36V5fzDOMuo7a4lSZjUxmfuiqhrSFP0Fyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tglx,

On 11/18/20 9:06 PM, Thomas Gleixner wrote:
> Suravee,
> 
> On Wed, Nov 18 2020 at 17:29, Suravee Suthikulpanit wrote:
>> On 11/17/20 9:00 AM, Suravee Suthikulpanit wrote:
>>
>> I might need your help debugging this issue. I'm seeing the following error:
>>
>> [   14.005937] irq 29, desc: 00000000d200500b, depth: 0, count: 0, unhandled: 0
>> [   14.006234] ->handle_irq():  00000000eab4b6eb, handle_bad_irq+0x0/0x230
>> [   14.006234] ->irq_data.chip(): 000000001cce6d6b, intcapxt_controller+0x0/0x120
>> [   14.006234] ->action(): 0000000083bfd734
>> [   14.006234] ->action->handler(): 0000000094806345, amd_iommu_int_handler+0x0/0x10
>> [   14.006234] unexpected IRQ trap at vector 1d
>>
>> Do you have any idea what might have gone wrong here?
> 
> Yes. This lacks setting up the low level flow handler. Delta patch
> below.
> 
> Thanks,
> 
>          tglx
> ---
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2033,6 +2033,7 @@ static int intcapxt_irqdomain_alloc(stru
>   
>   		irqd->chip = &intcapxt_controller;
>   		irqd->chip_data = info->data;
> +		__irq_set_handler(i, handle_edge_irq, 0, "edge");
>   	}
>   
>   	return ret;
> 

Yes, this fixes the issue. Now I can receive the IOMMU event log interrupts for IO_PAGE_FAULT event, which is triggered 
using the injection interface via debugfs.

Thanks,
Suravee
