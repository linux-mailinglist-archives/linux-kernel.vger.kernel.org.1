Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1C2C2A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbgKXO7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:59:44 -0500
Received: from foss.arm.com ([217.140.110.172]:37778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbgKXO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:59:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7AB21396;
        Tue, 24 Nov 2020 06:59:43 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9F13F70D;
        Tue, 24 Nov 2020 06:59:42 -0800 (PST)
Subject: Re: [PATCH V3] PM / EM: Micro optimization in em_cpu_energy
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <1606127371-13828-1-git-send-email-pkondeti@codeaurora.org>
 <1606127734-14507-1-git-send-email-pkondeti@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f98e3547-6896-5bd7-e748-57d1bba377c3@arm.com>
Date:   Tue, 24 Nov 2020 15:59:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606127734-14507-1-git-send-email-pkondeti@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2020 11:35, Pavankumar Kondeti wrote:
> When the sum of the utilization of CPUs in a performance domain is
> zero, return the energy as 0 without doing any computations.
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
> V3: %s/power/performance as corrected by Quentin
> V2: Fixed the function name in the commit message.
> 
>  include/linux/energy_model.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b67a51c..8810f1f 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	struct em_perf_state *ps;
>  	int i, cpu;
>  
> +	if (!sum_util)
> +		return 0;
> +
>  	/*
>  	 * In order to predict the performance state, map the utilization of
>  	 * the most utilized CPU of the performance domain to a requested


LGTM.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
