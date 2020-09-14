Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670726971F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgINUxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:53:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44504 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgINUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:53:42 -0400
Received: by mail-io1-f65.google.com with SMTP id g128so1609001iof.11;
        Mon, 14 Sep 2020 13:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJOlqkDfQLNWOhs5wDhdjESRaLgN0AeGZgQDBu2MKds=;
        b=cF/o3M6xnZ/J+S7RamVC/rhD28hzP2JK7+yhp8tjh4JlTc2G3fdTjMpy7dodyyguDj
         CpJQEZmjNXKQ9/XGAWL/Suj4m8BFT6EtkwaJMJKDdRcHqUF9rBpeWwCC/Lm7O9jTt2yr
         QeflAhT82FG7ip4Ota9FoRCmPEUHfHArkwIYSpZ9/uh62A61eIeDvv4ItK/OG5Z6xXGG
         /ZbTWarsRAWLRszLVGfg1gfhymtQbLxZk22WBnZnWiW73mNMAbcQhBjAH3XO+na+JJu9
         3rj6I8FUpr23O0746rMapKkLu/5kgK7ha2mmxBrW9G94ivcVrmfjYTW+WfoiusdUYlah
         iwmQ==
X-Gm-Message-State: AOAM533K9tqIZM7jDvaOtzxrTuHIXCxth4KFP2cVFVmpV5Q1eaFGYQj5
        1oDmiT5E5kjgQPWn8PgEOHWiDB5iy9bQ
X-Google-Smtp-Source: ABdhPJy68NE/gCPsVXkeSpMTDnxRz1ttcQMLfOfcBFbgs5ydsdMjE2/4J0W+T90WTnojvJbmbIH+gA==
X-Received: by 2002:a5d:914a:: with SMTP id y10mr13060270ioq.108.1600116819827;
        Mon, 14 Sep 2020 13:53:39 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u89sm7914006ili.63.2020.09.14.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:53:39 -0700 (PDT)
Received: (nullmailer pid 227956 invoked by uid 1000);
        Mon, 14 Sep 2020 20:53:38 -0000
Date:   Mon, 14 Sep 2020 14:53:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: fsl,mu: Add missing
 power-domains
Message-ID: <20200914205338.GA225374@bogus>
References: <20200903195325.5394-1-krzk@kernel.org>
 <20200903195325.5394-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903195325.5394-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:53:24PM +0200, Krzysztof Kozlowski wrote:
> Add quite common property - power-domains - to fix dtbs_check warnings
> like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
>     mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add missing properties instead of unevaluatedProperties
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 7ed096360be2..e372dcce8037 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -72,6 +72,8 @@ properties:
>      description: boolean, if present, means it is for side B MU.
>      type: boolean
>  
> +  power-domains: true

How many?

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.17.1
> 
