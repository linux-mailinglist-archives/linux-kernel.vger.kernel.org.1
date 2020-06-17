Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51501FD8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 00:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgFQWXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 18:23:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43820 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgFQWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:23:19 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so4791596iol.10;
        Wed, 17 Jun 2020 15:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fdc8LPvBg7IpDqgfMUorl6fjRqzreVXTCr85BbLnOzI=;
        b=nYoFyEjVu8LV7oCQQrWWsm5l58AOv9D/YfVORqqyCJZc0yDNBwhTCfGEjX1XsCaVHE
         AMIv6mcKWgbl4FiEhiLqDxK/qZlycPfaufDD04GaJLJ22oXZxvFY+Vnxvue6r4lrUnpA
         R/vwH8NFsU5S7640k7v0pPAE6s2NfRWvs0ElMinKEaaEcb4ByKCrjwvXvfUcujVGAujZ
         DOgmwtVQ70nNY4NIgLD702qNOEMXwpokdeZzYauSqrbqLK8S2x4818mJTHn958Wic6lL
         z5akfqvOUbg42Kw8fQVIruHJ6igc1hGgyWGXPgd4+btGGZiEUPirsv/8OPg+JhKoIHdU
         GkFg==
X-Gm-Message-State: AOAM532f9pL0bDLnGETf6/sKX0bYndgfBJFiOFTCZXhEYwOtzHs1Kp1B
        Wg1hjVrMm/MVYGCqP9Pcqw==
X-Google-Smtp-Source: ABdhPJw4FuQdRZJ34pMNVpkgP9I9YSTdXE0rgcVdxFi02YCM5O6qCa3oVlDmE8AWdr3loG3FQ6p+FA==
X-Received: by 2002:a6b:9355:: with SMTP id v82mr1704625iod.92.1592432597053;
        Wed, 17 Jun 2020 15:23:17 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g15sm495112ilq.39.2020.06.17.15.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:23:16 -0700 (PDT)
Received: (nullmailer pid 2942106 invoked by uid 1000);
        Wed, 17 Jun 2020 22:23:14 -0000
Date:   Wed, 17 Jun 2020 16:23:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     lkp@intel.com, bcm-kernel-feedback-list@broadcom.com,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, julia.lawall@lip6.fr, sboyd@kernel.org,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
        f4bug@amsat.org, jonas.gorski@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: bcm63xx: add 6318 gated clock
 bindings
Message-ID: <20200617222314.GA2942054@bogus>
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200610140858.207329-1-noltari@gmail.com>
 <20200610140858.207329-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610140858.207329-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 16:08:57 +0200, �lvaro Fern�ndez Rojas wrote:
> Add BCM6318 to the binding documentation for the gated clock controllers found
> on BCM63xx SoCs.
> 
> Signed-off-by: �lvaro Fern�ndez Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v2: no changes.
> 
>  Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
