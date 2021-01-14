Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DA2F5E93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbhANKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbhANKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:20:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7AC061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:19:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 91so5166563wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JTjMnC7epO2M+kmG9NGUY+viKlUnUBw4wC4DgbcuUPc=;
        b=B64eh2TUFb0ao9IJhHCrtHND9Am2OtpFXjf+ENwOS8zdkduEZtgynn450ayi60bwFM
         eLIFvLbxKCsUidPcqTD1KbOJx6MFRXAKmaqO8TYEtYkNVbYrVtmyiaPAhmiSF9bW10Wv
         d/7RQvGBSn8cVqsFOwq4H5k9urtv3bNEqT7VxAidBJbbdXJVpxaW6Xu50Mcwle4exXTP
         StS1jp5JPlt17nrOMElFZADfov3WSYin7+uu4TBwwk5Ukkcsc2qt8IS89TgkKqDTQOaw
         hq5zKlTeASjnXhcl8u/4lvgDX2tFf4K+3SjCqxHbrnSOwTAtwLe3dxOoNLPOkmqvijud
         j3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JTjMnC7epO2M+kmG9NGUY+viKlUnUBw4wC4DgbcuUPc=;
        b=DP4DqpWRqYqtozHVd6QcF+iKCVcOka2iV1fSvtBEiO9FKR/hxtsFN66nD20rth5dqa
         OYIeJLuEvLGG+OKRVxw22W0uSkXnnQFWEPdEmOLuk5OnOKf6SkBDoSYtVbGy8MR+BK3b
         u64DQPLMy5J6XUMLq+r3rICbfHeNhsZ22jj5AE8I95CqNe7JY/mZM8siTeqwX7LQXOGk
         7K+0G5whPGRQaawQB4QBmhCwwZCQmAIWLM57rmqJekbRcRvjMVjYifUVPkyMKztG0BsN
         FHQ3pqoXmZK3nuwF1lIP2z/gpqfurr14fjfaTBy2w86ai9qSuGgHcR5/RzjkcFM0fyXi
         t2vw==
X-Gm-Message-State: AOAM531RYBp0QR1RZWk+d5NWrQV3A4eb8Efn8hNV1pVr03rmB3uUSXM2
        TSkP1qWK+lZqnqolyjmSe/Ui+wfYNDkotpCW
X-Google-Smtp-Source: ABdhPJyN2r5XwrmXCLGqxIwGJ/46OqwCqmocYVLQ34Emd7TvUAR3j8/Y3r3l87T4dPmVW69oJJ75NA==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr7251281wrr.9.1610619578197;
        Thu, 14 Jan 2021 02:19:38 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id w13sm8575332wrt.52.2021.01.14.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:19:37 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:19:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mfd: iqs62x: Rename regmap_config struct
Message-ID: <20210114101935.GP3975472@dell>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-4-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609707369-11297-4-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021, Jeff LaBundy wrote:

> The regmap member of the driver's private data is called 'regmap',
> but the regmap_config struct is called 'iqs62x_map_config'. Rename
> the latter to 'iqs62x_regmap_config' for consistency.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/mfd/iqs62x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
