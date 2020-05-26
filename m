Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6E1D32E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgENO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 10:29:29 -0400
Received: from foss.arm.com ([217.140.110.172]:37622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:29:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AEC51FB;
        Thu, 14 May 2020 07:29:28 -0700 (PDT)
Received: from bogus (unknown [10.37.8.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FF223F71E;
        Thu, 14 May 2020 07:29:27 -0700 (PDT)
Date:   Thu, 14 May 2020 15:29:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix SMCCC_RET_NOT_SUPPORTED
 management
Message-ID: <20200514142924.GC23401@bogus>
References: <20200514082428.27864-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514082428.27864-1-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:24:28AM +0200, Etienne Carriere wrote:
> Fix management of argument a0 output value of arm_smccc_1_1_invoke() that
> should consider only SMCCC_RET_NOT_SUPPORTED as reporting an unsupported
> function ID as correctly stated in the inline comment.
>

I agree on the comment part, but ...

> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/firmware/arm_scmi/smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 49bc4b0e8428..637ad439545f 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -115,7 +115,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  	mutex_unlock(&scmi_info->shmem_lock);
>  
>  	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
> -	if (res.a0)
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
>  		return -EOPNOTSUPP;

Now this will return 0 for all values other than SMCCC_RET_NOT_SUPPORTED.
Is that what we need ? Or do you see non-zero res.a0 for a success case ?
If later, we need some fixing, otherwise it is safer to leave it as is
IMO.

-- 
Regards,
Sudeep
