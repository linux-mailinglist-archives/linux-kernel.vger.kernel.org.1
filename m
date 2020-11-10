Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50472ADB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgKJQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:17:38 -0500
Received: from mail-eopbgr760079.outbound.protection.outlook.com ([40.107.76.79]:22502
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgKJQRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:17:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR0gHKO+wqSDufGmqAPr5Ti67mkCPNE4ojp+fEZ3zTYz0S1PLv/ZnhIWlsTFE3sGKNJhLyxmk+kTSrQvGSiH3boake45aFjktxrIxuGjZYprnemafH4kyODU0ZQu3+6fSVMSpaCar9VyHTzUs4L4Pid/QpNfe9VJIiCpfeadPTbGi+iv6VB8Xnf/EWq/g+XatF6UfH1xaPO6eFnrm7xpGQfvZJIKVjKJ4UIpPIjVnBlBZP79UYsKR0bOpU22Iix1ovWVfBmCa+ar5TONhmW4VNscZRjJGZZ57EfnO/rjPIubeuJzOuRaCHMrZxrGsLNcfdjcX6gYkzmZnDlpD9GfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0K+1k3d3ckU0c7UrKk/dlvfSt5DO0Sr94XapuZme7M=;
 b=jCKAxRJnZN3t1wPgcxLgh5mDTpmh65tubTY9pHTgywgWAXWPlZF5RHMCPXrGeIhicmSz+g3zaoZDjBPGlTFG7t88bi1ie/wyGs7wH4DObAaZ4uy3rtpd9oqekdr0k4IisiOfx0RgQidUU5BB90p6YHr4VuNnw7zrd2eu3wUbs5VpA4RMmX/quwQeaZYdi6ev+ZQsICmPpbMskJFrgk5GUJ6k9wsmtL3wAkzfstRpYLZD6blnMXXuqJzB5LSh9oaDmNVeWZlSiUPR1FVJXp8+44QfBFM+NPNxCy1U/5Q57ts6x2+GsndKdqqXVLj3Fhl6Zmg+UutvM5hbG7SezBQKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0K+1k3d3ckU0c7UrKk/dlvfSt5DO0Sr94XapuZme7M=;
 b=h3Ggs4zZaVTXpkBLP4ik5h69Two6eI1zUUfi5oYaPUg1s8xACllITv2nBb6Bzo0iBClLQ+P48PY+upOMQvVu2UQkkbFGwWFEf2lBPjCfdU9qJJvpnm86g3fMnrLWe5mBYn+nWBhtom+hLEoH5eIorzziq7lXbTkJujuEJbjfJKk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Tue, 10 Nov 2020 16:17:31 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.034; Tue, 10 Nov 2020
 16:17:31 +0000
Subject: Re: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
 <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
 <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de>
 <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
 <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com>
Date:   Tue, 10 Nov 2020 10:17:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 16:17:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0a418ee-c1c7-4500-6dad-08d885942048
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-Microsoft-Antispam-PRVS: <DM6PR12MB279586D9A61ECF75D44DEA7BECE90@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtKccMXWmlZFgZmOP6mjKz00PTS0WOwtEZXuhn7pbUpYntDoP96znkGOi8hEu84HLi5p1TDbjO84Ztv69pyuC8bXcLFK/PLWZWVgDZZYqojFH5MSAKZu3oN+60lMcQYHYhI7HYwcrrWHfzHIcVEC/+McM9ixg2sujLkgzfo+SFrYOklCh4EhYRXAQ7j5duK3aklBBHJkfG/vUcrdZFtiasXLekFeF+wUDkloCiJVx1ziQI1Vr5xNts855MYKGYuE03X1psDg4xtp9id0AK0WpqEaiTZyU3vZyWRJfTbZJ78edeGrKOsF5DLvlhKYD+HuzdT0JSppKCyQUKEt6eXXarRK1JlUUBpkK9HwGOXxiHUPCTi+oui3dnPv2+xw8CIL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(36756003)(83380400001)(478600001)(53546011)(45080400002)(31696002)(2906002)(26005)(5660300002)(16526019)(86362001)(66556008)(66476007)(66946007)(2616005)(956004)(6486002)(110136005)(316002)(52116002)(16576012)(8936002)(8676002)(4326008)(54906003)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SSHl5YGK9otwXmssHs+vzjg/ayH0FiNnxNb6HarfVD9Cw1MnIUb5yZlKbscGaDWhBAlZWp8eLpH8XK/t3s4wM6dFm6rboD7ewD6tNBl0yRD5q1ZIAgNxuFlrv23IjWfs0kPzAOd2a4gPHRGQPmzEGAwttCXl+ueNynxCTbqPiUJUuqU0StWWhnGvldJEolRmuPkIDzIODkkfk3KAfPJwt68I8miCYUZNz/H1yE4D8nMna7IN7knNO59q5q4jdBj4hDyQxJKp6Z6530L2zvb9zALMZ4BGozQsrRFZjU7abod4fFMHkL7KdC8psguYfl9DXWI+jvVnqrMxuettvNOdpjoOYyOAkEYTwJ3VAb1Yx79q8/kyuWWANgk/Hn1VExpd/TqjteV8okra/IPkSNMux787UV7d0i8xwsL6PTeGkO75UcNGFKEto/Gf0g3HtRrb3gbHI3WruQvFM4hjdm9Nr5fYpbNs6PrTSmLVWGfeG1AdJ52EzomA+M5KfU4wNNiSHcsFfvInuKypxS/S7LDcD4LCRgCu6dz7ES1YPzPtFzqpTcS35So5Ls+OEorLWTKpBxwSYC3AMB3Ud8FHOUBkEIVLJShdjDQJWntnceaBmN0BJthxs6UkXTpkE7GiT+1O7LRV+tIPF0gQ4ZutX6EsTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a418ee-c1c7-4500-6dad-08d885942048
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 16:17:31.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcsjQp/99ddoovPmbyxLQcaHVakrsj/MMlCYLYQG+4eMxoeXN77RMmvP1o+8jAm8HiLW0vdglZMCTs5+oQl2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 9:54 AM, Thomas Gleixner wrote:
> On Tue, Nov 10 2020 at 08:55, Tom Lendacky wrote:
>> On 11/10/20 8:34 AM, Thomas Gleixner wrote:
>> I was about to send the dmesg output when I saw this. A quick test with
>> this change resolves the boot issue, thanks!
> 
> /me feels stupid
> 
>> I'm still seeing the warning at arch/x86/kernel/apic/apic.c:2527, but I'll
>> start a separate thread on that.
> 
> Can you please provide the backtrace?

Yep. The warning started triggering with:
47bea873cf80 ("x86/msi: Only use high bits of MSI address for DMAR unit")

Here's the backtrace:

[   15.611109] ------------[ cut here ]------------
[   15.616274] WARNING: CPU: 184 PID: 1 at arch/x86/kernel/apic/apic.c:2505 __irq_msi_compose_msg+0x79/0x80
[   15.626855] Modules linked in:
[   15.630263] CPU: 184 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-sos-custom #1
[   15.638516] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS REX1006G 01/25/2020
[   15.647549] RIP: 0010:__irq_msi_compose_msg+0x79/0x80
[   15.653188] Code: 0f f0 ff 09 d0 89 06 8b 47 04 c7 46 04 00 00 00 00 88 46 08 45 84 c0 74 08 8b 07 30 c0 89 46 04 c3 81 3f ff 00 00 00 77 01 c3 <0f> 0b c3 0f 1f 40 00 0f 1f 44 00 00 8b 05 81 f9 04 02 85 c0 75 16
[   15.674140] RSP: 0018:ffffc900000c7c30 EFLAGS: 00010212
[   15.679971] RAX: 0000000000000021 RBX: ffff888143789028 RCX: 0000000000000000
[   15.687936] RDX: 0000000000000000 RSI: ffffc900000c7c40 RDI: ffff8881447dd1c0
[   15.695899] RBP: ffff888143789028 R08: 0000000000000000 R09: 0000000000000005
[   15.703861] R10: 0000000000000002 R11: 0000000000000004 R12: ffff88900e7b80c0
[   15.711825] R13: 0000000000000000 R14: ffff88907646ba80 R15: 0000000000000000
[   15.719789] FS:  0000000000000000(0000) GS:ffff88900f000000(0000) knlGS:0000000000000000
[   15.728821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.735234] CR2: 0000000000000000 CR3: 000000114d40a000 CR4: 0000000000350ee0
[   15.743197] Call Trace:
[   15.745929]  irq_chip_compose_msi_msg+0x2e/0x40
[   15.750984]  msi_domain_activate+0x4b/0x90
[   15.755556]  __irq_domain_activate_irq+0x53/0x80
[   15.760707]  ? irq_set_msi_desc_off+0x5a/0x90
[   15.765568]  irq_domain_activate_irq+0x25/0x40
[   15.770525]  __msi_domain_alloc_irqs+0x16a/0x310
[   15.775680]  __pci_enable_msi_range+0x182/0x2b0
[   15.780738]  ? e820__memblock_setup+0x7d/0x7d
[   15.785597]  pci_enable_msi+0x16/0x30
[   15.789685]  iommu_init_msi+0x30/0x190
[   15.793860]  state_next+0x39d/0x665
[   15.797754]  ? e820__memblock_setup+0x7d/0x7d
[   15.802615]  iommu_go_to_state+0x24/0x28
[   15.806993]  amd_iommu_init+0x11/0x46
[   15.811076]  pci_iommu_init+0x16/0x3f
[   15.815165]  do_one_initcall+0x44/0x1d0
[   15.819447]  kernel_init_freeable+0x1e7/0x249
[   15.824311]  ? rest_init+0xb4/0xb4
[   15.828097]  kernel_init+0xa/0x10c
[   15.831889]  ret_from_fork+0x22/0x30
[   15.835883] CPU: 184 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-sos-custom #1
[   15.836876] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS REX1006G 01/25/2020
[   15.836876] Call Trace:
[   15.836876]  dump_stack+0x6d/0x88
[   15.836876]  __warn.cold+0x24/0x3d
[   15.836876]  ? __irq_msi_compose_msg+0x79/0x80
[   15.836876]  report_bug+0xd1/0x100
[   15.836876]  handle_bug+0x35/0x80
[   15.836876]  exc_invalid_op+0x14/0x70
[   15.836876]  asm_exc_invalid_op+0x12/0x20

[   15.836876] RIP: 0010:__irq_msi_compose_msg+0x79/0x80
[   15.836876] Code: 0f f0 ff 09 d0 89 06 8b 47 04 c7 46 04 00 00 00 00 88 46 08 45 84 c0 74 08 8b 07 30 c0 89 46 04 c3 81 3f ff 00 00 00 77 01 c3 <0f> 0b c3 0f 1f 40 00 0f 1f 44 00 00 8b 05 81 f9 04 02 85 c0 75 16
[   15.836876] RSP: 0018:ffffc900000c7c30 EFLAGS: 00010212
[   15.836876] RAX: 0000000000000021 RBX: ffff888143789028 RCX: 0000000000000000
[   15.836876] RDX: 0000000000000000 RSI: ffffc900000c7c40 RDI: ffff8881447dd1c0
[   15.836876] RBP: ffff888143789028 R08: 0000000000000000 R09: 0000000000000005
[   15.836876] R10: 0000000000000002 R11: 0000000000000004 R12: ffff88900e7b80c0
[   15.836876] R13: 0000000000000000 R14: ffff88907646ba80 R15: 0000000000000000
[   15.836876]  irq_chip_compose_msi_msg+0x2e/0x40
[   15.836876]  msi_domain_activate+0x4b/0x90
[   15.836876]  __irq_domain_activate_irq+0x53/0x80
[   15.836876]  ? irq_set_msi_desc_off+0x5a/0x90
[   15.836876]  irq_domain_activate_irq+0x25/0x40
[   15.836876]  __msi_domain_alloc_irqs+0x16a/0x310
[   15.836876]  __pci_enable_msi_range+0x182/0x2b0
[   15.836876]  ? e820__memblock_setup+0x7d/0x7d
[   15.836876]  pci_enable_msi+0x16/0x30
[   15.836876]  iommu_init_msi+0x30/0x190
[   15.836876]  state_next+0x39d/0x665
[   15.836876]  ? e820__memblock_setup+0x7d/0x7d
[   15.836876]  iommu_go_to_state+0x24/0x28
[   15.836876]  amd_iommu_init+0x11/0x46
[   15.836876]  pci_iommu_init+0x16/0x3f
[   15.836876]  do_one_initcall+0x44/0x1d0
[   15.836876]  kernel_init_freeable+0x1e7/0x249
[   15.836876]  ? rest_init+0xb4/0xb4
[   15.836876]  kernel_init+0xa/0x10c
[   15.836876]  ret_from_fork+0x22/0x30
[   16.046524] ---[ end trace 2fb272e5ca8df1c8 ]---

Thanks,
Tom

> 
> Thanks,
> 
>         tglx
> 
