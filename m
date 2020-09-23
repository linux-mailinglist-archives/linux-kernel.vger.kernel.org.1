Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578E7275409
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIWJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWJIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:08:43 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F877C0613CE;
        Wed, 23 Sep 2020 02:08:43 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p24so7061762vsf.8;
        Wed, 23 Sep 2020 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oIgYpLtXjizNAj00W4NnTag42BkGA1KmTe8MsxRr30M=;
        b=JqFe8ZKlxQLmOTS0+S2NOyUOXTu2R+cqTgSfpcbAN5dhCl7xKxMkHZz+n4Qrub3UyH
         YODXdn7/2HI+9rbSJjJo2Q/okxyP4Uf94hjlSR2vycbS0YR0p1g7io2RTBsMug9OK5wr
         BEVjNRS2AKFbtmcJQQ9yiDC4nrHcUR/3T0a9N3+vuacIEEZYALaEd+eXkj3RHQIYO6Qm
         JqdH5RTCu66J3FmpV/uruhihD8RqtXEouevITFix3ONHX9MaXKGTVYil46xQAaq4Vp07
         D3/oj3RN+lmn8ytb4ix91C1rpkU2k1dGdwG5fq/3q3FjJdzwRQWmBHGNQE5QSRZBFToN
         GSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oIgYpLtXjizNAj00W4NnTag42BkGA1KmTe8MsxRr30M=;
        b=M8WAde8bQou6E4tplazS9nKS5gebq5rHOBtWQB/7ydrbGdpTKSpDTUopF2j+/C00v7
         eA1DVlH3G51duItAjKLgG1kdv6BZB0mGu09XVqX/8gdVdFqILQ5KoEzJX4SaOhwqpThC
         kzDFrQJsPIP8t28OJnJlrLF2i3CRbfeRn5HeTS97SPNB/rP0WK8+RhaGbqmrqxasbJXd
         qHM8PajICm2vt86fwO2hM6quA+zm4JYwQXnT6h5tGhP6OKwiGnsy2BNsp495janmrGJm
         jQhi289zfCOxJUlSGcwq6yr/eKw549ZCQt3V7ynM4QqPPMZPWl7h7dPinswcV1/tlnTj
         M/mg==
X-Gm-Message-State: AOAM532xeN1+B/uH1BZfH6J1OyzbyOh8VMQ6VVnDCzAcGX3cw8DVZbMZ
        v5WXqoBs9XFy/zNJHO4Dia4IErQai1MFxDcc+J8=
X-Google-Smtp-Source: ABdhPJzdWKR6MZFwBb8dNIhCZhmrSt4ZxbwxAarG9bN4zsxoqrFZNT+Sb0sCYRIr4k19Dq1V0I6Fk6nqS5h8y+dtk/o=
X-Received: by 2002:a67:7dcb:: with SMTP id y194mr6368815vsc.26.1600852121235;
 Wed, 23 Sep 2020 02:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200902075707.9052-1-amelie.delaunay@st.com> <20200902075707.9052-2-amelie.delaunay@st.com>
In-Reply-To: <20200902075707.9052-2-amelie.delaunay@st.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 23 Sep 2020 17:08:30 +0800
Message-ID: <CAKgpwJWPWFF_yWC0N_7qPONpWCN8U8tKVJ5Ctr1DGqXd_FyWkA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/6] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amelie Delaunay <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:01=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Power operation mode may depends on hardware design, so, add the optional
> property power-opmode for usb-c connector to select the power operation
> mode capability.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> Changes in v2:
> - Add description for possible operation current values
> ---
>  .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 9bd52e63c935..2fd85b9a7e1a 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -88,6 +88,26 @@ properties:
>        - device
>        - dual
>
> +  power-opmode:
> +    description: Determines the power operation mode that the Type C con=
nector
> +      will support and will advertise through CC pins.
> +      - "default" corresponds to default USB voltage and current defined=
 by the
> +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports a=
nd
> +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
> +        operation respectively.
> +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined =
in USB
> +        Type-C Cable and Connector specification, when Power Delivery is=
 not
> +        supported.
> +      - "usb_power_delivery" when Power Delivery is supported, as define=
d in
> +        USB Power Delivery specification.

Why need "usb_power_delivery"? isn't this information can be implied by
existing properties like if "source-pdos" is present?

Li Jun
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +      - default
> +      - 1.5A
> +      - 3.0A
> +      - usb_power_delivery
> +
>    # The following are optional properties for "usb-c-connector" with pow=
er
>    # delivery support.
>    source-pdos:
> --
> 2.17.1
>
