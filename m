Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638BF2D1CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgLGWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:07:18 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:36066
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727646AbgLGWHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:07:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iY26EszfvwNvqM6iYG4SVZ4SZPRV7w32Sj23gNYFha5Ws0q6P2AL8rZXMB/MDVVx4mn0Z7u9UzKcIIa+xYrgTHXP4vEbROxacTPIcCU5gpFHHBe9sdgPVX6uvPImjo1iTmCTxOzPAfGeb6fftJ/LHfThcXv26B13sOoClykBFwK2w4z1tMmish4Z9XqE4oR71RfXCX7sB4SAsnBEG/g57dVa4XlcyWatLoQBXiL/jwwPBQQrACMh7QWAg7EAbeNfbrNd8BgxELuqFksvWU7GQGGkbBsFRhkXuTNS7hQ2ybMavZLMv863qHEEzo0W1rugfhd+v21jYPDPc4PXybsZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPfYH99InzV9MvhdLTus7a7tBKF88V3igWEiRPnxo4=;
 b=dqxd9GsuDuYPFPKMrpxwMSYlTHl2WqI4lLR/kqb0f/D2dlBrCRyHXRWEY76SSp+2gtPpzIbMST0zHMjY+x11/h5NBD5dCHOXLD/OQ8DTMJSAAD12JnTWPcFJ98Q7VibuIT8Hl1cNgSW6FZpilg4zSRVm+5xXbbrLHV17YFwHZKYUAnm8alGM3ecJBxnXlCUDtZZKhRiebfyTuvf1azzBfi/LRrYTg1TQkZuZJRz5mmY+chvM3pYfeuTCFadEM7uiuoGacwSxTY9OPy9tr7rjXU6ojVCDbfzP+KoJwgcAmirDyYzv6XiDJx6Xq4iD7mZNOZPQ8pWSmTnUcx62ZkxesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPfYH99InzV9MvhdLTus7a7tBKF88V3igWEiRPnxo4=;
 b=F9INFXcBSTqQuiGpewUcc2A7sePsO2O932OodM4HTwQZkgxiUkMgflKh5j+sSjw9JuIKbFuZFzjwwDkA1dcQ1lvtkdu4AqOmLl6v/pFtvJ8j9sKNz5pqqTnsfJyc+xBX3XJJOdsiPji7ZUcbhmCJCi85eTZ1ROfV/JhoNntZEN4=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 7 Dec
 2020 22:06:27 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 22:06:26 +0000
