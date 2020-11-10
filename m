Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288C42AE265
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgKJWAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:00:37 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:25635
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731687AbgKJWAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:00:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQHdopkV6I112V4X7vxvMlWBq66SZ7uB1Tl3siGiDikkMsU4bLF9j42cIRe0xojCafsfiECeiifE22DaoFpZa3a9NhF+JorqyMt/AS6NaMW+RDLLDqANxtlc7yaILka/G7thmoOlf4teL7V3yvy0Y/RwkRrTwfq5yKhOndmamp/3t/EGm0Jkdilu9jpY/hiA2Hzfq1ahOAopSKRnLthVcCQ+OLBDtG/06BQGxBDwYKk6Og9/IH+0B78SookJIs94nrv50H0yeJmPkPIHyCf8yIw1Cx8rff8GASxIzsaWsdNmGSYeFDV72337gvgxuHYCBakj/D9wW9rDnXlY9XOyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En8+dXy4GxBL3byPH7W+9tjB2hJIfKgIm2be6iNhYyY=;
 b=n6ryv7YdfSrrIHzuYefu43opbQY5fRDLPgi/FVYl8hatM6hI4qU8yWCMaDvwxhr8k2FXqRYQSm5UFTxO8+uDJkUJlzRhtdYQ7SjKTfAnTuJ0gqDOAUYzx4IhszvVE9zFGUGYLydQsx97VmiTTYOWOaQ4u92bhQwbywo9UTkDoKNBYnZnw+x26IyJJsTLAQIgiGt2tUtT6jULduqLks/YoBEK7nfqA0GPDznbbtYxK1FJje5TeEkMoxDNyCkBGwx7okVXV9WnP7WNMoU6WGSlMHB1q8swBhdC/TRoR6GmgO178LNEoq8anwFBjhAdgD/3EVGZ6XxDiQCnjrYiOze9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En8+dXy4GxBL3byPH7W+9tjB2hJIfKgIm2be6iNhYyY=;
 b=c9MDF8L7QV/6Y4UJOsLSo5EpRFE3Mq8V+N78HrRopkfd7Zq6S0chwRJKzUYAzIm3MWf2jfaTPVWwOJljrrPWKdXb4V9R0zatZwsmZnYMOkURGc4msvrIKJLI8ww2CYOaiYj8GcSYQMDObf0ILp696qK45GB44Soxft/l03YSvuw=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Tue, 10 Nov 2020 22:00:30 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.034; Tue, 10 Nov 2020
 22:00:30 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
 <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
