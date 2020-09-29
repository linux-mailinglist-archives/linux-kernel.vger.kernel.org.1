Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107CC27D53A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgI2R4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:56:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40793 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgI2R4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:56:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so6419242oif.7;
        Tue, 29 Sep 2020 10:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8AGcz/5KWE0x7YEsR85LpY7NpvRspu1aE4IpeIR564=;
        b=LRhlFB0wMCWgC54IbDjWysBaBjxK/6dLZvWYNVHNejFQ3BS9O7ej12HkL7tcj64zLY
         pab0tN3pptNwvgKnTesVQ100JSpEcVWPjjRwLV+xlZaOldQIbXYM+MfDXqBm9gwZEkJ3
         d0LXlU3KopJT/ZJf1tdlAxcScBgZGkjVu3UkB0TtoqzOJE7qmLoWW420HAzr3uuLsK0C
         por2BeuTcU5hPuwlCP6PVbQuFLfn+tj0gh/fST+JLXziyzca2bFgPu/mZf6yqlmWlglx
         d7zhEAzyZ2KN/1LnuKLqimWhUXQqRUT3n7uRRnzH9TCFCpopLM82/2H1QDEWMXgNAyLl
         ww8Q==
X-Gm-Message-State: AOAM530S1GcY4IdXFVnk4QPVPxLEfPTbpJTE4mzWLlPYdUjBeLyELwj/
        eDz1phgI5NEsyKagsmhBsw==
X-Google-Smtp-Source: ABdhPJzE6U5sNK1k+VhaZ6XpG9mlqL7FUrdW66G/z4sepadRzHNsQQK3/9U3Yxy1EoSB/pU5WTTEGw==
X-Received: by 2002:aca:3056:: with SMTP id w83mr3455891oiw.86.1601402193470;
        Tue, 29 Sep 2020 10:56:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 92sm1147276ota.38.2020.09.29.10.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:56:32 -0700 (PDT)
Received: (nullmailer pid 864047 invoked by uid 1000);
        Tue, 29 Sep 2020 17:56:32 -0000
Date:   Tue, 29 Sep 2020 12:56:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: add description for ONIE provider
Message-ID: <20200929175632.GA860453@bogus>
References: <20200921235237.7980-1-vadym.kochan@plvision.eu>
 <20200921235237.7980-3-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921235237.7980-3-vadym.kochan@plvision.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 02:52:37AM +0300, Vadym Kochan wrote:
> Add device-tree binding description for the ONIE nvmem provider.

What's ONIE?

> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  .../devicetree/bindings/nvmem/onie-nvmem.txt          | 11 +++++++++++

Bindings are in schema format now.

>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/onie-nvmem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/onie-nvmem.txt b/Documentation/devicetree/bindings/nvmem/onie-nvmem.txt
> new file mode 100644
> index 000000000000..16fb903118d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/onie-nvmem.txt
> @@ -0,0 +1,11 @@
> += Device tree bindings for ONIE NVMEM provider =
> +
> +Required properties:
> +- compatible: should be "onie-nvmem"
> +- nvmem: phandle to nvmem device node

Not a standard property.

I don't understand what you are trying to do.

> +
> +Example:
> +	onie_cells {
> +		compatible = "onie-nvmem"
> +		nvmem = <&at24>;
> +	};
> -- 
> 2.17.1
> 
