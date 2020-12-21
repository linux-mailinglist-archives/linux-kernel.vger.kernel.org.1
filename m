Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB42DFDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgLUQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:10:48 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:34783 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:10:48 -0500
Received: by mail-oo1-f49.google.com with SMTP id x23so2332795oop.1;
        Mon, 21 Dec 2020 08:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DXU/j7SczdrMW2tlWjItLlK8l/T1osvOso88px/PvnE=;
        b=iv2bEwqoibMO4NS/djDEs0Ko/+ECPQ3U0BaZ7SizmFfccZJsIuobHGlcCkeOGHo+82
         0Z8OQ8QQuHRSKa36R6P5B3HeyR6Mao2vCzetymKrZr3AdSW4uMWYrOGGgw99LAlnrP8S
         0S7OMcJmySD359abAPhOTSXV634pW2BcSwL/MIXfGTLsdGXJQe7xu0KWArHde549I8rp
         H/RUfjuUmgqkZhnHIN1qQJbn1vdNcsbAPfJbHTsB5R97IFTmbsyDNuF475m7YOULklpX
         DMUviHLMbfKe8BWVk6mZO85MvrSXnXA3+sz1BpoaptaEqIQIspFqEpkK7J0GOCidYM2L
         Nu3g==
X-Gm-Message-State: AOAM532wu0xHj9e+MeGPgu9Z4qu1hyU+H0HLvR2eumaqYw2ZrH/O9Dq/
        8SY21pvD6U17umZJ3o9A+w==
X-Google-Smtp-Source: ABdhPJw86lqB/+Tv7kbZmRAMSiNjr3WB65+jQBtHvk3g9NoWOg0xM4lKT4mTwVjjARL5dtRq9XFK0A==
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr12014164oof.61.1608567007079;
        Mon, 21 Dec 2020 08:10:07 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g5sm3963835otq.43.2020.12.21.08.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:10:05 -0800 (PST)
Received: (nullmailer pid 94449 invoked by uid 1000);
        Mon, 21 Dec 2020 16:10:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, catalin.marinas@arm.com,
        linux-rpi-kernel@lists.infradead.org, will@kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux@armlinux.org.uk, robh+dt@kernel.org
In-Reply-To: <20201218154320.28368-2-nsaenzjulienne@suse.de>
References: <20201218154320.28368-1-nsaenzjulienne@suse.de> <20201218154320.28368-2-nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 1/5] dt-bindings: nvmem: Add bindings for rmem driver
Date:   Mon, 21 Dec 2020 09:10:04 -0700
Message-Id: <1608567004.368707.94448.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 16:43:16 +0100, Nicolas Saenz Julienne wrote:
> Firmware/co-processors might use reserved memory areas in order to pass
> data stemming from an nvmem device otherwise non accessible to Linux.
> For example an EEPROM memory only physically accessible to firmware, or
> data only accessible early at boot time.
> 
> Introduce the dt-bindings to nvmem's rmem.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v1:
>  - Update schema to new driver design
> 
>  .../devicetree/bindings/nvmem/rmem.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/nvmem/rmem.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1418470

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

