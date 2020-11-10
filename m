Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6462ADC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgKJREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:04:46 -0500
Received: from mail-eopbgr690066.outbound.protection.outlook.com ([40.107.69.66]:53723
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730232AbgKJREp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:04:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnaxJj6MGQfjqL1sg+PuPA1j4zwHTUQcC+wSMk+JykJaxa83oJAY2iIyMD9rZ8yx1lZeM0uQ7rcXF5xJ1gbI0BeIqDz+4a4Jy9CG8rU2MZk+4fAs+JuSY59Ez1Hqr0qzAxmntGjBNMX6G1dsNIHuOhnZwjo4ZLkCZ+ea0OPVLkOvSaxCRVEFzSDnnO08om+ERaPD9n14xnN/f9Ere8wK1OAF2hhEoDR5ezqoFaozSXm59FuyIjwKXV4VroJQixUX5jKeFGuQc2ctjArZvbXTOe58tDSxpiuCr+U/EuRu2epA7qrnieIZ1Vx4QDlgStrvL7EabHctu368ew45vabOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1KD3Myn3+zxxPDlo86taXWkOL+T1XPbyqRrSs7XBbs=;
 b=BnMUcSQi45YL3eGJCWTKWB556Wg4WBVyPEyoFItktkEWiHAk4pZj+QSMES1ATPk3o/8YQkov5nscH5iXlkWoKr8akSFZpe+nJkOIksM6pTO7mBDFDqiAtpLaexivICExJ2yo5ODhnEPV70ptdYTiikQdEe1SutfHhBAZEEivd4Gof2T7Iq19O2g/Jbpw9P8GS+TcyZ9Y6y3JD9fKJbF0Zf/vxaBmPvVzma2Osf8lRplBUKgI4z85wnhyHDfOWiJEt+MymCdRmJyhSNhdbGTtIQtctRDcM0+3JdH+g05eNTc6CkppcFy+KszPOHr/qnWXSnZYnU/CqDiTsEPU/+eLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1KD3Myn3+zxxPDlo86taXWkOL+T1XPbyqRrSs7XBbs=;
 b=YsAuSiiQrM/W+eYmbBxeX67xOIFD5gyvhUHA2deSjS9d5RxxS48yomD1InUTqbkUSxbvYUrXG34LP9KWl5WtTApXZfbyOEqMm+FIKfg3P6r6HMsyhXnhpBdi6ANehyOjwLK8xbtKEkXnH//HdFishFryb21VpVLnoXNMt9aqHoc=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Tue, 10 Nov 2020 17:04:40 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.034; Tue, 10 Nov 2020
 17:04:40 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
 <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
 <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de>
 <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
 <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
 <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com>
 <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6ffd20b8-39c9-fc26-0ead-0468fb87cbe0@amd.com>
Date:   Tue, 10 Nov 2020 11:04:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:d3::7) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SA0PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:d3::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 17:04:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f886514b-3c91-46e2-1253-08d8859ab63a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3468790B83B4CA9C7F7B933BECE90@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nH5Rl938OhgT9Ot+U7kFB7ByaPhQ/vZGdtV/jS5dIl0Rf9cutDl0xWumaIEqThU/tAJivo891guCkGOp0NRosYNa/vOQEvLHPOmqg0jUmHsi/ZoY9coOJ1AGNB3RRJ1ooTVsXLBek1E5iDysihtP/UzmceZZGICiHTlRNMblkpdmYb5scfOVLMxVzKeClhCbRyMuq8q6MLO0ecy0QWcffeqtBeZ+TpaSWghV907h54Q0K6+dp4qq/VSPwqSb71fbnI4wtdTOTgN2FVGm1xcDkcunxsVrSJWYWPF485gY4pyYgxAtbKgTZyJLdwF6TSNvMBGdgaFCVJRUw8PdYMjIRAmpyZDku+tOBQdkag5yl8a82aiq4TLxoRNXQ2JGUJxN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(5660300002)(8676002)(4326008)(52116002)(31686004)(66556008)(66946007)(66476007)(8936002)(4001150100001)(478600001)(86362001)(2906002)(16526019)(2616005)(36756003)(186003)(956004)(54906003)(110136005)(26005)(316002)(16576012)(83380400001)(53546011)(6486002)(45080400002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: p43x1Hf8Y43Yzko//ejKo90Bjq+vjuuAJaRe83eTz2OzYMLmriv6EzUdBhfF7Sr5behQYmDWWAGpVbx/42JianC9ZW7EKczF96ezMQc9YAoSMTN3/SbrZUyFfm1GuCoXsnGEftQTcnqNgnzvEgTATCcpdmeCt+zoXR6PmabvcxNaY3ICZabmf5Wk2kEi/qKDLmlyFm1wegnlJMo0NGssqHQNcjWSot1g1fGKznD+dr0AAQnvxwz/tjomrEpYsYoN1aKCFtGH3ZmrqaoaKqTMLnwZyZSAvFzlZRPSQjQFcV4Ni5CnI3FAonEu5p1TfzZSkMKhVZCNaurQ/GaW517yfPlKgzhnrauElW0pWM2IE/dFcojBYBO5evky/8aOE/dRdjagZofo9IdSr9ZKLKasLCMEP9m7DajhzygDZeTiRMmuYfPt8Fn1/sLhUOfJmtVUH2XNQF3hbGjioiecURkVziL8TKpOZKVgDMUKtNTzT9jhQLkKba0jGKUW3iKXu7WrIWPfPUAbt8VpzH3zLUepwveJzht2eTScLWAvcPbyXEstglaeXuaOD+C/GhN/8MlaVyVof3EomH4v9YhQ5z7+bklVt5zIImZnIBQYf8NNkLQKwuq5KiXI1h4ppDeZMf0/nwvdnYqfE+6eU5jqK3BRjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f886514b-3c91-46e2-1253-08d8859ab63a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 17:04:40.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PALiDUnTH5SwB89qUrK5soxoUJcauzb4sRQ8YTcVIf3MWmUM39LvX6QVNgv7dz4ovdYFA4iz+huph0T08eSZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 10:33 AM, David Woodhouse wrote:
> On Tue, 2020-11-10 at 10:17 -0600, Tom Lendacky wrote:
>> Yep. The warning started triggering with:
>> 47bea873cf80 ("x86/msi: Only use high bits of MSI address for DMAR unit")
>>
>> Here's the backtrace:
>>
>> [   15.611109] ------------[ cut here ]------------
>> [   15.616274] WARNING: CPU: 184 PID: 1 at arch/x86/kernel/apic/apic.c:2505 __irq_msi_compose_msg+0x79/0x80
>> [   15.626855] Modules linked in:
>> [   15.630263] CPU: 184 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-sos-custom #1
>> [   15.638516] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS REX1006G 01/25/2020
>> [   15.647549] RIP: 0010:__irq_msi_compose_msg+0x79/0x80
>> [   15.653188] Code: 0f f0 ff 09 d0 89 06 8b 47 04 c7 46 04 00 00 00 00 88 46 08 45 84 c0 74 08 8b 07 30 c0 89 46 04 c3 81 3f ff 00 00 00 77 01 c3 <0f> 0b c3 0f 1f 40 00 0f 1f 44 00 00 8b 05 81 f9 04 02 85 c0 75 16
>> [   15.674140] RSP: 0018:ffffc900000c7c30 EFLAGS: 00010212
>> [   15.679971] RAX: 0000000000000021 RBX: ffff888143789028 RCX: 0000000000000000
>> [   15.687936] RDX: 0000000000000000 RSI: ffffc900000c7c40 RDI: ffff8881447dd1c0
>> [   15.695899] RBP: ffff888143789028 R08: 0000000000000000 R09: 0000000000000005
>> [   15.703861] R10: 0000000000000002 R11: 0000000000000004 R12: ffff88900e7b80c0
>> [   15.711825] R13: 0000000000000000 R14: ffff88907646ba80 R15: 0000000000000000
>> [   15.719789] FS:  0000000000000000(0000) GS:ffff88900f000000(0000) knlGS:0000000000000000
>> [   15.728821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   15.735234] CR2: 0000000000000000 CR3: 000000114d40a000 CR4: 0000000000350ee0
>> [   15.743197] Call Trace:
>> [   15.745929]  irq_chip_compose_msi_msg+0x2e/0x40
>> [   15.750984]  msi_domain_activate+0x4b/0x90
>> [   15.755556]  __irq_domain_activate_irq+0x53/0x80
>> [   15.760707]  ? irq_set_msi_desc_off+0x5a/0x90
>> [   15.765568]  irq_domain_activate_irq+0x25/0x40
>> [   15.770525]  __msi_domain_alloc_irqs+0x16a/0x310
>> [   15.775680]  __pci_enable_msi_range+0x182/0x2b0
>> [   15.780738]  ? e820__memblock_setup+0x7d/0x7d
>> [   15.785597]  pci_enable_msi+0x16/0x30
>> [   15.789685]  iommu_init_msi+0x30/0x190
>> [   15.793860]  state_next+0x39d/0x665
>> [   15.797754]  ? e820__memblock_setup+0x7d/0x7d
>> [   15.802615]  iommu_go_to_state+0x24/0x28
>> [   15.806993]  amd_iommu_init+0x11/0x46
>> [   15.811076]  pci_iommu_init+0x16/0x3f
> 
> Oh joy.
> 
> It's asking the core code to generate a PCI MSI message for it and
> actually program that to the PCI device (since the IOMMU itself is a
> PCI device).
> 
> That isn't actually used for generating MSI, but is instead interpreted
> to write the intcapxt registers which *do* generate the interrupts.
> 
> That wants fixing, preferably not to go via MSI format at all, or maybe
> just to use the 'dmar' flag to __irq_msi_compose_msg(). Either way by
> having an irqdomain of its own like the Intel IOMMU does.
> 
> If I could get post-5.5 kernels to boot at all with the AMD IOMMU
> enabled, I'd have a go at throwing that together now...

That's odd. I haven't had an issue with or heard of any issues with
booting post-5.5 kernels with the AMD IOMMU enabled. What kind of problems
are you encountering?

Thanks,
Tom

> 
