Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214B226C558
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIPQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgIPQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A865A20658;
        Wed, 16 Sep 2020 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600260402;
        bh=IpFNcwpgMGhaIjjYrhn3RrCKJAOKHJ/C9PHWEAEGuwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdmTyPZ+ChCahHH7J8zYPseh58htz4QL4nWTppk8PToYfyp1NH1p4VgPbS3HXQa51
         ilxcZ4QKeNPFvJKXJ1P8b/qCjfgok7LdgE2zyYdvQ4vTGeiJKhSTpMx5m2x8hb+P4O
         KE6kvVoBMHD7zGdaj71NJNQyeLNWhzaYNBUqIYC0=
Date:   Wed, 16 Sep 2020 18:16:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value
 set.
Message-ID: <20200916124634.GM2968@vkoul-mobl>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 16-09-20, 10:21, Srinivas Kandagatla wrote:
> According to usage (bitfields.h) of REG_FIELDS,
> Modify is:
>   reg &= ~REG_FIELD_C;
>   reg |= FIELD_PREP(REG_FIELD_C, c);
> 
> Patch ("soundwire: qcom : use FIELD_{GET|PREP}") seems to have
> accidentally removed clearing bit field while modifying the register.
> 
> Fix this by adding back clear register mask before setting it up!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index d7aabdaffee3..5d26361ab4f6 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -311,6 +311,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  
>  	/* Configure No pings */
>  	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
> +	val &= ~SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK;
>  	val |= FIELD_PREP(SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK, SWRM_DEF_CMD_NO_PINGS);

Should we rather use u32_replace_bits() here, I think the intention is
to replace bits.

>  	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>  
> @@ -372,6 +373,9 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
>  
>  	ctrl->reg_read(ctrl, reg, &val);
>  
> +	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
> +	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
> +
>  	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
>  	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
>  
> -- 
> 2.21.0

-- 
~Vinod
