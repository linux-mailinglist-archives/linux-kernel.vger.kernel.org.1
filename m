Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5112AF658
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKKQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKKQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:28:55 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:28:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 19so2823143wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ym5EYgB7vSN3P1iRjYUrfz/yvJ4pZVCU3lTRTichWa4=;
        b=X0XY7NGRos3Zh12NSdN/jvcFDGU+7W1MeDKQgcJu+DM8sCijAC/I0k7IhLVKQS1LOF
         PseeqfESggiWjTdEAcnDuhU8XJGa9dQhEwLjpI/18jyBeM9WSE8G5iiR1FtycKFW5cVk
         HGaeWrzFwKLg1jp/MwyMTmnF+b+hwxkhXSoJqlCCP2TrzE2MEYYwEZ3DiBJRLlfuGft+
         ya/gcP9Jgc/0SQaMwCaZab6l+9iyj1PY7uT9VPCPIFIf0PBMBxrMMh0EnIFfmSRPd3b5
         X+ioqAHmSusmWzoobzN43VI/GW90tmMGVfDq6lQzCHZ3H2erwUJo57K7Yz9ceZ8Y6IEa
         y1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ym5EYgB7vSN3P1iRjYUrfz/yvJ4pZVCU3lTRTichWa4=;
        b=HN7jS+ww7A/yfHfUkWzgO9rPcUeUSMlO92GLCxleAo8ApG1k5hA1u577fcC5HU/xzz
         nW3oBnVGxcG64wYvs7CQvtyFDzSAPCja8GxYsZ6Uj/Da4LUnt7+hC+R3rRhKbDackJ8/
         PzE/THkKagmegEvD20/+hPriU1D05h3y+BSV/YC3i4jfJuklfl0/wb3RbuNRl/WQSRWm
         PgoEFBfCyfMzGAQT3nchL9JX1xLENnGUcSuQqz91bgBP/p20M5dyh2g0BAyrHMOJOs+R
         KnQzeeVfHDXZY4Wrxtwhi+mon//1XCf18xylv4FKn+7Xcm/6G4kdzqET18NIOOeidE3/
         Hjpg==
X-Gm-Message-State: AOAM533hGoFlToEpcZV16eeB6wguwtcnSzyRNBxD1xEGuf7bZlFR8EhD
        mNcg48VmKMnGEXPqXU4JrYadcA==
X-Google-Smtp-Source: ABdhPJyAOVWEmMpYP8Gjbn2N58tbEs1A5iI8XhfBfzfIEopp7tmhw7fX+9i/0PE8pnKKD5XoGcfDEQ==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr5377342wmg.68.1605112133539;
        Wed, 11 Nov 2020 08:28:53 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm3138756wrm.51.2020.11.11.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:28:52 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:28:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     darkstar6262@gmail.com, sameo@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: htc-i2cpld: Add the missed i2c_put_adapter() in
 htcpld_register_chip_i2c()
Message-ID: <20201111162848.GP2063125@dell>
References: <20201106074346.194621-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106074346.194621-1-jingxiangfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Jing Xiangfeng wrote:

> htcpld_register_chip_i2c() misses to call i2c_put_adapter() in an error
> path. Add the missed function call to fix it.
> 
> Fixes: 6048a3dd2371 ("mfd: Add HTCPLD driver")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
> v2:
> - add the tag Fixes
> 
> ---
>  drivers/mfd/htc-i2cpld.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
