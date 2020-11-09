Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56722AC10E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgKIQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:37:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45874 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:37:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id j7so10827724oie.12;
        Mon, 09 Nov 2020 08:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tq7rUzr/gw10MEoyCZnSq/EiwnB2bInd24MzCsWxH8k=;
        b=GN/LnFw1VjgfiX7pYywruabAMSVJrL3YLT1p6aMeRofBrCG+ok96Jj9zZ3nvzf266W
         LIGfGDx97QvoHjFAPyRLzT4nMXMTob3kuUCAh/tUpn9Db1rZCx/mAtaqsI5/LXYJQSQt
         IzjoN5gC2+xoQTPkYG8RJP4BxGy8UyVUL4vKYvh1/996rK1/m7kHIAGwWsHauiGFtcmk
         lf7ppM/STZLcQCb2VMTKcuKy327vsY2WB2WsrSmOmnt9KPe+vYqBlqAcxoCmATW3HYRA
         GSjijcFreo5A2hQHCeGnVQSIlEuwlprh4OesnelUUthCHcc1eQWG7tM43j6YCz2K5A2U
         A1QA==
X-Gm-Message-State: AOAM53320Hs4MqEvKsKhtvEBvEQJsguoq6jVoTUFFaVV8cTBCVTtCzCC
        UT15X8aT5GDwQidLI5fxlA==
X-Google-Smtp-Source: ABdhPJwLqQONMstaMXV/iyNOCJ8sCnMO9TUIGoYg1lmfIEQEeF/LXCOWXsWVAAtsy+AIrYmyia3DLQ==
X-Received: by 2002:a05:6808:b24:: with SMTP id t4mr8942748oij.93.1604939854580;
        Mon, 09 Nov 2020 08:37:34 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e15sm1176458otj.43.2020.11.09.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:37:33 -0800 (PST)
Received: (nullmailer pid 1410944 invoked by uid 1000);
        Mon, 09 Nov 2020 16:37:33 -0000
Date:   Mon, 9 Nov 2020 10:37:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: arm: stm32: lxa,stm32mp157c-mc1: add
 extra SiP compatible
Message-ID: <20201109163733.GA1404197@bogus>
References: <20201104113932.30702-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104113932.30702-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:39:31PM +0100, Ahmad Fatoum wrote:
> The Linux Automation MC-1 is built around a SIP with CPU, RAM, PMIC,
> Oscillator and EEPROM. Add a further compatible identifying the SiP,
> so boot firmware can match against it to apply fixups if necessary.
> 
> To avoid intermittent dtbs_check breakage in the sole upstream device
> tree that uses that SiP, patch it here as well.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> I know that bindings and device tree patches should be separate. Does
> this apply here as well? Should I split the dts change into a follow-up
> commit? 

Yes.

> Is it ok that dtbs_check will report an intermittent breakage?

If the binding comes first, it won't break.

But generally, 'dtbs_check' being warning free is not yet a requirement. 
That will probably first have to be per platform.

> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 +++++++-
>  arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts              | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index 009b424e456e..9127094f0208 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -40,7 +40,6 @@ properties:
>        - items:
>            - enum:
>                - arrow,stm32mp157a-avenger96 # Avenger96
> -              - lxa,stm32mp157c-mc1
>                - shiratech,stm32mp157a-iot-box # IoT Box
>                - shiratech,stm32mp157a-stinger96 # Stinger96
>                - st,stm32mp157c-ed1
> @@ -52,6 +51,13 @@ properties:
>            - const: st,stm32mp157c-ev1
>            - const: st,stm32mp157c-ed1
>            - const: st,stm32mp157
> +      - description: Octavo OSD32MP15x System-in-Package based boards
> +        items:
> +          - enum:
> +              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
> +          - const: oct,stm32mp15xx-osd32

'oct' is not docuemnted in vendor-prefixes.yaml.

> +          - enum:
> +              - st,stm32mp157
>        - description: Odyssey STM32MP1 SoM based Boards
>          items:
>            - enum:
> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> index 1e5333fd437f..cda8e871f999 100644
> --- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> @@ -15,7 +15,7 @@
>  
>  / {
>  	model = "Linux Automation MC-1 board";
> -	compatible = "lxa,stm32mp157c-mc1", "st,stm32mp157";
> +	compatible = "lxa,stm32mp157c-mc1", "oct,stm32mp15xx-osd32", "st,stm32mp157";
>  
>  	aliases {
>  		ethernet0 = &ethernet0;
> -- 
> 2.28.0
> 
