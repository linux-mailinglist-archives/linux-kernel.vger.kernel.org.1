Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F194D2C8F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgK3UvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:51:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:60991 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgK3UvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:51:02 -0500
IronPort-SDR: yvFIJimU7A/Scfus2zvlQyQy4ZJ+Bez2gYnBxBN1LYRwIr7hK1UFX24Zcp1CCySvCOoJrAZpVa
 KSfOF2q8MfPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="169210056"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="169210056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:49:21 -0800
IronPort-SDR: l56Kv88FxBl/g7uL0cUWjbZXa/xxgbrCaAcsyNjw772ia5128r3FdUn8oR744As54N2C3ch1GM
 22LAH4UIVNVw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480800565"
Received: from whsiao-mobl.amr.corp.intel.com (HELO [10.209.17.17]) ([10.209.17.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:49:21 -0800
Subject: Re: [PATCH] soundwire: Fix error return code in
 sdw_compute_port_params
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201125065035.154262-1-miaoqinglang@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fc8ffb8c-955e-ddf3-3113-52c8b7329696@linux.intel.com>
Date:   Mon, 30 Nov 2020 11:35:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125065035.154262-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/20 12:50 AM, Qinglang Miao wrote:
> Fix to return the error code -EINVAL in sdw_compute_port_params
> instead of 0.
> 
> Fixes: 9026118f20e2 ("soundwire: Add generic bandwidth allocation algorithm")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Thanks for the patch.
The test covers a very unlikely error scenario but nevertheless not a 
zero probability so the suggested fix makes sense to me.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/soundwire/generic_bandwidth_allocation.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
> index 0bdef38c9..ad857ac62 100644
> --- a/drivers/soundwire/generic_bandwidth_allocation.c
> +++ b/drivers/soundwire/generic_bandwidth_allocation.c
> @@ -283,8 +283,10 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (group.count == 0)
> +	if (group.count == 0) {
> +		ret = -EINVAL;
>   		goto out;
> +	}
>   
>   	params = kcalloc(group.count, sizeof(*params), GFP_KERNEL);
>   	if (!params) {
> 
