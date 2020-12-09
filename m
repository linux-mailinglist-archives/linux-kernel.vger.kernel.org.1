Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E762D46D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgLIQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:36:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40208 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgLIQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:36:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id p126so2332474oif.7;
        Wed, 09 Dec 2020 08:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5eXeZ1rOl1SnuLrH50s341Cy25jly+HKj6684KUWPc=;
        b=fVAatociWY6PT7f6dFZ+gquYIvCxaoe8exrBrAXjDNoVkViyyd3Aw6mRk2HlxoLsdt
         JAqYLzothzx33ZCW/8nfG+N7qjniMBEkuJLCdsvvusuhrByRLPl6WG4ppS7gkUX3Jg/p
         dXmRbF92U9MLCbikk0Cfn8CsN3S6Hzl8vpdVxyljC/ykdLLLEgndBBHt/2bxHvUHWJv9
         UUbMcgBH1OwvfIAgBoYFExs1kS0ScatoG9ymmEjt2dY2uGWPlbIDQlROxp8izCZS0vsU
         6u1rY7NLGmyag/dnrnQterx6GKnRLM7+lckPJjoXchaKjdy5eZ3g18GJP5dkAPEEw0TF
         Wmew==
X-Gm-Message-State: AOAM532Hr+VN7DZreLNkv9K9CpU7cwTjhgl+Fkj7xRlWC+t9EgtW80bf
        9ym2oHoa37nVGSHTFaNjoA==
X-Google-Smtp-Source: ABdhPJyRz0Ow15DwwuB85ognDOjEEsa6IIR6nWF8zZkU2X8hroQcLUEZZWkbV0eiPUgWqqrlivMqdw==
X-Received: by 2002:aca:d5c3:: with SMTP id m186mr2314853oig.73.1607531738289;
        Wed, 09 Dec 2020 08:35:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r12sm413774ooo.25.2020.12.09.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:35:37 -0800 (PST)
Received: (nullmailer pid 569438 invoked by uid 1000);
        Wed, 09 Dec 2020 16:35:36 -0000
Date:   Wed, 9 Dec 2020 10:35:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, arnd@arndb.de, w@1wt.eu
Subject: Re: [PATCH v2 01/10] dt-bindings: mstar: Add binding details for
 mstar,smpctrl
Message-ID: <20201209163536.GB566058@robh.at.kernel.org>
References: <20201201134330.3037007-1-daniel@0x0f.com>
 <20201201134330.3037007-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201134330.3037007-2-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:43:21PM +0900, Daniel Palmer wrote:
> This adds a YAML description of the smpctrl node needed by the
> platform code for the MStar/SigmaStar Armv7 SoCs to boot secondary cpus.

You need an 'enable-method' string defined too.

> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/arm/mstar/mstar,smpctrl.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
> new file mode 100644
> index 000000000000..599c65980f5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 thingy.jp.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mstar/mstar,smpctrl.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MStar/SigmaStar Armv7 SoC SMP control registers
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +description: |
> +  MStar/SigmaStar's Armv7 SoCs that have more than one processor
> +  have a region of registers that allow setting the boot address
> +  and a magic number that allows secondary processors to leave
> +  the loop they are parked in by the boot ROM.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sstar,ssd201-smpctrl # SSD201/SSD202D
> +      - const: mstar,smpctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    smpctrl@204000 {
> +        compatible = "sstar,ssd201-smpctrl", "mstar,smpctrl";
> +        reg = <0x204000 0x200>;
> +    };
> -- 
> 2.29.2
> 
