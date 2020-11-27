Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3252C61BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgK0Jck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgK0Jcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:32:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC76C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:32:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so4869633wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lAxkAYvCa7eeDOc+aoeZS0G8r5xJMwvnpqn8jKIhjj0=;
        b=WxsRmHZK/D7hklZYA+bATzachY4P8/1CjCLcq5zP+7ElEyu783Ch+nUf1lcnuignHS
         T85HYP9g4tT5lC9VwQ7d8INq7eCbWKJnA7hDQNk8zPclOmXGAm8azI8dur5e4jpbf69i
         goO0fsroDYpazuS9uX+IheOGpXF6STQtb1oMOlAf19y2nz5cr5T1nrVukyrVRdrzbBpQ
         UKQtzUwJdg2bXMuJybPc2y0lcsLNEzAd7DfAjMTVdhrIS8aba7b6GoUhaILvkqSygYuA
         GaIjh9atCdamRF6umlGotb27L4VRPsemKz+59kniEWMBSO1/ttfi+dJKPkPTmXL3hqyE
         RYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lAxkAYvCa7eeDOc+aoeZS0G8r5xJMwvnpqn8jKIhjj0=;
        b=jLBaqr2v6YsapB/m1kiJJy+FaiQMoi+oVmUSRrgUs0UI25J4B+eXVUfMpCwYq1jn4u
         E31vz3vLE/rWWzED4RsIdHhfCXuWHr2B+dU/M4Rq4DTsEYdbWGEUu9A4RgdxXhze0P3O
         w8GT410t0I50Y0OLdDmZizify+15p8/tl2MXZOWUkaVfVHQ41Vgka+kuKBJlDUepS6YF
         Af1W4OYkjI3d36B9Hx9Q9CZn/UUBZshYwJAgwMno+vcKT6gCQ1sXQ5HpoD+WkwuGv3vw
         kUdpG8YZFjSv088ijpQ3kv2nAX66+RyQTfloSQiXW5wS0u+sVr7xi4nhQc+5cvzVuji8
         iFyQ==
X-Gm-Message-State: AOAM532Kugss9U5POvklK7b4uzvEMqPYrroV0cXJvuPF8vdTezL1gMBv
        AM12QbZ4qTwvytfCsnS9w2pgpA==
X-Google-Smtp-Source: ABdhPJyE5yrp/QCLUHsa9WBEW+n10WAdt6LRN1ctPgu6eAswud+B3UVJlIP1A0aF6fmiPpFLGrcw4Q==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr9370555wrn.392.1606469557473;
        Fri, 27 Nov 2020 01:32:37 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d3sm13168196wrr.2.2020.11.27.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:32:36 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:32:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Shihlun Lin <shihlun.lin@advantech.com.tw>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: Re: [RESEND PATCH v4 2/6] mfd: ahc1ec0: Add Advantech EC include
 file used by dt-bindings
Message-ID: <20201127093234.GQ2455276@dell>
References: <20201125070744.4651-1-shihlun.lin@advantech.com.tw>
 <20201125070744.4651-2-shihlun.lin@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125070744.4651-2-shihlun.lin@advantech.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020, Shihlun Lin wrote:

> This files defines the sud-device types and hwmon profiles support by
> Advantech embedded controller.
> 
> Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
> ---
>  include/dt-bindings/mfd/ahc1ec0.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/ahc1ec0.h

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
