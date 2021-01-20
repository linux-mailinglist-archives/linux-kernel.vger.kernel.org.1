Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56442FD38C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbhATPJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbhATPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:00:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89829C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:59:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c124so3099094wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wTTpt9baQV1IojdvX3VLbJozKtinDQLSiS4JMFBUvpw=;
        b=D0SC+TfsUw97jXhMaauhoJ2V10Doi/pQS75sO1dyt0ORnMKtP5n9a9mcA2tBuWmIIu
         82dQNdOJHsCGXSqJM5kJ+14cQMsKbc7xevN1toqZuvOm3WBXn7zvCguOMY/II5fmvEqm
         fOv4OzQN5EHihHmf3SZ3fT6R2JAxpxHppk2WjMjgeZq5g7aDBgAOtIukjvIerr9N9/Dd
         VnUq1iruBw849HnHuYXSsE9MKVmZmbJV93JGsP8mgF1h9TKktNwyrBAlDjUGmthSKIVd
         3svGVkXMWHB5i4edZ2keWWvej1y6qo+ehqXV97iwVU28f/4ByzW6s7JnRB6v/I5U86oI
         xp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wTTpt9baQV1IojdvX3VLbJozKtinDQLSiS4JMFBUvpw=;
        b=ShLhgw3w+UbIbpZrBQYSt5O8y857KwDl20cCuA7JFYEbqC4kD574ZM8/1t3DHajqbI
         7X0shsDYRPPNF8PeJWqyu5+XB645xRO9wA0tLlnWwlO8YaGNThplaaclDsFQ98dXYpsQ
         Z2HHJaJABVCG9AloF3R7wYeG59/3+wopO1EvZrkTOtMPqZ1GoNMUOo8++9N2O7l48Cym
         s73Bb7f1bPxkyfajIn1X7jus+9ZyRjxVRPtv1+em4Fe+ee4UFtyY2IqihycXX9MvtEiA
         ZsgKA3+WRRtxTmYs4TTONjVywCIOGlnFZv2iXfz1W+BFJQiY3JML/F71vyCSngoVpCjC
         brug==
X-Gm-Message-State: AOAM531Fv/k/EEtFe1NR9QZQqB5LSvUf9gGRl2bOPMpJ/cJeAESYg/CK
        i+JdGmHwloLTtp02bzyXJ3Q0tA==
X-Google-Smtp-Source: ABdhPJxtkvddop+w7wDdFZDnf5USm9uT3ZTY0AqCwLAZYaClKDgwqGgNAVkQTs/GbcaDt7LgrkHfIA==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr4610059wmd.157.1611154767181;
        Wed, 20 Jan 2021 06:59:27 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h13sm4467006wrm.28.2021.01.20.06.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:59:26 -0800 (PST)
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org
References: <20210120080627.20784-1-manivannan.sadhasivam@linaro.org>
 <20210120080627.20784-3-manivannan.sadhasivam@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SDX55 interconnect provider
 driver
Message-ID: <cb0f56b6-a75c-51a8-d640-08896d459a68@linaro.org>
Date:   Wed, 20 Jan 2021 16:59:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210120080627.20784-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Thanks for the patch!

On 1/20/21 10:06, Manivannan Sadhasivam wrote:
> Add driver for the Qualcomm interconnect buses found in SDX55 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Based on SM8250 driver and generated from downstream dts.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/interconnect/qcom/Kconfig  |  10 +
>   drivers/interconnect/qcom/Makefile |   2 +
>   drivers/interconnect/qcom/sdx55.c  | 356 +++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/sdx55.h  |  70 ++++++
>   4 files changed, 438 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/sdx55.c
>   create mode 100644 drivers/interconnect/qcom/sdx55.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index a8f93ba265f8..6df7e2161a0a 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -65,6 +65,16 @@ config INTERCONNECT_QCOM_SDM845
>   	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>   	  platforms.
>   
> +config INTERCONNECT_QCOM_SDX55
> +	tristate "Qualcomm SDX55 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST

Why not use depends on INTERCONNECT_QCOM_RPMH_POSSIBLE?

> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on sdx55-based
> +	  platforms.
> +
>   config INTERCONNECT_QCOM_SM8150
>   	tristate "Qualcomm SM8150 interconnect driver"
>   	depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index cf628f7990cd..981a5ea45af9 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -8,6 +8,7 @@ qnoc-qcs404-objs			:= qcs404.o
>   icc-rpmh-obj				:= icc-rpmh.o
>   qnoc-sc7180-objs			:= sc7180.o
>   qnoc-sdm845-objs			:= sdm845.o
> +qnoc-sdx55-objs				:= sdx55.o
>   qnoc-sm8150-objs			:= sm8150.o
>   qnoc-sm8250-objs			:= sm8250.o
>   icc-smd-rpm-objs			:= smd-rpm.o
> @@ -20,6 +21,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
> new file mode 100644
> index 000000000000..a7ac12a1b62b
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdx55.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm SDX55 interconnect driver
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + *
> + * Copyright (c) 2020, Linaro Ltd.

Now is 2021, but probably you wrote it in 2020.

> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/interconnect/qcom,sdx55.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +#include "sdx55.h"
> +
> +DEFINE_QNODE(ipa_core_master, SDX55_MASTER_IPA_CORE, 1, 8, SDX55_SLAVE_IPA_CORE);
> +DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
> +DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
> +DEFINE_QNODE(xm_apps_rdwr, SDX55_MASTER_AMPSS_M0, 1, 16, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(qhm_audio, SDX55_MASTER_AUDIO, 1, 4, SDX55_SLAVE_ANOC_SNOC);
> +DEFINE_QNODE(qhm_blsp1, SDX55_MASTER_BLSP_1, 1, 4, SDX55_SLAVE_ANOC_SNOC);
> +DEFINE_QNODE(qhm_qdss_bam, SDX55_MASTER_QDSS_BAM, 1, 4, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(qhm_qpic, SDX55_MASTER_QPIC, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
> +DEFINE_QNODE(qhm_snoc_cfg, SDX55_MASTER_SNOC_CFG, 1, 4, SDX55_SLAVE_SERVICE_SNOC);
> +DEFINE_QNODE(qhm_spmi_fetcher1, SDX55_MASTER_SPMI_FETCHER, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
> +DEFINE_QNODE(qnm_aggre_noc, SDX55_MASTER_ANOC_SNOC, 1, 8, SDX55_SLAVE_PCIE_0, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_USB3, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(qnm_ipa, SDX55_MASTER_IPA, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_TLMM, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(qnm_memnoc, SDX55_MASTER_MEM_NOC_SNOC, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS,  SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(qnm_memnoc_pcie, SDX55_MASTER_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_SLAVE_PCIE_0);
> +DEFINE_QNODE(qxm_crypto, SDX55_MASTER_CRYPTO_CORE_0, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
> +DEFINE_QNODE(xm_emac, SDX55_MASTER_EMAC, 1, 8, SDX55_SLAVE_ANOC_SNOC);
> +DEFINE_QNODE(xm_ipa2pcie_slv, SDX55_MASTER_IPA_PCIE, 1, 8, SDX55_SLAVE_PCIE_0);
> +DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
> +DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
> +DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
> +DEFINE_QNODE(ipa_core_slave, SDX55_SLAVE_IPA_CORE, 1, 8);
> +DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
> +DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
> +DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
> +DEFINE_QNODE(qns_sys_pcie, SDX55_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(qhs_aop, SDX55_SLAVE_AOP, 1, 4);
> +DEFINE_QNODE(qhs_aoss, SDX55_SLAVE_AOSS, 1, 4);
> +DEFINE_QNODE(qhs_apss, SDX55_SLAVE_APPSS, 1, 4);
> +DEFINE_QNODE(qhs_audio, SDX55_SLAVE_AUDIO, 1, 4);
> +DEFINE_QNODE(qhs_blsp1, SDX55_SLAVE_BLSP_1, 1, 4);
> +DEFINE_QNODE(qhs_clk_ctl, SDX55_SLAVE_CLK_CTL, 1, 4);
> +DEFINE_QNODE(qhs_crypto0_cfg, SDX55_SLAVE_CRYPTO_0_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ddrss_cfg, SDX55_SLAVE_CNOC_DDRSS, 1, 4);
> +DEFINE_QNODE(qhs_ecc_cfg, SDX55_SLAVE_ECC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_emac_cfg, SDX55_SLAVE_EMAC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_imem_cfg, SDX55_SLAVE_IMEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ipa, SDX55_SLAVE_IPA_CFG, 1, 4);
> +DEFINE_QNODE(qhs_mss_cfg, SDX55_SLAVE_CNOC_MSS, 1, 4);
> +DEFINE_QNODE(qhs_pcie_parf, SDX55_SLAVE_PCIE_PARF, 1, 4);
> +DEFINE_QNODE(qhs_pdm, SDX55_SLAVE_PDM, 1, 4);
> +DEFINE_QNODE(qhs_prng, SDX55_SLAVE_PRNG, 1, 4);
> +DEFINE_QNODE(qhs_qdss_cfg, SDX55_SLAVE_QDSS_CFG, 1, 4);
> +DEFINE_QNODE(qhs_qpic, SDX55_SLAVE_QPIC, 1, 4);
> +DEFINE_QNODE(qhs_sdc1, SDX55_SLAVE_SDCC_1, 1, 4);
> +DEFINE_QNODE(qhs_snoc_cfg, SDX55_SLAVE_SNOC_CFG, 1, 4, SDX55_MASTER_SNOC_CFG);
> +DEFINE_QNODE(qhs_spmi_fetcher, SDX55_SLAVE_SPMI_FETCHER, 1, 4);
> +DEFINE_QNODE(qhs_spmi_vgi_coex, SDX55_SLAVE_SPMI_VGI_COEX, 1, 4);
> +DEFINE_QNODE(qhs_tcsr, SDX55_SLAVE_TCSR, 1, 4);
> +DEFINE_QNODE(qhs_tlmm, SDX55_SLAVE_TLMM, 1, 4);
> +DEFINE_QNODE(qhs_usb3, SDX55_SLAVE_USB3, 1, 4);
> +DEFINE_QNODE(qhs_usb3_phy, SDX55_SLAVE_USB3_PHY_CFG, 1, 4);
> +DEFINE_QNODE(qns_aggre_noc, SDX55_SLAVE_ANOC_SNOC, 1, 8, SDX55_MASTER_ANOC_SNOC);
> +DEFINE_QNODE(qns_snoc_memnoc, SDX55_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDX55_MASTER_SNOC_GC_MEM_NOC);
> +DEFINE_QNODE(qxs_imem, SDX55_SLAVE_OCIMEM, 1, 8);
> +DEFINE_QNODE(srvc_snoc, SDX55_SLAVE_SERVICE_SNOC, 1, 4);
> +DEFINE_QNODE(xs_pcie, SDX55_SLAVE_PCIE_0, 1, 8);
> +DEFINE_QNODE(xs_qdss_stm, SDX55_SLAVE_QDSS_STM, 1, 4);
> +DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
> +
> +DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
> +DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
> +DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
> +DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
> +DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
> +DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
> +DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
> +DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
> +DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
> +DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
> +DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
> +DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_qdss_stm);
> +DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
> +DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_sys_tcu_cfg);
> +DEFINE_QBCM(bcm_pn5, "PN5", false, &qxm_crypto);
> +DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie);
> +DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3,
> +	    &qns_aggre_noc);
> +DEFINE_QBCM(bcm_sn8, "SN8", false, &qhm_qdss_bam, &xm_qdss_etr);
> +DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc);
> +DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_memnoc_pcie);
> +DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_ipa, &xm_ipa2pcie_slv);
> +
> +static struct qcom_icc_bcm *mc_virt_bcms[] = {
> +	&bcm_mc0,
> +};
> +
> +static struct qcom_icc_node *mc_virt_nodes[] = {
> +	[MASTER_LLCC] = &llcc_mc,
> +	[SLAVE_EBI_CH0] = &ebi,
> +};
> +
> +static struct qcom_icc_desc sdx55_mc_virt = {

Can this be const?

> +	.nodes = mc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> +	.bcms = mc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *mem_noc_bcms[] = {
> +	&bcm_sh0,
> +	&bcm_sh3,
> +	&bcm_sh4,
> +};
> +
> +static struct qcom_icc_node *mem_noc_nodes[] = {
> +	[MASTER_TCU_0] = &acm_tcu,
> +	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
> +	[MASTER_AMPSS_M0] = &xm_apps_rdwr,
> +	[SLAVE_LLCC] = &qns_llcc,
> +	[SLAVE_MEM_NOC_SNOC] = &qns_memnoc_snoc,
> +	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_sys_pcie,
> +};
> +
> +static struct qcom_icc_desc sdx55_mem_noc = {

const?

> +	.nodes = mem_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
> +	.bcms = mem_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {
> +	&bcm_ce0,
> +	&bcm_pn0,
> +	&bcm_pn1,
> +	&bcm_pn2,
> +	&bcm_pn3,
> +	&bcm_pn5,
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn3,
> +	&bcm_sn4,
> +	&bcm_sn6,
> +	&bcm_sn7,
> +	&bcm_sn8,
> +	&bcm_sn9,
> +	&bcm_sn10,
> +	&bcm_sn11,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {
> +	[MASTER_AUDIO] = &qhm_audio,
> +	[MASTER_BLSP_1] = &qhm_blsp1,
> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[MASTER_QPIC] = &qhm_qpic,
> +	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
> +	[MASTER_SPMI_FETCHER] = &qhm_spmi_fetcher1,
> +	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
> +	[MASTER_IPA] = &qnm_ipa,
> +	[MASTER_MEM_NOC_SNOC] = &qnm_memnoc,
> +	[MASTER_MEM_NOC_PCIE_SNOC] = &qnm_memnoc_pcie,
> +	[MASTER_CRYPTO_CORE_0] = &qxm_crypto,
> +	[MASTER_EMAC] = &xm_emac,
> +	[MASTER_IPA_PCIE] = &xm_ipa2pcie_slv,
> +	[MASTER_PCIE] = &xm_pcie,
> +	[MASTER_QDSS_ETR] = &xm_qdss_etr,
> +	[MASTER_SDCC_1] = &xm_sdc1,
> +	[MASTER_USB3] = &xm_usb3,
> +	[SLAVE_AOP] = &qhs_aop,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_APPSS] = &qhs_apss,
> +	[SLAVE_AUDIO] = &qhs_audio,
> +	[SLAVE_BLSP_1] = &qhs_blsp1,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
> +	[SLAVE_ECC_CFG] = &qhs_ecc_cfg,
> +	[SLAVE_EMAC_CFG] = &qhs_emac_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
> +	[SLAVE_PCIE_PARF] = &qhs_pcie_parf,
> +	[SLAVE_PDM] = &qhs_pdm,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QPIC] = &qhs_qpic,
> +	[SLAVE_SDCC_1] = &qhs_sdc1,
> +	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
> +	[SLAVE_SPMI_FETCHER] = &qhs_spmi_fetcher,
> +	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM] = &qhs_tlmm,
> +	[SLAVE_USB3] = &qhs_usb3,
> +	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
> +	[SLAVE_ANOC_SNOC] = &qns_aggre_noc,
> +	[SLAVE_SNOC_MEM_NOC_GC] = &qns_snoc_memnoc,
> +	[SLAVE_OCIMEM] = &qxs_imem,
> +	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
> +	[SLAVE_PCIE_0] = &xs_pcie,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sdx55_system_noc = {

const?

> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *ipa_virt_bcms[] = {
> +	&bcm_ip0,
> +};
> +
> +static struct qcom_icc_node *ipa_virt_nodes[] = {
> +	[MASTER_IPA_CORE] = &ipa_core_master,
> +	[SLAVE_IPA_CORE] = &ipa_core_slave,
> +};
> +
> +static struct qcom_icc_desc sdx55_ipa_virt = {

const?

The rest looks good!

Thanks,
Georgi
