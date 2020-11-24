Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8024D2C2E39
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgKXRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:15:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:50297 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390280AbgKXRPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:15:40 -0500
IronPort-SDR: PBaeAwh+jpv6Is7fgpM7umK+aIptXBTwBzcz5Cv1uJri68OXhmIMxKH9LubrRPhMw2ptdaYBbw
 h3xL1K4uCi2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="171201662"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="171201662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 09:15:40 -0800
IronPort-SDR: BL9/f2x7001UmbRYVr03aocEjYzrMKeRkqA0WVMRbanRqfUVFI6MfBIC0UV/K1vn9ZWv2TP9a/
 n0E5yflx9oMg==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546910675"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.133.99]) ([10.249.133.99])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 09:15:35 -0800
Subject: Re: [PATCH V2] PM / EM: Micro optimization in em_cpu_energy
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <1606126679-11799-1-git-send-email-pkondeti@codeaurora.org>
 <1606127371-13828-1-git-send-email-pkondeti@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <671427cc-2abb-68eb-5e54-0851785efa84@intel.com>
Date:   Tue, 24 Nov 2020 18:15:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1606127371-13828-1-git-send-email-pkondeti@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2020 11:29 AM, Pavankumar Kondeti wrote:
> When the sum of the utilization of CPUs in a power domain is zero,
> return the energy as 0 without doing any computations.
>
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
> V2: Fixed the function name in the commit message.
>
>   include/linux/energy_model.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b67a51c..8810f1f 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	struct em_perf_state *ps;
>   	int i, cpu;
>   
> +	if (!sum_util)
> +		return 0;
> +
>   	/*
>   	 * In order to predict the performance state, map the utilization of
>   	 * the most utilized CPU of the performance domain to a requested

If I'm to take this, please resend it with a CC to 
linux-pm@vger.kernel.org (and with the tags you've received so far).

Thanks!


