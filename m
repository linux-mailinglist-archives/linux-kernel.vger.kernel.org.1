Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744D92FAA08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393979AbhARTYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437207AbhARTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:19:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D05C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:18:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u25so25632935lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1G++hlstE5EhL0NBi0mNuJgSYlqKjxYXBmRajyzuRok=;
        b=CIr2xOcp79UpmWJ/jyt/XIKvAFMFSeDmOt3iPj7fpsRRj78cq96vdOB6vPLauPdGVm
         GBP3+Vjinfw0cr4nZkCwhex4OS4nplF0EIHooHPh2gO6j0gI8t7NgQwes4HGNpz3YSVn
         RRtbowVP6LbaTCXeRXqhGTuA5Z35bbdn+8WxzBDNtRP4pecko6dZ9HaFS9L5dBI0NvYe
         rwwp4WYEXYk6Ih0sl28bOHIhOdx4U6uBv4UX7WGNKTbSR3L5E7WZlrXAmBhVHlPy9V3s
         tC/MkAHH8qS8md1C9b0bOPjtYV7FbbOiA5lg4xSrTSm9IL4otHBcQP9uLFHtTx3sZMFL
         XMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1G++hlstE5EhL0NBi0mNuJgSYlqKjxYXBmRajyzuRok=;
        b=WZgtpIL8ozcRsf6hhthR5PkYrxGF5lNpgS4thpv61L/5zX4W1+uWeXrHHMiu7jk7dJ
         k35n0u4hZ14o+s+5czIZfvFn6SPjsZTqoO/aHcLXH5u8Uuu/b9bNd6usnaXYYB7kW1Q/
         s/ATVCbz+1wvKN0QjyrYrte8K9GVfVXahy0Hz1MPkJmVIAw36AxKsuCPlx6zjXrHiEvY
         vFk3B2IXEzBOJHP2aERkE9YObvZCJ8ODT2DR5JdP8FPhmoRD7b4KqFBAXRM9wzPkK0mZ
         EOxY/bl/PHSNvZsKgnfYnr8jeneL5UKa3o4G4WVY5eKsyhOhpXfOYJglM2bhnolckPM1
         ROMQ==
X-Gm-Message-State: AOAM531cCNv9E5+MZdqPKE5ym6216D7DxaU28ytCuYeckpUjWdxPwTps
        +wXjRvHo7/ikB6hnKcNgKyveTA==
X-Google-Smtp-Source: ABdhPJxUgdKMu/r2+a09F5q+MudyKgnyRx2Z4mFWXK/y9jeHKBuRZ6u0z8GSceupre/DIB4pgM7OmA==
X-Received: by 2002:a19:a04:: with SMTP id 4mr266769lfk.30.1610997529211;
        Mon, 18 Jan 2021 11:18:49 -0800 (PST)
Received: from [192.168.118.216] ([85.249.43.69])
        by smtp.gmail.com with ESMTPSA id g190sm1987837lfd.72.2021.01.18.11.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:18:48 -0800 (PST)
Subject: Re: [PATCH v4] media: ov8856: Configure sensor for GRBG Bayer for all
 modes
To:     Robert Foss <robert.foss@linaro.org>, dongchun.zhu@mediatek.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Tomasz Figa <tfiga@google.com>
References: <20210118190132.1045913-1-robert.foss@linaro.org>
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
Message-ID: <db76aedb-de5e-2040-1e1c-777848614a7f@linaro.org>
Date:   Mon, 18 Jan 2021 22:18:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118190132.1045913-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Thanks for you patch!

Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>

On 18.01.2021 22:01, Robert Foss wrote:
> The previously added modes 3264x2448 & 1632x1224 are actually
> configuring the sensor for BGGR mode, this is an issue since
> the mode that is exposed through V4L incorrectly is set as GRBG.
> 
> This patch fixes the issue by moving the output crop window of
> internal sensor ISP uses by one row, which means that the Bayer
> pattern of the output is changed.
> 
> From:
> row 1: B G B G B G ...
> row 2: G R G R G R ...
> raw 3: B G B G B G ...
> ...
> 
> To:
> raw 2: G R G R G R ...
> raw 3: B G B G B G ...
> ...
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Suggested-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> ---
> 
> Changes since v1:
>   - Sakari: Added mode information to ov8856_mode struct
>   - Sakari: enum_mbus_code updated
> 
> Changes since v2:
>   - Andrey: Switched approach to changing the sensor configuration
>     to yield identical Bayer modes for all modes
> 
> Changes since v3:
>   - Andrey: Improve commit msg to explain Bayer shift better
> 
>   drivers/media/i2c/ov8856.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 2f4ceaa80593..8a355135c7db 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -428,7 +428,7 @@ static const struct ov8856_reg mode_3264x2448_regs[] = {
>   	{0x3810, 0x00},
>   	{0x3811, 0x04},
>   	{0x3812, 0x00},
> -	{0x3813, 0x02},
> +	{0x3813, 0x01},
>   	{0x3814, 0x01},
>   	{0x3815, 0x01},
>   	{0x3816, 0x00},
> @@ -821,7 +821,7 @@ static const struct ov8856_reg mode_1632x1224_regs[] = {
>   	{0x3810, 0x00},
>   	{0x3811, 0x02},
>   	{0x3812, 0x00},
> -	{0x3813, 0x02},
> +	{0x3813, 0x01},
>   	{0x3814, 0x03},
>   	{0x3815, 0x01},
>   	{0x3816, 0x00},
> 
