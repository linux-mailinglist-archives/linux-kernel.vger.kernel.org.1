Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C32AC02C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgKIPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:45:07 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36630 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbgKIPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:43:07 -0500
Received: by mail-oo1-f66.google.com with SMTP id l20so2300143oot.3;
        Mon, 09 Nov 2020 07:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQXAVaxmapIU32OVQ6oDnCQfYBC2+6O7V7QppsiIjBA=;
        b=Oz6hvw6ntyrqwbDV0LJL2BKTyFaDtyyfsHIxL5HEj4bcGC1tK3GwuH6E8nPCzXBmQ7
         y6dYvcJkaHAmxU/hFYbgomVJZRhh59CkyNX2SXUqxMPyLAuI5yumjeBRhGwlh+Z2mI7W
         44N7qYaJNb5RM9Yo5XRLwm9QeS9x/NkbUq5ByC03ECiDb8vUBQeWl3sMZHiZBXKqzfQb
         q5+sxY0qeVGSOlAhslUCLTeLAWklX9VoYNvL2sNJ979fvxbjAKL4FCEsy2o4hoIt/Blm
         vHA6wEO2ua+vRICxqMmj2c9jV7VIS/2DeFNXImVWhoYJlRAMGYOkzSy7u2DNbiG/OAxM
         SpnA==
X-Gm-Message-State: AOAM532YWokHszGkK1PrZ5x1z3hnK7Piq+5fyggrxJ8xzmbhC0ec4ylF
        C26j3WLSXZ3jYtmCW5SPOw==
X-Google-Smtp-Source: ABdhPJwsMGHzrlJK5kP0burDP1pADQSPBBt8XDrr9y/gStG3DCJXsFNBx6VAZSTkbSeN5AclFuYc4g==
X-Received: by 2002:a4a:e1c6:: with SMTP id n6mr6052672oot.68.1604936586868;
        Mon, 09 Nov 2020 07:43:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c21sm2460394oos.30.2020.11.09.07.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:43:05 -0800 (PST)
Received: (nullmailer pid 1342982 invoked by uid 1000);
        Mon, 09 Nov 2020 15:43:04 -0000
Date:   Mon, 9 Nov 2020 09:43:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        aford@beaconembedded.com, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: soc: imx: Add binding doc for spba
 bus
Message-ID: <20201109154304.GA1342665@bogus>
References: <20201107115809.1866131-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107115809.1866131-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020 05:58:04 -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V4:  Correct errors in YAML
> V3:  New to series
> 
>  .../devicetree/bindings/bus/fsl,spba-bus.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: properties:items: [{'const': 'fsl,spba-bus'}, {'const': 'simple-bus'}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: Additional properties are not allowed ('type' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: properties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'items'
./Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: ignoring, error in schema: properties: items
warning: no schema found in file: ./Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml


See https://patchwork.ozlabs.org/patch/1396117

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

