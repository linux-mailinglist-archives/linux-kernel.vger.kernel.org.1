Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8263A1B4F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 23:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgDVVde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 17:33:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:52807 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDVVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:33:34 -0400
IronPort-SDR: AlEo/8IX9tR6MT85NhsZB7oK+ak5dVH6ssaJFMoRkfVee4wBaTXt4GvokTDSAq+QKsyx+HERTf
 27OgY9Etvtkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:33:32 -0700
IronPort-SDR: fx8/G3TFQoZ3nr8G0Vq3Pe3qg7wxlfg2R3xGHK9hTuRd8fjb4LZ1VcQYtjhGMqagNDJLKq2WQv
 tLLhU1v0EfqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="430075957"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 14:33:32 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for
 and populating /firmware/ node
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
References: <20200421173256.34897-1-sudeep.holla@arm.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
Date:   Wed, 22 Apr 2020 16:50:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200421173256.34897-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I tried and couldn't load stratix10-svc driver with your patch on kernel 
5.6.

Regards,
Richard

On 4/21/20 12:32 PM, Sudeep Holla wrote:
> Commit 3aa0582fdb82 ("of: platform: populate /firmware/ node from
> of_platform_default_populate_init()") changed the core-code to generate
> the platform devices, meaning there is no need for the driver to check
> the firmware node and populate it again here.
> 
> Let us just drop the unnecessary extra check done here as the core takes
> care of it.
> 
> Cc: Richard Gong <richard.gong@linux.intel.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/firmware/stratix10-svc.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> Hi Richard,
> 
> I assume the subsys_initcall is essential here. If not we can remove the
> whole initcalls and replace it with module_platform_driver(). Let me know.
> Just found this by accident when grepping for something else.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index d5f0769f3761..791d70fe82c1 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1094,23 +1094,6 @@ static struct platform_driver stratix10_svc_driver = {
>   
>   static int __init stratix10_svc_init(void)
>   {
> -	struct device_node *fw_np;
> -	struct device_node *np;
> -	int ret;
> -
> -	fw_np = of_find_node_by_name(NULL, "firmware");
> -	if (!fw_np)
> -		return -ENODEV;
> -
> -	np = of_find_matching_node(fw_np, stratix10_svc_drv_match);
> -	if (!np)
> -		return -ENODEV;
> -
> -	of_node_put(np);
> -	ret = of_platform_populate(fw_np, stratix10_svc_drv_match, NULL, NULL);
> -	if (ret)
> -		return ret;
> -
>   	return platform_driver_register(&stratix10_svc_driver);
>   }
>   
> 
