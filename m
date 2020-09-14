Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D02269610
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgINUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:08:47 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33774 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgINUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:08:43 -0400
Received: by mail-il1-f195.google.com with SMTP id x2so843381ilm.0;
        Mon, 14 Sep 2020 13:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1DsB/R9jQHz/25EsMKCSZRYLqR+pPmt2zfdCCxJ2fM=;
        b=JzG6IXJrAZytnk/IjvfDI0jW6c4fvWybrHtTMKDfkKxHmdCQ8ifbGZxffKpTjEOUqh
         YfCM6dVZpZXadLoJn62gzQVcAwi4gve3aolZzS3bf5aFr5u7yJVkbTOrENqZjqWZJEaK
         K8YaS2WYL5eRV9+N0GmbWncd5wA77Qv9nc+2YrV5XowyJUGpF+S1idSqxLxUxmeRS6qP
         Qj2oUCPjVV6iby6QfUZzFaE7iptFCePpZscPJbU/HpEJX2sZGCCIX32EzivZJU8bX9du
         aVOFJEF6zkeKZlrufJTOyr6gqLmK+AWFWeD/WfzsOB654JN5Ox3zU6JV+iw5AyTXvtKJ
         iMAw==
X-Gm-Message-State: AOAM531PVuQEypjpRbs8YxJIvkwIa4wbBjDb1kf5lWYcCJD0RdwVbgZA
        Ftme2X3ncgOFzIlZvzHcOy9PEzqFbZIk
X-Google-Smtp-Source: ABdhPJwp6hmW8+H8XZH0rWXq5dRp3lZ60quV/J0n0opUPCzyzhNHiWUdgFXB4hBEscxnFolEWbuCOA==
X-Received: by 2002:a92:9a92:: with SMTP id c18mr14090572ill.265.1600114122076;
        Mon, 14 Sep 2020 13:08:42 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t8sm7650982ild.21.2020.09.14.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:08:41 -0700 (PDT)
Received: (nullmailer pid 154651 invoked by uid 1000);
        Mon, 14 Sep 2020 20:08:40 -0000
Date:   Mon, 14 Sep 2020 14:08:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     axboe@kernel.dk, p.zabel@pengutronix.de, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sgoud@xilinx.com, michal.simek@xilinx.com
Subject: Re: [PATCH 2/2] dt-bindings: ata: achi: ceva: Update documentation
 for CEVA Controller
Message-ID: <20200914200840.GA152914@bogus>
References: <1599030348-3334-1-git-send-email-piyush.mehta@xilinx.com>
 <1599030348-3334-3-git-send-email-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599030348-3334-3-git-send-email-piyush.mehta@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:35:48PM +0530, Piyush Mehta wrote:
> This patch updates the documentation for the CEVA controller for adding
> the required properties for 'phys' and 'resets'.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-ceva.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> index 7561cc4..f01d317 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -35,6 +35,10 @@ Required properties:
>  			ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
>  			RIT:  Retry Interval Timer.
>  			RCT:  Rate Change Timer.
> +  - phys: phandle for the PHY device
> +  - phy-names: Should be "sata-phy"
> +  - resets: phandle to the reset controller for the SATA IP
> +  - reset-names: Should be "sata_rst".

The names here are rather pointless. You don't really need them if only 
1 entry.

>  
>  Optional properties:
>    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> @@ -56,4 +60,8 @@ Examples:
>  		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
>  		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
>  		ceva,broken-gen2;
> +		phy-names = "sata-phy";
> +		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
> +		reset-names = "sata_rst";
> +		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
>  	};
> -- 
> 2.7.4
> 
