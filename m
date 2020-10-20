Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A8293FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436913AbgJTPwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:52:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43374 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436904AbgJTPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:52:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id l85so2613807oih.10;
        Tue, 20 Oct 2020 08:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cuj8FYcNkqUs6si3CJnFao+OyDVHBcl/RdsIhf6hpE8=;
        b=GCPQ15x2iW/8Hh6RMAR1g4aaWTB7meUhsbwtahBy32MQ2ayIbpTcgQkkmbMJIWWgma
         KW2D/438A8In66VctLfvBT++HLVIeN9bKm0g893bDREj6QMGSSlSiDAtUvURJTTHNYdj
         AgtVX/bp7KCbb6ZjQCpLOq2Sv4zeAQBc3+0BGYAWvskYjNVlXNVNHRylOIsLuYkFewlz
         BnC8DPiSkOfLcfsW9UNbCBH69usCoJGXhXtCpj3OH7wApLVBypiINo2HbSgYgpSdV/hN
         U1+AobBlxagYJdOXvRr+jlm8VZR/CGw5NR5qORE9ABIJx6bxlsMcDQRXZjtxM3IHLGBF
         mQHg==
X-Gm-Message-State: AOAM532drfKgGGtZPqHnwtTPJckHXwdSFKYWhk9EDya+s1WcAAzzzb62
        Rb+aIpR/EBi5CZwuuJ316Q==
X-Google-Smtp-Source: ABdhPJwm+3bWHCRyFI+ShnwRrr9u7+alcmPQdLWqF0fyKmjdJS9/IpzApUmx78OQrOzZeNNnLnqxXA==
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr2127334oie.171.1603209149057;
        Tue, 20 Oct 2020 08:52:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm514782otn.53.2020.10.20.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:52:28 -0700 (PDT)
Received: (nullmailer pid 906474 invoked by uid 1000);
        Tue, 20 Oct 2020 15:52:27 -0000
Date:   Tue, 20 Oct 2020 10:52:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        heiko@sntech.de, vigneshr@ti.com, robh+dt@kernel.org,
        richard@nod.at, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v12 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20201020155227.GA906028@bogus>
References: <20201020031733.17883-1-yifeng.zhao@rock-chips.com>
 <20201020031733.17883-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020031733.17883-2-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 11:17:30 +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v12:
> - Fix some warnings while make dt_binding_check
> - Drop a allOf defined
> 
> Changes in v8:
> - Fix a error while make dt_binding_check
> 
> Changes in v7:
> - Fix some wrong define
> 
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> 
> Changes in v5:
> - Fix some wrong define.
> - Add boot-medium define.
> - Remove some compatible define.
> 
> Changes in v4:
> - The compatible define with rkxx_nfc.
> - Add assigned-clocks.
> - Fix some wrong defineChanges in.
> 
> Changes in v3:
> - Change the title for the dt-bindings.
> 
>  .../mtd/rockchip,nand-controller.yaml         | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
