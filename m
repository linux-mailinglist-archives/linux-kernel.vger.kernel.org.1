Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B272A3157
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgKBRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:20:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36989 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgKBRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:20:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id l36so5306423ota.4;
        Mon, 02 Nov 2020 09:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vjHYpv3TzO5WrOgzhwvPqk7gGBfVBDNS9p3u4+MfxU=;
        b=sMn6Kvkk/CqE++K/cl78sQuQbdWPnwNCBTVa1p60rZEvffUHsRsYJZ/SsQ/xE3BNbr
         mg5yhE4L75TIiF0L7/ky9SX0gSKz7KCOJSLEJK7wUxlKhdKZKO4UZ+jLy3ZVrIJd8vqX
         eDxaS3T9LNFlQckbiLh7m/ini6sQBRcOYjtLRf8TDadwJZNWWFj4oy3Vne9a41bB9QF7
         PeZ2Xt3dAs8gclsja0gSIf334jsZpMVWgJ2ayKidSOGAkN/PzOmuih+esWWhxA1XlXv8
         2Q1E7SvQMey9Nx/rXAk1UoMDzx5XD/gaun/uiPfjd51O6ewhAPcF3yvM0ObqSMgngEUd
         ZeCg==
X-Gm-Message-State: AOAM530XysHbsDIcUlQkKzvyWWaNnxnQ+rrBlzXp3vZpDlGCDlMUcX1i
        6WF4g5u6L3RFURaVVUrj8w==
X-Google-Smtp-Source: ABdhPJyqe5CiVpnLDvI6nmkZNO3LgwugA7sN3Wcua4QRjLdpj72n5d74CwMjua9xyXSJk8NBXoLxCw==
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr13213252otk.156.1604337613138;
        Mon, 02 Nov 2020 09:20:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5sm3833063otb.44.2020.11.02.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:20:12 -0800 (PST)
Received: (nullmailer pid 4070968 invoked by uid 1000);
        Mon, 02 Nov 2020 17:20:11 -0000
Date:   Mon, 2 Nov 2020 11:20:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     devicetree@vger.kernel.org, aford@beaconembedded.com,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: imx: Add binding doc for spba bus
Message-ID: <20201102172011.GB4063854@bogus>
References: <20201101131257.782279-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101131257.782279-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 07:12:56AM -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> new file mode 100644
> index 000000000000..acb3944168ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Shared Peripherals Bus Interface
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: |
> +  A simple bus enabling access to shared peripherals.
> +
> +  The "spba-bus" follows the "simple-bus" set of properties, as
> +  specified in the Devicetree Specification.  It is an extension of
> +  "simple-bus" because the SDMA controller uses this compatible flag to
> +  determine which peripherals are available to it and the range over which
> +  the SDMA can access.  There are no special clocks for the bus, because
> +  the SDMA controller itself has its interrupt, and clock assignments.

select:
  properties:
    compatible:
      contains:
        const: fsl,spba-bus
  required:
    - compatible

(needed to avoid applying to buses with just 'simple-bus')

> +
> +properties:
> +  $nodename:
> +    pattern: "^bus(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    contains:
> +      const: fsl,spba-bus

items:
  - const: fsl,spba-bus
  - const: simple-bus

> +    description:
> +      Shall contain "fsl,spba-bus" in addition to "simple-bus"
> +      compatible strings.

And then drop this.

> +
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +
> +additionalProperties: true

We can restrict this to nodes with:

type: object

> +
> +examples:
> +  - |
> +
> +    bus {
> +        compatible = "fsl,spba-bus", "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +    };
> -- 
> 2.25.1
> 
