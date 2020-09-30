Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1EE27E8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgI3Mro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:47:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41774 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Mrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:47:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id l24so1674869edj.8;
        Wed, 30 Sep 2020 05:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nR4ZvBqW38g9myLM2SaZTe6ALIuOu3sHwnGk2K3Vh4w=;
        b=Woy6bUj/QOUOqnYvEjR8850AVdy5kge9J6F2iulhl+VXfrnUtRAV8jzGjcyO7/e7HF
         q8+CX3DVh82/xyH3evID/GDMBVaqUbh1nYNZwIq4Mv2C3z+/rzhpP1fO8r3hlC0xiDU1
         Dr/kZReOjujwfcP5KkFRH7F4CQKYSkLUmONebrLo3OmibG8Fo+11SpKXqyFu5mWVWUCu
         +qKY5MV9pAJ6Zr+dClGw8bcVsgRCHacbHTEEgmBVVXTnQKU2e3ebjPPZe+DclaN9unB5
         unmdn+PRrAIYD5kAZhnV3oUcdduI6ARLjdVgmSZgifbz/H9N6KIdOHsuc7v8eQuxui4Y
         nVqg==
X-Gm-Message-State: AOAM533nTS86pP6Nm9QLcd1HmQdpiqyaGV3R4Eub9po/AlP3DGNLva9V
        IuFwrPBlw1j8vCNf6UACZZw=
X-Google-Smtp-Source: ABdhPJwqOvXOi0ySltgqwksx/J262p4Kzaqs6MMnRyrjQFzbwkyXP3jmMmkkcDreQE5eNEamVC9B4w==
X-Received: by 2002:a50:ef0c:: with SMTP id m12mr2482092eds.264.1601470061400;
        Wed, 30 Sep 2020 05:47:41 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id b20sm1563495ejv.9.2020.09.30.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:47:40 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:47:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/14] dt-bindings: arm: fsl: document i.MX6DL boards
Message-ID: <20200930124737.GA1410@pi3>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-10-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 06:28:07PM +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6DL based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index d9c430bfe37e..24c79cecd815 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -257,16 +257,25 @@ properties:
>        - description: i.MX6DL based Boards
>          items:
>            - enum:
> -              - armadeus,imx6dl-apf6      # APF6 (Solo) SoM
> -              - armadeus,imx6dl-apf6dev   # APF6 (Solo) SoM on APF6Dev board
> +              - boundary,imx6dl-nit6xlite     # Boundary Devices Nitrogen6 Lite
> +              - boundary,imx6dl-nitrogen6x    # Boundary Devices Nitrogen6x
> +              - bticino,imx6dl-mamoj      # BTicino i.MX6DL Mamoj
>                - eckelmann,imx6dl-ci4x10
>                - emtrion,emcon-mx6         # emCON-MX6S or emCON-MX6DL SoM
>                - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
> +              - engicam,imx6-icore        # Engicam i.CoreM6 Starter Kit
> +              - engicam,imx6-icore-rqs    # Engicam i.CoreM6 RQS Starter Kit
>                - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
> +              - fsl,imx6dl-sabrelite      # i.MX6 DualLite SABRE Lite Board
>                - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
> +              - karo,imx6dl-tx6dl         # Ka-Ro electronics TX6U Modules
>                - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
> +              - poslab,imx6dl-savageboard # Poslab SavageBoard Dual
>                - prt,prtrvt                # Protonic RVT board
>                - prt,prtvt7                # Protonic VT7 board
> +              - rex,imx6dl-rex-basic      # Rex Basic i.MX6 Dual Lite Board
> +              - riot,imx6s-riotboard      # RIoTboard i.MX6S
> +              - solidrun,hummingboard/dl
>                - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
>                - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
>                - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
> @@ -277,12 +286,26 @@ properties:
>                - toradex,colibri_imx6dl-v1_1     # Colibri iMX6 Module V1.1
>                - toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri Evaluation Board V3
>                - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6 Module V1.1 on Colibri Evaluation Board V3

I need to add here two solidrun boards and fix up the Toradex boards.
I will send a v2.

Best regards,
Krzysztof
