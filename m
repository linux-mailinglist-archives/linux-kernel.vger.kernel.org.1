Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1740028DBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgJNIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:47:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:27894 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbgJNIrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:47:21 -0400
IronPort-SDR: h51LH6Jg7DzPFDo98BbEpkqL6xFmW4ZoeskFGq+Ui8KXLOg0tiGWcTojB5FOcofT8AfK9D5BKI
 4rvbGBIXH9Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="163432570"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="163432570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 01:47:20 -0700
IronPort-SDR: JY83hw1KBGRXJnKJDV1va5At2JNYZ0qNhoRorCpwtr3YGKEDKKHW+lGeu7xzCFO9KII6j+2mLK
 zjln8S7O6Pkg==
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="521345922"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 01:47:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kScSL-006UAi-Hj; Wed, 14 Oct 2020 11:48:21 +0300
Date:   Wed, 14 Oct 2020 11:48:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt: Add the missed ida_simple_remove() in
 ring_request_msix()
Message-ID: <20201014084821.GR4077@smile.fi.intel.com>
References: <20201014014604.167968-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014014604.167968-1-jingxiangfeng@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:46:04AM +0800, Jing Xiangfeng wrote:
> ring_request_msix() misses to call ida_simple_remove() in an error path.
> Add a label 'err_ida_remove' and jump to it.

...

> @@ -406,11 +406,22 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
>  	ring->vector = ret;

^^^

>  	ring->irq = pci_irq_vector(ring->nhi->pdev, ring->vector);
> -	if (ring->irq < 0)
> -		return ring->irq;
> +	if (ring->irq < 0) {
> +		ret = ring->irq;
> +		goto err_ida_remove;
> +	}

What about
	ret = pci_irq_vector(ring->nhi->pdev, ring->vector);
	if (ret < 0)
		goto err_ida_remove;

	ring->irq = ret;

?

(See also context above)

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


