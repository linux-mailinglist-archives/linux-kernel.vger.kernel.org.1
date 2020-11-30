Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89942C899F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgK3Qe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgK3Qe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:34:27 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BFCC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:33:46 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l10so2806959oom.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wF+KSfYEGboISQSOjgP2pMG62F3CaZKfxuQBmoNo6Lw=;
        b=KHTeyW9YWN46J6zn8dWFKNKuyXTJ+ZrpFUSnUzALlVa3LlUBzHLbpISiFJjZ1IfJ7k
         lmYm9BpYpbzpNaT18wPEzosYSmbPMUigfWbSTsVTNaUKkx4ADLwuL5b5cGJjwehHpIx9
         VeUTVt7N9m0+Vas/3VvB9+G7Aaeb/gchfJWx6qdk97nVbzneF2ayiNP7574m16GbmKhY
         noJvNMTrXNb/bWYP1DWIilgpjzEiWQT/kryKbeockUf/iKQAGqvqIGEg5PJQ/4zm81fE
         9P8PfNgCxIGSBWbg28DNGG5JFACDOUWTA+QHYRV5/QtJuBA2D1WkQsGP39iVLzcb4YGo
         Wzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wF+KSfYEGboISQSOjgP2pMG62F3CaZKfxuQBmoNo6Lw=;
        b=FRtAsmDEYVQ1WT3d9x4PO+BtpvB9Q9uKR0IZvLuptBhp3qBKsxwdWW4lpP5jptnGU9
         V6FnS0GTYlLqmbNmWdrvpJImm6IuP6ezxHymWBFwmb2prBXiDFYIbbM85gAVSIGc4qQR
         CHa0+9qsazbfRIF0y9KXbQXGqruvlQFrF4gTF3pSNVmwrrQ3O0O4oB0FvGLZeGCXML10
         NWcVeJQlGmzZ4nU/nLafRnUg9d8nJcXo2R/3NHx/eFM8OF1RF6/F3ar1ASmnBedaJKFd
         zao0iERO2qUyOwH5xMDidlVccObfhn95qeIQGszmSFQhi5L8iG5UBCY7R9QBzduECHoa
         MD9g==
X-Gm-Message-State: AOAM531lfl4oyt1Dp2vviYqY2Y9VUs3Z5uB/ueBOQPaOW1qE/T1pTeya
        h8rfnFXjUU7wGfg5akILomRWDw==
X-Google-Smtp-Source: ABdhPJyjcGTdWTupTqlH6YUBnBmz9KTU+QtA2cbbLviGxqtyXgjGbM05figv88/NJ1CLaX5YrSHz6A==
X-Received: by 2002:a4a:9711:: with SMTP id u17mr15983851ooi.57.1606754026199;
        Mon, 30 Nov 2020 08:33:46 -0800 (PST)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id g82sm10031114oib.38.2020.11.30.08.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:33:45 -0800 (PST)
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm PON driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20201125023831.99774-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <b4d23c05-60b5-d7f9-f116-702a7abcc988@kali.org>
Date:   Mon, 30 Nov 2020 10:33:44 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125023831.99774-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/24/20 8:38 PM, Bjorn Andersson wrote:
> The PON block in the PMIC provides, among other things, support for
> "reboot reason", power key and reset "key" handling. Let's enable the
> driver for this block.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c9246f51085f..8e3ed05b655a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -521,6 +521,7 @@ CONFIG_POWER_AVS=y
>  CONFIG_QCOM_CPR=y
>  CONFIG_ROCKCHIP_IODOMAIN=y
>  CONFIG_POWER_RESET_MSM=y
> +CONFIG_POWER_RESET_QCOM_PON=m
>  CONFIG_POWER_RESET_XGENE=y
>  CONFIG_POWER_RESET_SYSCON=y
>  CONFIG_SYSCON_REBOOT_MODE=y

Tested-by: Steev Klimaszewski <steev@kali.org>


