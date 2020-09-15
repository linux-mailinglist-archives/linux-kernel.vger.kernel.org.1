Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74D26AC99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIOSww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:52:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43237 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgIORYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:24:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id g3so3765105qtq.10;
        Tue, 15 Sep 2020 10:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IlLyj2saxTTjsywCjSXJt2Rce2uMyGTitfwMxI+v+Kg=;
        b=bWoNyZ4d0WGjLTVjn6VokQimjGERYkPWQh/McKBdpSP8vAuCg+6aT8Gy/n9qBEhzSR
         02v+4xWOOKRQlkhQqvtuNPxBZjco5IbNdEHN6y5BiackCbafwOyY9RGWoGq7GYBI4BZX
         XM9tSvxYT9GpiSLHYqAl10RJ01mQUzLBBaxdvuBEW+5+9DegShUvATrRm9IHMK063ZyK
         QZQWI/RTB98SPwyaeGi4f6TZXnYDrvib/eRbM05ocZUP6UlJcexJhn8cNOxyLOgukOwm
         cO4QOrjDB9ar/cbOPF7w8A+7yc2ctnAW4e2aU2c9Mx/qYLxT/R5HkZk3ltZF36/SUUAo
         3DLQ==
X-Gm-Message-State: AOAM5328mMEpZrnD/sAEOcs7/TdiAvH7fGx5rqh1AsrkgNHGUzfarJsR
        Q50U3N7fDxz002uTopvW7ChriKSrqXRPtUY=
X-Google-Smtp-Source: ABdhPJzvXSvuBSSIbmk0BXjqKM7yXBjjp5/cHX5mDIy0KLIb2rQdnPHckzSsVC1ZOZe2R9OMCrPjoA==
X-Received: by 2002:a05:6638:14c8:: with SMTP id l8mr18794773jak.136.1600188830508;
        Tue, 15 Sep 2020 09:53:50 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m8sm7937079ioq.11.2020.09.15.09.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:53:49 -0700 (PDT)
Received: (nullmailer pid 2112732 invoked by uid 1000);
        Tue, 15 Sep 2020 16:53:46 -0000
Date:   Tue, 15 Sep 2020 10:53:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-power@fi.rohmeurope.com, Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Message-ID: <20200915165346.GA2112678@bogus>
References: <20200908145900.4423-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908145900.4423-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Sep 2020 16:59:00 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted some
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/act8945a.txt          | 2 +-
>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 3 ++-
>  Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
