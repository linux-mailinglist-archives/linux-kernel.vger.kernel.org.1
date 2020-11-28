Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9F2C716F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391251AbgK1Vw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbgK1TBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:01:49 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D595C09427B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:36:06 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so6047922pge.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oorQnZ3X9K7o6Vi8SRIRZ2P5+sGMNT5C3v8YMuqPYp8=;
        b=lB3sodOPpd1yngKU6rJ8B0PdNSpXydjE+3yZ8JKpAJ05rWUgkKs6WW1yVR9yhH3Prr
         wsgIDxGu71BLeiinSFKQ/Iu9H48iJwjo2fp9Oz+NlKtBg4DGvHxloqZKgc7IQ7qMS9a0
         hNNzQlgD7EyJ0+JGOlcM1ee8ipRx4Eoi8cbopS6neOF+cNK0x5ZHJbHRPnryjByq9QQO
         VRvKPjMd+ssud+dcYI+XqCfH9aH4C7ssTaudt9WhRmHHeWzYb41L4LIWiLfUY86CL9Bi
         B+ofixbLx1ZArOGgm3VFgACtExjjhb08Mov14UydrNjBly8K0LRfzno9YsqmdKXweFvx
         hplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oorQnZ3X9K7o6Vi8SRIRZ2P5+sGMNT5C3v8YMuqPYp8=;
        b=AL0wOoFOlwGea2MEo/Kwc6YsnewQQB0VkW87Fxveh3BnuZimFjKIfWikJ8V0SF4nLF
         L5eXyx5POBXT6Qo5UtiRTBhHjJDjG8Z2out9hkT8CQ4n+lykBO9EMc6h5DlpKzzJkGEC
         TEccd1/D3PKBkNXBqsdU8sOA4IBgrusmUpHJfWn/+14rnflTJda6bO0XzSVmqN0h7FFG
         kjLEynLHRnHizmyMt+jglooaykGu37FBA6+AQbbUHPUUzAUgGpvnkOr/n43WPutZt7go
         2/sI63ejFHyzWP9ceHYo04e2OqOeKg5NBUZSQjtzGbtlDuaLwxjzhGTiOdvaTS/jLgHG
         hhCg==
X-Gm-Message-State: AOAM533Ktqxk+n9zu3OwJdMV5DTrP5UYWA4lGRZsmSoiURBS5uRCiq7O
        4d+oNUKlDRQ9MA7usCRZUhmk
X-Google-Smtp-Source: ABdhPJxBnYMftlA1E+SeVA2QYE+CB0vb+Mp/45FPJ15JRIvZ/EmexhujbatGGprmrky4QH/XlPhssw==
X-Received: by 2002:a63:4:: with SMTP id 4mr9671601pga.443.1606548965999;
        Fri, 27 Nov 2020 23:36:05 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id i29sm9291856pgb.10.2020.11.27.23.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:36:05 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:05:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] arm: dts: owl-s500: Add SIRQ controller
Message-ID: <20201128073558.GA3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <db464acca3e30bfe5beaa3eb395c0664e2e7f3ad.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db464acca3e30bfe5beaa3eb395c0664e2e7f3ad.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:08AM +0200, Cristian Ciocaltea wrote:
> Add SIRQ controller node for Actions Semi S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index 55f8b8c2e149..cd635f222d26 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -233,6 +233,16 @@ i2c3: i2c@b017c000 {
>  			status = "disabled";
>  		};
>  
> +		sirq: interrupt-controller@b01b0200 {
> +			compatible = "actions,s500-sirq";
> +			reg = <0xb01b0200 0x4>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
> +				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
> +		};
> +
>  		timer: timer@b0168000 {
>  			compatible = "actions,s500-timer";
>  			reg = <0xb0168000 0x8000>;
> -- 
> 2.29.2
> 
