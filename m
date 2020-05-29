Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031FD1E7EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2N2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2N2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:28:46 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2353CC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:28:46 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F0E2A327; Fri, 29 May 2020 15:28:43 +0200 (CEST)
Date:   Fri, 29 May 2020 15:28:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix reference count leak in iommu_group_alloc.
Message-ID: <20200529132842.GG14598@8bytes.org>
References: <20200527210020.6522-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527210020.6522-1-wu000273@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 04:00:19PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> kobject_init_and_add() takes reference even when it fails.
> Thus, when kobject_init_and_add() returns an error,
> kobject_put() must be called to properly clean up the kobject.
> 
> Fixes: d72e31c93746 ("iommu: IOMMU Groups")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
