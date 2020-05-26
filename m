Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136B61A977F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895109AbgDOIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505530AbgDOIvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:51:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D48C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:51:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so16411538wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v0vxNepfmbCVO2pjiPVGMZ1nlG/9vSikCXlDStur+y8=;
        b=EAPLwH0NhIMDwtJJ2bWprHprO73wldrdAUl3IDOWpyt5N7xZRpSq4v7ZRrtkKWGhQs
         afP7RRQWt4rSqLdbjO/X/pNyNgSLzE5LnmVxvlRWh709Z0Z3FtjQOExo6/N5cA30UT9w
         Dts29jC0BvLi0Wz0EhvYpur3H3BIYQYFQ0vgi2oLsSZwh9lm3I39JYwOsDaE58fnl2Mi
         IXU/gm17YSXEXCtT9cthm0BPliM2ezFOrdMXmCMB9SuqQOXgaIL6j7nnQ7qFqAObPdLg
         uwPAA2IielMHS/3xI8VKgdYnl40Qhvp6oIBOtP/025MI+jakSnpo19XZ+su5qWxjzO/s
         1Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v0vxNepfmbCVO2pjiPVGMZ1nlG/9vSikCXlDStur+y8=;
        b=a00IssFVY4lhv83+Pa2L6ODnFLrRLP+MwjQDA9l+sUm8AFbOxizttqEeGYoXn6l4vy
         PXvEtsrmQ3COZDXCFCQidNwJ2wGVUEgw12Cg3wjTlymaU9x4vcUoDesH+q/hjGc9aLWS
         m/yjinxKmzvW24H40r+QbeqxQ82Tad91itPU/pURC8vVlFOZsSjJYrTzLfqgfP0Vu21x
         tWKOysXlRLlONrM+yogCVlx1ikRvd4MtD7kihoRz7GXM3t3hxhcoaSfChPwCz9CuKsAQ
         qSMpPvbaT8UrKdNzT9YozEo1wqwZ8nJLwl0eQPFjQ6YPpYiL/0DCJnxliItENCIICOrW
         nMIg==
X-Gm-Message-State: AGi0PuabJYQIOhDP4hI6YZa4XXAaaiGnpgz8+kShA/vSOVERnrUq+1Gj
        WLeY3cUOSmapSM7N2UFZqYJ2Dw==
X-Google-Smtp-Source: APiQypLF5toBswWpyDxDYMtR9h6DMT/RcYmPvwszy/EWIgrvbtujo1PdN/K4Bn4pMuQJfjiFF4TaCA==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr4181612wmf.85.1586940672963;
        Wed, 15 Apr 2020 01:51:12 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56? ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id v16sm21906787wml.30.2020.04.15.01.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:51:12 -0700 (PDT)
Subject: Re: [PATCH RFC v1 2/4] dt-bindings: power: meson-ee-pwrc: add support
 for the Meson GX SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        robh+dt@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
 <20200414201457.229131-3-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <907211b1-c8d5-39cd-5d2b-dd41efbdc7a7@baylibre.com>
Date:   Wed, 15 Apr 2020 10:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414201457.229131-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 22:14, Martin Blumenstingl wrote:
> The power domains on the GX SoCs are very similar to G12A. The only
> known differences so far are:
> - The GX SoCs do not have the HHI_VPU_MEM_PD_REG2 register (for the
>   VPU power-domain)
> - The GX SoCs have an additional reset line called "dvin"
> 
> Add a new compatible string and adjust the reset line expectations for
> these SoCs.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml | 27 +++++++++++++++++++
>  include/dt-bindings/power/meson-gxbb-power.h  | 13 +++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
> index a0e4cf143b9c..15a29ed19327 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
> @@ -26,6 +26,7 @@ properties:
>        - amlogic,meson8-pwrc
>        - amlogic,meson8b-pwrc
>        - amlogic,meson8m2-pwrc
> +      - amlogic,meson-gxbb-pwrc
>        - amlogic,meson-g12a-pwrc
>        - amlogic,meson-sm1-pwrc
>  
> @@ -42,6 +43,7 @@ properties:
>  
>    resets:
>      minItems: 11
> +    maxItems: 12
>  
>    "#power-domain-cells":
>      const: 1
> @@ -77,6 +79,31 @@ allOf:
>          - resets
>          - reset-names
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-gxbb-pwrc
> +    then:
> +      properties:
> +        reset-names:
> +          items:
> +            - const: viu
> +            - const: venc
> +            - const: vcbus
> +            - const: bt656
> +            - const: dvin
> +            - const: rdma
> +            - const: venci
> +            - const: vencp
> +            - const: vdac
> +            - const: vdi6
> +            - const: vencl
> +            - const: vid_lock
> +      required:
> +        - resets
> +        - reset-names
> +
>    - if:
>        properties:
>          compatible:
> diff --git a/include/dt-bindings/power/meson-gxbb-power.h b/include/dt-bindings/power/meson-gxbb-power.h
> new file mode 100644
> index 000000000000..57ab38dcb6bb
> --- /dev/null
> +++ b/include/dt-bindings/power/meson-gxbb-power.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#ifndef _DT_BINDINGS_MESON_GXBB_POWER_H
> +#define _DT_BINDINGS_MESON_GXBB_POWER_H
> +
> +#define PWRC_GXBB_VPU_ID		0
> +#define PWRC_GXBB_ETH_ID		1

Should be PWRC_GXBB_ETHERNET_MEM_ID like meson8 bindings.

> +
> +#endif
> 


Apart that, itlooks ok.

Neil
