Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89E42EFEBD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAIJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbhAIJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 04:11:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D996AC06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oeFR1Ii2CLZIpiUQWYmQLIKPyDt1VC2/pWydszGRV/w=; b=LZxbf1Efb3bNU7b+f5f15xvaOt
        5j8L4J6R20ULrZTWXMp995e6CIY8qhN5/UNIpjjazBeK1xklHU6LrNVlmSt6v/xfKybx1v4GYDFMz
        AeW1ev7pb/Ite4VrBB4vFJv+3ccGeh/LbCyq3+S/LtBYm0Y2L+QgLK+G7HWDw5HcDw3TdzsfjM9xg
        jOb8TyUE4Q9vw1/URTs9QuSQIZD7EScVjVS3kJIdRI2ApeYw/qyfuHGMlF89RamJtZU6XutAegeTs
        ybYHZLyLjjsCCEMGTu6N5JU6oQt04R7fMrNRVkb+e0IlIB09hLfa7dXDpd58s//qRDrGGvArlLTaF
        RA+xHLqA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kyAFN-000Odv-OC; Sat, 09 Jan 2021 09:09:26 +0000
Date:   Sat, 9 Jan 2021 09:09:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
Message-ID: <20210109090921.GA93456@infradead.org>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
 <1609940111-28563-7-git-send-email-john.garry@huawei.com>
 <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:18:06AM +0800, Lu Baolu wrote:
> The typical use case is
> 
>         if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
>                 rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX);
>                 if (rc < 0) {
>                         dev_warn(dev, "Failed to enable aux-domain: %d\n",
> rc);
>                         return rc;
>                 }
>         }
> 
> So please don't remove it.

This doesn't have an upstream user, and did not have for years!  If
new users show up they can add it back.  Note that the above API with
a separate has vs enable is horrible anyway - the right way is to just
enable and fail it with a specific error code if not supported.

We have a general rule that APIs should only be introduced with their
users, and this example just confirms the reasons of why that rule is in
place once again.
