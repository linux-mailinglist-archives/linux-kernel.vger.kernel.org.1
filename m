Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9260A29F048
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgJ2PkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:40:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42874 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgJ2PkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:40:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id h62so2625753oth.9;
        Thu, 29 Oct 2020 08:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFK119oKBHUlA5FZkroLBkkbquLP5uElSERBD9V0akk=;
        b=C9MR8x/it2pugcUt033mWhbKd3+zMWIEFBxTlEvDYzJiTqRaVG66Kmay9GluAM/vee
         arO7hFF9i9fdIoU1XsLnobuSzUI7wTwn6knG3AsRPgc01MkE9vlkEO5TG8U2lt+QzBTJ
         crv8gkm0GJ/dda8+J6YNaBuTcce7xICHs8ylu82O1jFLWI/FlSuWmyTuz67HWjbIsX0S
         rbChFrlha+31BXo+xUiqpF5QXQK0ahDgcPib2CnkmFVY1LhsY1GQ2jHSyG9u5fCQwODW
         0iRrLGzmJlhXtlaPph7wOMp3H7ELCpW3nK4iaEVDeQamg7W5Gdj09q6av58Y7LaJBTxH
         mPKw==
X-Gm-Message-State: AOAM531QCs3rW3h4Ut9crfn1wuyKiwEuWdRHws1CvFSDFwg2PGt9k4xt
        ICO5i7gWuICwJ4ob6v1m4Q==
X-Google-Smtp-Source: ABdhPJz/JkJ8C9MRVeRTN9L11T1V3txCS2mQ0fPKSM+XS8DvNISSelFbI4vfJlW1k1+tqtbj0oK9SA==
X-Received: by 2002:a05:6830:4033:: with SMTP id i19mr3841436ots.127.1603986017758;
        Thu, 29 Oct 2020 08:40:17 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 76sm681405oty.15.2020.10.29.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:40:17 -0700 (PDT)
Received: (nullmailer pid 1920595 invoked by uid 1000);
        Thu, 29 Oct 2020 15:40:16 -0000
Date:   Thu, 29 Oct 2020 10:40:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
Message-ID: <20201029154016.GA1917373@bogus>
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029095806.10648-2-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> Power operation mode may depends on hardware design, so, add the optional
> property power-opmode for usb-c connector to select the power operation
> mode capability.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 728f82db073d..200d19c60fd5 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -93,6 +93,24 @@ properties:
>        - device
>        - dual
>  
> +  power-opmode:

I've acked this version:

https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com

Please ack it if you are okay with it.

Rob


> +    description: Determines the power operation mode that the Type C connector
> +      will support and will advertise through CC pins when it has no power
> +      delivery support.
> +      - "default" corresponds to default USB voltage and current defined by the
> +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
> +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
> +        operation respectively.
> +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
> +        Type-C Cable and Connector specification, when Power Delivery is not
> +        supported.
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +      - default
> +      - 1.5A
> +      - 3.0A
> +
>    # The following are optional properties for "usb-c-connector" with power
>    # delivery support.
>    source-pdos:
> -- 
> 2.17.1
> 
