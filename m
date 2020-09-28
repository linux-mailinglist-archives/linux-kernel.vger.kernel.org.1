Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC80D27B501
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgI1THv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:07:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37094 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1THv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:07:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id a3so2567966oib.4;
        Mon, 28 Sep 2020 12:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HW0SNAUaJb67rBXmqThlSQm/kVHy1iHZ89+dsR1mJCE=;
        b=WUfVqpLfyknLNmiywY5WzJiObYzAGLzsXfLqeDFXnET+DekpGxVFBzkklciJ70M/G0
         G5ZCFM9BfoXVqwFhRp9nlxob0c9W+NsXdRIQCc6IyOlpAxPhntZxgjIaGA9XZo58e7X2
         2MpwVyEbnICFr+kWtD5+5+zEmXUg6yXwv0XgAQiZiy4a1V0hwm6gJ4lYxhT58ME79lS/
         B8Q38LadGiOlgMva1PiIarZY25UvG3tdyofYt0LLkKydeCeVt3D7a8Yv/GTLL4eXlsyn
         wYkaSbvyUEacEl05dRJNNxrZeo0H2SEteQ76GXCxtIoimrOyVe3RkeRY5BQ3NL7gwcvf
         BWcw==
X-Gm-Message-State: AOAM531UiRaVH2mddH6RuyIZIZEBmiGJfzJwMo/FAFo+ahBmdVa8zE+0
        rbEXbu1MAvG3hcfZ4WmqaA==
X-Google-Smtp-Source: ABdhPJyRdWxQJ4UtVeSppxk/kcJFvqkg0QpvE+9wkEaUGfoYgwbFYt1DKaMOgWAsgRHQKacOEThPNw==
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr247403oih.10.1601320070043;
        Mon, 28 Sep 2020 12:07:50 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a20sm2284867oos.13.2020.09.28.12.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:07:49 -0700 (PDT)
Received: (nullmailer pid 3091768 invoked by uid 1000);
        Mon, 28 Sep 2020 19:07:48 -0000
Date:   Mon, 28 Sep 2020 14:07:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 03/20] dt-bindings: arm: hisilicon: add binding for
 SD5203 SoC
Message-ID: <20200928190748.GA3090434@bogus>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928151324.2134-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:13:07PM +0800, Zhen Lei wrote:
> Add devicetree binding for Hisilicon SD5203 SoC.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> index 6d17309c7c84308..3337eebc61da812 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> @@ -59,4 +59,8 @@ properties:
>        - description: HiP07 D05 Board
>          items:
>            - const: hisilicon,hip07-d05
> +
> +      - description: SD5203 Board

This should be a board compatible and then a SoC compatible.

> +        items:
> +          - const: hisilicon,sd5203
>  ...
> -- 
> 1.8.3
> 
> 
