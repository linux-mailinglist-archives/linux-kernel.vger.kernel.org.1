Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7FC27C19C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgI2JrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgI2JrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:47:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:47:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so4634355wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xgu+t4c0Hj/GvcOVJdD7iwVpZkR4c7q5e85qV1kBjNo=;
        b=NOW8WOxtXjyauKTcGXQNShd+/NM0gPC9MrygYedOz5v41mrfSXbNUNmdQfME8QDtvO
         f3jSB+rhaRY5W2z8QdLK51GueF373dNTEapV4x8ijeTdbjuXS7TENVmJHckAbNrP6Ggo
         /6yV+RFR1KKo1mIpPBslUDmJ2C887+oSC5ZyYVvHLgMetOQ5XOLTJbWak2Qx1Sp38Ixf
         UEv4X82/ARW2YE1S6kkP7Pb4cLXGQDuk2YiViBGqQTk0hIKsVlxcffYPpTLnbFIEnGXD
         qvxQ4MyNmiumjCNW3d5+TYBVrABi0v+xJPjbJTp6CdEi5IYnZHw8t5nCUnzTI2T0Z6Ug
         0jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xgu+t4c0Hj/GvcOVJdD7iwVpZkR4c7q5e85qV1kBjNo=;
        b=IVhAdRY/HeTVGodR8OEj4d+Ezshv81kZrF35Hxn9KqDKHz0RbR8eaTBj2ixH4YjMBG
         bOen1267R+nWYKJXnUIsbWLb3WFttS/d3OtNlYtSnnhpBvasjHW7Ni6tIHSdT0c5fDab
         zRDYvwgDLiyetLAiuaoNG0cjB4AvA+El2qamLI1CFQUmcXVVTM6j1naxgsplaI61T5+W
         2WwudLvW90DHvkq4cIDYnjPFWu2sfnQ0WqAWpsXWtAdA8/mVLtIWSJERUog4rOa3sZ/P
         jSOcQ+6VAOkrvQHQyUm87hf7QMNzWS1HYkXeo8EOai8ySRQ7L4GIBjcfFubfLPj+LkQx
         eujg==
X-Gm-Message-State: AOAM533peLAGRCJIfRrUQ6sGMI7t8AU5mZDcvBoGpYX8JwzvgIoPWPA8
        zbLvkEisjAJOK3ELyOa/YSY0spnQ1Y5Nmg==
X-Google-Smtp-Source: ABdhPJxXEep7SF9Qpk4Znubq9FBmlxsqdwPUuDmXdWiZ+hVgqT1yyNneHvGay0XQFwJsamVSunbhtA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr3523229wro.152.1601372820224;
        Tue, 29 Sep 2020 02:47:00 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id u186sm4763822wmu.34.2020.09.29.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:46:59 -0700 (PDT)
Date:   Tue, 29 Sep 2020 10:46:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v2] dt-bindings: mfd: correct interrupt flags in examples
Message-ID: <20200929094657.GD6148@dell>
References: <20200917185613.5905-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917185613.5905-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020, Krzysztof Kozlowski wrote:

> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted same
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> # for BD70528
> Acked-by: Tim Harvey <tharvey@gateworks.com> # for gateworks-gsc.yaml
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add acks

FYI, this should not bump the patch version.

> ---
>  Documentation/devicetree/bindings/mfd/act8945a.txt          | 2 +-
>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 3 ++-
>  Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
