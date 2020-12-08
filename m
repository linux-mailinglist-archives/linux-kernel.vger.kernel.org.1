Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD852D2576
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgLHIOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:14:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53597 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:14:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id k10so1356787wmi.3;
        Tue, 08 Dec 2020 00:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yve/ZADh457qg7/+Dy6j2VWCsLzLDQxW7IculdMabgw=;
        b=iudvjKp0Hse5eTwK6AbgVcZTPmjckXRnu63DjMMwHkE4vjiKmLDLFeFRP8u5OXr8OF
         7h+fIxpC3jS1AWDk1DGFaS9ssOJr60dQlsP6Y25npypaO01WuY4QmkP+ZLpMzI/UwnCb
         VGJzB/LokT/DSsYUai7aQk1yUYvCDAkh9pYuPd8GW65Mkroin8RaT1IEyn5PeVhy+tS9
         7J+uHw5IxR7NqOuTACaiFJUWCPxY3UQvPF4aC+ks3kR4QyY18H0ROTcZYq69PNq2eaOp
         WUuC8JnUPsh1M1BxRFcv/33GqrZsvfCucjhLQGPSMzb5MqE9tKcL915kwezW5Z0smgDY
         sGgg==
X-Gm-Message-State: AOAM532EaeSFgjyiL/s99wnpqXAzTiKGD2P4VQnfClFd4X8MqI+qhE4J
        XZoe6pLXo5R5y8JrccJeCPY=
X-Google-Smtp-Source: ABdhPJzct0mSavW2Re8RCZYEbB9nX5jsRfbK4x1GZ/R7YI+2oplEjfaegPoKXVXSZoIbTskLyPV1SQ==
X-Received: by 2002:a1c:e3c4:: with SMTP id a187mr2645626wmh.58.1607415232866;
        Tue, 08 Dec 2020 00:13:52 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z8sm2158130wmg.17.2020.12.08.00.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:13:51 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:13:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
Subject: Re: [PATCH 4/4] dt-bindings: hwmon: convert AD ADM1275 bindings to
 dt-schema
Message-ID: <20201208081350.GA5088@kozik-lap>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-4-krzk@kernel.org>
 <20201207211259.GA832269@robh.at.kernel.org>
 <20201208001916.GA59429@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208001916.GA59429@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:19:16PM -0800, Guenter Roeck wrote:
> On Mon, Dec 07, 2020 at 03:12:59PM -0600, Rob Herring wrote:
> > On Tue, Nov 17, 2020 at 11:08:07PM +0100, Krzysztof Kozlowski wrote:
> > > Convert the Analog Devices ADM1275 bindings to dt-schema.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../bindings/hwmon/adi,adm1275.yaml           | 58 +++++++++++++++++++
> > >  .../devicetree/bindings/hwmon/adm1275.txt     | 25 --------
> > >  Documentation/hwmon/adm1275.rst               |  2 +-
> > >  3 files changed, 59 insertions(+), 26 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> > > new file mode 100644
> > > index 000000000000..2cad28c499dc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> > > @@ -0,0 +1,58 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +
> > > +$id: http://devicetree.org/schemas/hwmon/adi,adm1275.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices ADM1075/ADM127x/ADM129x digital power monitors
> > > +
> > > +maintainers:
> > > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > > +
> > > +description: |
> > > +  The ADM1293 and ADM1294 are high accuracy integrated digital power monitors
> > > +  that offer digital current, voltage, and power monitoring using an on-chip,
> > > +  12-bit analog-to-digital converter (ADC), communicated through a PMBus
> > > +  compliant I2C interface.
> > > +
> > > +  Datasheets:
> > > +    https://www.analog.com/en/products/adm1294.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,adm1075
> > > +      - adi,adm1272
> > > +      - adi,adm1275
> > > +      - adi,adm1276
> > > +      - adi,adm1278
> > > +      - adi,adm1293
> > > +      - adi,adm1294
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  shunt-resistor-micro-ohms:
> > > +    description:
> > > +      Shunt resistor value in micro-Ohm.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > 
> > Don't need a type if you have units. With that dropped,
> > 
> 
> Sorry, I am not familiar with the terminology. Does that refer to
> the '$ref' line ?

Yes, it's the $ref line which can be safely removed. The core dt-schema
applies such $ref if the property name ends with '-micro-ohms'.

Best regards,
Krzysztof

