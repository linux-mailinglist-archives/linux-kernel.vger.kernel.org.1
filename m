Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9C2B0C09
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKLSAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgKLSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:00:50 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC841221E9;
        Thu, 12 Nov 2020 18:00:48 +0000 (UTC)
Date:   Thu, 12 Nov 2020 18:00:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mark.rutland@arm.com, sudeep.holla@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: implement CPPC FFH support using AMUs
Message-ID: <20201112180045.GO29613@gaia>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106125334.21570-4-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:53:34PM +0000, Ionela Voinescu wrote:
> +static inline
> +int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> +{
> +	if (!cpu_has_amu_feat(cpu))
> +		return -EOPNOTSUPP;
> +
> +	smp_call_function_single(cpu, func, val, 1);
> +
> +	return 0;
> +}

I got lost in the cpufreq call chains. Can this function ever be called
with interrupts disabled?

-- 
Catalin
