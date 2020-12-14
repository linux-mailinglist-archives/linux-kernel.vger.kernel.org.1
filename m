Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15742DA16F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503194AbgLNUWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:22:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41691 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503119AbgLNUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:21:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id 15so20656570oix.8;
        Mon, 14 Dec 2020 12:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/QPcy0Axl+o8hy8WDOYUxwEWrmNTJySrAH30GVfVQZo=;
        b=UY0elicZwjr45LkempZyyZG91SVV6hBGuFki49Fe3db/LFQOAqS1BguNAVU1irfK2U
         RmFK0lfKGh5x+C5p7rjl2zfnrVHD/kZID9FYi3EAV/bT6Et9iUoxedPodRIRhtqqDKWK
         StnlnhWnmuDj1Rja22bPIDP6vg4+nZ0DLqdMZMHt+8OS08Jg1w+rKh6gKO//CcZXIjs/
         Zh73rdQUAm/Rc4ZKqEaYx/0USHXJaNKtf10ZjRgWDKcWl057TuVuCEsTG3Ep50vcHq1x
         4+8jYOmhf3fDl/GVS2D6rTQeOointoWMHm4FsljBLTa2qz/CINeSqb2YJWql/ez4B9DH
         y8Yw==
X-Gm-Message-State: AOAM532yuXs5HOCxc6YzxjMfFT9sct2wdRrfCqFfRBVp23w0lSmsrD+M
        P0wPQhUxKEXsO/Vnca44cnnoZeKHSA==
X-Google-Smtp-Source: ABdhPJzXP+picASEtdv4d/QCN9WiqqLRWg5l+ar6sBgJ0RG54qJ2b81kyPQnL8HO14hVdaWOW918WA==
X-Received: by 2002:aca:3192:: with SMTP id x140mr19614880oix.172.1607977266237;
        Mon, 14 Dec 2020 12:21:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v38sm1286470ott.52.2020.12.14.12.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:21:05 -0800 (PST)
Received: (nullmailer pid 2333154 invoked by uid 1000);
        Mon, 14 Dec 2020 20:21:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
In-Reply-To: <20201214140109.21955-1-a-govindraju@ti.com>
References: <20201214140109.21955-1-a-govindraju@ti.com>
Subject: Re: [PATCH v5] dt-bindings: usb: Add new compatible string for AM64 SoC
Date:   Mon, 14 Dec 2020 14:21:04 -0600
Message-Id: <1607977264.104039.2333153.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 19:31:09 +0530, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as the same USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v4:
>  - used oneOf instead of enum, as the schema has to convey that the strings
>    ti,j721e-usb and ti,am64-usb can be used combined or seperately in the
>    DT nodes.
> 
> Changes since v3:
>  - used enum instead of anyOf.
> 
> Changes since v2:
>  - added changes done over the versions.
> 
> Changes since v1:
>  - replaced the '\t' at the beginning of the lines with spaces as it was
>   causing the dt_binding_check to fail.
> 
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml: properties:compatible:oneOf:2:items: 'anyOf' conditional failed, one must be fixed:
	['ti,j721e-usb', 'ti,am64-usb'] is not of type 'object', 'boolean'
	'ti,j721e-usb' is not of type 'object', 'boolean'
	'ti,am64-usb' is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml: ignoring, error in schema: properties: compatible: oneOf: 2: items
warning: no schema found in file: ./Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml

See https://patchwork.ozlabs.org/patch/1415942

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

