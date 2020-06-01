Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A101EA792
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 12:09:35 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:20515 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgFAQJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:09:34 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 3A87A203BF;
        Mon,  1 Jun 2020 19:09:29 +0300 (MSK)
Date:   Mon, 1 Jun 2020 19:09:29 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
Message-ID: <alpine.LNX.2.20.13.2006011903210.16067@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru> <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com> <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru> <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of blindly moving the code around to a spot that would just work,
> I am trying to understand what might be required here. In this case,
> the init_device_table_dma()should not be needed. I suspect it's the IOMMU
> invalidate all command that's also needed here.
> 
> I'm also checking with the HW and BIOS team. Meanwhile, could you please give
> the following change a try:

Yes, this also fixes the problem for me.
Alexander

> 
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
