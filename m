Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325B12B8604
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgKRUug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:50:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37937 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgKRUug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:50:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id 92so96803otd.5;
        Wed, 18 Nov 2020 12:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzuGJTKIjyJhtMSnPa2mvqmBY2OH+8TXIjdPZSXUb1M=;
        b=Eb1Z/j1JAU1wlAyHBPP8/wG89zJMDaVC/F20BlrgcBsfQoTx0LMQ7XE88hwUXgZZF+
         VQ0dFP8y5DbAc+wXyNxgMgFCLb3d1Q9M+YOCaroS8ofXRrb4vo7utHHWpEv+gObBkT3v
         SgXvhOS6dgDOofl/B5HCdxiiN0OWd66UE+lcuIZabbjVuUfNVXLZciS8OHXRGsoGp3Mf
         9WhkIaBtOhMug2DQD4hyBwBVi15AsDSyZWtuU+7W7xb8n+fbJ4Ujxk2DrsGWVGIq+vgl
         O497ChwCbC01KVYKATRx4PfjgFHr86n6eoiCAieL2iIL0Z7OJb6eSD36I08SZ1UfdOrU
         wDeQ==
X-Gm-Message-State: AOAM532LS0wEXa+bnybCvJ+11cubVycfZdmJacuoEx+GAhDNx0gTr1GZ
        0HGi3PmfnYqpm0QkyApirgP6GoWOXg==
X-Google-Smtp-Source: ABdhPJwgobC7djDQXv+wDpmhs7eph9+by/o+u6Cx0Eh5f5mJWhaC+/c47oqnUeTnEoCefcMXZHs7qg==
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr7889535otc.114.1605732635556;
        Wed, 18 Nov 2020 12:50:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x18sm2376067otq.6.2020.11.18.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 12:50:34 -0800 (PST)
Received: (nullmailer pid 1796286 invoked by uid 1000);
        Wed, 18 Nov 2020 20:50:33 -0000
Date:   Wed, 18 Nov 2020 14:50:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Marc Zyngier <maz@kernel.org>, Steen.Hegelund@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: interrupt-controller: convert icpu
 intr bindings to json-schema
Message-ID: <20201118205033.GA1795638@bogus>
References: <20201116162427.1727851-1-gregory.clement@bootlin.com>
 <20201116162427.1727851-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116162427.1727851-2-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 17:24:23 +0100, Gregory CLEMENT wrote:
> Convert device tree bindings for Microsemi Ocelot SoC ICPU Interrupt
> Controller to YAML format
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../mscc,ocelot-icpu-intr.txt                 | 21 -------
>  .../mscc,ocelot-icpu-intr.yaml                | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.example.dt.yaml: interrupt-controller@70000070: '#address-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml


See https://patchwork.ozlabs.org/patch/1401029

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

