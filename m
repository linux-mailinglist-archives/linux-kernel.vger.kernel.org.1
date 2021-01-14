Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678AB2F5E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbhANKTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbhANKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:19:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE481C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:19:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w5so5148948wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IX/Vl8tZidwpXK8aDv9kkwvwljH5l08IDwbkXx2VWNs=;
        b=IhShY049DvvhzelRe+DNH9Q+LXxcisEDSoKy6BIJj4DM2KoWNVxhNPWwvbUiBDlBCu
         877ALAOYcoaoOo9IQcYY8fFZpm1f30kTWKECmxyx2+iyMr+UwVgoFQeRuoMzH8zdfv5p
         c3wwc/8kA/WIeEzRo3nXa2ZhdZ/d7lqe++77APtLjn+ZIAeNiLMR/FATXNNf9HE6NCAz
         CoyyMow8mBVpH9NmKBJ//dQw8TNHjmf9XMhPXq2kcLrtW6klap2pA1y9mBpWyKk1XXVO
         zhXHu2N/llAscBSKcxYUt/5HMo4q0hwGUgdok3z6Lojr7B9iFnkSZMd3ckrIrJU9IZMO
         +P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IX/Vl8tZidwpXK8aDv9kkwvwljH5l08IDwbkXx2VWNs=;
        b=X38JL3qCfacTSW3LLiTM7DwGohoR3PKTq7bskEZIF7xGZ+Gw6F4T4A3oQW3+WISZ0g
         8VatQIFneRvYDLW+IJzONh46g/QGG83jyTLvP4FyqGL8E5X5Oe/evmEXiRTz4MR7KOwe
         sLYpcQVJNsmwsTH2XAqCzz7oWL65WMIIGhAZoCNbsp5+9tMNHX1Dea3beqER3EIyENxl
         +KusJ5Rm1y55bFEkfF/okPTbTu4zTKsyRv5qnmq0I7AYRgyRX0hCIqXd9WUbhMLIbTor
         OhJeBZfEvHSNfh1nyYYlc/JSoJHBNp98HggxVAPoyUOFzJ4lo63wjUnLs5WzGpFxtjcj
         E9aw==
X-Gm-Message-State: AOAM531j8eQODHJ3zV7XVoDgCZYjh0JANbuDdg8CfnZZ8wJoFLHvQfQj
        ryv9GFC5jl8zPZuFEbYUAdnAPw==
X-Google-Smtp-Source: ABdhPJxZKQNic7KvcwKccIQPRDzbqZMvt6BSO+Q4C+rmscm0KAkc5oQcBJcDhgVfkqTUHRB72lN4Jg==
X-Received: by 2002:adf:f707:: with SMTP id r7mr7342801wrp.113.1610619540444;
        Thu, 14 Jan 2021 02:19:00 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id l20sm9805238wrh.82.2021.01.14.02.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:18:59 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:18:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mfd: iqs62x: Remove unused bit mask
Message-ID: <20210114101858.GO3975472@dell>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-3-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609707369-11297-3-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021, Jeff LaBundy wrote:

> The register write that performed a mandatory soft reset during
> probe was removed during development of the driver, however the
> IQS62X_SYS_SETTINGS_SOFT_RESET bit mask was left behind. Remove
> it to keep stray macros out of the driver.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/mfd/iqs62x.c | 1 -
>  1 file changed, 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
