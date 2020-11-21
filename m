Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0822BBF15
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgKUMyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:54:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35719 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgKUMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:54:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id v143so11750082qkb.2;
        Sat, 21 Nov 2020 04:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2ejWjSwcsPIE/JaW7yGyr3QkPvl0CuFfocLUWFS4q0=;
        b=cnAZDKY2g/earIKMognEAirAzDmdkFbvqr/OXNoQ3kz7p3J0ljojt8Jqj5IJ/W1HQB
         YAKIb78SY/tNHvrbFiRE6jBD5dFfORVxU++10TVnTzaMEmteVLIu3r8BQqazneAyfuXP
         rB2VENxhsMibFX/UA2K/rWUZxoWSlNZ5K2XSXj77/miUEmF9+3QW9gXaAxyr0g3dIdW1
         9Tk/WFq6bxUIqUxW9huySl0bBfgdY9nmAZy5jL+H+7TjH9ackasmL/ErALJ5E0gaZVZg
         fFDdVOzNRVL0jaFwGAgXYB4aSVqGx4II/epDreTBkeBZhGmXDi4kfi9o1EaH5TDakc6V
         M9Jw==
X-Gm-Message-State: AOAM532dMW0CONQ7qkLU/ybtou5KpDgz+52q4engPMP5XMBdVvnZAZ9T
        BaWRf7VgElh5NzhfEYjN6A==
X-Google-Smtp-Source: ABdhPJyI4dNE34z1SUnPBQWVLYdjgLqPkdV2CupYPMB8yoQfkzgp69+njbLGZoagfA+JOBlg9NQeBg==
X-Received: by 2002:a37:a481:: with SMTP id n123mr20961708qke.114.1605963288811;
        Sat, 21 Nov 2020 04:54:48 -0800 (PST)
Received: from xps15 ([2607:fb90:5feb:6270:cdf7:680e:59f2:6ccd])
        by smtp.gmail.com with ESMTPSA id s134sm4045140qke.99.2020.11.21.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 04:54:48 -0800 (PST)
Received: (nullmailer pid 2081252 invoked by uid 1000);
        Sat, 21 Nov 2020 12:54:43 -0000
Date:   Sat, 21 Nov 2020 06:54:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Jonathan.Cameron@huawei.com, wsa@kernel.org,
        sam@ravnborg.org, sagar.kadam@sifive.com, anup@brainfault.org,
        bp@suse.de, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
Message-ID: <20201121125443.GA2076465@robh.at.kernel.org>
References: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:41:13PM +0530, Yash Shah wrote:
> The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
> compared to 3 in FU540. Update the DT documentation accordingly with
> "compatible" and "interrupt" property changes.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 33 +++++++++++++++++-----
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index efc0198..4873d5c 100644
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
> @@ -51,12 +54,6 @@ properties:
>  
>    cache-unified: true
>  
> -  interrupts:
> -    description: |
> -      Must contain entries for DirError, DataError and DataFail signals.
> -    minItems: 3
> -    maxItems: 3

Keep this here and just change maxItems to 4. Really, what each 
interrupt is should be listed out as an 'items' entry.

> -
>    reg:
>      maxItems: 1
>  
> @@ -67,6 +64,28 @@ properties:
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
> +      minItems: 3
> +      maxItems: 3

Here you just need 'maxItems: 3'.

> +
> +else:
> +  properties:
> +    interrupts:
> +      description: |
> +        Must contain entries for DirError, DirFail, DataError, DataFail signals.

DirFail should be last so you keep the same indices.

> +      minItems: 4
> +      maxItems: 4

And 'minItems: 4'

> +
>  additionalProperties: false
>  
>  required:
> -- 
> 2.7.4
> 
