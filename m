Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C342C9157
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbgK3Wm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3Wm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:42:57 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52507C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:42:17 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so11358785pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jU2fyM0lZB1mWD112XT0MzePw1IcvoPEr8FjSNN3GVc=;
        b=d/L7bjhpvlqbSpSiVZevXSgcedQhlGt5uyWgzdEQAaniYUTBj/VsH48ccMyHDRRXPs
         B6xvUL3Sua3vcR02NeAf15w5INoh7Rl5tuS43cWotBCyKJchxdKcis6vjCJZrTnPF5fI
         Pb68Iwm5BMEX+8bZLJS8yKgc378S/uhf7tnpCjUqktQUL27LDwY9/tYasPN/fY8jaHGi
         fjO0eEW0jpX227WVC2zhjJBp/cRCTFO6vAKBisKcFDjbXpX7Il5hWhgug5b9KS9jhXcO
         4WiIS8NpOOKJsREthNVMmbP8zecPGZLm16ubwdRg3ZIoyNTDz+9CFDKaYMknw41OFs1X
         2sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jU2fyM0lZB1mWD112XT0MzePw1IcvoPEr8FjSNN3GVc=;
        b=EhE4Vou9WrKSx+I2ifKj78rfvJYK5CRGOZ33d0yeTteKPV7f6xwE1eis4XY8frHN8y
         0BnbIE8GjbD1rRb5WOKrewFDfgVI3QX8mSgdlbPt9gvztpQAwEZwNQGNag+4SEnSNhH3
         vCS/Zs45z3nBkPqZ8eUGNrU2eQS2Re09o1j/K2DDd2AADjEYEndnpq3j4NHp1qechG4h
         VJefqjHAuO9uLUr8ywraXPD1mnP5a342e9J8N8/O51ul7r1fW0YycN55iR9BXQDL6U6x
         5RbaQ15tlC3GkdVeE0cNgSo3nxfWx+dyfh4AuyM+0y+fgfMj6TWKDRKmjbPfMSmofhZL
         5Dyg==
X-Gm-Message-State: AOAM533exjKUn/A3lGlmllwVTLKivurD158LV9jOTMu9YcgXAl+0LVEB
        LM1CDIsLe1yTA+2X+2IgYsAGpg==
X-Google-Smtp-Source: ABdhPJwH1L6Y4ECljQI3VNFAMDdmvzfXlcEdtckdXik+6mI6dg1wPGHhjA4wAQaVfJVD+ZTR71ZcLQ==
X-Received: by 2002:a63:da0a:: with SMTP id c10mr20184407pgh.145.1606776136873;
        Mon, 30 Nov 2020 14:42:16 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r11sm509642pjd.52.2020.11.30.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:42:16 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:42:14 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 18/25] coresight: etm4x: Expose trcdevarch via trcidr
Message-ID: <20201130224214.GL1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-19-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-19-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:40PM +0000, Suzuki K Poulose wrote:
> Expose the TRCDEVARCH register via the sysfs for component
> detection. Given that the TRCIDR1 may not completely identify
> the ETM component and instead need to use TRCDEVARCH, expose
> this via sysfs for tools to use it for identification.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 009818675928..277fd5bff811 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2395,6 +2395,7 @@ coresight_etm4x_cross_read(trcidr10, TRCIDR10);
>  coresight_etm4x_cross_read(trcidr11, TRCIDR11);
>  coresight_etm4x_cross_read(trcidr12, TRCIDR12);
>  coresight_etm4x_cross_read(trcidr13, TRCIDR13);
> +coresight_etm4x_cross_read(trcdevarch, TRCDEVARCH);
>  
>  static struct attribute *coresight_etmv4_trcidr_attrs[] = {
>  	&dev_attr_trcidr0.attr,
> @@ -2410,6 +2411,7 @@ static struct attribute *coresight_etmv4_trcidr_attrs[] = {
>  	&dev_attr_trcidr11.attr,
>  	&dev_attr_trcidr12.attr,
>  	&dev_attr_trcidr13.attr,
> +	&dev_attr_trcdevarch.attr,
>  	NULL,
>  };
>  
> -- 
> 2.24.1
> 
