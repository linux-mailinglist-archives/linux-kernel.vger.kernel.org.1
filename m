Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6F21B5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGJNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 09:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgGJNFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:05:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D9C20748;
        Fri, 10 Jul 2020 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594386331;
        bh=EDql9LXT2itJkdhBRq+W0xaKADE3RTfhQuAty2vmxuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnRVM/8nu6yid3DGoPwuPeKeWJebZK5Gp9pEALAT1xgI2b0x1fade4Xmvt8jN7NXM
         1UFZgjEFLUyYtUD2ARniQ7l9C5exu7qfh8cKLJdz0qQdka4Z7dM95ETYShr8fyiusf
         7NM8UBJW94sAgoG0yolNnJEiHjitQugvwimRz5Sc=
Date:   Fri, 10 Jul 2020 14:05:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200710130526.GA30578@willie-the-truck>
References: <20200703162548.19953-1-will@kernel.org>
 <20200710125831.GI27672@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710125831.GI27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Fri, Jul 10, 2020 at 02:58:32PM +0200, Joerg Roedel wrote:
> On Fri, Jul 03, 2020 at 05:25:48PM +0100, Will Deacon wrote:
> > The IOMMU_SYS_CACHE_ONLY flag was never exposed via the DMA API and
> > has no in-tree users. Remove it.
> > 
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > As discussed in [1], sounds like this should be a domain attribute anyway
> > when it's needed by the GPU.
> > 
> > [1] https://lore.kernel.org/r/CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com
> > 
> >  drivers/iommu/io-pgtable-arm.c | 3 ---
> >  include/linux/iommu.h          | 6 ------
> >  2 files changed, 9 deletions(-)
> 
> Applied, thanks.

Ah, I'd already got this queued for 5.9:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

and I've queued a small number of patches on top of it now.

Are you planning to send it for 5.8? If so, I suspect I'll have to rebase.

Will
