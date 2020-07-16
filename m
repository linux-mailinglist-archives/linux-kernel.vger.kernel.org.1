Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AFA222433
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGPNqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 09:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:46:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:46:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so11655433wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1Crn7XaTOFPhrYlDIsZatzqk+FDLvcbXlzkZjad2WAY=;
        b=ZCu8CXInP03TrQAxb0+85FxBWLoCqTLjBYofXz9dz/MHBJ77oYeCkS8BZyB8PfsyfR
         h7cjuoHQ174FvNAJe35uUkTDTuLXEnw9B1Cflc08dT7LoiAJ9eS/MTClE919psUmJ1Yu
         p4hq+AQIbrL3c/EQPIxO7/uBvFi2BgRHqOB6Iaxhwlr7sxy4ZjOm3HmFduE5nVCaoc40
         GLk8L5R5p6M8YK+HSwfbUvxTgwY7ielCaJZwmN2BYHiTS/+L6bfalaUV0qJPIu/KD7Kw
         S9tgrpiX2WcT4Xz3ZUF3ygTqzjgJ1Tn23fETuDN+PWti4AfK+fNPDv5fpTB+vXXq4CvH
         hiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1Crn7XaTOFPhrYlDIsZatzqk+FDLvcbXlzkZjad2WAY=;
        b=ndDRHGHLDXosrgIZ7/iGhDU3wiFXjWBOLmjf26JGRMMzaLiAdr/HMXWWecLY5EiLRu
         ofPvjYKeNhjP7ZixF8/Ww1YaqMCOkPthAe9AzOFHPud17JvhbwWkvWzOymBQk8rJeMV9
         Ent9f5+3S0v1u8CwFzi5+KRvijPN1Clq2gva1r6G1i2tJPeE8WvgO9g/3yRVahFi6Lv5
         McUwOZYu2ZNrD+N3nZkDuda6Zz8h5+PSgScMCzINf6MjEq0QdP9HDQfEYLbFyiR3HymC
         +KBCCgnqjAGgvhGxjud1LN/cCZ/SO8JIAso2znwSoB06Ll/pxtsUxA3GKUPDrn44w+yz
         Tcbg==
X-Gm-Message-State: AOAM532yi8hA/bC0Z8cdXyOHARCM18oNc/iNTVE9NXo06fS0kCzDByt5
        5/6rj4fG0lmaJakeuyIcWJTDDQ==
X-Google-Smtp-Source: ABdhPJzABLymprHrJbOu3vDvVfyXX0rXIMPbOqyh2TEOe8TDMx7XvUjAN27s4XgvRAL1AYfWA8gMCA==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr4433464wml.92.1594907165870;
        Thu, 16 Jul 2020 06:46:05 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w13sm9162781wrr.67.2020.07.16.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:46:05 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:46:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200716134603.GR3165313@dell>
References: <20200716090236.13057-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716090236.13057-1-miaoqinglang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020, Qinglang Miao wrote:

> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  drivers/mfd/ab3100-core.c | 15 ++-------------
>  drivers/mfd/ab3100-otp.c  | 16 +++-------------
>  drivers/mfd/tps65010.c    | 14 ++------------

Can you split this out into different patches please.

>  3 files changed, 7 insertions(+), 38 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
