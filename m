Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6AB2D36D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgLHXWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:22:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43030 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:22:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id q25so403283otn.10;
        Tue, 08 Dec 2020 15:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMniSFV4+130ZIEZpjALAeT/RpGcoF1J+lgVhHbcJ28=;
        b=tpkCaRC88OUGp2Fh8pCwWtRn39rYzWqbcgWof+JPUvg5wE6a5gB22G9z6LeTH/yOMK
         Rj4qtFm5Dg8sBzR+dqlthB4W+bke8qFd/McQC6tcgl5lIy1bx4EhJRWkdeHOXyT7rRtD
         4c8glQmdBVQ79yqrJhlBR12i0hTS78lwnM0nNALCK2NccHv1+gofQZbMA9nsQOXjkRiN
         Fpgwp9tq+SnuLVk32w+CP6H+ZTn02PbDBTMsa2uKd7eonrK2Ft3m+CE5SS/DaRAIQGwR
         taUr8MIaQlt+pKh8XRf/MXaJ4z1jrAfJM32AlFBN9PwTSzLM7aC4mV59Tl9JCDb6a/Mq
         tOgw==
X-Gm-Message-State: AOAM530NXnm5SQvwjTjZSIbqHNY5xIRv107x7sEUkUeaAS0j/6FuI09P
        6LBq8rFwJSnIAKHOe8O1ZQ==
X-Google-Smtp-Source: ABdhPJyaxdlSzuLG5UOTM6JMcax7tOhiEjrsX/dso/hyIBUnZNj6th3HeOaiCH4QiM8P2Vpy0BckUg==
X-Received: by 2002:a9d:7e8c:: with SMTP id m12mr427098otp.38.1607469703203;
        Tue, 08 Dec 2020 15:21:43 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm67432oib.24.2020.12.08.15.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:21:42 -0800 (PST)
Received: (nullmailer pid 3303386 invoked by uid 1000);
        Tue, 08 Dec 2020 23:21:41 -0000
Date:   Tue, 8 Dec 2020 17:21:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, bp@suse.de, anup@brainfault.org,
        Jonathan.Cameron@huawei.com, wsa@kernel.org, sam@ravnborg.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, sagar.kadam@sifive.com,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
Message-ID: <20201208232141.GA3292265@robh.at.kernel.org>
References: <1606714984-16593-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606714984-16593-1-git-send-email-yash.shah@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:13:03AM +0530, Yash Shah wrote:
> The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
> compared to 3 in FU540. Update the DT documentation accordingly with
> "compatible" and "interrupt" property changes.

'dt-bindings: riscv: ...' for the subject.

> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
> Changes in v2:
> - Changes as per Rob Herring's request on v1
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 35 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index efc0198..749265c 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -27,6 +27,7 @@ select:
>        items:
>          - enum:
>              - sifive,fu540-c000-ccache
> +            - sifive,fu740-c000-ccache
>  
>    required:
>      - compatible
> @@ -34,7 +35,9 @@ select:
>  properties:
>    compatible:
>      items:
> -      - const: sifive,fu540-c000-ccache
> +      - enum:
> +          - sifive,fu540-c000-ccache
> +          - sifive,fu740-c000-ccache
>        - const: cache
>  
>    cache-block-size:
> @@ -53,9 +56,15 @@ properties:
>  
>    interrupts:
>      description: |
> -      Must contain entries for DirError, DataError and DataFail signals.
> +      Must contain 3 entries for FU540 (DirError, DataError and DataFail) or 4
> +      entries for other chips (DirError, DirFail, DataError, DataFail signals)

While below is wrong, don't give descriptions that just repeat what the 
schema says.

>      minItems: 3
> -    maxItems: 3
> +    maxItems: 4
> +    items:
> +      - description: DirError interrupt
> +      - description: DirFail interrupt
> +      - description: DataError interrupt
> +      - description: DataFail interrupt

This says DataFail is optional.

>  
>    reg:
>      maxItems: 1
> @@ -67,6 +76,26 @@ properties:
>        The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
>        The reserved memory node should be defined as per the bindings in reserved-memory.txt.
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: sifive,fu540-c000-ccache
> +
> +then:
> +  properties:
> +    interrupts:
> +      description: |
> +        Must contain entries for DirError, DataError and DataFail signals.
> +      maxItems: 3
> +
> +else:
> +  properties:
> +    interrupts:
> +      description: |
> +        Must contain entries for DirError, DirFail, DataError, DataFail signals.
> +      minItems: 4
> +
>  additionalProperties: false
>  
>  required:
> -- 
> 2.7.4
> 
