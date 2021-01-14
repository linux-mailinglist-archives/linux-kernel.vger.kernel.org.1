Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D82F5E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbhANKVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbhANKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:21:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6D9C061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:21:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so4184879wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ioElmSSQBq4ewe2c9MnqUseUB/dr1wIzp1aRLBynftE=;
        b=MNFuI1a2ZkTCD4CEWQMX5EffUUluvlOh9lFR1B8cCTvtiJD/R9Qe5b0+ermZaSc4QF
         XBc/SNJlWS+348uT+XqYOYpnZXu5tKHXL7gawp/L9iwIqnC2HdSGvcq6DI9ztmAUyK1N
         HdKxQfFBssRviDwGpJC9xV65i5qnQiV4lRFNVyWmrZltRmweB6iDWoAcmPjy1mnPMrQt
         jz9Zr0SHt27Beql0xVNXdZ0yeAWArliK4O7Jq27teApQSFIFoGEFIOIivpTzMCRCCG6N
         ER9M5zU6etIwKV1Mq3CkbTAmB/ev+ciqAAXHq8qcDxxMZcVeSn5jo8U7+aYFxeRSs1yY
         aZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ioElmSSQBq4ewe2c9MnqUseUB/dr1wIzp1aRLBynftE=;
        b=VHpkCNa0lhZo6FDUtTeUMyQ8VnmA/s1f6wlNFkMfCrNP8fCaScmMKqSq7pvi+w3jVD
         BeaK7ky44VUuu1sAA0zeMDhUlqgd+v6s/OG1Eorgy4fGfrV9mU4m0yRyrAbzHCJRZoqT
         NwlyVh2oVjzwuHodzlkBRLQlpKolfJgUWXviNQYTv7rsQVFE7lU4aS7/ObGcFyoEAdXe
         8SUMrDvylJIltIy/H4o4WAH/6Oj8WOClmrZtnXufbFS570KEGTgGlJM48St0wcGhc3Ml
         t3FcuE7Hmykryoggs6VMI+9lXEBr8RnnatruXgFF+y9W1dGQTPtn4rapTP001EBIpHYj
         Iyjg==
X-Gm-Message-State: AOAM532NqkbkkUwjm+aSz1AODmgBjqwRHzVCvHALJONPhBtQzkr1g0MU
        XOR4+C2bvWpUigcZGErbC4cv7zBi4eSjU4h5
X-Google-Smtp-Source: ABdhPJyFS90xToHcA74Izr3EeLRMPB+YGrBjX4TNVnW9dnGc5Y3pYmH9w0f8dmV0mOfvOyLJCJ+VIA==
X-Received: by 2002:a05:600c:154c:: with SMTP id f12mr3242162wmg.120.1610619666615;
        Thu, 14 Jan 2021 02:21:06 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id r20sm10457496wrg.66.2021.01.14.02.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:21:05 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:21:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mfd: iqs62x: Do not change clock frequency during ATI
Message-ID: <20210114102104.GR3975472@dell>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-7-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609707369-11297-7-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021, Jeff LaBundy wrote:

> After a reset event, the device automatically triggers ATI at the
> default core clock frequency (16 MHz). Soon afterward, the driver
> loads firmware which may attempt to lower the frequency.
> 
> If this initial ATI cycle is still in progress when the frequency
> is changed, however, the device incorrectly reports channels 0, 1
> and 2 to be in a state of touch once ATI finally completes.
> 
> To solve this problem, wait until ATI is complete before lowering
> the frequency. Because this particular ATI cycle occurs following
> a reset event, its duration is predictable and a simple delay can
> suffice.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/mfd/iqs62x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
