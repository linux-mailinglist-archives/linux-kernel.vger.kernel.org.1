Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC72D1EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgLHAT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:19:59 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:47995 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbgLHAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:19:59 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 7A0FE215E12
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:19:18 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mQirkuyGli1lMmQisks6Gj; Mon, 07 Dec 2020 17:19:18 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=KcKiiUQD c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10
 a=evQFzbml-YQA:10 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=zGQ2m3odkreZA2kYg2QA:9 a=CjuIK1q_8ugA:10 a=Q7RPfSbWTOsA:10
 a=yllJabXkTJAA:10 a=AjGcO6oz07-iQ99wixmX:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=oVHKYsEdi7-vN-J5QA_j:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4eNIuJvGf9dzYaNGC/fEaC3RxpCv7V0tT4GVf8YTdV0=; b=XJ8Kq5HMNlHErvgMuwlXTUkS69
        m3iu1F1cTG5aIo3EoSlJ3bwP//scZ7kniKWdAz3DeBcUfYSeLuiobRESgWMuOaBLtXXqkXDGSt7Ej
        gPeVOW4GQ1PWULKRif5T22Rog2OG5OJkiSiJ7Xt4OB/U3kF2kYSzoIyPQLteiwURckJgN/3RxNbeH
        h2rlIxv6ssIIdbauWlfErc8LnTzm7UXHM0QdP4VaJd0Gjb3WzZrKehVNcCzcdTWCvYSBNQbCUryqZ
        4752VQSaKGvPAKAhlmn7OkV0TmJgS2j3TXc2KjmAmxNQcU91qtAONZhg+JeZzqI1aNr9xezgqKlDr
        krw/WQ1A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33534 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmQir-001v7K-Ce; Tue, 08 Dec 2020 00:19:17 +0000
Date:   Mon, 7 Dec 2020 16:19:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
Subject: Re: [PATCH 4/4] dt-bindings: hwmon: convert AD ADM1275 bindings to
 dt-schema
Message-ID: <20201208001916.GA59429@roeck-us.net>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-4-krzk@kernel.org>
 <20201207211259.GA832269@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207211259.GA832269@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmQir-001v7K-Ce
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:33534
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 34
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:12:59PM -0600, Rob Herring wrote:
> On Tue, Nov 17, 2020 at 11:08:07PM +0100, Krzysztof Kozlowski wrote:
> > Convert the Analog Devices ADM1275 bindings to dt-schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../bindings/hwmon/adi,adm1275.yaml           | 58 +++++++++++++++++++
> >  .../devicetree/bindings/hwmon/adm1275.txt     | 25 --------
> >  Documentation/hwmon/adm1275.rst               |  2 +-
> >  3 files changed, 59 insertions(+), 26 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> > new file mode 100644
> > index 000000000000..2cad28c499dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/adi,adm1275.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADM1075/ADM127x/ADM129x digital power monitors
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +description: |
> > +  The ADM1293 and ADM1294 are high accuracy integrated digital power monitors
> > +  that offer digital current, voltage, and power monitoring using an on-chip,
> > +  12-bit analog-to-digital converter (ADC), communicated through a PMBus
> > +  compliant I2C interface.
> > +
> > +  Datasheets:
> > +    https://www.analog.com/en/products/adm1294.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adm1075
> > +      - adi,adm1272
> > +      - adi,adm1275
> > +      - adi,adm1276
> > +      - adi,adm1278
> > +      - adi,adm1293
> > +      - adi,adm1294
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  shunt-resistor-micro-ohms:
> > +    description:
> > +      Shunt resistor value in micro-Ohm.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Don't need a type if you have units. With that dropped,
> 

Sorry, I am not familiar with the terminology. Does that refer to
the '$ref' line ?

Thanks,
Guenter