Date:   Tue, 10 Nov 2020 16:00:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::28) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM6PR17CA0015.namprd17.prod.outlook.com (2603:10b6:5:1b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 22:00:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5556855-230a-47ce-bbe9-08d885c409ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3081AC808FE873DDF3F84B1FECE90@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AttEVEXF7EpZw53cTv0pRWj+sGQ6vcxselyXYp3GPDgJiEeAqoEDLjgeaF6P52bGDkW+G4rQZuEhPn7W12SuDAWhjXNK9V1jjU6VV+LiFZj4WMJ8Z/jnwS1ef7czeyxYsEIflGVG1vyjsu562fm1dm8n1OKF8GNI3iW+w1DowXVMHiXpgmBOw2xG8qs38MqpA59lSph4vAE1mJ2nh4TRksbHpro3NWylixneXjWV4JbmnI0UF3IDJvuFA6N2bntlG40EXDdE2Tor1bXXFNh6W9ZXvRgbJrh8FWJCiBTM1XMrvbyyTQeB0uMFiWM7it2kaih5YttuRLqutjrGwxiowfrlciF4j25I1hirBfa8R4Gahr0eg8qojsihiD18sMw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(186003)(16526019)(26005)(478600001)(8676002)(36756003)(4326008)(83380400001)(8936002)(66476007)(66556008)(86362001)(31686004)(52116002)(45080400002)(66946007)(956004)(16576012)(316002)(2616005)(54906003)(110136005)(31696002)(5660300002)(2906002)(6486002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RzpF7OplB9PI/+TJoO/9L4IUZE24qURVPKK+rBMGFtaFEXBfYGX+X1fz3pp04CVWkM6g4TDTMo+NCmOWsPLRu6Ki+ClH9wtTJH4DoP646RfD8A3svDdcLzm0LC3D2fJQUysP/shI+r8tdbbAvmosorCD31Zi6/mwkDYtAfvvrOVyAM5AQJ8G+pjZAg2TIGIImdJSlcCDZ91Nr+Q9g25kncqMFSP9Ol2TdaP/pzpMFCoL5DKdDn/jTLZRTlnJ9kAB7dZjMxzcglt0vmB9XbkBGKvFp/k5r2KSv4Vo4iFNkcpTz2+0MaMNL/lb8WqyDayealnDVoPtebY/NUBFJKW2ojHNumAO91fGLjBUlmRyDgLTOBYPUWvl4wjDmislfF7RjEHLyF8UlgM3SVJdKFq2R3cuHivnQrRWC5MTkCBKevgWH7Thu5FBENZ72ONDR7IDgAuZVyLj1JBmUdzDrfNM5W4oPO6Z5LNxlvQoETgIoFCibA0/iSN4dq24u0uiGxp788MXWUq0KekEcotgo3Uf+erd9FZQJjtYbN0HPb8JIGyTIL+FjqNGgQ4s9xP0DF7CKa4Z0Szk1sHsXwvIOzvHOlrukpI7u5+cICQ3wuoZAfaKdXyI0smhwtY9NOCyCvS8xBzSVF22xrULZMKnp7b6ZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5556855-230a-47ce-bbe9-08d885c409ae
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 22:00:29.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q3sD5gKL8YOKj/1ZDJUJA+gAD2dxjOr17MZXva1a9wTDL79kG0p7wywovKanyCpVAKt6jlCkHbFsKKdUy+KUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 3:30 PM, David Woodhouse wrote:
> 
> 
> On 10 November 2020 21:01:17 GMT, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, Nov 10 2020 at 19:21, David Woodhouse wrote:
>>
>>> On 10 November 2020 18:56:17 GMT, Thomas Gleixner
>> <tglx@linutronix.de> wrote:
>>>> On Tue, Nov 10 2020 at 18:50, Thomas Gleixner wrote:
>>>>> On Tue, Nov 10 2020 at 16:33, David Woodhouse wrote:
>>>>>> If I could get post-5.5 kernels to boot at all with the AMD IOMMU
>>>>>> enabled, I'd have a go at throwing that together now...
>>>>>
>>>>> It can share the dmar domain code. Let me frob something.
>>>>
>>>> Not much to share there and I can't access my AMD machine at the
>>>> moment. Something like the untested below should work.
>>>
>>> Does it even need its own irqdomain? Can it not just allocate
>> directly
>>> from the vector domain then program its own register directly based
>> on
>>> the irq_cfg?
>>
>> It uses pci_enable_msi() and I have no clue about that piece of
>> hardware
>> and whether that is actually required or not. If it is, then it needs a
>> domain because that's what pci_enable_msi() uses.
> 
> I'd be kind of surprised if it is required, but testing on qemu is obviously not going to cut it. Tom?

Was just in the process of testing it... I still get a warning. Here's
the new backtrace:

[   15.581115] WARNING: CPU: 6 PID: 1 at arch/x86/kernel/apic/apic.c:2527 __irq_msi_compose_msg+0x9f/0xb0
[   15.581115] Modules linked in:
[   15.581115] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc3-sos-custom #1
[   15.581115] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS REX1006G 01/25/2020
[   15.581115] RIP: 0010:__irq_msi_compose_msg+0x9f/0xb0
[   15.581115] Code: 01 00 74 1e 3d ff 7f 00 00 77 1f 0f b7 16 c1 e8 08 83 e0 7f c1 e0 05 66 81 e2 1f f0 09 d0 66 89 06 c3 3d ff 00 00 00 77 01 c3 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00
[   15.581115] RSP: 0018:ffffc900000c7c18 EFLAGS: 00010012
[   15.581115] RAX: 0000000000000100 RBX: 0000000000000000 RCX: 0000000000000000
[   15.581115] RDX: 0000000000000000 RSI: ffffc900000c7c20 RDI: ffff8881088341c0
[   15.581115] RBP: ffff8881599e0428 R08: 0000000000000000 R09: ffffffffffffffff
[   15.581115] R10: 0000000000000003 R11: 0000000000000004 R12: ffff8881088341c0
[   15.581115] R13: 0000000000000000 R14: 0000000000000004 R15: ffff888108834180
[   15.581115] FS:  0000000000000000(0000) GS:ffff88900d380000(0000) knlGS:0000000000000000
[   15.581115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.581115] CR2: 0000000000000000 CR3: 000000015240a000 CR4: 0000000000350ee0
[   15.581115] Call Trace:
[   15.581115]  irq_msi_update_msg+0x4d/0x80
[   15.581115]  msi_set_affinity+0x160/0x190
[   15.581115]  irq_do_set_affinity+0x52/0x190
[   15.581115]  irq_setup_affinity+0xd7/0x170
[   15.581115]  irq_startup+0x5d/0xf0
[   15.581115]  __setup_irq+0x6b9/0x700
[   15.581115]  request_threaded_irq+0xf8/0x160
[   15.581115]  ? irq_remapping_alloc+0x4d0/0x4d0
[   15.581115]  ? e820__memblock_setup+0x7d/0x7d
[   15.581115]  iommu_init_msi+0x60/0x190
[   15.581115]  state_next+0x39d/0x665
[   15.581115]  ? e820__memblock_setup+0x7d/0x7d
[   15.581115]  iommu_go_to_state+0x24/0x28
[   15.581115]  amd_iommu_init+0x11/0x46
[   15.581115]  pci_iommu_init+0x16/0x3f
[   15.581115]  do_one_initcall+0x44/0x1d0
[   15.581115]  kernel_init_freeable+0x1e7/0x249
[   15.581115]  ? rest_init+0xb4/0xb4
[   15.581115]  kernel_init+0xa/0x10c
[   15.581115]  ret_from_fork+0x22/0x30
[   15.581115] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc3-sos-custom #1
[   15.581115] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS REX1006G 01/25/2020
[   15.581115] Call Trace:
[   15.581115]  dump_stack+0x6d/0x88
[   15.581115]  __warn.cold+0x24/0x3d
[   15.581115]  ? __irq_msi_compose_msg+0x9f/0xb0
[   15.581115]  report_bug+0xd1/0x100
[   15.581115]  handle_bug+0x35/0x80
[   15.581115]  exc_invalid_op+0x14/0x70
[   15.581115]  asm_exc_invalid_op+0x12/0x20
[   15.581115] RIP: 0010:__irq_msi_compose_msg+0x9f/0xb0
[   15.581115] Code: 01 00 74 1e 3d ff 7f 00 00 77 1f 0f b7 16 c1 e8 08 83 e0 7f c1 e0 05 66 81 e2 1f f0 09 d0 66 89 06 c3 3d ff 00 00 00 77 01 c3 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00
[   15.581115] RSP: 0018:ffffc900000c7c18 EFLAGS: 00010012
[   15.581115] RAX: 0000000000000100 RBX: 0000000000000000 RCX: 0000000000000000
[   15.581115] RDX: 0000000000000000 RSI: ffffc900000c7c20 RDI: ffff8881088341c0
[   15.581115] RBP: ffff8881599e0428 R08: 0000000000000000 R09: ffffffffffffffff
[   15.581115] R10: 0000000000000003 R11: 0000000000000004 R12: ffff8881088341c0
[   15.581115] R13: 0000000000000000 R14: 0000000000000004 R15: ffff888108834180
[   15.581115]  irq_msi_update_msg+0x4d/0x80
[   15.581115]  msi_set_affinity+0x160/0x190
[   15.581115]  irq_do_set_affinity+0x52/0x190
[   15.581115]  irq_setup_affinity+0xd7/0x170
[   15.581115]  irq_startup+0x5d/0xf0
[   15.581115]  __setup_irq+0x6b9/0x700
[   15.581115]  request_threaded_irq+0xf8/0x160
[   15.581115]  ? irq_remapping_alloc+0x4d0/0x4d0
[   15.581115]  ? e820__memblock_setup+0x7d/0x7d
[   15.581115]  iommu_init_msi+0x60/0x190
[   15.581115]  state_next+0x39d/0x665
[   15.581115]  ? e820__memblock_setup+0x7d/0x7d
[   15.581115]  iommu_go_to_state+0x24/0x28
[   15.581115]  amd_iommu_init+0x11/0x46
[   15.581115]  pci_iommu_init+0x16/0x3f
[   15.581115]  do_one_initcall+0x44/0x1d0
[   15.581115]  kernel_init_freeable+0x1e7/0x249
[   15.581115]  ? rest_init+0xb4/0xb4
[   15.581115]  kernel_init+0xa/0x10c
[   15.581115]  ret_from_fork+0x22/0x30
[   15.581115] ---[ end trace 05c9465e30ba6a20 ]---


Thanks,
Tom

> 
