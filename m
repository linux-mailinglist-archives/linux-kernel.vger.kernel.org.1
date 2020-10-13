Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272F128CCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgJMLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:42:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:34062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgJMLm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:42:29 -0400
IronPort-SDR: Xvpqxlhl4wwiS7y0TSejNfA+9gwuJeKsh2bCqwSmJ8MXZqtr2HnbNC/OqxD27RTwe9dKCJGQQ3
 tFUQr48x7AEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="227533114"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="227533114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 04:42:26 -0700
IronPort-SDR: 4DLS+NwWImG7ltnbt45OuGGxGfkBzEsEWhp/3BkEZOwoeK64dwt3EgnXutdmw/HWlL1xeJscVv
 E0Vw0vVyR4Fw==
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="318263274"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 04:42:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kSIiD-005mp7-1D; Tue, 13 Oct 2020 14:43:25 +0300
Date:   Tue, 13 Oct 2020 14:43:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add the missed ida_simple_remove() in
 ring_request_msix()
Message-ID: <20201013114325.GK4077@smile.fi.intel.com>
References: <20201013024518.195557-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013024518.195557-1-jingxiangfeng@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:45:18AM +0800, Jing Xiangfeng wrote:
> ring_request_msix() misses to call ida_simple_remove() in an error path.
> Add the missed function call to fix it.

...

>  	ring->irq = pci_irq_vector(ring->nhi->pdev, ring->vector);
> -	if (ring->irq < 0)
> +	if (ring->irq < 0) {
> +		ida_simple_remove(&nhi->msix_ida, ret);
>  		return ring->irq;
> +	}
>  
>  	irqflags = no_suspend ? IRQF_NO_SUSPEND : 0;
>  	return request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);

According to your logic don't you need it here as well?

-- 
With Best Regards,
Andy Shevchenko