Date:   Mon, 7 Dec 2020 22:06:24 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201207220624.GB6855@ashkalra_ubuntu_server>
References: <20201203032559.3388-1-Ashish.Kalra@amd.com>
 <20201207121007.GD20489@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207121007.GD20489@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:806:d2::8) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by SA0PR11CA0063.namprd11.prod.outlook.com (2603:10b6:806:d2::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 22:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ef5675c-3c90-4489-1204-08d89afc57e2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25122892EAF28163CC0F509C8ECE0@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWA2ZMWRH3MjKZiUKrncwUB+KvBgPUCgfdENsqoiJ06RZ5aSnVfjBhU47zkTm/7JYnmlKk8qYG3zZGkZmG5kSk6ofM0SkhoG/BpHTcfwn2Usiag3TPBsICNxXZNJ3v9Cv/VVOxNvVFFU6t/zXl2QZzAO+M9bdUcPnTcosJAchu5upFK77iwrW9X7cpEQ1ht7PTfSeZWnXDc6V83XwNtkED80WZKYfWzBfYgng5Yuvs+0Tz4r3i6xQ4e2NbivYmsFWzP7ARJuQufsJqnbCJR8hy/IVQqaJvW0G1/LCwVCKxDxKbj2hEQR1cy0LCE7gsWUhMnAFLo1d5xnSFj7XGbM+VrN8PmpKr9AyUOy++ihpPY2Wxz5QQiGXurit6G+PUcXCvq0zA2Yn7slAc8DAjM2Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(86362001)(33656002)(478600001)(9686003)(26005)(966005)(83380400001)(2906002)(44832011)(186003)(8676002)(52116002)(66476007)(1076003)(16526019)(66946007)(8936002)(7416002)(33716001)(66556008)(316002)(45080400002)(956004)(4326008)(6496006)(6916009)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vu1KE1s9xPP7eM+1tVAPge65dNeWxz9oWBUcPbaBLxSyK0w4a2kfq10w0mgt?=
 =?us-ascii?Q?CJqkSZap+N8hbDufwk5tmPYqvrWHmfdkvjjVouLaK1v71UT/JbUpV4TNkhvt?=
 =?us-ascii?Q?K5lLpRyWDLQvQXoUqwA7WAtYJB1YKUItEj09Tfs+Ft1TrV+fhqG8OZpfkoVL?=
 =?us-ascii?Q?QU+RRpZ0EYxfH0o0zV3lPfdzwgNf8y+Ync6M1caNtImVECQX3VwIdZXQanCy?=
 =?us-ascii?Q?fIp+oemGk3+Xc4MQJyiKpZ6diH4+CraT4vT1QdTSswr0cQN9uFyMpasjyDLp?=
 =?us-ascii?Q?w2JiHVH4pnR3yutXCAFME4QtYwAvgm+7ouxPeihRrz646v2qoc0UZLFmuVPi?=
 =?us-ascii?Q?zKo5X7A5ISfHP1u2/GC4kGymhtXKP8uNM2Uqe6CUvhS0doKZ2QGNHRWpvsoO?=
 =?us-ascii?Q?t7IUX7VwgpxbwS8nXhak/N1xMZ/bC0dNvPpFjL60aoVs9KjO+kh1rqugPD8k?=
 =?us-ascii?Q?s/iIoGc4P6DJ1Ntfy8yGtoolEwDa43v1Z3EmJPpKmFQyPjYLpnGHMvUprWkF?=
 =?us-ascii?Q?BXQewDVReyNq0Ga0UZD2j29jw95CKeFH3HpDg2V7gwPF19VgjI+0sKch8vXJ?=
 =?us-ascii?Q?wG6zLj0CNljl2C3l2PlB4RGTSZnk4QKgEiZOIHcFtDyavYci+k/4+OgT9Oim?=
 =?us-ascii?Q?mN9RdzlLdm9XhxKeHgAQs4t/VEv7v7dBn+AdjnMd/whcy5Juu1OIe/fIR1mh?=
 =?us-ascii?Q?KNW2NUIETJdISIwQzRCNxVWEuX4AwAIugS6REmAZX8EmYf1ojTYQli6BCi8z?=
 =?us-ascii?Q?TVg9xCSLDVa+/kVvcNXaoaneFUjizLjQA/n7IToSeSF/Q5fxeLYyFIBPDvPs?=
 =?us-ascii?Q?G9lGceKuuGnF9GlVL80mQ9d3pL2r5CRULEvHtzSbAaDDe/4DzxMsy7CrkSpn?=
 =?us-ascii?Q?cT1JtyRQ80Bkz9l/a+/JzNRXWzDzvWTQRwxCu522WHg0GGjj2qZt+NUzUJC0?=
 =?us-ascii?Q?pQCaOY0ctuzbSI3tphcGf7iKki5jrHKNGCon6n412mNhgytKix6Et8zUZkEQ?=
 =?us-ascii?Q?LAdr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 22:06:26.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef5675c-3c90-4489-1204-08d89afc57e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HL+KzgQj2xyMNd3CS1QREwqaydWnVB20+J/fCfITq3k1lq6AfeTHdALJGJ7+Qc529nGma7S7PF8jJoeuzd0Ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Boris, 

On Mon, Dec 07, 2020 at 01:10:07PM +0100, Borislav Petkov wrote:
> On Thu, Dec 03, 2020 at 03:25:59AM +0000, Ashish Kalra wrote:
> > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > index 1bcfbcd2bfd7..46549bd3d840 100644
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -485,7 +485,38 @@ static void print_mem_encrypt_feature_info(void)
> >  	pr_cont("\n");
> >  }
> 
> Any text about why 6% was chosen? A rule of thumb or so? Measurements?
>

This is related to the earlier static adjustment of the SWIOTLB buffers
as per guest memory size and Konrad's feedback on the same, as copied
below : 

>>That is eating 128MB for 1GB, aka 12% of the guest memory allocated statically for this.
>> 
>> And for guests that are 2GB, that is 12% until it gets to 3GB when 
>> it is 8% and then 6% at 4GB.
>> 
>> I would prefer this to be based on your memory count, that is 6% of 
>> total memory. 

Thanks,
Ashish

> > +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT	6
> > +
> >  /* Architecture __weak replacement functions */
> > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > +{
> > +	unsigned long size = iotlb_default_size;
> > +
> > +	/*
> > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > +	 * SEV uses SWOTLB to make this happen without changing device
> > +	 * drivers. However, depending on the workload being run, the
> > +	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
> > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > +	 * performance degradation especially with high I/O workloads.
> > +	 * Adjust the default size of SWIOTLB for SEV guests using
> > +	 * a percentage of guest memory for SWIOTLB buffers.
> > +	 * Also as the SWIOTLB bounce buffer memory is allocated
> > +	 * from low memory, ensure that the adjusted size is within
> > +	 * the limits of low available memory.
> > +	 *
> > +	 */
> > +	if (sev_active()) {
> > +		phys_addr_t total_mem = memblock_phys_mem_size();
> 
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense:
> 
> WARNING: Missing a blank line after declarations
> #95: FILE: arch/x86/mm/mem_encrypt.c:511:
> +               phys_addr_t total_mem = memblock_phys_mem_size();
> +               size = total_mem * SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> 
> But no need to resend now - just a hint for the future.
> 
> Konrad, ack?
> 
> On a 2G guest here, it says:
> 
> [    0.018373] SWIOTLB bounce buffer size adjusted to 122MB for SEV
> 
> so it makes sense to me.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CAshish.Kalra%40amd.com%7C5c7096203e774538383308d89aa95b4a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637429399488203154%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=G8JOTIQ5eVyOU50iBAI3%2FotUlGV1EBuOZectZNWlUyE%3D&amp;reserved=0
