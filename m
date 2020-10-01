Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5815C27F99C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJAGmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:42:05 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37563 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAGmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:42:03 -0400
Received: by mail-ej1-f68.google.com with SMTP id nw23so6366953ejb.4;
        Wed, 30 Sep 2020 23:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AFhmMjQUJ4d/TCY1Soy1FghGhE1GLMxB/YcvvfKL18Y=;
        b=KsyBRg0+4kFoduXZ5Rqm4JsKN1wFIDdWZn9jk9l+YgabIo40fDxm9bYDHw922dqKkj
         aFWTHcwQh2TYny7F5eWlJ8Uxj2gIC7OMEtjnujstOHic3iftUOhoIStfKatzz3mGQ88O
         v3vtm1d5BB4ha+c6f2plhOcs3HYANHxR8yoIQqqhpnvLxQYj4FYzvzzUn1zA2U02CQ7K
         nesa6QxVy3jzOgmC1uG2stii1+Ak2eJroG+ED53sB/Mt/Qii119thUll2FOypTGn2b2Z
         ov1mkvkTUTQyjjp65UnSBHF/98oInje+akUMh+0e9BP3zBTDYT+JxRwoves2LqcNwBFh
         rddA==
X-Gm-Message-State: AOAM532EopTei/UZnWS8SdWq11Xtp8ct6Ew+2Yc7o6g0M/1ET7PPz4tq
        6gygjytTllwrssHNy4YrDAg=
X-Google-Smtp-Source: ABdhPJypB3zCOCcDJbhJSVfDFxjYjy+8oWdrBVDzuFFC3vv0mlahEnCsQ0cYw3m2eN0WN8K7H+wl5g==
X-Received: by 2002:a17:906:2cd2:: with SMTP id r18mr6820842ejr.371.1601534520883;
        Wed, 30 Sep 2020 23:42:00 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id lo25sm3262836ejb.53.2020.09.30.23.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 23:41:59 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:41:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 14/17] dt-bindings: arm: hisilicon: convert
 hisilicon,hip04-bootwrapper bindings to json-schema
Message-ID: <20201001064156.GF3018@kozik-lap>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-15-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-15-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:17:09AM +0800, Zhen Lei wrote:
> Convert the Hisilicon Bootwrapper boot method binding to DT schema format
> using json-schema.
> 
> The property boot-method contains two groups of physical address range
> information: bootwrapper and relocation. The "uint32-array" type is not
> suitable for it, because the field "address" and "size" may occupy one or
> two cells respectively. Use "minItems: 1" and "maxItems: 2" to allow it
> can be written in "<addr size addr size>" or "<addr size>, <addr size>"
> format.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hisilicon/controller/hip04-bootwrapper.yaml    | 34 ++++++++++++++++++++++
>  .../controller/hisilicon,hip04-bootwrapper.txt     |  9 ------
>  2 files changed, 34 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
> new file mode 100644
> index 000000000000000..7378159e61df998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hip04-bootwrapper.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bootwrapper boot method
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: Bootwrapper boot method (software protocol on SMP)
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,hip04-bootwrapper
> +
> +  boot-method:
> +    description: |
> +      Address and size of boot method.
> +      [0]: bootwrapper physical address
> +      [1]: bootwrapper size
> +      [2]: relocation physical address
> +      [3]: relocation size

Intead: items with each item description (bootwrapper address,
relocation address). This way also min/max Items should not be needed.

Best regards,
Krzysztof


> +    minItems: 1
> +    maxItems: 2
> +
