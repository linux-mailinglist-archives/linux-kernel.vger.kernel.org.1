Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E652FC497
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbhASXPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:15:54 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39776 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbhASXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:11:43 -0500
Received: by mail-ot1-f46.google.com with SMTP id i30so8621037ota.6;
        Tue, 19 Jan 2021 15:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zwnspLO1XU1UxAjviLLOho2793ZeLPfsqMsqct/RJD4=;
        b=I5p36v8nFPGov43Xa1UYERG+V0gM6jF+5D0bBQWU43E5o9eNphYHXgvk+Chaa1xecP
         41Vq/8rFz7MJLVprcK6PfeBzI04li/dWROHEq14rSvy7y6kTfYxmGNyJskvWuytAIVqS
         013ksw1IHmOJ6KnA0j5YoUhy5YtM/hzvPuskuz7m8VAckMwLlfTPl5hQzWeEOPMTI2E+
         9YvXmiHjuer+sMu0SL4Jfcda55SY0DH8f9Ud10Nc4Dl4o5qWZpoIEYWo6Q9hVxLmeE08
         +fEi3tmAA0MVGTKI598IcMXuBF71WxlTB6LBjVHog/IHgjR9ZwNfz+WXFNmS6imHVHkM
         VjwA==
X-Gm-Message-State: AOAM530VJCefrYW79vck7PVIiAD6ZQYqlieyGOFGzinZTh8N8Fm92/qh
        ZSBfhWgCDvpzln3w7z0nuRP2Fzw1RQ==
X-Google-Smtp-Source: ABdhPJyTgJTFM5NXoV7ntdMWXNrAUbzEb6Iwjg696qOUlnMDqKMVqsb1IVxmC6Gqyn9VRUxLSXvACQ==
X-Received: by 2002:a9d:4e8d:: with SMTP id v13mr5250786otk.12.1611097860450;
        Tue, 19 Jan 2021 15:11:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h203sm31052oib.11.2021.01.19.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:10:59 -0800 (PST)
Received: (nullmailer pid 2774332 invoked by uid 1000);
        Tue, 19 Jan 2021 23:10:58 -0000
Date:   Tue, 19 Jan 2021 17:10:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] usb typec: tcpci: mt6360: Add vbus supply into
 dt-binding description
Message-ID: <20210119231058.GA2772032@robh.at.kernel.org>
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
 <1610720001-15300-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610720001-15300-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:13:21PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add external vbus source into dt-binding description.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> index 1e8e1c2..b8d842b 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -26,6 +26,11 @@ properties:
>      items:
>        - const: PD_IRQB
>  
> +  vbus-supply:
> +    description:
> +      Vbus source supply regulator.
> +    maxItems: 1

vbus-supply is already in the 'connector' node, you don't need it here.

> +
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml#
> @@ -38,6 +43,7 @@ required:
>    - compatible
>    - interrupts
>    - interrupt-names
> +  - vbus-supply
>  
>  examples:
>    - |
> @@ -54,6 +60,7 @@ examples:
>            compatible = "mediatek,mt6360-tcpc";
>            interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
>            interrupt-names = "PD_IRQB";
> +          vbus-supply = <&otg_vbus>;
>  
>            connector {
>              compatible = "usb-c-connector";
> -- 
> 2.7.4
> 
