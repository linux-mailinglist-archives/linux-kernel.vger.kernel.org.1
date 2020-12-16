Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233A42DBD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgLPI6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLPI6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:58:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5DC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:58:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y23so1636624wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CnyyKZ0Zx1BxINWxPqOgHgBA1hAyUh9nq8RAHfNkCus=;
        b=fZHU34jQlz1e2bWiS5yLio80iUB2pJw8FaGi9nwz3hsQAEpTTVFuu9ePjFreyn4sO7
         PU2DQMlqac65tisGoObkSRhMZ4Cv4e9ByEitpNNAKP/hiQWG7RDD0dj2+UFfc/CAQnxv
         SSQJOp35A9eG6Wlqwk8K+Kr0V7t/Y0MgdwLiSOG16X5h+WgldPpM43if+YUzeQST2qgf
         E7pW6z1bseE5Rrii/nSvWF/MAtRDgpnZbEzCSkjg2ZNyPJt0kzaOQoYV2gfSXTT09QZK
         GSAwtVf5/4BSe9+g1NS6PCDRqUxjeHG1JyCwIpryX0ejWqaq2+4gkfPXu+JE5erN0il6
         Yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CnyyKZ0Zx1BxINWxPqOgHgBA1hAyUh9nq8RAHfNkCus=;
        b=Gsf73BCJYwHe/AsLGzrHTgla+TtytwvBeD3QylpmjoXuF8YCCep+ERWoK3APvCdrGb
         MICygCAZFUBkZMvJYS3Y6GT0k50oisBLbxh5aWjY1nmw0ECu7mwaLBbDBBPFYoomq/f4
         wkXCwuBL9h9e38DJ/M6ULPDD/HFY3c7SJ5odyCuBgLSNGmlq+PBkXPUzqVq/D4/P7B7d
         fuwQVa7DU4rLw86XouscEXpFIRWx1G3sztE0X4S3zwYzMG6WxiA7ruCGoepTTKQSGFRi
         eLJZLf4Oh32wNz0EKAamzhDhvBGZ+uWYx+vIQBtjQqmVwD3n3/SDlb4Wdqs2dcF16Fim
         JWWA==
X-Gm-Message-State: AOAM531S8+ajLz9GwvK4Hw6oR5vhiqV4SWeTjYh4wzhNPTrVRGvJltmF
        Hf8wyLYEhpgtxycXflvoJ6AsyQ==
X-Google-Smtp-Source: ABdhPJxyD6igsMnOelb9CqTbNakrbhwN83NwuKQeIw5SBvQ4jSlkvgYwYSwyhS6HWPk299U6SE0Fsg==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr2200622wmd.41.1608109089069;
        Wed, 16 Dec 2020 00:58:09 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id w13sm2126803wrt.52.2020.12.16.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:58:08 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:58:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: mfd: correct the node name of the panel
 led
Message-ID: <20201216085806.GJ4776@dell>
References: <20201204093813.1275-1-thunder.leizhen@huawei.com>
 <20201204093813.1275-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204093813.1275-6-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020, Zhen Lei wrote:

> According to the definition in leds-pwm.yaml, the node name of each led
> must match the regular expression "^led(-[0-9a-f]+)?$". "led" or "led-"
> followed by a decimal or hexadecimal ID number.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
