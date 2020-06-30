Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F020F276
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbgF3KRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 06:17:43 -0400
Received: from 8bytes.org ([81.169.241.247]:50734 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732259AbgF3KRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:17:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C6A72A7; Tue, 30 Jun 2020 12:17:40 +0200 (CEST)
Date:   Tue, 30 Jun 2020 12:17:39 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] iommu: move sg_table wrapper out of CONFIG_IOMMU_SUPPORT
Message-ID: <20200630101738.GN28824@8bytes.org>
References: <CGME20200630081806eucas1p2a9a0ecae69dfe3306092aff30e21cb5c@eucas1p2.samsung.com>
 <20200630081756.18526-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630081756.18526-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 10:17:56AM +0200, Marek Szyprowski wrote:
> Move the recently added sg_table wrapper out of CONFIG_IOMMU_SUPPORT to
> let the client code copile also when IOMMU support is disabled.
> 
> Fixes: 48530d9fab0d ("iommu: add generic helper for mapping sgtable objects")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/iommu.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Applied, thanks (not for v5.8, as there seem to be no users yet).

