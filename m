Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF752B71C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgKQWlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:41:07 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0787720709;
        Tue, 17 Nov 2020 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652866;
        bh=aesflSSYIio9RUvTzHtgIgEoBgRRVoXJ8Ijz+a/sfyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uS3dCUKL6WFxURM7zFODhozxOOvUIRtS5/nhXQgMIIRf00VUQ+S2X+GvIrcTVSiNf
         tsRxeURBO1Q2jzx7d7dPMBxKja0S1W9Am/ZpO07cm3BAMZlZBvCfQ9S1TRLVRBgHum
         53Aa+N9+/selE+q+CxLJsVann3TpX5J16I2ODveI=
Date:   Tue, 17 Nov 2020 22:41:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
Message-ID: <20201117224102.GD524@willie-the-truck>
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
 <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
 <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:11:28PM +0800, Yang Yingliang wrote:
> On 2020/11/17 17:40, Lu Baolu wrote:
> > On 2020/11/17 10:52, Yang Yingliang wrote:
> > > If iommu_group_get() failed, it need return error code
> > > in iommu_probe_device().
> > > 
> > > Fixes: cf193888bfbd ("iommu: Move new probe_device path...")
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   drivers/iommu/iommu.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index b53446bb8c6b..6f4a32df90f6 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
> > >           goto err_out;
> > >         group = iommu_group_get(dev);
> > > -    if (!group)
> > > +    if (!group) {
> > > +        ret = -ENODEV;
> > 
> > Can you please explain why you use -ENODEV here?
> 
> Before 79659190ee97 ("iommu: Don't take group reference in
> iommu_alloc_default_domain()"), in
> 
> iommu_alloc_default_domain(), if group is NULL, it will return -ENODEV.

Hmm. While I think the patch is ok, I'm not sure it qualifies as a fix.
Has iommu_probe_device() ever propagated this error? The commit you
identify in the 'Fixes:' tag doesn't seem to change this afaict.

Will
