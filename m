Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DCC2F5E99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbhANKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbhANKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:21:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FBC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:20:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a6so4047288wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9P3ld5aRKGFDposfpcVyC/9O/XEwNg25A3P+K+YSyP8=;
        b=EriA8LrKocY/rXHAP6D3ew1VLT5+W0Oi92nxPnSOfJGBKyHYSMtAVlwGIec/30vh+i
         i3OZcHJ4T9TEFPpE2Z6mJZLAdSfnCmlMq9FwP2dCN7S8A2nQccuEZxSUJh3+qp8eCpz9
         dVekqin6/qqSA7pQFs/uEsk4dXUOlXy5HeJHfFLd250ju2aulmhCmJHq5OO8eoCSR0tn
         TodA9sqf5UGbXrruVLMqWbtWgV6Ut3RY7a8k2QhlU6WxA4wbPuNAe/syyRXRdKT1MEVx
         GTzvTS+OQiVXEQ7CbeZvMIeLa2NjPt14K680949Uc9cjfByDdoiNpkSQbmB/pXNve/3Q
         zxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9P3ld5aRKGFDposfpcVyC/9O/XEwNg25A3P+K+YSyP8=;
        b=cQfqOOpHyQM/I9Mr1kVUJhKfHYsCGxqGOZfe2y2VxbNiuH2dsGwcJ3a80uKP67S0Ov
         2+XW15MRAhovf19L/kfsrv20ZHBWdn15bFpNLzZpj10SP6koEheZODJ+OZcX4bPbUEgh
         oC0Til+bZA0dv1OPCcBxXvsNzV1uPwZ1WppHIiRkIk7S9xI7ur5VRMXgFXgcxRZPZ79P
         Ir0AEoBm8b7twdNBoCgk2YCTgfYy1dJaQN/Wf0gdEDhv+ZN1hcmxOBjN7CMGyfE7S7kp
         uA5oSVJ4M34SzBpOGBt0SvQboWBDMxOB5EYycbCxTb0/jhMVIoICXWHyj0d+HCUuhWuv
         WXNQ==
X-Gm-Message-State: AOAM532d7P6rIVyBPA+CYxMwOzyhlcmgPBDlZVj9FzLdk4LM6OqL9Pp2
        le/X9aQxbJ8TjnJbMNBO6TvxgQ==
X-Google-Smtp-Source: ABdhPJwyMBvmJBUlDn3Q2mIgZ/gcsBjyNQ2LMuFqQk5s5xXgTjKgPPpiRAkGk0dGF4GLxg844CE9lQ==
X-Received: by 2002:a1c:5941:: with SMTP id n62mr3233464wmb.63.1610619616591;
        Thu, 14 Jan 2021 02:20:16 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id u205sm7380303wme.42.2021.01.14.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:20:16 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:20:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] mfd: iqs62x: Increase interrupt handler return delay
Message-ID: <20210114102014.GQ3975472@dell>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-5-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609707369-11297-5-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021, Jeff LaBundy wrote:

> The time the device takes to deassert its RDY output following an
> I2C stop condition scales with the core clock frequency.
> 
> To prevent level-triggered interrupts from being reasserted after
> the interrupt handler returns, increase the time before returning
> to account for the worst-case delay (~90 us) plus margin.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/mfd/iqs62x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
