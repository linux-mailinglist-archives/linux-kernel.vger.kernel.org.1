Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC22D1BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgLGVLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:11:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46707 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:11:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id k2so17014530oic.13;
        Mon, 07 Dec 2020 13:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NRv6o8aIzwIXifyIzgNpw8K5FrqvuGndsSDRsi1EZkA=;
        b=sOpvgxeIFZIFddxiG70fy+6lW7I03TgS6Bfkc9BewJhSUX6puauNUjzfTa6ONtVZ+5
         yIH7EkJdh4TxHTVO9La9/ksNkO2k0zOKRmWIqjtsgNvdaNLT7YubfuESVr4PrcCpjbIS
         C7bBaaQIJerdAlaD3NSJ7cGf2jEoR67NKqJg+PYUrIlTtwpkikvqNR+j7NishGgDxJqH
         yCb47UakWdFXMP84Z7l4REHVZCcnWwjyYbBE9y+6u5q/l7fpO2HSxi0XYDEhJXnFTPC3
         fkwNk+2rg9Lj34n08d8Bf7bQVjz+asWh8ZU1Qe9xxPQgmRSbk1vBOrpCF/vXpvqHhelL
         ooQQ==
X-Gm-Message-State: AOAM531xvcPheyn86ep2UD2Yfb1qn1s2aS5ZDly2KRaU+8Qkd7tLvb8r
        pM2/bl1ex0OsHSADcQokPg==
X-Google-Smtp-Source: ABdhPJxx0aNKXK7vp9Z42EHDjHAQG3J4RCuVseOOU7bOf+cDkVdzRDIVOeTUXfapJDre4QUMmCFsrg==
X-Received: by 2002:aca:4c4f:: with SMTP id z76mr541441oia.1.1607375424336;
        Mon, 07 Dec 2020 13:10:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p8sm3204541oig.22.2020.12.07.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:10:23 -0800 (PST)
Received: (nullmailer pid 829680 invoked by uid 1000);
        Mon, 07 Dec 2020 21:10:22 -0000
Date:   Mon, 7 Dec 2020 15:10:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kun Yi <kunyi@google.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: convert AD AD741x bindings to
 dt-schema
Message-ID: <20201207211022.GA829623@robh.at.kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 23:08:05 +0100, Krzysztof Kozlowski wrote:
> Convert the Analog Devices AD741x bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/hwmon/ad741x.txt      | 15 -------
>  .../devicetree/bindings/hwmon/adi,ad741x.yaml | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ad741x.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
