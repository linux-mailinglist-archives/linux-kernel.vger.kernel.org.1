Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB32F1F47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391246AbhAKT2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:28:20 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42922 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390917AbhAKT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:28:19 -0500
Received: by mail-oi1-f180.google.com with SMTP id l200so489291oig.9;
        Mon, 11 Jan 2021 11:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kbu8h898aPvDxNdMP6PIxAif/V11sNJeHZ+ubY72cF4=;
        b=JH0kAC2ZUq58MobXTZ3UAUlP/kc+EWKh/VQ2FhsILpe//kh+U7pg/ehkImNeQucuwj
         7YILPXk+Ro3nNiVTtap2mCMtt6GAeidomxnqSsrr9Y+iqpEGIFH4JZpbiMWaFr8Au3DF
         BmZGiAynjHKQNvlfmucUEwSJV084/TsgklZB5/ZDJpXzQiWh8R3rQB2NS42DxPbcIJXW
         s1zwwi+H2lavtvfM+hk3UMY3tKJh/tFjUjwloRwpU2R1voeVd9Z2crDUlGsjRJzmk5+U
         oNDZG4aIiRB3zHSTMD5MNtY6qLJ2tRKBjAl3nFfZkgycsPA4poRrIoczFJ9qHAzCkJKQ
         ehCw==
X-Gm-Message-State: AOAM533W6l5MDj7pHmnv6SBjoI9O//hCMqkem6UQEktoW6mSj/GUZQ6w
        GxN5GzXi1R4HPWxsEyAaIA==
X-Google-Smtp-Source: ABdhPJzIo6ArZ7rCm2kfPJdqNvsNuq7OiqpnM5MMXKGJYwIpBfv7Za1TVn0837DH2EM13mC1HwP1fw==
X-Received: by 2002:aca:cf03:: with SMTP id f3mr5129oig.39.1610393258606;
        Mon, 11 Jan 2021 11:27:38 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm139896otj.67.2021.01.11.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:27:37 -0800 (PST)
Received: (nullmailer pid 2925593 invoked by uid 1000);
        Mon, 11 Jan 2021 19:27:36 -0000
Date:   Mon, 11 Jan 2021 13:27:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: Re: [PATCH v2 19/34] xlink-core: Add xlink core device tree bindings
Message-ID: <20210111192736.GA2922463@robh.at.kernel.org>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-20-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108212600.36850-20-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 01:25:45PM -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for keembay-xlink.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> ---
>  .../bindings/misc/intel,keembay-xlink.yaml    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> new file mode 100644
> index 000000000000..89c34018fa04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) Intel Corporation. All rights reserved.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay xlink
> +
> +maintainers:
> +  - Seamus Kelly <seamus.kelly@intel.com>
> +
> +description: |
> +  The Keem Bay xlink driver enables the communication/control sub-system
> +  for internal and external communications to the Intel Keem Bay SoC.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: intel,keembay-xlink
> +
> +examples:
> +  - |
> +    xlink {
> +        compatible = "intel,keembay-xlink";
> +    };

A node with a compatible and nothing else is generally a sign of abusing 
DT to instantiate a driver. You don't need DT for that.

Rob
