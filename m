Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F232A62EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKDLH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbgKDLH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:07:58 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38BC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:07:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so10780355wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aQ70y6nwaGDpVB89YcPazoVFZhvvvPhw+w2IO+1iReE=;
        b=jfysMykNr92UGsxIyN652D9xl/9pnxEADKDct0dfoNO4LiBNV3A/PP9Wd83LRENnX3
         auopbcIq3U8iz7xjlh0FqIBSGUP+eAT3BKoK9btR7rzu6FL+zs+U5xDZaJuMcczeCAhr
         r3xHpNXrgPA8QuyOEw/HwTUl2EXPEEIufGWGsPC7AUiROdCtJGz9p81OzEngd19rj8Ib
         p90yTmQv/nlx4AhOwJ8mor3Ho4Tq39dcAkjY8dMxrDcYTpbgQd0l5pfkGgIvFi01MASC
         /PTksf/V2B4MH/GN/n+sSEWz2uK8+qmgarR/XtML7y/wqxEn19GuaaQjdtZxW77jTvin
         1hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aQ70y6nwaGDpVB89YcPazoVFZhvvvPhw+w2IO+1iReE=;
        b=lmEUAGpte6OzhebCmPCErzmgt7SJCeX7v/NXI7Ft3wztj9E/LNThgJV/dggunKFiaX
         PiQ9QWDrfoKeXN4TH8wpNUVudIlmqg0QcQhBuBAAPxX3Fn7mgE1QoF2NvG+jQF9e+FPr
         MbgRMzBfy9yaoiY+kwthID/9SHr2nLEoAVb4Ri5N8hJxmyfeds570Ec1JjxdHPSa21o0
         ISHTClTIeok3iXU5QrgZMHl3ciuDkCUuKIsQMW0OZSq4bibT30P7GL+53QISm1IDHp2x
         1DeVMq5aSf7/iAaFCvAKJaZ9lrNOPv0eXwPx5CNsGviHOxpvOO4XU6AA1vhSNiP8EF4n
         tL7Q==
X-Gm-Message-State: AOAM5338E529hCWGbgVK/6W4uzRjMc+8413522GP+2T2G2JcAY4BLLLf
        WZkmmxmyD5c9P3HLVKFOLcCd2A==
X-Google-Smtp-Source: ABdhPJxcshakygaS5pG5d0dSFGQuQu935SeJv+/o49do1BVAVtfmVD7fWuIEWoa1UUrK19pvhwCoRQ==
X-Received: by 2002:adf:94e3:: with SMTP id 90mr29585926wrr.380.1604488075362;
        Wed, 04 Nov 2020 03:07:55 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t7sm1889308wrx.42.2020.11.04.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:07:54 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:07:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     kholk11@gmail.com
Cc:     broonie@kernel.org, lgirdwood@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mfd: qcom-spmi-pmic: Add support for PM660/PM660L
Message-ID: <20201104110752.GB4488@dell>
References: <20200926125549.13191-1-kholk11@gmail.com>
 <20200926125549.13191-7-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200926125549.13191-7-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020, kholk11@gmail.com wrote:

> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the subtype and compatible strings for PM660 and PM660L,
> found in various SoCs, including SDM630, SDM636, SDM660 and
> SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  drivers/mfd/qcom-spmi-pmic.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
