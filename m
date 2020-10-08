Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B5287DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgJHVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:18:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgJHVSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:18:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82F4D1063;
        Thu,  8 Oct 2020 14:18:08 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E19B3F66B;
        Thu,  8 Oct 2020 14:18:06 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:18:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 2/5] firmware: arm_scmi: fix transfer missing
 re-initialization
Message-ID: <20201008211804.soegjqsvmsgfmcne@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143722.21888-2-etienne.carriere@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:37:19PM +0200, Etienne Carriere wrote:
> Implement helper function scmi_do_xfer_again() to process consecutive
> transfers that are initialized only once with scmi_xfer_get_init()
> and hence get the pool completion and responses message length not
> reloaded regarding last completed transfer.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/firmware/arm_scmi/base.c    |  2 +-
>  drivers/firmware/arm_scmi/clock.c   |  2 +-
>  drivers/firmware/arm_scmi/common.h  |  2 ++
>  drivers/firmware/arm_scmi/driver.c  | 10 ++++++++++
>  drivers/firmware/arm_scmi/perf.c    |  2 +-
>  drivers/firmware/arm_scmi/sensors.c |  2 +-
>  6 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 9853bd3c4d45..508f214baa1b 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -183,7 +183,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
>  		/* Set the number of protocols to be skipped/already read */
>  		*num_skip = cpu_to_le32(tot_num_ret);
>  
> -		ret = scmi_do_xfer(handle, t);
> +		ret = scmi_do_xfer_again(handle, t);
>  		if (ret)
>  			break;
>  
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index c1cfe3ee3d55..9bb54c1a8d55 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -161,7 +161,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
>  		/* Set the number of rates to be skipped/already read */
>  		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
>  
> -		ret = scmi_do_xfer(handle, t);
> +		ret = scmi_do_xfer_again(handle, t);
>  		if (ret)
>  			goto err;
>  
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 37fb583f1bf5..6d4eea7b0f3e 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -143,6 +143,8 @@ struct scmi_xfer {
>  
>  void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
>  int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
> +int scmi_do_xfer_again(const struct scmi_handle *handle,
> +		       struct scmi_xfer *xfer);
>  int scmi_do_xfer_with_response(const struct scmi_handle *h,
>  			       struct scmi_xfer *xfer);
>  int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index c5dea87edf8f..887cb8249db0 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -402,6 +402,16 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  	return ret;
>  }
>  
> +int scmi_do_xfer_again(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> +{
> +	struct scmi_info *info = handle_to_scmi_info(handle);
> +
> +	xfer->rx.len = info->desc->max_msg_size;

I am tempted to just have helper for above and use it where needed.
Or may be I just don't like the name of the function, how about
scmi_do_xfer_rxlen_reinit or anything else. Suggestions ?

> +	xfer->hdr.poll_completion = false;

Do we really need the above ?

-- 
Regards,
Sudeep
