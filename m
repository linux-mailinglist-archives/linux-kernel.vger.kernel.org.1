Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563B629DA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbgJ1XSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:18:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35389 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgJ1XRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:17:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id w191so1383228oif.2;
        Wed, 28 Oct 2020 16:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9xGcm8q97b1Pd4skv7mi7RHXIXoGHZIAAwtVH9gLfo=;
        b=IcGuu3R67hky1exSImAbTAYR4JIZG33GVfkHe1EyQlvHoJSMiWePlJMcAZzHlaivwQ
         CyGgb5WUJd+H9gXaiFtbAbpVsOEgJKrsZ/UyWE+S3Q0vP5GZshsPuszn1oqNJiVAOOaV
         1rCwVjpx7rl+MrDkZncbQX9T4bPAM/KhQOwG8UoOzFHkg0+3CDBzwRZKf0CNUY9EqGop
         hlQ/mMSlURzl9Uh22XyeV82nRHIMINZM+hr84U/7nxrD/ONih3FNHPtR9LOSWL/CekFm
         PCqY9gfraykGMzxyag7FlIi/LdXICQjWpXAoc2EHxrL3dIJAhFTPyH8qIC4sn0mqjTl6
         0gJg==
X-Gm-Message-State: AOAM531GykdjlkpVzHtMhAEvDKeLzfcHAGogFxxPZvh2FVBQRQCRaDNR
        ufVpR7rDPjnlRqvbU4vpw43XE0URBw==
X-Google-Smtp-Source: ABdhPJwsO6pD7ObQFTyD2GlTwW6QAtdf6KnbKuM1cAN1HFof/CWmTmFS6xuNbep2BF+NsIMok0JnGw==
X-Received: by 2002:a05:6808:57c:: with SMTP id j28mr5197913oig.63.1603893433383;
        Wed, 28 Oct 2020 06:57:13 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm2760537oif.26.2020.10.28.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:57:12 -0700 (PDT)
Received: (nullmailer pid 3932609 invoked by uid 1000);
        Wed, 28 Oct 2020 13:57:11 -0000
Date:   Wed, 28 Oct 2020 08:57:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     weiyi.lu@mediatek.com, hsinyi@chromium.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, fparent@baylibre.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] dt-bindings: power: Add bindings for the
 Mediatek SCPSYS power domains controller
Message-ID: <20201028135711.GA3932108@bogus>
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

With the indentation warnings fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
