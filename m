Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803E2A04AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgJ3Lrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgJ3Lrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:47:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:47:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 07CC01F45EBD
Subject: Re: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for mt8167
To:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201027131122.374046-1-fparent@baylibre.com>
 <20201027131122.374046-2-fparent@baylibre.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <157c2b93-4ac3-5368-d04c-b574f04d6f41@collabora.com>
Date:   Fri, 30 Oct 2020 12:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027131122.374046-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Thank you for the patch and base it on the new SCPSYS PM domains driver

On 27/10/20 14:11, Fabien Parent wrote:
> Add the needed board data to support mt8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> This patch depends on the SCPSYS PM domains driver [0].
> 
> v2:
> 	* Implement on top of new SCPSYS PM domains driver [0]
> 
> [0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=370737
>  drivers/soc/mediatek/mt8167-pm-domains.h | 86 ++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-pm-domains.c    |  5 ++
>  drivers/soc/mediatek/mtk-pm-domains.h    |  1 +
>  include/linux/soc/mediatek/infracfg.h    |  8 +++
>  4 files changed, 100 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8167-pm-domains.h
> 
> diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
> new file mode 100644
> index 000000000000..ff18139d0d6c
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8167-pm-domains.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_MEDIATEK_MT8167_PM_DOMAINS_H
> +#define __SOC_MEDIATEK_MT8167_PM_DOMAINS_H
> +
> +#include "mtk-pm-domains.h"
> +#include <dt-bindings/power/mt8167-power.h>
> +
> +#define MT8167_PWR_STATUS_MFG_2D	BIT(24)
> +#define MT8167_PWR_STATUS_MFG_ASYNC	BIT(25)
> +
> +/*
> + * MT8167 power domain support
> + */
> +
> +static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
> +	[MT8167_POWER_DOMAIN_DISP] = {
> +		.sta_mask = PWR_STATUS_DISP,
> +		.ctl_offs = SPM_DIS_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MM_EMI |
> +					       MT8167_TOP_AXI_PROT_EN_MCU_MM),
> +		},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8167_POWER_DOMAIN_VDEC] = {
> +		.sta_mask = PWR_STATUS_VDEC,
> +		.ctl_offs = SPM_VDE_PWR_CON,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8167_POWER_DOMAIN_ISP] = {
> +		.sta_mask = PWR_STATUS_ISP,
> +		.ctl_offs = SPM_ISP_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8167_POWER_DOMAIN_MFG_ASYNC] = {
> +		.sta_mask = MT8167_PWR_STATUS_MFG_ASYNC,
> +		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bp_infracfg = {
> +			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MCU_MFG |
> +					       MT8167_TOP_AXI_PROT_EN_MFG_EMI),
> +		},
> +	},
> +	[MT8167_POWER_DOMAIN_MFG_2D] = {
> +		.sta_mask = MT8167_PWR_STATUS_MFG_2D,
> +		.ctl_offs = SPM_MFG_2D_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +	},
> +	[MT8167_POWER_DOMAIN_MFG] = {
> +		.sta_mask = PWR_STATUS_MFG,
> +		.ctl_offs = SPM_MFG_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +	},
> +	[MT8167_POWER_DOMAIN_CONN] = {
> +		.sta_mask = PWR_STATUS_CONN,
> +		.ctl_offs = SPM_CONN_PWR_CON,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = 0,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +		.bp_infracfg = {
> +			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_CONN_EMI |
> +					       MT8167_TOP_AXI_PROT_EN_CONN_MCU |
> +					       MT8167_TOP_AXI_PROT_EN_MCU_CONN),
> +		},
> +	},
> +};
> +
> +static const struct scpsys_soc_data mt8167_scpsys_data = {
> +	.domains = scpsys_domain_data_mt8167,

Just to let you know, this is now domains_data.

> +	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8167),
> +	.pwr_sta_offs = SPM_PWR_STATUS,
> +	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
> +};
> +
> +#endif /* __SOC_MEDIATEK_MT8167_PM_DOMAINS_H */
> +
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 293efa27b6ce..34c704865f01 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -15,6 +15,7 @@
>  #include <linux/regmap.h>
>  #include <linux/soc/mediatek/infracfg.h>
>  
> +#include "mt8167-pm-domains.h"
>  #include "mt8173-pm-domains.h"
>  #include "mt8183-pm-domains.h"
>  #include "mt8192-pm-domains.h"
> @@ -515,6 +516,10 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
>  }
>  
>  static const struct of_device_id scpsys_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8167-power-controller",
> +		.data = &mt8167_scpsys_data,
> +	},
>  	{
>  		.compatible = "mediatek,mt8173-power-controller",
>  		.data = &mt8173_scpsys_data,
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index eda453f55126..7c1e1a7209f1 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -14,6 +14,7 @@
>  #define SPM_VEN_PWR_CON			0x0230
>  #define SPM_ISP_PWR_CON			0x0238
>  #define SPM_DIS_PWR_CON			0x023c
> +#define SPM_CONN_PWR_CON		0x0280
>  #define SPM_VEN2_PWR_CON		0x0298
>  #define SPM_AUDIO_PWR_CON		0x029c
>  #define SPM_MFG_2D_PWR_CON		0x02c0
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index e7842debc05d..4615a228da51 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -123,6 +123,14 @@
>  #define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
>  #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
>  
> +#define MT8167_TOP_AXI_PROT_EN_MM_EMI		BIT(1)
> +#define MT8167_TOP_AXI_PROT_EN_MCU_MFG		BIT(2)
> +#define MT8167_TOP_AXI_PROT_EN_CONN_EMI		BIT(4)
> +#define MT8167_TOP_AXI_PROT_EN_MFG_EMI		BIT(5)
> +#define MT8167_TOP_AXI_PROT_EN_CONN_MCU		BIT(8)
> +#define MT8167_TOP_AXI_PROT_EN_MCU_CONN		BIT(9)
> +#define MT8167_TOP_AXI_PROT_EN_MCU_MM		BIT(11)
> +
>  #define MT2701_TOP_AXI_PROT_EN_MM_M0		BIT(1)
>  #define MT2701_TOP_AXI_PROT_EN_CONN_M		BIT(2)
>  #define MT2701_TOP_AXI_PROT_EN_CONN_S		BIT(8)
> 

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric
