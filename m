Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7F2BC388
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 05:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgKVEMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 23:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgKVEML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 23:12:11 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6EFC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 20:12:11 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id t10so3195496oon.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 20:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nUrst92hN4R1vEKZe17VBjcPtW9XUfweRUvi4imPNMQ=;
        b=iCpTCFswqajPzLzuyGR95U7aVI7wvW2Ra7+CqobSR1cwc3UOOKnYVCi2XgwAezAM10
         XbOJtaJiVoSyMMIUZUuExLV3orfDIkgYO9IxGTZGwn4WOeVfndtmpwGF+k76mOi45tW4
         C7kBU3ZqnyVK/1Hzqon9DJAGAdoy7+SN89mJLNta0EDj6Smdzmc5oPmctHr/YuTs6elO
         Bgd8qgjYVQavbvh9H5OCrJPg5UUVAdTdFuPt79nd1p2uUqKkEC+9b9KuUg9mV/PKfd2V
         tnpWmlLBKabEPQAEsx0aYBmCB+2NVthgEPqBGXGkr8DrSC6n6gli0XzwOsl8GP/1OpR6
         FQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nUrst92hN4R1vEKZe17VBjcPtW9XUfweRUvi4imPNMQ=;
        b=DEOJyFPKxgdOnzN8YaeZivs3OZRKSeTzE0/ZSKpdZJ5GV7FWdsuT912HP8FxWckTCr
         aA/DkQWLbnT+N1OslCvFdUWl9U3Bd5x6rCxpcJZNtrIeTzjij7a1u4jdrFz1cjRK/DpT
         AYicSVK1BYbEoqH0xPckQJ3E/RtpnbF1i/QubET+rm5QA851kwLWJym1ER0feR6a4d74
         U0IckoDkwSUcgDs8ot/j+d1BqktvkCymjEdS8MK18vEwZBZjAzpTK60zMbbwP/2LLMDn
         wML8v7ctScZefPPf0axYINIXoeq9QgW+MUu09dbK6gLRx+ejbyL6TE+/pdIeaqGOn2qm
         ssrQ==
X-Gm-Message-State: AOAM533y5hPjoQ4g8FkAf2SLPWFq+hSgKOENnxOw6NVtJsS29Ts//REl
        R5hU2hsJDXB4D91x99S5mi7vcQ==
X-Google-Smtp-Source: ABdhPJxChDi69FkqZW7zJ2WKySbDy1owm9VNzJSI1WuQN44hg30kWYrZ5DgrvVBvFYeCM6cQyqBVag==
X-Received: by 2002:a4a:9664:: with SMTP id r33mr4883708ooi.17.1606018330793;
        Sat, 21 Nov 2020 20:12:10 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c21sm3368320otf.20.2020.11.21.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 20:12:10 -0800 (PST)
Date:   Sat, 21 Nov 2020 22:12:08 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org
Subject: Re: [PATCH v5 4/5] PCI: qcom: Add SM8250 SoC support
Message-ID: <20201122041208.GD95182@builder.lan>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
 <20201027170033.8475-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170033.8475-5-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Oct 12:00 CDT 2020, Manivannan Sadhasivam wrote:

> The PCIe IP (rev 1.9.0) on SM8250 SoC is similar to the one used on
> SDM845. Hence the support is added reusing the members of ops_2_7_0.
> The key difference between ops_2_7_0 and ops_1_9_0 is the config_sid
> callback, which will be added in successive commit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b4761640ffd9..0b180a19b0ea 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1361,6 +1361,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>  };
>  
> +/* Qcom IP rev.: 1.9.0 */
> +static const struct qcom_pcie_ops ops_1_9_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  };
> @@ -1474,6 +1484,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
> +	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
>  	{ }
>  };
>  
> -- 
> 2.17.1
> 
