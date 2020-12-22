Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0A2E0851
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgLVJwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLVJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:52:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11401C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:52:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v14so1334725wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s8FlNBJc1tOTzj1/5kq2UR+5JabDHOpPzaLRtEUB/HU=;
        b=gvvTyEq3lOW77ADAiTItaTJnUGezfK5apmO7swllVcsQZSe06cTh2e4paz8ofAf3NO
         h/mXiSo7GQuyKJTRTuvXIJJ3dvlXHXGsOA3Urs1IRfx/8ebdhXfp3fNJs2a4+KmVygK+
         ROpDp4kq6Tqu2uv5FLLlRjd+RjubqcvcZZFfylmKIbCTCUoIrzacxiu6s2XD3Oow2y8V
         LQFKgGJxJJzJocKRxmlMHwV9fAHAYNWkl2N9d2JY5+leOndLXq0+tNCybHERqWg75RFR
         1/RWsCVpt8uxjA2DS4k7pfHkat8iJghci11Po6iEmFOmy+FThuqd/0wRFg5MNAo6Da/2
         CL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s8FlNBJc1tOTzj1/5kq2UR+5JabDHOpPzaLRtEUB/HU=;
        b=sAUHFS6jIgHAuqveOagsnABX0HT/h9rGZXnC1qHDl20Pm+N0499P7LSrTrmHWO+1vS
         6zow3BEZ51KIoaJgn37F45fyC6lS8c26gnWkRhXXlUS5VTKhLX2ePdppDdNJH9sDxJI6
         z8ggAjy/+av0GOfx70agYo0ezjGF9jmiHL1Og+BOMZqNtL3bul/yGWF2qHrgj8NIjshj
         68piADBE/DBZMbUKayc+y7aXswi7J0vc1XQiMfEfjFsIS2tTYusMI7Kj5DLwzEmFAEV8
         Vhkl3dITPEZM23k6DLIFXqHtTcIvABJrgfryx8vmYa3ciYP2pXMqH1fwy79Y1+mcB3hA
         05yw==
X-Gm-Message-State: AOAM532F42BPmArXnx+tVVWmdCUpe5DWFLiuCB61mbsvSynX1AEReZlg
        6nK3EvFIK1g7UDwuOX9614VLLw==
X-Google-Smtp-Source: ABdhPJyfs5ZpTygXxaGZ5j8GtWYGKD6uk7BkURU0CRMiJrejb6fOEpzfcrY5OfLnYg+fJAPxGXnicQ==
X-Received: by 2002:a1c:5410:: with SMTP id i16mr21190404wmb.30.1608630730769;
        Tue, 22 Dec 2020 01:52:10 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id s20sm25149033wmj.46.2020.12.22.01.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 01:52:09 -0800 (PST)
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20201222043745.3420447-1-bjorn.andersson@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] arm64: defconfig: Make INTERCONNECT_QCOM_SDM845 builtin
Message-ID: <41571e59-b9f4-3e59-e23b-d9fbda9bee18@linaro.org>
Date:   Tue, 22 Dec 2020 11:52:13 +0200
MIME-Version: 1.0
In-Reply-To: <20201222043745.3420447-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 06:37, Bjorn Andersson wrote:
> As of v5.11-rc1 the QUP nodes of SDM845 has got their interconnect
> properties specified, this means that the relevant interconnect provider
> needs to be builtin for the UART device to probe and the console to be
> registered before userspace needs to access it.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

> ---
>   arch/arm64/configs/defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 838301650a79..3848ae99501c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1078,7 +1078,7 @@ CONFIG_INTERCONNECT=y
>   CONFIG_INTERCONNECT_QCOM=y
>   CONFIG_INTERCONNECT_QCOM_MSM8916=m
>   CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> -CONFIG_INTERCONNECT_QCOM_SDM845=m
> +CONFIG_INTERCONNECT_QCOM_SDM845=y
>   CONFIG_INTERCONNECT_QCOM_SM8150=m
>   CONFIG_INTERCONNECT_QCOM_SM8250=m
>   CONFIG_EXT2_FS=y
> 
