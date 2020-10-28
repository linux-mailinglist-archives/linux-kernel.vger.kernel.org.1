Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C929DA31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbgJ1XQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:16:23 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35499 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgJ1XQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:16:11 -0400
Received: by mail-yb1-f194.google.com with SMTP id m188so617393ybf.2;
        Wed, 28 Oct 2020 16:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxEFiESFFvIIRPRbjQZYOy9rW3FUEJN6c1uP5x8Fe0o=;
        b=LKXEwabf77YBwUnTT8b706jDf6NkXrO3//oNJ+7gY034DB8BM7PPy8y+GsXVYGJrjg
         yp9Dvnvnz5RLjvnd9Gkb/aAIU+uKHeg7qHPIDzGQrXlbz8/o0pv0BsyHa69V+Hjs6I/k
         0BcBctsjSv7pKURU/bGO67hV18zyGOvaFC3/qEt0u9wHMCZ+vtUulFzM1GAbNzgo+qPd
         aIVgXko8/2lS8xzs5NcCbzXojoA7qkiMNcufSEtq79AF/K+yzPP9e5uee4K13sU36Jv/
         oMDNBFeBNOp6cSjkjVy/qW2wTdbop+bKaLtiJzlIwHjZrkCFwC66a5WiZBCtqZN/8i0s
         qw2A==
X-Gm-Message-State: AOAM532AyVUgqJcJZ4uI2txa+xmxUHnoVWx8+QYjDe3euyAIpWIMyxt3
        O9hmT9Rfa5/da/1VOHyLTf1gvSF6oA==
X-Google-Smtp-Source: ABdhPJxt7hN4xUvuog8gqBqk13H5yJDzXn4vFsZ2RtHulAwtm9rjXpNnE8FyfD0Skkw3nwCGpElVfQ==
X-Received: by 2002:a05:6830:1241:: with SMTP id s1mr5047362otp.366.1603893331451;
        Wed, 28 Oct 2020 06:55:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z126sm2710580oiz.41.2020.10.28.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:55:30 -0700 (PDT)
Received: (nullmailer pid 3930187 invoked by uid 1000);
        Wed, 28 Oct 2020 13:55:29 -0000
Date:   Wed, 28 Oct 2020 08:55:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, weiyi.lu@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        linux-arm-kernel@lists.infradead.org, drinkcat@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 01/16] dt-bindings: power: Add bindings for the
 Mediatek SCPSYS power domains controller
Message-ID: <20201028135529.GA3929806@bogus>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
 <20201026175526.2915399-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026175526.2915399-2-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 18:55:10 +0100, Enric Balletbo i Serra wrote:
> The System Control Processor System (SCPSYS) has several power management
> related tasks in the system. Add the bindings to define the power
> domains for the SCPSYS power controller.
> 
> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Use hex for unit-addresses.
> - Define child nodes for nested power domains even are duplicated, but
>   more clear than adding a regex scaped to be a valid URI.
> 
> Changes in v2:
> - Use generic node names (power-domain).
> - Define valid values for common properties like #power-domain-cells.
> 
>  .../power/mediatek,power-controller.yaml      | 289 ++++++++++++++++++
>  1 file changed, 289 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:48:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
./Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:99:17: [warning] wrong indentation: expected 14 but found 16 (indentation)
./Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:109:14: [warning] wrong indentation: expected 12 but found 13 (indentation)
./Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:147:21: [warning] wrong indentation: expected 18 but found 20 (indentation)
./Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:157:18: [warning] wrong indentation: expected 16 but found 17 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1387955

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

