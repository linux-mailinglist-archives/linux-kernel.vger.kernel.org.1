Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F72B463A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgKPOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44685 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgKPOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id f16so16187499otl.11;
        Mon, 16 Nov 2020 06:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DhdqYuLR/udiQ0jG8nvEMNbkKXl40kYQbIo96y8tB1s=;
        b=oX04QnbXfP8+D+XMZRfq88+glXHeIuMps4YrWQ4THzOanohJ4Po52hHVKocremr05K
         NIjpRLiyEjN43PNx2MoccBPFnKZ9NxrZbNKxwsgJrAJHhV8VhF68YEKVN8alAD2hPp6Y
         arPjk/lQh+/YMylBZTfous6IRvqmIJFw5Oc+mSWHP61uLO9rgLL7Is59efiVpEBrjAbo
         rwvc4AR6kIr0fqEiL2MD5qbWrYBcRxzelLnvNH8+Q4fn2yudQ5PKzHscFhwx0R+d+Hhv
         d+sD2pMA2Hxt42iCSmymwYPIvHUqO2gklUSE4HaTZMXBu6nwOLWMcqQ0YpagB80dmSY5
         imYw==
X-Gm-Message-State: AOAM5336MZQa9U5U1+rQlcK3CeUSO3f9pR69k02XzUT2Cxj8Qx24MnmH
        iqvuZlIhNZa9sPsH1ymCog==
X-Google-Smtp-Source: ABdhPJxBPbbHm5LgNbhTtFcFM9VTscsxtEr9/TF4vbddIOYwnJ/Dxl0rlFI4NFOTxQB+4ecz8y4gMw==
X-Received: by 2002:a9d:39b4:: with SMTP id y49mr10348433otb.20.1605537992610;
        Mon, 16 Nov 2020 06:46:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q7sm4747432oig.42.2020.11.16.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:46:31 -0800 (PST)
Received: (nullmailer pid 1624561 invoked by uid 1000);
        Mon, 16 Nov 2020 14:46:31 -0000
Date:   Mon, 16 Nov 2020 08:46:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steen.Hegelund@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: convert icpu
 intr bindings to json-schema
Message-ID: <20201116144631.GA1623670@bogus>
References: <20201112160424.1383051-1-gregory.clement@bootlin.com>
 <20201112160424.1383051-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112160424.1383051-2-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 17:04:20 +0100, Gregory CLEMENT wrote:
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
./Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml:59:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1399077

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

