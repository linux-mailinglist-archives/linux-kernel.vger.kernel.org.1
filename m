Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2C2F9E04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbhARLYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390217AbhARLWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:22:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11201221FF;
        Mon, 18 Jan 2021 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610968891;
        bh=f7slgC3FybDChj4RgWx/+lOIZ+uIiteGAYHQ8oorWy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqVL7gdAFxJseTnv/KHUNnT6Jm7jXOVXD09MZcwKcTam0E9x8k6bte9kJ+qgDDIue
         4nDfanXk43ign34DCyhFvOBPnE3kxZoWOKqfSCvFzRbUSLeIPZ+ymYOGxmq/S37TpM
         RZJdTDD+rJbr7CWEm7sa45n1NtYGOXuDjCcLBjtaEFKrIOrpPHBTF7yRrntPolCXzs
         fSBupA9l4YyXMrIwSj22DOQYbza0qHm/mNZ1oSf4+bHQF+BRmgk6mgeZLRuY5HmIVr
         Vo1VepR3MR2d212OymR40qcT45y3ufy6PeZBHoRJg1gfYy8xuqjMXOqwb/LtNgGk0V
         srap3RxV9Ggcw==
Date:   Mon, 18 Jan 2021 11:21:26 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/6] IOMMU: Some more IOVA and core code tidy-up
Message-ID: <20210118112126.GA16500@willie-the-truck>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 09:35:05PM +0800, John Garry wrote:
> Just some tidy-up to IOVA and core code.
> 
> Based on v5.11-rc2
> 
> Differences to v1:
> - Add core IOMMU patches
> 
> John Garry (6):
>   iova: Make has_iova_flush_queue() private
>   iova: Delete copy_reserved_iova()
>   iova: Stop exporting some more functions
>   iommu: Stop exporting iommu_map_sg_atomic()
>   iommu: Delete iommu_domain_window_disable()
>   iommu: Delete iommu_dev_has_feature()
> 
>  drivers/iommu/iommu.c | 21 ---------------------
>  drivers/iommu/iova.c  | 36 +-----------------------------------
>  include/linux/iommu.h | 13 -------------
>  include/linux/iova.h  | 12 ------------
>  4 files changed, 1 insertion(+), 81 deletions(-)

For the series:

Acked-by: Will Deacon <will@kernel.org>

Will
