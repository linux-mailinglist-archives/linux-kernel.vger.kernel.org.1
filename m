Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D185426F86C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIRIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:36:22 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D954C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:36:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CE2BF396; Fri, 18 Sep 2020 10:36:19 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:36:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix potential @entry null deref
Message-ID: <20200918083618.GF31590@8bytes.org>
References: <20200910171621.12879-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910171621.12879-1-joao.m.martins@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:16:21PM +0100, Joao Martins wrote:
> After commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn bit after
> programming IRTE"), smatch warns:
> 
> 	drivers/iommu/amd/iommu.c:3870 amd_iommu_deactivate_guest_mode()
>         warn: variable dereferenced before check 'entry' (see line 3867)
> 
> Fix this by moving the @valid assignment to after @entry has been checked
> for NULL.
> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Fixes: 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn bit after programming IRTE")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied for v5.9, thanks.
