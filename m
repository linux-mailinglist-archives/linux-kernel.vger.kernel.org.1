Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A723269928
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgINWou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:44:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40559 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgINWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:44:49 -0400
Received: by mail-io1-f67.google.com with SMTP id j2so1937718ioj.7;
        Mon, 14 Sep 2020 15:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1F6lWP19Bna6U6ABMV+DTOcBGgc6tw6QgYSDYop8Woo=;
        b=BQy/oIhb7ZXBlP6fO/4Fgx6zMHf3240Bh6/pFqzBdRDEwjUXqe6uTmthwqs+h0iiXn
         bckMCC7BVBS/JsIwYGv+2JEmUlAo/f5L6rNGMPNtSs6BjxbQ8tZzMAqU46rRY81yHyVn
         9D/JIdbKB3JtIdzd0yYNycD8SDjBOCsrGypS6ZMUOBB4LK5wWyEtxK5hw3Qv9hEa6rgm
         fnCq8TBcR/PCeJd05mWSK1nSJAmaijUP6udbbcOPGparoTUG6/zVYWZaupP0zWm6cHlN
         BEJzgqJ6Oz0EFhZyHI1N4DP0oyARrln5036Am5pVtZB7+3n+C6K29fOrHaHQeGWSeooT
         d5pQ==
X-Gm-Message-State: AOAM533zY6s7IgKrCFWi4JNNBgrxo/of+FkRN4Z+UaqfKJ5GEkCy+gPb
        CbTnboNgW7mFfwM0cLhXuV9VVMaqgY3u
X-Google-Smtp-Source: ABdhPJzmOHZo3WkW4zjgJCSzBhtT5LXIU+riR1XZx8a1l4NwReJeJQ59h2/U1bZ8wh9fVG7Z00XGrg==
X-Received: by 2002:a02:9f0d:: with SMTP id z13mr15265754jal.60.1600123488495;
        Mon, 14 Sep 2020 15:44:48 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 137sm6812483ioc.20.2020.09.14.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:44:47 -0700 (PDT)
Received: (nullmailer pid 405112 invoked by uid 1000);
        Mon, 14 Sep 2020 22:44:44 -0000
Date:   Mon, 14 Sep 2020 16:44:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/13] dt-bindings: mfd: rohm,bd71847-pmic: Add common
 clock-names
Message-ID: <20200914224444.GA404414@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-8-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:53:06PM +0200, Krzysztof Kozlowski wrote:
> Add common 'clock-names' property which might appear in DTSes.  This
> makes it consistent with rohm,bd71837-pmic dtschema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> index 5d531051a153..6328163fc32a 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> @@ -35,6 +35,9 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  clock-names:
> +    maxItems: 1

Need to define the name.

> +
>    "#clock-cells":
>      const: 0
>  
> -- 
> 2.17.1
> 
