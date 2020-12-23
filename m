Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4A2E1EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgLWPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgLWPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:43:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:42:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so5721033wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LU4YLLdgV2OHKcF8z8NsZmWpfmKfBzDLLjzmSIcMu+M=;
        b=XjwbOGoD22JQ1FeEPQbToF//vDKBjWM4Be/7VWRXUpJIi599X+nB5D6iXntYZOgmi/
         M24NMvxv+DNCyKsiaOcIQz216zfz57vol3NZDILc9zzAndfpKPqdPlrrf+bsNeD2w5oL
         DCX+ku0xVAUTpkKsv26l2S8d5L9XYDg6GMQvK2ipo7aZtvtg+zbJNK715gsU+uv4oe0X
         zsR7596apzOQUGWrlz00ngwNG9eSVqnGCeksMFl2/aBHkKv8Kn8zpRFHAF14l8g1M+96
         dOsEfwaOIEmIyF7QkLw96H882NyqQbuGwIhLuxHWQuQ7eMNuBn+F89Q4w4Nx6fYL2X4T
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LU4YLLdgV2OHKcF8z8NsZmWpfmKfBzDLLjzmSIcMu+M=;
        b=P/jxwfUupcPHTR3ItNwNKeMu7PBjFhEVE4z74vqWZClKzCR8Nc6OpwMIqc4jU5Et4g
         gzxvkBeXcHcFnw1492O4goSbauNBFDsXKnXsEoABgmkbIEy+3fxTT/+zmlTwWt1RkBCo
         7HKk/XA1qtP6A0pTitvK82KD5V4ICP6dxHnSw6fhu4aC866d8PkqBhrno8yHtjStnTqy
         ias/erpR2UGG9Z9pPfgfg9gA74m+xmimbgOxqmBkavRsPy/vD7oeUwQU8NZJbO9wfWWi
         CbXhH8SyQFcSYrGO2ShLEHTdyOU9KPE+uOHk/mG1gZmZEBmwQZOLHMzuFV/gxMslmLAj
         j7nQ==
X-Gm-Message-State: AOAM530zeb5ltCjTFZV8VBE3qhFH/FZJaBoUiFFRWdhFmQW/5ph0MScy
        0UH1TlR722rvzFZ+7F2tOL2m58L3rI/Eh4Y+
X-Google-Smtp-Source: ABdhPJyAgccZMIridU2QqUBkK2SszokiMsJmp8ELchpHkPSbmVY1ZqYuxu1yXbsTdaStfShhQ0QqGw==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr296853wmi.23.1608738165570;
        Wed, 23 Dec 2020 07:42:45 -0800 (PST)
Received: from dell ([91.110.221.175])
        by smtp.gmail.com with ESMTPSA id o23sm39690328wro.57.2020.12.23.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 07:42:44 -0800 (PST)
Date:   Wed, 23 Dec 2020 15:42:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd/mcp-sa11x0: use DIV_ROUND_UP to calculate
 rw_timeout
Message-ID: <20201223154243.GC681741@dell>
References: <20201222133326.19698-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222133326.19698-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020, Zheng Yongjun wrote:

> Don't open-code DIV_ROUND_UP() kernel macro.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mfd/mcp-sa11x0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I've fixed the subject line and applied the patch, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
