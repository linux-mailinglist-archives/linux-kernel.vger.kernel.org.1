Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA532E8D40
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbhACQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:40:25 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:37152 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbhACQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:40:21 -0500
Received: by mail-il1-f180.google.com with SMTP id k8so23162692ilr.4;
        Sun, 03 Jan 2021 08:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zeml2GAhWGvlyObknefZT18uus2BWf4wQLF3uVJZpZw=;
        b=Xoh23xcMgXReJWPsfqxngxbBTqbZGnYlNTnjMwZRSYL+n1MJ6LSOODMLmBLTxCNq+/
         tCzZXve3pRz7bopwWCUKkCMr5Sz2I0WCzD0sKA8DjTxsFcL0cpWK1a901i6Th4Ui25CP
         mIMV+UI7XmaSysqakvo5//HlLkCJPTappktfeFhrJJZ73MdkFac09Fc5oIIGGFKt7SId
         OLNkuTTKPLeHpl4psk2HBoR7qCj36LSSSiwJnAJxlWJfZJlDwvBmgwFVXhAj6WNqGOBR
         VX98EJd9G/GwDBdIuK/UN3JuTjMavzip8K8rV2ufJ5dB2qRB1ahCLIALL37I6fIpUCnr
         rDSA==
X-Gm-Message-State: AOAM530IOyF9jEiTwDdB9MsPDT6j0P7SAPADuk9Znno79eNEjIZWS00T
        g0j3w5sQIdTah8eurRePGxGvSMEc1w==
X-Google-Smtp-Source: ABdhPJzM6d8PEvYyediwGe+XcJGdCdnnt5tUfePOMvaIpJMIL4Mq/pWK64weXF+uLd/cbTnmaIbHXA==
X-Received: by 2002:a05:6e02:60f:: with SMTP id t15mr67597160ils.250.1609691980702;
        Sun, 03 Jan 2021 08:39:40 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l4sm39764006ilo.29.2021.01.03.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:39:39 -0800 (PST)
Received: (nullmailer pid 4011573 invoked by uid 1000);
        Sun, 03 Jan 2021 16:39:36 -0000
Date:   Sun, 3 Jan 2021 09:39:36 -0700
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add TI TPS23861 bindings
Message-ID: <20210103163936.GA4009325@robh.at.kernel.org>
References: <20201222143012.1618807-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222143012.1618807-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 03:30:10PM +0100, Robert Marko wrote:
> Document bindings for the Texas Instruments TPS23861 driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
>  .../bindings/hwmon/ti,tps23861.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> new file mode 100644
> index 000000000000..a7a801f54398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/ti,tps23861.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS23861 PoE PSE
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  The TPS23861 is a IEEE 802.3at Quad Port Power-over-Ethernet PSE Controller.
> +
> +  Datasheets:
> +  https://www.ti.com/lit/gpn/tps23861
> +
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps23861
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description: |
> +      The value of curent sense resistor in microohms.

s/curent/current/

> +    items:

Drop 'items', not an array.

> +      default: 255000
> +      minimum: 250000
> +      maximum: 255000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          tps23861@30 {
> +              compatible = "ti,tps23861";
> +              reg = <0x30>;
> +              shunt-resistor-micro-ohms = <255000>;
> +          };
> +    };
> -- 
> 2.29.2
> 
