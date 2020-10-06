Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF47285194
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgJFS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:29:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43982 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFS3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:29:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id l85so13620809oih.10;
        Tue, 06 Oct 2020 11:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdoCilP9gHxlZuptkIiqOS0CEMQ6bgTjni0IwuiFV74=;
        b=qnEk0y3gzdqczH65bYtTzhIDAezOy/x9xb9aMHRapd9E6iHUNpUfPqx+iZG8vD7sr8
         eCGYngG4cp2fc9NFpRmYuokFIcf97DKUiCBYyGD9sif7fWvx8FNWnE/5iWaqwHfAAuCq
         QR8Fq+lytgWAZnewqWRJsvxnCzjdL3NGzbwgxB4o3gXyA37hmQvJWrpKeGAfk8fZ2tOx
         pdY7lpgPn7LP5YeChoKaERGowSzDEA1zxH6hyUiELS7A2aFtOBBcK9ORG+6k+ntuArNj
         ys/kaJFuclYMPtipIIklZGUAUQqvmSq5zgbnNfsyVNIWFMm0QxNSafT9qOtKaadfjYnE
         Y5kw==
X-Gm-Message-State: AOAM530x8V0+t+uN2BkQNufHHnR4267pMWKYdkMTmYvaFV0i1PcUIXZ5
        KMeWPBFOvp5+FhW6ITmwkw==
X-Google-Smtp-Source: ABdhPJyEn/ZUppWqSvo9c2Fn7T2a6/QrTY0PirSgHBmjup22yXY1sTDgeHJYRnOoTBbOP2x3nXSc8A==
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr3442678oic.78.1602008982994;
        Tue, 06 Oct 2020 11:29:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 126sm1394296oof.28.2020.10.06.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:29:41 -0700 (PDT)
Received: (nullmailer pid 2589688 invoked by uid 1000);
        Tue, 06 Oct 2020 18:29:40 -0000
Date:   Tue, 6 Oct 2020 13:29:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v9 05/15] dt-bindings: connector: Add property to set
 initial current cap for FRS
Message-ID: <20201006182940.GA2574941@bogus>
References: <20200929024004.244992-1-badhri@google.com>
 <20200929024004.244992-6-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929024004.244992-6-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 07:39:54PM -0700, Badhri Jagan Sridharan wrote:
> This change adds frs-typec-current which allows setting the initial current
> capability of the new source when vSafe5V is applied during PD3.0
> sink Fast Role Swap.

Shouldn't you Cc the person you copied this from?


> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Removed the redundant usb-connector.txt that I created by mistake.
> - Moved to yaml.
> 
> Changes since v7:
> - Rebase 
> 
> Changes since v8:
> - Redefine new-source-frs-typec-current as string enums to address
>   Rob Herring's comment.
> ---
>  .../bindings/connector/usb-connector.yaml     | 26 +++++++++++++++++++
>  include/dt-bindings/usb/pd.h                  | 10 +++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 9bd52e63c935..0b8cd08a8678 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -142,6 +142,32 @@ properties:
>      required:
>        - port@0
>  
> +  new-source-frs-typec-current:
> +    description: Initial current capability of the new source when vSafe5V
> +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
> +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
> +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
> +      provides a detailed description of the field. The sink PDO from current source
> +      reflects the current source's(i.e. transmitter of the FRS signal) power
> +      requirement during fr swap. The current sink (i.e. receiver of the FRS signal),
> +      a.k.a new source, should check if it will be able to satisfy the current source's,
> +      new sink's, requirement during frswap before enabling the frs signal reception.
> +      This property refers to maximum current capability that the current sink can
> +      satisfy. During FRS, VBUS voltage is at 5V, as the partners are in implicit
> +      contract, hence, the power level is only a function of the current capability.
> +      "not-supported" implies sink to source fast role swap not supported.
> +      "default" refers to default USB power level as described by
> +      "Table 6-14 Fixed Supply PDO - Sink".
> +      "1.5A" refers to 1.5A@5V.
> +      "3.0A" refers to 3.0A@5V.


> +
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - not-supported
> +      - default
> +      - 1.5A
> +      - 3.0A

What happens if the property is not present?

I'm not crazy about mixing strings and what could be a number.

> +
>  required:
>    - compatible
>  
> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> index 985f2bbd4d24..db1ad4532197 100644
> --- a/include/dt-bindings/usb/pd.h
> +++ b/include/dt-bindings/usb/pd.h
> @@ -35,6 +35,16 @@
>  
>  #define VSAFE5V 5000 /* mv units */
>  
> +/*
> + * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
> + * Version 1.2"
> + * Initial current capability of the new source when vSafe5V is applied.
> + */
> +#define FRS_NOT_SUPPORTED	0
> +#define FRS_DEFAULT_POWER	1
> +#define FRS_5V_1P5A		2
> +#define FRS_5V_3A		3

Why are these in a DT header, but not used by the binding? Though 
perhaps they should be. Are these numbers from the spec or made up?

> +
>  #define PDO_BATT_MAX_VOLT_SHIFT	20	/* 50mV units */
>  #define PDO_BATT_MIN_VOLT_SHIFT	10	/* 50mV units */
>  #define PDO_BATT_MAX_PWR_SHIFT	0	/* 250mW units */
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
