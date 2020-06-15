Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862A1FA1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgFOUs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:48:58 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:13370 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729692AbgFOUs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:48:58 -0400
Received: from [10.10.3.121] (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id CF78A203BF;
        Mon, 15 Jun 2020 23:48:53 +0300 (MSK)
Date:   Mon, 15 Jun 2020 23:48:52 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
Message-ID: <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru> <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com> <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru> <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:

> Alexander
> 
> On 6/1/20 4:01 PM, Alexander Monakov wrote:
> > On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:
> > 
> > > > Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
> > > > the issue. This is the earliest point in amd_iommu_init_pci where the
> > > > call succeeds on my laptop.
> > > 
> > > According to your description, it should just need to be anywhere after
> > > the
> > > pci_enable_device() is called for the IOMMU device, isn't it? So, on your
> > > system, what if we just move the init_iommu_perf_ctr() here:
> > 
> > No, this doesn't work, as I already said in the paragraph you are responding
> > to. See my last sentence in the quoted part.
> > 
> > So the implication is init_device_table_dma together with subsequent cache
> > flush is also setting up something that is necessary for counters to be
> > writable.
> > 
> > Alexander
> > 
> 
> Instead of blindly moving the code around to a spot that would just work,
> I am trying to understand what might be required here. In this case,
> the init_device_table_dma()should not be needed. I suspect it's the IOMMU
> invalidate all command that's also needed here.
> 
> I'm also checking with the HW and BIOS team. Meanwhile, could you please give
> the following change a try:

Hello. Can you give any update please?

Alexander

> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 5b81fd16f5fa..b07458cc1b0b 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1875,6 +1875,8 @@ static int __init amd_iommu_init_pci(void)
>                 ret = iommu_init_pci(iommu);
>                 if (ret)
>                         break;
> +               iommu_flush_all_caches(iommu);
> +               init_iommu_perf_ctr(iommu);
>         }
> 
>         /*
> --
> 2.17.1
> 
> Thanks,
> Suravee
> 
