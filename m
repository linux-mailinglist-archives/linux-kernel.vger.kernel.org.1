Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237372B27EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKMWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:10:11 -0500
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:16896
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbgKMWKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:10:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfmwH7LUBScNWTJm2qfyr3wnjRuw3XkpvB/epYuDW1KWNnp7iNMh2D4MArlp6s1TEFj2wzPL5bId6y4OE59g+xJ4yozp1egRKuyj38DSi9r2xs884zJ7ggqpta37WrCiyt1gyOc+P3JmN5C+za9cyLa47SVypkTbgGwB2+EY96g5fzdRiSess+M3Pjux/mzd+SE3YTi5r3EKFAJ6tlMBm0qNNkkPp4afdS+73skeMuFDGmxur/iQ8W9Jsxo0kaezjOpwPFq10PwSl9aBm8AARwqOsAngTPzb4pD/+VnBAsWdktjWe0G8Q2be+NRAoaSQoaZDMrW6qPh95OowHIvSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a81Va9lo7CAN5tIAfIVErNrH13AasOKMKyzK1MXaMP4=;
 b=RdKCdS1ZBjtsi7Aip6MrjjV3IYMjCFt8q0tjHZK+wBdzDTtFAYi1K+1z/pqYHXl/V2ERrN1HlXJdHW9FsF1pb7OQoml+WPXgXQ3JYjtQ/lzFoXyZ32Ck5HxNwh4/aPHdmmHQlem0jmdIk96OztkPbc2HRuvkkvJ1RfMd8XqHH9ayfNTnA+Nx/hudM0QHzf6OzFjqgwBTmfLr0i8UFr8G3mtZ4Au4vUOczw5FB3noF+HwYI5u+nwbMhZJI1w4MILYyMveMIGmdI8PzTBNf+uEty3W+3osXhkVEliCoTT1pqP+MVzAKCpX1CpgkeQOQCNwBGGL2jt4uOHW04E4459FXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a81Va9lo7CAN5tIAfIVErNrH13AasOKMKyzK1MXaMP4=;
 b=JUqNBjZSgVMIiu6cgsGxS9udaltxOPA2sGAoiyZ5HjPOPNeNwIGUyQm+r3iahUQTG3AZuQuUE13m5Eb/w8Hk7nhIQjZ1/1OB4H13ttghsYQe1xEreasT38d1vNlJn//Nfn7kHbDmZiFfmio0Cg+PuZKyCXLcUhYRzlzwZHlFb4Q=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 22:10:07 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 22:10:07 +0000
