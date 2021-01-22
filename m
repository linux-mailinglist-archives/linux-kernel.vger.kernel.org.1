Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAC3004CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAVOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:04:33 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35799 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbhAVOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:01:40 -0500
Received: by mail-oi1-f180.google.com with SMTP id w8so6074034oie.2;
        Fri, 22 Jan 2021 06:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=EUaxXtMWBR0BSS8k6na/vc+HlfNaGeb+7ZCL4OicyZo=;
        b=tcNcQFTa9eTkeefyMNo0nbaKZoEjRJl04HKsP9c03B8EaIIhh7+o0lSd3fh+rp4AN4
         Jtz23oimntuw3KWgeWKWoBCPL6Cuap7wqy2H8d4CLaCzrH7SAY0ANJP62VfeR5yxVFZr
         G5yGlyhAtWMU0ZdF8oGBAs7vZBd17llLUDi3GesY7HKu4oqXxOSaPvyvEa305vM5vmjm
         C6yL5/6Wk4LZZvg0Ggdpx2S1AT7fmDZBWdtVPov5R9tsg1q02iQ9+ekxEFFak/glbmYV
         v8g01Yd9oSabaRaDyvgEwWnMsX3RgWd38z8eliAXl3LGkFl7m5bW2eoaIc47uUHDSp1t
         hwHQ==
X-Gm-Message-State: AOAM531ZvPVExek1+izjzKzDoT6ox6ahcrY3kDVkczqw7KBJw3PBjVxT
        PGncIKO4VrdCRAWqX0zSFA==
X-Google-Smtp-Source: ABdhPJzuup2G8I4By0nwY5GjTeCgXxvfBNcb5i/dqcjgAbP+KwX1KNzEuKUqEobX9LeiIvN8oDTXpw==
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr3361372oia.54.1611324054240;
        Fri, 22 Jan 2021 06:00:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm1719630oib.24.2021.01.22.06.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:00:53 -0800 (PST)
Received: (nullmailer pid 674375 invoked by uid 1000);
        Fri, 22 Jan 2021 14:00:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@foss.st.com
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210122105101.27374-14-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com> <20210122105101.27374-14-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH 13/14] dt-bindings: clock: stm32mp1 new compatible for secure rcc
Date:   Fri, 22 Jan 2021 08:00:45 -0600
Message-Id: <1611324045.701742.674374.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 11:51:00 +0100, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Introduce new compatible string "st,stm32mp1-rcc-secure" for
> stm32mp1 clock driver when the device is configured with RCC
> security support hardened.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dt.yaml: rcc@50000000: compatible:1: 'st,stm32mp1-rcc' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dt.yaml: rcc@50000000: compatible: ['st,stm32mp1-rcc-secure', 'syscon'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml

See https://patchwork.ozlabs.org/patch/1430316

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

