Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBF2A0604
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgJ3M4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:56:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:65229 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3M4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:56:44 -0400
IronPort-SDR: oisDeNTVFX+WpqRKLHJoZJKKYy1wyqazAjQP58ag8QHhO4JX1zGVrF1Dwq4RdJVqrq9eE//ylB
 Wedl+29+/YYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156375111"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="156375111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:56:42 -0700
IronPort-SDR: mfZBZuCyvqRQfQgXl5o5aDDGACTbwr1Tf7cOv/s5vxTubptdl3crp5CdmHeMk5lezIl91PgvRo
 Ear1wf7vEgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="425339020"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2020 05:56:40 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Fix a bug for PDP check in
 prq_event_thread
To:     Yi Sun <yi.y.sun@linux.intel.com>, joro@8bytes.org,
        dwmw2@infradead.org, jean-philippe@linaro.org
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
 <1604025444-6954-3-git-send-email-yi.y.sun@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <429b63d1-1692-2244-f69b-a924e8534131@linux.intel.com>
Date:   Fri, 30 Oct 2020 20:49:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604025444-6954-3-git-send-email-yi.y.sun@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 10:37 AM, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>
> 
> In prq_event_thread(), the QI_PGRP_PDP is wrongly set by
> 'req->pasid_present' which should be replaced to
> 'req->priv_data_present'.
> 
> Fixes: 5b438f4ba315 ("iommu/vt-d: Support page request in scalable mode")
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Cc: stable@ver.kernel.org
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7584669..3242ebd 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1035,7 +1035,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   			resp.qw0 = QI_PGRP_PASID(req->pasid) |
>   				QI_PGRP_DID(req->rid) |
>   				QI_PGRP_PASID_P(req->pasid_present) |
> -				QI_PGRP_PDP(req->pasid_present) |
> +				QI_PGRP_PDP(req->priv_data_present) |
>   				QI_PGRP_RESP_CODE(result) |
>   				QI_PGRP_RESP_TYPE;
>   			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
> 
