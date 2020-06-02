Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348691EC363
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgFBUFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 16:05:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:28467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBUFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:05:36 -0400
IronPort-SDR: KzILVJWxaOkFgTBhuJKzfIIlGYk8j96zA4lQqQkjU/Mr8wEpgdImR2tkrZrclyn0SxmGOvzjEC
 Tq3ozTuQIO2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 13:05:35 -0700
IronPort-SDR: j+uz9EZpXx3Aq/tV6t8Xv3otI9hzrOUqAVrLgz40kePv1smgfrIh2DXHXSvd6Y1uDTPIN4kz1l
 ro0C9uuMJkGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="257227532"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2020 13:05:35 -0700
Date:   Tue, 2 Jun 2020 13:05:35 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>,
        lalithambika.krishnakumar@intel.com, rajatxjain@gmail.com,
        pmalani@google.com, bleung@google.com, levinale@google.com,
        zsm@google.com, mnissler@google.com, tbroch@google.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Don't apply gfx quirks to untrusted
 devices
Message-ID: <20200602200534.GA17363@otc-nc-03>
References: <20200602184133.75525-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602184133.75525-1-rajatja@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat

On Tue, Jun 02, 2020 at 11:41:33AM -0700, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
> V2: - Change the warning print strings.
>     - Add Lu Baolu's acknowledgement.
> 
>  drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e5..fdfbea4ff8cb3 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6214,6 +6214,13 @@ const struct iommu_ops intel_iommu_ops = {
>  
>  static void quirk_iommu_igfx(struct pci_dev *dev)
>  {
> +	if (dev->untrusted) {
> +		pci_warn(dev,
> +			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
> +			 __func__);
> +		return;
> +	}
> +

This check and code seems to be happening several times. Maybe add a simple
function to do the test and use in all places?

Cheers,
Ashok
