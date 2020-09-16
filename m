Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24626CA89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIPUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:06:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:8958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbgIPRec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:34:32 -0400
IronPort-SDR: ycfQC+Ml4IuTne+Rb6b94H/i04jckQMcKrekbydpRksNDVH4DrFzkoW2Q+dogzogU3sb7VCG3z
 rbUqxgwx5ORA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="156897687"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="156897687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 08:20:04 -0700
IronPort-SDR: OdYOIHYHB+y7zJZS4X7mv0ayqmUQSgUR9w2A1EhshwcoaySbXJXAFJD52gSCbgi3dLjg+qJxRh
 7R7bs54essGg==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="507204721"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 08:20:04 -0700
Date:   Wed, 16 Sep 2020 08:20:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, madhuparnabhowmik10@gmail.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200916152004.GC2485491@iweiny-DESK2.sc.intel.com>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> There is an error when pin_user_pages_fast() returns -ERRNO and
> inside error handling path driver end up calling unpin_user_pages()
> with -ERRNO which is not correct.
> 
> This patch will fix the problem.
> 
> Fixes: e8de370188d09 ("rapidio: add mport char device driver")
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index a303429..163b6c72 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -871,15 +871,16 @@ static int do_dma_request(struct mport_dma_req *req,
>  				rmcd_error("pin_user_pages_fast err=%ld",
>  					   pinned);
>  				nr_pages = 0;
> -			} else
> +			} else {
>  				rmcd_error("pinned %ld out of %ld pages",
>  					   pinned, nr_pages);
> +				/*
> +				 * Set nr_pages up to mean "how many pages to unpin, in
> +				 * the error handler:
> +				 */
> +				nr_pages = pinned;
> +			}
>  			ret = -EFAULT;
> -			/*
> -			 * Set nr_pages up to mean "how many pages to unpin, in
> -			 * the error handler:
> -			 */
> -			nr_pages = pinned;
>  			goto err_pg;
>  		}
>  
> -- 
> 1.9.1
> 
