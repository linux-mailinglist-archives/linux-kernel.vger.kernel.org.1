Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5531D7A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgERNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgERNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:42:34 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2335C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:42:33 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 336D3386; Mon, 18 May 2020 15:42:31 +0200 (CEST)
Date:   Mon, 18 May 2020 15:42:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
Subject: Re: [PATCH] iommu/mediatek-v1: Add def_domain_type
Message-ID: <20200518134229.GD18353@8bytes.org>
References: <1589530123-30240-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589530123-30240-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:08:43PM +0800, Yong Wu wrote:
> The MediaTek V1 IOMMU is arm32 whose default domain type is
> IOMMU_DOMAIN_UNMANAGED. Add this to satisfy the bus_iommu_probe to
> enter "probe_finalize".
> 
> The iommu framework will create a iommu domain for each a device.
> But all the devices share a iommu domain here, thus we skip all the
> other domains in the "attach_device" except the domain we create
> internally with arm_iommu_create_mapping.
> 
> Also a minor change: in the attach_device, "data" always is not null.
> Remove "if (!data) return".
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> a. rebase on linux-next.
> b. After this patch and fixed the mutex issue(locally I only move
>    mutex_unlock(&group->mutex) before __iommu_group_dma_attach(group)),
>    the mtk_iommu_v1.c could work normally.
> ---
>  drivers/iommu/mtk_iommu_v1.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied, thanks.
