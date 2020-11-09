Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC32ABF55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgKIPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbgKIPEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:04:05 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA6F21D7F;
        Mon,  9 Nov 2020 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604934244;
        bh=klOzq0fwls70xqZlUdJhI8p1HAh7xB/+hUm3hhvBTbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zRkjX1fywCRc3cml6SgOLCjAP2nOhigBWN5i0+nDFKxkORwia7b0HsX9kYPgUg7jT
         rR/ga4f3KxVT4cND616QWDq5eHk5H3ps34SnJNgFSi/PN6cxg8R/FKQAn0OWaXk6sz
         7+l/AC0itXBgeHXQyXwhTYa7EbU//qSkwiYccBWw=
Received: by mail-ot1-f47.google.com with SMTP id n15so9184875otl.8;
        Mon, 09 Nov 2020 07:04:04 -0800 (PST)
X-Gm-Message-State: AOAM5332G4Iqsu2tMlzS0JxSvs3MHAd/ixVUk7vNkmQDbkCKS/D2rMCq
        FgUfgE+T/BsaAGW1tSv/CppgT3nYJ7jpKYCnmw==
X-Google-Smtp-Source: ABdhPJwVIajxUZd8pHgC4uOmEOHHpIlfzHZZGsTgFYCu33zI8wFT1W6B6OuaQFPH0g3XDgCIJq3bs4vnyzZR5TPU8Uo=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr10977628otd.192.1604934243782;
 Mon, 09 Nov 2020 07:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20201106165805.31534-1-amelie.delaunay@st.com> <20201106165805.31534-2-amelie.delaunay@st.com>
In-Reply-To: <20201106165805.31534-2-amelie.delaunay@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Nov 2020 09:03:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+A=nixpdrT3Omq7Osat=_Egb5g6VGao=gY4CEssOe+xQ@mail.gmail.com>
Message-ID: <CAL_Jsq+A=nixpdrT3Omq7Osat=_Egb5g6VGao=gY4CEssOe+xQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: connector: add typec-power-opmode
 property to usb-connector
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:58 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
>
> Power operation mode may depends on hardware design, so, add the optional
> property typec-power-opmode for usb-c connector to select the power
> operation mode capability.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> Hi Bahdri, Rob,
>
> I've added the exlusion with FRS property, but new FRS property name
> should be use here so, be careful.
>
> ---
>  .../bindings/connector/usb-connector.yaml     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 62781518aefc..a84464b3e1f2 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -93,6 +93,24 @@ properties:
>        - device
>        - dual
>
> +  typec-power-opmode:
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

Use the enums here. Unless you want to define it as actual current as
a numerical value.

Rob
