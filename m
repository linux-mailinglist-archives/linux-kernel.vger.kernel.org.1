Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2126CA50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIPTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgIPRgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:36:20 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F148222207;
        Wed, 16 Sep 2020 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600260559;
        bh=lyfkIW9nbLNG0cBwGnyyE0n2KPe0IWoaCwcpwXnNqmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgMnF4koXmSj6iGs92bUFpHcKffgKJP9AY8W5C42o5vpJ+bEzzBjwgkeEQ9d3uyO3
         7CKnr3rV2IwC9wuvwtOnSm47n14Ry/tlMQYDy9RDu0ba7ypXwWVQ+dcRn8aFV9vCOy
         zKNbVb4j0IUZCvsSGid2uht1jsCV3Ecd5YX9GYBI=
Date:   Wed, 16 Sep 2020 18:19:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] soundwire: qcom: get max rows and cols info from
 compatible
Message-ID: <20200916124911.GN2968@vkoul-mobl>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916092125.30898-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 10:21, Srinivas Kandagatla wrote:
> currently the max rows and cols values are hardcoded. In reality
> these values depend on the IP version. So get these based on
> device tree compatible strings.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 50 ++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 76963a7bdaa3..1dbf33684470 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -66,11 +66,6 @@
>  #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
>  			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
>  
> -#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
> -#define SWRM_DEFAULT_ROWS	48
> -#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
> -#define SWRM_DEFAULT_COL	16
> -#define SWRM_MAX_COL_VAL	7
>  #define SWRM_SPECIAL_CMD_ID	0xF
>  #define MAX_FREQ_NUM		1
>  #define TIMEOUT_MS		(2 * HZ)
> @@ -104,6 +99,8 @@ struct qcom_swrm_ctrl {
>  	unsigned int version;
>  	int num_din_ports;
>  	int num_dout_ports;
> +	int cols_index;
> +	int rows_index;
>  	unsigned long dout_port_mask;
>  	unsigned long din_port_mask;
>  	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
> @@ -113,6 +110,21 @@ struct qcom_swrm_ctrl {
>  	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
>  };
>  
> +struct qcom_swrm_data {
> +	u32 default_cols;
> +	u32 default_rows;
> +};
> +
> +static struct qcom_swrm_data swrm_v1_3_data = {
> +	.default_rows = 48,
> +	.default_cols = 16,
> +};
> +
> +static struct qcom_swrm_data swrm_v1_5_data = {
> +	.default_rows = 50,
> +	.default_cols = 16,
> +};
> +
>  #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
>  
>  static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
> @@ -299,8 +311,10 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	u32 val;
>  
>  	/* Clear Rows and Cols */
> -	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
> -	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MIN_COL_VAL);
> +	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK,
> +			 ctrl->rows_index);
> +	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK,
> +			  ctrl->cols_index);

single line for these ?

>  	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
>  
> @@ -378,8 +392,10 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
>  	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
>  	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
>  
> -	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
> -	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
> +	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK,
> +			  ctrl->cols_index);
> +	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK,
> +			  ctrl->rows_index);

here as well

>  
>  	return ctrl->reg_write(ctrl, reg, val);
>  }
> @@ -780,6 +796,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	struct sdw_master_prop *prop;
>  	struct sdw_bus_params *params;
>  	struct qcom_swrm_ctrl *ctrl;
> +	const struct qcom_swrm_data *data;
>  	int ret;
>  	u32 val;
>  
> @@ -787,6 +804,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	if (!ctrl)
>  		return -ENOMEM;
>  
> +	data = of_device_get_match_data(dev);

Wont it be good to check if data is valid, we do dereference it few line
below

> +	ctrl->rows_index = sdw_find_row_index(data->default_rows);
> +	ctrl->cols_index = sdw_find_col_index(data->default_cols);
>  #if IS_ENABLED(CONFIG_SLIMBUS)
>  	if (dev->parent->bus == &slimbus_bus) {
>  #else
> @@ -836,8 +856,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	params = &ctrl->bus.params;
>  	params->max_dr_freq = DEFAULT_CLK_FREQ;
>  	params->curr_dr_freq = DEFAULT_CLK_FREQ;
> -	params->col = SWRM_DEFAULT_COL;
> -	params->row = SWRM_DEFAULT_ROWS;
> +	params->col = data->default_cols;
> +	params->row = data->default_rows;
>  	ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
>  	params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
>  	params->next_bank = !params->curr_bank;
> @@ -847,8 +867,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	prop->num_clk_gears = 0;
>  	prop->num_clk_freq = MAX_FREQ_NUM;
>  	prop->clk_freq = &qcom_swrm_freq_tbl[0];
> -	prop->default_col = SWRM_DEFAULT_COL;
> -	prop->default_row = SWRM_DEFAULT_ROWS;
> +	prop->default_col = data->default_cols;
> +	prop->default_row = data->default_rows;
>  
>  	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
>  
> @@ -899,8 +919,8 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_swrm_of_match[] = {
> -	{ .compatible = "qcom,soundwire-v1.3.0", },
> -	{ .compatible = "qcom,soundwire-v1.5.1", },
> +	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
> +	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>  	{/* sentinel */},
>  };
>  
> -- 
> 2.21.0

-- 
~Vinod
