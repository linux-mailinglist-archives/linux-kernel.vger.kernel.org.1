Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DB29E45C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgJ2HiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:38:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:55426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbgJ2Hh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:37:58 -0400
IronPort-SDR: 5uYCoCOJyEC5cqlUQRO/L8VrfAI0NWRnTGF2IStfLTLD1BBUrybN60MGAOdFrQ6RMvn7O1mW+p
 QPwbIrvTYDiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="147668490"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="147668490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 23:34:43 -0700
IronPort-SDR: TO89TgFWTBwxKI1wY/dCWuN+2xZpIKFfD6OZHHKIi+BrK8tmn4aUkmjc/QmsD+amF7DblA7KJy
 ArXxYTG5KI9Q==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="536544945"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Oct 2020 23:34:41 -0700
Date:   Thu, 29 Oct 2020 14:30:02 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iommu: Fix an issue in iommu_page_response()
 flags check
Message-ID: <20201029063002.GE27139@yi.y.sun>
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
 <20201028091356.GB2328726@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028091356.GB2328726@myrica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-28 10:13:56, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Wed, Oct 28, 2020 at 09:36:57AM +0800, Yi Sun wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > original code fails when LAST_PAGE is set in flags.
> 
> LAST_PAGE is not documented to be a valid flags for page_response.
> So isn't failing the right thing to do?
> 
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 8c470f4..053cec3 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1200,9 +1200,11 @@ int iommu_page_response(struct device *dev,
> >  		return -EINVAL;
> >  
> >  	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
> > -	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
> > +		!(msg->flags & IOMMU_PAGE_RESP_PASID_VALID)) {
> 
> It should be OK not to have PASID_VALID set, we're just checking for
> undefined flags here.
> 
Thanks! You are right. Per published spec, we should not care LAST_PAGE
for page_response. I will remove this patch in next version.
 
> Thanks,
> Jean
> 
> > +		dev_warn_ratelimited(dev, "%s:Invalid ver %x: flags %x\n",
> > +				__func__, msg->version, msg->flags);
> >  		return -EINVAL;
> > -
> > +	}
> >  	/* Only send response if there is a fault report pending */
> >  	mutex_lock(&param->fault_param->lock);
> >  	if (list_empty(&param->fault_param->faults)) {
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
