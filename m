Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A482EC025
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhAFPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:08:39 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:39855 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbhAFPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:08:39 -0500
Received: by mail-io1-f44.google.com with SMTP id d9so3025840iob.6;
        Wed, 06 Jan 2021 07:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sDcxo2YF0ytDnnc725r7joapiGpKbCFaBKSVTNjyV08=;
        b=P1iRmIR05NnkXTJ3m1fryMqfTOw1JjPJNq5Y+v5FMr2C2PoQWk5cA0BecwUVMpxuVC
         x4EkaxDduN6hR8FogI9ObXDFAyztXRRPf+ecbikvnOELdhhoHrTxluCr12GR04h123Be
         hRf5Qk9ayeNMVu4/YigZovrEmVRlYfjcQ1jgfbbCr8GPAF8u8EusLlywpZ/XuU6R3TK4
         trGxW+mgSrrw+W31Lqda0AUiuZa21ijIACFEqWknSdUbNVS7E/ol0lXMxZm+Vy6GCJgZ
         UjllxiJdBYhmHeAZITiZFT7GfAhfulBoRIO4ZHHnP2i3LXh7Z2aimyDUTPF7w+HSu4oN
         uuwg==
X-Gm-Message-State: AOAM531Z6RY4RlFae8M4FgAz+3U/qBqi8h//idmcHFKS9PP/G6wrXukc
        e8ZyRz/cHjMUd2u48c9e3g==
X-Google-Smtp-Source: ABdhPJzcqFMgFW34fkmkOuo+dCdNB7WmoXOrBa8gSy2L1EIrTcOVy6xN9/O2/530ZQJPmTYHIe13/w==
X-Received: by 2002:a5e:aa13:: with SMTP id s19mr3211317ioe.108.1609945678007;
        Wed, 06 Jan 2021 07:07:58 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f20sm2260581ilr.85.2021.01.06.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 07:07:56 -0800 (PST)
Received: (nullmailer pid 2229519 invoked by uid 1000);
        Wed, 06 Jan 2021 15:07:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, p.zabel@pengutronix.de,
        tglx@linutronix.de, joel@jms.id.au, openbmc@lists.ozlabs.org,
        maz@kernel.org, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
In-Reply-To: <20210106055939.19386-2-chiawei_wang@aspeedtech.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com> <20210106055939.19386-2-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH 1/6] dt-bindings: aspeed: Add eSPI controller
Date:   Wed, 06 Jan 2021 08:07:55 -0700
Message-Id: <1609945675.315536.2229518.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jan 2021 13:59:34 +0800, Chia-Wei, Wang wrote:
> Add dt-bindings and the inclusion header for Aspeed eSPI controller.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml  | 252 ++++++++++++++++++
>  .../interrupt-controller/aspeed-espi-ic.h     |  15 ++
>  2 files changed, 267 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
>  create mode 100644 include/dt-bindings/interrupt-controller/aspeed-espi-ic.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/soc/aspeed/espi.example.dts:45.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/soc/aspeed/espi.example.dt.yaml] Error 1
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1422809

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