Date:   Fri, 13 Nov 2020 22:10:00 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com,
        ssg.sos.patches@amd.com
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201113221000.GA6850@ashkalra_ubuntu_server>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113211925.GA6096@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0032.namprd21.prod.outlook.com
 (2603:10b6:3:ed::18) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.11 via Frontend Transport; Fri, 13 Nov 2020 22:10:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 704cf210-1a1d-4b2c-4e72-08d88820e13b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384BFFDC3F0D8A8B37B85878EE60@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/q4CuYuhOhxJkQjhP1I4NhaakWJzv0UzGQk7INCgi2y7eDM/MuxTkKa6uUav2Ph48cKhfgXEEqTw2BI6u4KCD2OuLwYiktEjJ3r29/K/KtRtHUZKov7We/heGRnavp2uIlOsBJhNfFm7xWaHHAYIKDCaAJRSo8B6duZvvQs5hjQ2xTABmtSpkeJmCTuI8mTffdK9hNWEaMP7g47DO6mEka29ridVA8hxIePzOhfHlWGR0saTSN7d+kKPoqyvJmkctGjxlIrppx6+ABU3dP2Cqr59RnlBDztbQu1Hxl7UxxmSb6sUSsQ0xSeEH1nZuHqIOuJQjaX4Jm3/6pZDBzLCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(44832011)(6496006)(316002)(6916009)(4326008)(52116002)(2906002)(16526019)(8676002)(66946007)(7416002)(5660300002)(956004)(55016002)(66476007)(6666004)(86362001)(478600001)(9686003)(8936002)(33716001)(66556008)(186003)(1076003)(33656002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3qIyDGUOjvs1391qDy3mPl1gYQg9AKbiBvpPQtND92hguoKKlPM4UF1dvRaBjQl+voZmrwtORt0LQOjJl9yTVwymGylwwMZudBTs2f8McwfhALnMvtmeJ+LEg7noSJYKMdrFZsq/qNmQbSQCX7nXUaz/bqQfw9ddih4YbC9Vo3P1yZzl1jrXQBvTS/b1D8FFyM48/P7xBM5zOSD6yvfb9uZQQmexQ/ZS3CwNcYSX58n77CpkjWiONY6G+ktFqvhqFaYzMPj0ivskSdwpWpuL16CuC8D9uGir/EwbqgGZiSpJlqR+oNOz5pxX4JAO/GOXelxs7fi5zTQQMFdj2BGdSLSHu+dVdYyfPSjDc7i1SlPngPcIdTtV+Q34MnD35Y0RmNGviktWyG9X8GAkAudnjiJMee+Cx9PBnIoxFJARUuhh+ghZ7TiwBmlusmKO+c+XX41o1xpiNrRfc+MiNdnAPysFf5zu96mcBekGmCdiEBxclE2UifTgD2ZmYVyxN6ULXYVvjddLHBRChWoqhNWLb/9X14v3C2xTjYk5JM16bCP53eOGqE7hYUHppAGcn8VhhWwDrUZ4Au+fsn2IHGsuK5HoXowPkgNNBGM+pOacg2fnvZJmyjq4orGsanFoQL81V3o6BaxZbDqvdnROAJY9ErcQ6CLorBwGR17qUQu5tOjVKePc2q4DsSw8fVm72uc3lPYAs2S32QppskW//SwMB3/o/Jgz4IVm0Vym5ASBP2x1ktvIvCysbrT0mSkqkN2zWFnpTOChcr6VJ5M1xMZVB3SS4Z4eEpleqwXv2ow4SJ4PujJhr5svUWnaZhlJZGdMBvmHxob3Vpis1epocFWnX/hdUDO+0R7HUJSBNY+71DPwqoCg+uAoFT11dRLBmBDU4Mox4vCslY0ds7nmE/P9vA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704cf210-1a1d-4b2c-4e72-08d88820e13b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 22:10:07.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n1wYure6R8xtgLISua+MubYaTcy8wrFF01PupeRB+pxO+lLfCsuYAITtplmxjXxscQdz11L6PXHtWAI+rdDbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Konrad,

On Fri, Nov 13, 2020 at 04:19:25PM -0500, Konrad Rzeszutek Wilk wrote:
> On Thu, Nov 05, 2020 at 09:20:45PM +0000, Ashish Kalra wrote:
> > On Thu, Nov 05, 2020 at 03:20:07PM -0500, Konrad Rzeszutek Wilk wrote:
> > > On Thu, Nov 05, 2020 at 07:38:28PM +0000, Ashish Kalra wrote:
> > > > On Thu, Nov 05, 2020 at 02:06:49PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > .
> > > > > > > Right, so I am wondering if we can do this better.
> > > > > > > 
> > > > > > > That is you are never going to get any 32-bit devices with SEV right? That
> > > > > > > is there is nothing that bounds you to always use the memory below 4GB?
> > > > > > > 
> > > > > > 
> > > > > > We do support 32-bit PCIe passthrough devices with SEV.
> > > > > 
> > > > > Ewww..  Which devices would this be?
> > > > 
> > > > That will be difficult to predict as customers could be doing
> > > > passthrough of all kinds of devices.
> > > 
> > > But SEV is not on some 1990 hardware. It has PCIe, there is no PCI slots in there.
> > > 
> > > Is it really possible to have a PCIe device that can't do more than 32-bit DMA?
> > > 
> > > > 
> > > > > > 
> > > > > > Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
> > > > > > when there is I/O pressure, because we do need to support device
> > > > > > passthrough of 32-bit devices.
> > > > > 
> > > > > Presumarily there is just a handful of them?
> > > > >
> > > > Again, it will be incorrect to assume this.
> > > > 
> > > > > > 
> > > > > > Considering this, we believe that this patch needs to adjust/extend
> > > > > > boot-allocation of SWIOTLB and we want to keep it simple to do this
> > > > > > within a range detemined by amount of allocated guest memory.
> > > > > 
> > > > > I would prefer to not have to revert this in a year as customers
> > > > > complain about "I paid $$$ and I am wasting half a gig on something 
> > > > > I am not using" and giving customers knobs to tweak this instead of
> > > > > doing the right thing from the start.
> > > > 
> > > > Currently, we face a lot of situations where we have to tell our
> > > > internal teams/external customers to explicitly increase SWIOTLB buffer
> > > > via the swiotlb parameter on the kernel command line, especially to
> > > > get better I/O performance numbers with SEV. 
> > > 
> > > Presumarily these are 64-bit?
> > > 
> > > And what devices do you speak off that are actually affected by 
> > > this performance? Increasing the SWIOTLB just means we have more
> > > memory, which in mind means you can have _more_ devices in the guest
> > > that won't handle the fact that DMA mapping returns an error.
> > > 
> > > Not neccessarily that one device suddenly can go faster.
> > > 
> > > > 
> > > > So by having this SWIOTLB size adjustment done implicitly (even using a
> > > > static logic) is a great win-win situation. In other words, having even
> > > > a simple and static default increase of SWIOTLB buffer size for SEV is
> > > > really useful for us.
> > > > 
> > > > We can always think of adding all kinds of heuristics to this, but that
> > > > just adds too much complexity without any predictable performance gain.
> > > > 
> > > > And to add, the patch extends the SWIOTLB size as an architecture
> > > > specific callback, currently it is a simple and static logic for SEV/x86
> > > > specific, but there is always an option to tweak/extend it with
> > > > additional logic in the future.
> > > 
> > > Right, and that is what I would like to talk about as I think you
> > > are going to disappear (aka, busy with other stuff) after this patch goes in.
> > > 
> > > I need to understand this more than "performance" and "internal teams"
> > > requirements to come up with a better way going forward as surely other
> > > platforms will hit the same issue anyhow.
> > > 
> > > Lets break this down:
> > > 
> > > How does the performance improve for one single device if you increase the SWIOTLB?
> > > Is there a specific device/driver that you can talk about that improve with this patch?
> > > 
> > > 
> > 
> > Yes, these are mainly for multi-queue devices such as NICs or even
> > multi-queue virtio. 
> > 
> > This basically improves performance with concurrent DMA, hence,
> > basically multi-queue devices.
> 
> OK, and for _1GB_ guest - what are the "internal teams/external customers" amount 
> of CPUs they use? Please lets use real use-cases.

I will get back to you with some real use-case data for the above guest
configurations next week.

Thanks,
Ashish
