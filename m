Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FAE2299E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgGVOO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 10:14:56 -0400
Received: from 8bytes.org ([81.169.241.247]:58728 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgGVOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:14:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 204A0367; Wed, 22 Jul 2020 16:14:55 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:14:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Eric Auger <eric.auger@redhat.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Make some functions static
Message-ID: <20200722141453.GL27672@8bytes.org>
References: <20200713142542.50294-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713142542.50294-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:25:42PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/iommu/iommu.c:386:5: warning:
>  symbol 'iommu_insert_resv_region' was not declared. Should it be static?
> drivers/iommu/iommu.c:2182:5: warning:
>  symbol '__iommu_map' was not declared. Should it be static?
> 
> Those functions are not used outside of iommu.c, so mark them static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

