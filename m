Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2028F066
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgJOKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:54:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:2525 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgJOKyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:54:09 -0400
IronPort-SDR: 5RfIHasnXjmCJZFiT5LLic1yMXiPzvVIPC+6t1A9tdBDChWneDZXRriddeIv7z3tkNHIZ8AE+v
 nib7W2W1i0fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="251010715"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="251010715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:54:08 -0700
IronPort-SDR: oTlPNGogSA3vCiKBES+jH8XEQ+PM/jK/9DMxGEIHvWvzODG2XE7+vWO0m6lFarEv3eAll85fpP
 QqXe1HlZUnXQ==
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="390936528"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:54:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kT0ua-007NHO-BV; Thu, 15 Oct 2020 13:55:08 +0300
Date:   Thu, 15 Oct 2020 13:55:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thunderbolt: Add the missed ida_simple_remove() in
 ring_request_msix()
Message-ID: <20201015105508.GT4077@smile.fi.intel.com>
References: <20201015084053.56158-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015084053.56158-1-jingxiangfeng@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 04:40:53PM +0800, Jing Xiangfeng wrote:
> ring_request_msix() misses to call ida_simple_remove() in an error path.
> Add a label 'err_ida_remove' and jump to it.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 046bee1f9ab8 ("thunderbolt: Add MSI-X support")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---

When new version is issued do not forget to add changelog here (after cutter '---' line).

>  drivers/thunderbolt/nhi.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 5f7489fa1327..a331e52789e3 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -405,12 +405,23 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
>  
>  	ring->vector = ret;
>  
> -	ring->irq = pci_irq_vector(ring->nhi->pdev, ring->vector);
> -	if (ring->irq < 0)
> -		return ring->irq;
> +	ret = pci_irq_vector(ring->nhi->pdev, ring->vector);
> +	if (ret < 0)
> +		goto err_ida_remove;
> +
> +	ring->irq = ret;
>  
>  	irqflags = no_suspend ? IRQF_NO_SUSPEND : 0;
> -	return request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
> +	ret = request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
> +	if (ret)
> +		goto err_ida_remove;
> +
> +	return 0;
> +
> +err_ida_remove:
> +	ida_simple_remove(&nhi->msix_ida, ring->vector);
> +
> +	return ret;
>  }
>  
>  static void ring_release_msix(struct tb_ring *ring)
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


