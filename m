Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA11B298F83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781693AbgJZOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:38:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38259 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781566AbgJZOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:36:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id h10so10699182oie.5;
        Mon, 26 Oct 2020 07:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3tEkDqcCTG0IzQXPAwhJWmsvNZknIocrF7E2OMjuhE0=;
        b=A+kHQRSDWX7dOx7IB19LYwONX3yffrJVd04zjCJ1dWpd7CapLrL/oDtntLf3ZDLSYb
         PTgFHQNSj3TEh4LC+2GDsV5Tjt6AOWEAYXcCrtOW/kMTO9WQeg8R/t1G0JUObPTwlAQ9
         gyTBGY3Fc2p8PhGJ/KBy0vvsyHQ21rRQ+3PUKQ+40ShsuQ0v0rvSEsk10+KLeafRdzOr
         Apr7AciFrCbrs5CCtnUYyggGSQDKnidIy5rDHXMpDlvVR2JKGuVUA0F8ShW+7ni7q+tm
         DDy/KJbWmFzZqEw5VAJ5RXryuBZbkmIAXqDSIUi7gSkXs9cnBaV9buSHb1g5opYoD5VI
         eDeQ==
X-Gm-Message-State: AOAM532lU7N/qjLXlUdtLU9rwGofsq7wgo52snXGwBpuRsf9gG/t1PtL
        aQKa1vqVZ3OgvEYOKa4ewA==
X-Google-Smtp-Source: ABdhPJzBqpRozB+mA8uEtko0jSmowYbYh7fKvDh0onqyFGNDBAaBRoW4U6MOniEhL45Ri9gx/NcHRQ==
X-Received: by 2002:aca:a893:: with SMTP id r141mr10621763oie.50.1603723017545;
        Mon, 26 Oct 2020 07:36:57 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s27sm2574459otg.80.2020.10.26.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:36:56 -0700 (PDT)
Received: (nullmailer pid 121443 invoked by uid 1000);
        Mon, 26 Oct 2020 14:36:56 -0000
Date:   Mon, 26 Oct 2020 09:36:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: stm32: add simple-mfd
 compatible for tamp node
Message-ID: <20201026143656.GA118160@bogus>
References: <20201021102855.18026-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021102855.18026-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:28:55PM +0200, Ahmad Fatoum wrote:
> The stm32mp1 TAMP (Tamper and backup registers) does tamper detection
> and features 32 backup registers that, being in the RTC domain, may
> survive even with Vdd switched off.
> 
> This makes it suitable for use to communicate a reboot mode from OS
> to bootloader via the syscon-reboot-mode binding. Add a "simple-mfd"
> to support probing such a child node. The actual reboot mode
> node could then be defined in a board.dts or fixed up by the bootloader.

'simple-mfd' implies there is no dependency on the parent node for the 
child (such as the regmap perhaps). Is that the case here?

> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 available here:
> https://lore.kernel.org/linux-arm-kernel/20200916142216.25142-1-a.fatoum@pengutronix.de/
> 
> v1 -> v2:
>  - new patch, rebased on top of
>    https://lore.kernel.org/r/20201014125441.2457-1-arnaud.pouliquen@st.com
> ---
>  .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml       | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
> index 6634b3e0853e..4684017a42e4 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
> @@ -19,8 +19,11 @@ properties:
>                - st,stm32mp151-pwr-mcu
>                - st,stm32-syscfg
>                - st,stm32-power-config
> -              - st,stm32-tamp
>            - const: syscon
> +      - items:
> +          - const: st,stm32-tamp
> +          - const: syscon
> +          - const: simple-mfd
>  
>    reg:
>      maxItems: 1
> -- 
> 2.28.0
> 
