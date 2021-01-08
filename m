Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477932EEB9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhAHDBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:01:46 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:44864 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbhAHDBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:01:45 -0500
Received: by mail-io1-f47.google.com with SMTP id z5so8350849iob.11;
        Thu, 07 Jan 2021 19:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIydIjVS70m7vlRE8Gf3usvG2tZBDyqmTjPrewVyQF4=;
        b=Er1qEEoNlQ7CQM9r3Uc/NQQDHqehLtNNsHMYhq/PQrZxYKh+oEL55hBugN7DLdnCRO
         bo7qCvwOjdlAoyXIKjQpAvpSBScRBvruDkimX9iimR102j6Xvc+s2hQQAT8WidDdeSWX
         ZJ6sEBxxl3OWkaYT8cOZ9Fwz6SLiaol0zgU/PWzaiEeweOeLOfzm5ZyYkut1Ei70lG4+
         7hEOAlZ4Wv9hjPEFAhDbndoCY+CP0oUdXyMtBHzVw7DKkOnsmNJwOSC+xHBY8Pcvz0dG
         djOC5jcEBRCWROt9mI9ZBDxIjqzyTMOg9Psdu7hu5lzRWjIapexLodqc1dPCMgVhCFsh
         bayg==
X-Gm-Message-State: AOAM530JjFhNBzRoRsH2glixdhhma8sLsS3LmTyM0ALy974dLiigQ8xb
        bpb3hqjBTr1syamBX1H2Kg==
X-Google-Smtp-Source: ABdhPJyH3n4nE7gzFfForpU2TiApTFxpvzo2NEtbaEjsf4d/twdGI+2EBX1dSmJI5NoN5RbHT4PPPQ==
X-Received: by 2002:a5d:8483:: with SMTP id t3mr3817820iom.35.1610074864447;
        Thu, 07 Jan 2021 19:01:04 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y12sm6205714ilk.32.2021.01.07.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:01:03 -0800 (PST)
Received: (nullmailer pid 1794327 invoked by uid 1000);
        Fri, 08 Jan 2021 03:01:01 -0000
Date:   Thu, 7 Jan 2021 20:01:01 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] dt-bindings: phy: cadence-torrent: Add binding for
 refclk driver
Message-ID: <20210108030101.GA1792772@robh.at.kernel.org>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224114250.1083-4-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 05:12:46PM +0530, Kishon Vijay Abraham I wrote:
> Add binding for refclk driver used to route the refclk out of the
> SERDES.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index e266ade53d87..d3b96afd514c 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -125,6 +125,23 @@ patternProperties:
>  
>      additionalProperties: false
>  
> +  "^refclk-driver":
> +    type: object
> +    description: |
> +      Driver to route the reference clock out of the SERDES.
> +    properties:
> +      clocks:
> +        maxItems: 1
> +        description: Phandle to clock nodes representing the input to the
> +          refclk driver.
> +
> +      "#clock-cells":
> +        const: 0

Just move to the parent node.

> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +
>  required:
>    - compatible
>    - "#address-cells"
> -- 
> 2.17.1
> 
