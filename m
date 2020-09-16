Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5526BD58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIPGh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:37:59 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3363 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgIPGh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:37:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f61b2b70000>; Tue, 15 Sep 2020 23:37:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 23:37:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 15 Sep 2020 23:37:56 -0700
Received: from [10.2.57.195] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 06:37:52 +0000
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <akpm@linux-foundation.org>, <gustavoars@kernel.org>,
        <madhuparnabhowmik10@gmail.com>, <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1ec3dab9-9716-4413-5a3b-9a492259712d@nvidia.com>
Date:   Tue, 15 Sep 2020 23:37:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600238263; bh=GmkCD6TTtf8PK3nJhrPO32jAC/V54cPuX6dDsVaN2aU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ei9NyVqXK+4HFQCdYIOvrZJmV2zSST4k+gaGDONoDSAnThQNmnxlKtGIqYQ0C307r
         a/28hOsX3nbEdt/IZAtSYQcL6xwPQoJbWdsp4v0AaJqKLQJHv9Z0sZgIldZHjrUCt6
         i0/mdi0rW4Qf1ulv7e/J7HJ7GNOFGtsaonuZC6YM5D0HthvimR2GbAjLDfZOqT11sP
         E1GLmbl/O2AqYsjOAi8avhluWQTMzow62jmCF1e8dqrdcp0d8M9bERq6ugrq048A75
         +5b+ULeqFvCYRPbuYdVZEcjaBJrxFnO1N1et0Hq6tLBUNkW/Lmb/Vt6cII/OQpgqOS
         4iMOnxtbPIIsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 8:42 PM, Souptick Joarder wrote:
> There is an error when pin_user_pages_fast() returns -ERRNO and
> inside error handling path driver end up calling unpin_user_pages()
> with -ERRNO which is not correct.
> > This patch will fix the problem.

How about:

rio_dma_transfer() attempts to clamp the return value of
pin_user_pages_fast() to be >= 0. However, the attempt fails because
nr_pages is overridden a few lines later, and restored to the
undesirable -ERRNO value.

The return value is ultimately stored in nr_pages, which in turn is
passed to unpin_user_pages(), which expects nr_pages >= 0, else,
disaster.

Fix this by fixing the nesting of the assignment to nr_pages: nr_pages
should be clamped to zero if pin_user_pages_fast() returns -ERRNO, or
set to the return value of pin_user_pages_fast(), otherwise.

> 
> Fixes: e8de370188d09 ("rapidio: add mport char device driver")
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index a303429..163b6c72 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -871,15 +871,16 @@ static int do_dma_request(struct mport_dma_req *req,
>   				rmcd_error("pin_user_pages_fast err=%ld",
>   					   pinned);
>   				nr_pages = 0;
> -			} else
> +			} else {
>   				rmcd_error("pinned %ld out of %ld pages",
>   					   pinned, nr_pages);
> +				/*
> +				 * Set nr_pages up to mean "how many pages to unpin, in
> +				 * the error handler:
> +				 */
> +				nr_pages = pinned;
> +			}
>   			ret = -EFAULT;
> -			/*
> -			 * Set nr_pages up to mean "how many pages to unpin, in
> -			 * the error handler:
> -			 */
> -			nr_pages = pinned;
>   			goto err_pg;
>   		}
>   
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
