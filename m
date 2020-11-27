Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D82C60AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405369AbgK0Hxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgK0Hxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:53:35 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDEC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 23:53:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so4562515wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/ks/jnOnx2V4g6fp0YfK0QCpJ1gtm6gOdpGW+D6UW1k=;
        b=RgEoXR4Iz9mGXu1n7m16EZUiixCGlQW5aboKwgs6+VNNR707mHmFTz0eXUsfRmCjQX
         ZJOzLNpeLRMNviuPOV1+JisEyczgh1BKBoKhFiHQbKPCmhmulXKp+MqO+ry6GZj3ERN1
         b7XZblLpRISYWni2DSUNHDa12nkPWKfY5mSB8jtXvc5YN3tg69Z19h/Ex9zAzXnlmw5T
         MCmwDYeTCV+ML8qH1k4CpxJkA3xcZwGy9a2e+04OK0bjcUemdJFKxsp0D6lz9MhBp4VQ
         xLjtzbMGTEACeKs1uVK1YyPGPDEkVjGIMuhtqN0llYIVM4fXUzcTODm0esrB1CnwH0Vm
         T81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/ks/jnOnx2V4g6fp0YfK0QCpJ1gtm6gOdpGW+D6UW1k=;
        b=XUSVtFKJhXWVRkZp4RFtA9FEkne0SPtEzq8PUSBvD/ICqvW5p/uwl/Sfj7fWZLAzQN
         RnllO6aqyQCgaw2axSMLw4D6bcMbOE8mhz6/2ycblJ5hyFoIh+XJVtlrILrlk96+gHr0
         R+M+n1ZvKxVtXTMmJHZb3O4fZNSkw+z1oqWt4YON2tzkb11O4iz1gpSSo8llyCynXujo
         C5vRQqAm5lW7nts1TbXIzc0Ht6mIWbh342izc0ZpEtB4AcvqboN8Zy39a9I6V1yJrH/P
         E+JDspP7ozF4lRppI7fOdx7JySp3iLXnzW6NcAyX2Yv+BYxLMqJQkQ1Zj14UlfnkoXye
         JucQ==
X-Gm-Message-State: AOAM5335p67/hFH4Fnoxn7BKNryWHNQ0nSnVilaLr6CmaHt7BgrVNLjJ
        u+QlQop6kecd0NQgBwluU62/aw==
X-Google-Smtp-Source: ABdhPJw9S66mmI+0qTw2TUKVCXiDbYRh/GqWSqUlvaAcrWwx6GKilkDrZN8KMYYQdlrAHWkk8TgFRg==
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr8565144wrr.375.1606463612772;
        Thu, 26 Nov 2020 23:53:32 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id c190sm6457198wme.19.2020.11.26.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 23:53:32 -0800 (PST)
Date:   Fri, 27 Nov 2020 07:53:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH v3] mfd: kempld-core: Check for DMI definition before ACPI
Message-ID: <20201127075330.GI2455276@dell>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
 <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
 <ca31b0f1638d07f5c597c652ed887a3ce0f595aa.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca31b0f1638d07f5c597c652ed887a3ce0f595aa.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Michael Brunner wrote:

> Change the detection order to priorize DMI table entries over available
> ACPI entries.
> 
> This makes it more easy for product developers to patch product specific
> handling into the driver.
> Furthermore it allows to simplify the implementation a bit and
> especially to remove the need to force synchronous probing.
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> 
> v3: Cleaned up comment, added Reviewed-by
> 
>  drivers/mfd/kempld-core.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)

Nit: Just letting you know that checkpatch.pl complains about your
patches, since your From: address does not match your SoB one.

Patch applied though, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
