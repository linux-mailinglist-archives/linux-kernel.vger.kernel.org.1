Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F927D446
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgI2RRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgI2RRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:17:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B100B20757;
        Tue, 29 Sep 2020 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601399825;
        bh=P/QhiYBumdpCaF4VgQUDRrSUPpdh2M7EfHQSsTjYSdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWKOe9F0l7ZFWsMN/l6VodfQMncPdF0Rn1xjGT//tXiTwUdtnFndsHBgkcR9Qym/q
         4iqMT3Twn/PsWQiRlsT9eNGtwJbZRh3GBkqwHMBiGpCPgt6pX8kPkSyuhCHeoFb1WC
         4CeK1eO5hi5IbxjghBagBskxkl2YcbPiGjgWa/NY=
Date:   Tue, 29 Sep 2020 18:17:01 +0100
From:   Will Deacon <will@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf: arm-cmn: Fix unsigned comparison to less
 than zero
Message-ID: <20200929171700.GA14317@willie-the-truck>
References: <20200929170835.GA15956@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929170835.GA15956@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:08:35PM -0500, Gustavo A. R. Silva wrote:
> Fix unsigned comparison to less than zero by assigning the returned
> value of function platform_get_irq() to a new integer variable _ret_
> and then make the comparison. In case the returned value is greater
> than or equal to zero, assign it to dtc->irq.
> 
> Addresses-Coverity-ID: 1497488 ("Unsigned compared against 0")
> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/perf/arm-cmn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index e824b5b83ea2..383b67042677 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1246,11 +1246,13 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
>  {
>  	struct arm_cmn_dtc *dtc = cmn->dtc + idx;
>  	struct arm_cmn_node *xp;
> +	int ret;
>  
>  	dtc->base = dn->pmu_base - CMN_PMU_OFFSET;
> -	dtc->irq = platform_get_irq(to_platform_device(cmn->dev), idx);
> -	if (dtc->irq < 0)
> -		return dtc->irq;
> +	ret = platform_get_irq(to_platform_device(cmn->dev), idx);
> +	if (ret < 0)
> +		return ret;
> +	dtc->irq = ret;

Why don't we just change the type of the 'irq' field in 'struct arm_cmn_dtc'
to be 'int' instead of 'unsigned int'?

Robin?

Will
