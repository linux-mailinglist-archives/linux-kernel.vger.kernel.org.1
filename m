Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648682B7B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKRK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:29:43 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:20832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgKRK3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:29:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTZ5gJPXXjFWthLV+y1UdvIjyOraZDoKETBTY5EBfQ2NawNob7SWAtfrvwoHKnyWNOwLPWmP+ptJpPo9jKvZPjOm3S2RtEE4zmL1ebhInI4/7njvga3gLP+/xo+0/JNN7nmOGR2Lz/fcyDnzHnb5pppB5hpPcRkybz9g5iQO1KLqxreC9EKZn7NFrCzeICtnd0cVSu/T6vlKChcQM9P0stk9U9khHvCjXO994mDORe0hNh3AoXqar2FN5SIamS4bk9+h5LQmQ9B68UhA7iPzc0zDhumQjDjkoTIsbBmli/9X5i++VfX3boDN4dEqLG3EvLOXs8vh73AgoI3szj5LRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpEvnGkwnY5k/ts2Vj9lKiM5MaLPNGT4jMMJtsuIdNc=;
 b=QISJjW0hdud9WmTeVzhFWr34MixBm0M5/9E99NvxIW8daTgUzwNHlRkK2jhrGboMFzabGBR+ZiTF1pJ7829Us6noJXT0EipDrhNbJmBpGjE6wOHTIYqnMH5hqDrL5LBlZvwApSeYZXkzsTGlhQ0j6w3yQhupmsmPBn4SzwLRcZKZSSkQV1Xjsafdbk66H554JLhlu6gcMHeMqh0o8XntEuWDFVW0a3TlDAzGqbg9LVqSPaZ2OeJjZycinRnXDswrBBpnjEaochlBDonYWLVVBhhMZE6VSwVQCFSk6Rw32Az3QQ+uLQqtTyxYn+k2eVg+namxsZW8fl5flbVnPPAF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpEvnGkwnY5k/ts2Vj9lKiM5MaLPNGT4jMMJtsuIdNc=;
 b=wgfPkE2xyYMCnuNFxH/5+79B4Vkiwai3ohA0LkpV7YvXsjiqAgAvVviHvZHCYp0tRRvJmVbtJR5u7VdrJM3t/f3lXvy3P2LhMIVJ08MhGXup4RlXCc2ESOFCzKWnJht/W9iamU4p+8+Q3+Iei0H6Brjxsghujio3ay6CTCK3VZc=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4601.namprd12.prod.outlook.com (2603:10b6:5:163::16)
 by DM5PR12MB4662.namprd12.prod.outlook.com (2603:10b6:4:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 18 Nov
 2020 10:29:39 +0000
Received: from DM6PR12MB4601.namprd12.prod.outlook.com
 ([fe80::c87a:7bdf:9470:6d85]) by DM6PR12MB4601.namprd12.prod.outlook.com
 ([fe80::c87a:7bdf:9470:6d85%3]) with mapi id 15.20.3564.031; Wed, 18 Nov 2020
 10:29:39 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
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
 <c2361f78-b739-2f71-562b-d2c5f20825e7@amd.com>
Message-ID: <79d2e4ee-bfe1-7e86-6f35-f6fda1ce17fa@amd.com>
Date:   Wed, 18 Nov 2020 17:29:28 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <c2361f78-b739-2f71-562b-d2c5f20825e7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1P15301CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::20) To DM6PR12MB4601.namprd12.prod.outlook.com
 (2603:10b6:5:163::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1P15301CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:820:6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4 via Frontend Transport; Wed, 18 Nov 2020 10:29:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 796861c6-8c3d-4b42-08e8-08d88bacda90
X-MS-TrafficTypeDiagnostic: DM5PR12MB4662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB466218E731DAEA592CB02618F3E10@DM5PR12MB4662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wy8BPd0Rq8pTc1jvJi0k6nsdvUqsSYYG17L8cG8Q68LU3WgX9+xaLvTGgHomN+zxWgESdTPhv7SO45RUOb9EUGrYMO7jKkVrhSFyhl0aFhIu/veqjb2ZlFS+bFl4S5SQNZNwKGwSy6dE3Z34Gh4c4N4PVxbJBYYlXogMr+Xo7XhInojBmuWoztlymSlHV2ezdn2wJJRUmXyxQ/+zvnxK62hiBFuZAjnDKFlUwCqahkNlqKj/r43d2BgajyW5r/FvaFhwxxm9reLgO+d/BGPTe37vBYcqfgp57hq1CF4xGupCegtQQM2CxAxdh1U3pGnz5iNBtccK+VHm1xmQVCGmVFaXQobLVctCNmQV7KstXtlFEqCf5lP9VrWMwfI+uQVj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(478600001)(4326008)(52116002)(6486002)(8676002)(2906002)(66946007)(31696002)(66556008)(26005)(5660300002)(8936002)(6666004)(83380400001)(66476007)(2616005)(31686004)(53546011)(44832011)(6506007)(110136005)(36756003)(86362001)(6512007)(54906003)(16526019)(4001150100001)(956004)(316002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i5SiEEa/Az65oqvazRgW5oaUyyw0g2MZISz/A0+QruQBFKv4jr1CrUKvzuAOBDhMWmU1Jrr932D0oPllv3TCNEdl8P8ZcK5ID12KYWXHhZNEQiJx+ZLGRFJ0NemNKmSB3cciRONjecFhhocN3+EHG/O66lkOK8t5lya2dRqDpP8Y6ljh3R27i4Zs7lKCTy9MKLpeQUoupG2EcTBnnsme7aCBghCRtuGOgvJkBbTtzS+Pn0eXLXeBYcvJTQOroVoW3VUPcLETlPnYI4FVjFpZa355msYrw+hGqG3RyEl9cOCMOLhNf8piS8nKH0Arf14VjYT7YL8rmoBb0Bjry4j5/eHMc9F/q3yP6WQUeI0JeJQigd4xp9fuFWt6iySeAsSpn5CYPu1CnnbHyngE7jK03oqlhNwDZc7oMPmyjYXezI+uk8CfQdTyGrhK3ihIXqCL3rHlAG4btjTnpKYcOjH4M5LY5wX+GUx19dich78h7yxKXjKNYfaW/dH6SqXMZtkY6rqkB/jb44c7Ju0ASV1TEWGiQeDswKNC579SH+cT8khJrWvzzytmQfqEWolWtwZh9PfFPSS2B+hQRVdu0RLN2SZxM3wj7ruCcyzMIqMfK7ks6LqfBLXtJFUAzU8GWNj7L0X158fgFp1F0etq3EQGpV9KtzfUak515i5oMOqe6uWEs18sY3FjBspQa/JU6DVLEk3IyeKa1uCTQAatPri2F9rang1yiQ3EZDn7uWTNTGMwRi6Pnc769cyz/XjIsgB2MptDaFCSaJmtYfjFQxiwFIp3Qm9ggwtjmJKEx4KvluVndFWGd80QKsOZH14W57P7YzKh0zkaIpWYrX1D+h38xyPWf7KAJTQV9/659LrG4vJjvo1+ny7uu8qBNu7gvKHQcxGSeoO/IaDrWtGqoRKWXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796861c6-8c3d-4b42-08e8-08d88bacda90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 10:29:39.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkQ1CPjegopGMHIUrMY+NfEFErI6Pp4nMd1X3PI3IJbZZCb6dOcoT1GExRwqDtxDm60/sVy76yjU6rG81aQLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4662
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David

On 11/17/20 9:00 AM, Suravee Suthikulpanit wrote:
> David,
> 
> On 11/13/20 10:14 PM, David Woodhouse wrote:
>> On Wed, 2020-11-11 at 14:30 -0600, Tom Lendacky wrote:
>>> I had trouble cloning your tree for some reason, so just took the top
>>> three patches and applied them to the tip tree. This all appears to be
>>> working. I'll let the IOMMU experts take a closer look (adding Suravee).
>>
>> Thanks. I see Thomas has taken the first two into the tip.git x86/apic
>> branch already, so we're just looking for an ack on the third. Which is
>> this one...
>>
>>  From 49ee4fa51b8c06d14b7c4c74d15a7d76f865a8ea Mon Sep 17 00:00:00 2001
>> From: David Woodhouse <dwmw@amazon.co.uk>
>> Date: Wed, 11 Nov 2020 12:09:01 +0000
>> Subject: [PATCH] iommu/amd: Fix IOMMU interrupt generation in X2APIC mode
>>
>> The AMD IOMMU has two modes for generating its own interrupts.
>>
>> The first is very much based on PCI MSI, and can be configured by Linux
>> precisely that way. But like legacy unmapped PCI MSI it's limited to
>> 8 bits of APIC ID.
>>
>> The second method does not use PCI MSI at all in hardawre, and instead
>> configures the INTCAPXT registers in the IOMMU directly with the APIC ID
>> and vector.
>>
>> In the latter case, the IOMMU driver would still use pci_enable_msi(),
>> read back (through MMIO) the MSI message that Linux wrote to the PCI MSI
>> table, then swizzle those bits into the appropriate register.
>>
>> Historically, this worked because__irq_compose_msi_msg() would silently
>> generate an invalid MSI message with the high bits of the APIC ID in the
>> high bits of the MSI address. That hack was intended only for the Intel
>> IOMMU, and I recently enforced that, introducing a warning in
>> __irq_msi_compose_msg() if it was invoked with an APIC ID above 255.
>>
>> Fix the AMD IOMMU not to depend on that hack any more, by having its own
>> irqdomain and directly putting the bits from the irq_cfg into the right
>> place in its ->activate() method.
>>
>> Fixes: 47bea873cf80 "x86/msi: Only use high bits of MSI address for DMAR unit")
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> I'm still working on testing this series using IO_PAGE_FAULT injection to trigger the IOMMU interrupts. I am still 
> debugging some issues, and I'll keep you updated on the findings.
> 
> Thanks,
> Suravee

I might need your help debugging this issue. I'm seeing the following error:

[   14.005937] irq 29, desc: 00000000d200500b, depth: 0, count: 0, unhandled: 0
[   14.006234] ->handle_irq():  00000000eab4b6eb, handle_bad_irq+0x0/0x230
[   14.006234] ->irq_data.chip(): 000000001cce6d6b, intcapxt_controller+0x0/0x120
[   14.006234] ->action(): 0000000083bfd734
[   14.006234] ->action->handler(): 0000000094806345, amd_iommu_int_handler+0x0/0x10
[   14.006234] unexpected IRQ trap at vector 1d

Do you have any idea what might have gone wrong here?

Thanks,
Suravee
