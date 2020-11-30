Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F02C8993
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgK3QbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgK3QbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:31:02 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED34CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:30:21 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id z24so11857513oto.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Bgoh1l3MHIhHDr+hgc0XVmeqZH9CASsikjVSJH5R0cs=;
        b=o6QP4kDzDtQyHqO5dSS6eSOqTqAhEmml0T779W3hG9CfGkTIfjGD/SZmJ+xKQcHAmS
         WUcWjliVA+UvUqwGmuCgxGmODPYxeMk3JObAxQ0jkiEBl6TfRSajNa+ehxWJWmuQw5ox
         b0xEyuRBe614HmCLUaKgr9mnUJ07NHMRs+fReTTjAm6t7kTwWvVF4v7f5aqOeogRRLGr
         7G9X1+gslXzVEm2Ak4vCuEKVv7jr7uBhyD0XxvDQhwBsA1idaJ4w1RLnGhYmw1eck+2r
         1IWOp976szwb+vqqV/C/1JTJHz1N0OXNfYzP1Iy8+7VTiiTX5g/jilZfN8LqFfRfNM2M
         bEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bgoh1l3MHIhHDr+hgc0XVmeqZH9CASsikjVSJH5R0cs=;
        b=ny7dnr9k6jmb0pzS6Xtd+VJYUy0ARmOh81tRrbR4IEJvl+MgHgETK5vvVTrnaHqzXe
         JELFFumcveU8WTuwiBfUpfOpQHdc87rg86DGWOCm6FSYa35z5QDCbCKh1EOTeONc4vGC
         iPdhLtRMODmKlC4EgP1aXfW0DO8VIMSV+N6YsBa3hOtw1bFluvd7p6yw99/C53YsSB9N
         kdlbQVkhWshZ86Vv7FbYJOmVEkQAzah1UoZ9Ka+KYML4uDrOlUqhK1LoZi9ih7guIiMM
         5AKOUHAkW+GEM/A4RivVv+OkDVhCX1s43OzD+nH66JLxIwE3LTBpYMxWY0lDHvX/rAKA
         947w==
X-Gm-Message-State: AOAM531ivK4sKRqJPAiw5mjdKd4XA2N9cZtM3mMsgt9enscPBeazIfhP
        epf6VcovcY5/ShguIyeMhzvrqg==
X-Google-Smtp-Source: ABdhPJzh98WZ+HFNhF3r/OsOtg0aHVaF4Yrml6oG82esGs6S434Z8UJJwohs7PLxby3kqPzky1LMIw==
X-Received: by 2002:a05:6830:128a:: with SMTP id z10mr17338726otp.3.1606753819932;
        Mon, 30 Nov 2020 08:30:19 -0800 (PST)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id c19sm4892501otn.59.2020.11.30.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:30:19 -0800 (PST)
Subject: Re: [PATCH] arm64: defconfig: Enable QCOM_SCM as builtin
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, John Stultz <john.stultz@linaro.org>
References: <20201118162528.454729-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <444557fe-32f5-9e1a-8165-c9c952619516@kali.org>
Date:   Mon, 30 Nov 2020 10:30:17 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118162528.454729-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/20 10:25 AM, Bjorn Andersson wrote:
> The Qualcomm SCM driver was never explicitly enabled in the defconfig.
> Instead it was (apparently) selected by DRM_MSM and by the recent change
> to make it tristate now became =m.
>
> Unfortunately this removes the ability for PINCTRL_MSM and ARM_SMMU to
> be =y and with deferred_probe_timeout defaulting to 0 this means that
> things such as UART, USB, PCIe and SDHCI probes with their dependencies
> ignored.
>
> The lack of pinctrl results in invalid pin configuration and the lack of
> iommu results in the system locking up as soon as any form of data
> transfer is attempted from any of the affected peripherals.
>
> Mark QCOM_SCM as builtin, to avoid this.
>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d129340a7ed1..287ccf98dc41 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -99,6 +99,7 @@ CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
>  CONFIG_INTEL_STRATIX10_SERVICE=y
>  CONFIG_INTEL_STRATIX10_RSU=m
> +CONFIG_QCOM_SCM=y
>  CONFIG_EFI_CAPSULE_LOADER=y
>  CONFIG_IMX_SCU=y
>  CONFIG_IMX_SCU_PD=y

Tested-by: Steev Klimaszewski <steev@kali.org>


