Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E063D29F58E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJ2Ttg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:49:36 -0400
Received: from mail-mw2nam12on2135.outbound.protection.outlook.com ([40.107.244.135]:48416
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgJ2Ttf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBpSDPl+1rfbYGb7V1VtwQjBkDzX1PDLPhCU9rjY4I+CadFwHvOgk+f0JS7fB5RO5DRVTEYvbVWRkfZ4W43gZ/0BMongkN0BgfqprHkT2oLNuleVcGakOHKneB1XkMucToIisLtAVIY+xBSKORu4MGbl+bngiVoYHJU2Hzp1GA/pCpBYfR1Zk/i0mra/EcJrkeZQuUkQw0PDYMioxtr8BbgD+Nvl8wrMFfFw8sCtUV00Pd7pFpQontzxRAhiQRpvzVFqMmoQBpJ8Rddx8vX+vA5zDcyUlq0LSJ8bzQNphPONMa3wVJzLZBl8OIIxI6Chcy7FkJ7RchFvV3CBXvqDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bXmT7Vp4VxZ3OtZ8RszKXEPqxO7z8tif8eIQdU2L/A=;
 b=gb9zcIR7E6H07l/ZluXYylWNDsB0Sjy428p8j6p2gZtbaPoCVO4Y8zov1CH26uGcHy6Lrq/0irza/2SdaBzygskTgCh8fpRMtCPB4CPGhIc9UH1iBqEUX1Y26ZnrG0IFeDIganVLnNHxXljmckNHzH1Ji7GfTz7JCTfg25meaGrdjqc5fBFpNwAC3ZzBTVCMEb2N2vInV6TQE4VIJFixy3C1qf3F5flDzoJjCcxuvycfK7iYpWHtsFjSM3FMV52t+X6r+mgEkd/twb2ZQqxWLFQ0cwjMPz9hUN1YPXDEEfmsJXRWa9cdreIbRONeUeA5e8LEzVbdEX+fMGR2ueBwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bXmT7Vp4VxZ3OtZ8RszKXEPqxO7z8tif8eIQdU2L/A=;
 b=Dkg7Sw8ia0M2wmqoODBr2V6+wPbuxVG9vGLsEdohF939zT4cy04UesJnEINyY19MPJXi3UjyJ7LwgmQmKW+BpO043+1BtyPqxMgTzGfGhU5JhhdRTHMyPh+vfThqA2KpktfBpmGNcjqs5eX653T/H9nTPEIkLYtNDvkH2JfZa54=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN8PR01MB5474.prod.exchangelabs.com (2603:10b6:408:b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Thu, 29 Oct 2020 19:48:53 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 19:48:53 +0000
Date:   Thu, 29 Oct 2020 12:48:50 -0700
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201029194850.jon6lxlbhquy7zql@con01sys-r111.scc-lab.amperecomputing.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
 <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
 <jhj5z73qkkq.mognet@arm.com>
 <20201029133709.GE10776@gaia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201029133709.GE10776@gaia>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:903:18::13) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:903:18::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 19:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d3f131-1394-4d3b-363a-08d87c43a9cc
X-MS-TrafficTypeDiagnostic: BN8PR01MB5474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR01MB54740C030386E1C4686A5D1F9D140@BN8PR01MB5474.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4HvEjS5bvYV/ifym0TPpm9nx4XYwnWVLC20J0sEKeX3VRSgsxPxtoZ+aSePPDa1IA9wDQCwQ0eU6dcA1g3UXAGMLQR8+eQyKvgKhZSqPrs/K6fpuTv6DtB+3qXa07AsDodFU0sf+4gh111ND1FuOkNxT/J22snGdcDvmu53bb0tFOO0PYhADhhHrg7U9ZG/6LMfMZ4I69T0fstdEbtBWPwyGr8Zr3HICdfak/ozvto/cVTSBi8DypRNy+26TBH55+mKyZr+0w29GhC67yZQsXKd7f4jBntDtRciBorLtshEMgGaPRzs/C8+FykxXQLObagglv1zvjFNz1og4uCuBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(54906003)(316002)(6486002)(478600001)(1076003)(6916009)(26005)(186003)(66556008)(53546011)(16526019)(66476007)(66946007)(52116002)(6496006)(9686003)(2906002)(8676002)(8936002)(86362001)(4326008)(83380400001)(956004)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: L8AKZGCd02nGFBArwwRPKW/5wRjoffVwlNZ7wUoQnGAR5o1BbEl/ZCfGl53+MVaE6SA4ATDvn8+KxiqI70KsxtxDNmaP21pZHngEjW+hmRBBbMxe1Cxi9aTlx4DXOse0vE8ogZEzF8irbLSNq7tBkH/CGkmoG8OJMx6c8bRfUoWqPd3mxrbkCDU1CcsbsQGEAc4aSN0BvTVsUFmQuF2YfHf0JpvkKNni+ITRrlAIWMo7fpjZ5tsTH4SY79wIPqHgH+R+nt6aR46aMxpijFLf4fys+gb389BxV/9ZQ1+wR6RNBn3HQDins3chUKNxT7YtFZ1DJ/Lv0bk4GKtl0pqCQW6xsPI/MICe2mBB3/DZ3URBNSeqxOGzJgTRoMzU6qzhI8rrbz9dn8CjSif97Fshw7xs4xt5YPwvWFHwzBanVSlr6hZ40rjKPZTUIkAEndb2ZjlN3TsiscIkm5p78NM0E/R8fAc05NcPgBBuY0jmkf98/XgN9K3KDn9oxij/jl5vO3Dn/obvn61Q+TUY//3nA7MIopgR912iTNKRn0cd7hOD84zDhNS+7LgOMZeeiYglQe6Z1cn13ZXhpih1HW51gY5omQxPPjbbPvBtn7tWBh1/XV1bOgAf9kG1wU/4iA37oe32jtjCW4fQxtaxYU7Ohg==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d3f131-1394-4d3b-363a-08d87c43a9cc
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 19:48:53.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+cuS9EL8S2kSpVkuMFQgte85pR34jDKUwz9yeCOKn0CzXvuK7V41BnzzDvBo6yKfyh7G4A5klEraXL8f3mph8tvuSV5gvhvoYk9zfw/7loUyW8px783b1nWhAl4gOst
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5474
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:37:10PM +0000, Catalin Marinas wrote:
>On Wed, Oct 21, 2020 at 11:29:41PM +0100, Valentin Schneider wrote:
>> On 21/10/20 12:02, Jonathan Cameron wrote:
>> > On Wed, 21 Oct 2020 09:43:21 +0530
>> > Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>> >> Agreed. Do we really need to match X86 right now ? Do we really have
>> >> systems that has 64 nodes ? We should not increase the default node
>> >> value and then try to solve some new problems, when there might not
>> >> be any system which could even use that. I would suggest increase
>> >> NODES_SHIFT value upto as required by a real and available system.
>> >
>> > I'm not going to give precise numbers on near future systems but it is public
>> > that we ship 8 NUMA node ARM64 systems today.  Things will get more
>> > interesting as CXL and CCIX enter the market on ARM systems,
>> > given chances are every CXL device will look like another NUMA
>> > node (CXL spec says they should be presented as such) and you
>> > may be able to rack up lots of them.
>> >
>> > So I'd argue minimum that makes sense today is 16 nodes, but looking forward
>> > even a little and 64 is not a great stretch.
>> > I'd make the jump to 64 so we can forget about this again for a year or two.
>> > People will want to run today's distros on these new machines and we'd
>> > rather not have to go around all the distros asking them to carry a patch
>> > increasing this count (I assume they are already carrying such a patch
>> > due to those 8 node systems)
>>
>> I agree that 4 nodes is somewhat anemic; I've had to bump that just to
>> run some scheduler tests under QEMU. However I still believe we should
>> exercise caution before cranking it too high, especially when seeing things
>> like:
>>
>>   ee38d94a0ad8 ("page flags: prioritize kasan bits over last-cpuid")
>>
>> To give some numbers, a defconfig build gives me:
>>
>>   SECTIONS_WIDTH=0 ZONES_WIDTH=2 NODES_SHIFT=2 LAST_CPUPID_SHIFT=(8+8) KASAN_TAG_WIDTH=0
>>   BITS_PER_LONG=64 NR_PAGEFLAGS=24
>>
>> IOW, we need 18 + NODES_SHIFT <= 40 -> NODES_SHIFT <= 22. That looks to be
>> plenty, however this can get cramped fairly easily with any combination of:
>>
>>   CONFIG_SPARSEMEM_VMEMMAP=n (-18)
>>   CONFIG_IDLE_PAGE_TRACKING=y (-2)
>>   CONFIG_KASAN=y + CONFIG_KASAN_SW_TAGS (-8)
>>
>> Taking Arnd's above example, a randconfig build picking !VMEMMAP already
>> limits the NODES_SHIFT to 4 *if* we want to keep the CPUPID thing within
>> the flags (it gets a dedicated field at the tail of struct page
>> otherwise). If that is something we don't care too much about, then
>> consider my concerns taken care of.
>
>I don't think there's any value in allowing SPARSEMEM_VMEMMAP to be
>disabled but the option is in the core mm/Kconfig file. We could make
>NODES_SHIFT depend on SPARSEMEM_VMEMMAP (there's DISCONTIGMEM as well
>but hopefully that's going away soon).
>
>> One more thing though: NR_CPUS can be cranked up to 4096 but we've only set
>> it to 256 IIRC to support the TX2. From that PoV, I'm agreeing with
>> Anshuman in that we should set it to match the max encountered on platforms
>> that are in use right now.
>
>I agree. Let's bump NODES_SHIFT to 4 now to cover existing platforms. If
>distros have a 10-year view, they can always ship a kernel configured to
>64 nodes, no need to change Kconfig (distros never ship with defconfig).
>
>It may have an impact on more memory constrained platforms but that's
>not what defconfig is about. It should allow existing hardware to run
>Linux but not necessarily run it in the most efficient way possible.
>

 From the discussion it looks like 4 is an acceptable number to support
current hardware. I'll send a patch with NODES_SHIFT set to 4. Is it 
still possible to add this change to the 5.10 kernel?

Vanshi

>-- 
>Catalin
