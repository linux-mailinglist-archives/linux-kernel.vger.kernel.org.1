Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B42DB38B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgLOSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:19:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36688 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbgLOSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:18:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id d20so2356535otl.3;
        Tue, 15 Dec 2020 10:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/jLsGp20WgJwDEhTmMuRmqydR5T/IJ51ILOe2UCGr8=;
        b=LC9F36cPjJBn2MX92uVRX8JjOJU92OEj1kY30+sEGE66uqwEz2DGaQZ0zBZz3pbe/c
         cMcVMj8x0+4Z3aaEqN8x8/5pmKusQjvN3/pZMzN03731l1bKzSB9sFPMrfbaH87yqs7n
         Oj3nGs7g/f0i03cXxzLC6Ns1qQpRrhVQqS1MJfw9fUHPrO1HkxNp3sId3TFFm1VxcPPH
         lByt9ADEPBfnABkyJaOqrBGcJ6d5FyZq+8itzZOLET4Cf85GH2F7znL+WOQks4jmdQbC
         EFsm+P5Z+AFRbTNWMw7+aumH2CB52GP/1TdBq1CJS5is3YY45nsX6FlpVtYzVeqhWgpH
         Nceg==
X-Gm-Message-State: AOAM530+kwVysBlmYuT20nRvkgC+UAk9DKLDybIN0//JrK7UXa8wFKhI
        +xerhFJuumGihKd13AdIQA==
X-Google-Smtp-Source: ABdhPJw5u7KWSVyM8A8MHLioXhU8/SevPeNGrm3xUT9JurqqAhjH4LaA75m9/X5WWOTjdIe9a3jVbg==
X-Received: by 2002:a9d:7ac1:: with SMTP id m1mr1666058otn.186.1608056287634;
        Tue, 15 Dec 2020 10:18:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d20sm593325ote.48.2020.12.15.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:18:06 -0800 (PST)
Received: (nullmailer pid 4146529 invoked by uid 1000);
        Tue, 15 Dec 2020 18:18:05 -0000
Date:   Tue, 15 Dec 2020 12:18:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] devicetree: phy: rockchip-emmc optional add
 vendor prefix
Message-ID: <20201215181805.GA4145251@robh.at.kernel.org>
References: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
 <20201215014409.905-2-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215014409.905-2-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 09:44:07 +0800, Chris Ruehl wrote:
> Update the documentation and add the vendor prefix to the optional
> properties referred in vendor-prefixes.yaml.
> Follow up with
> commit 8b5c2b45b8f0a ("phy: rockchip: set pulldown for strobe line in dts")
> commit a8cef928276bb ("phy: rockchip-emmc: output tap delay dt property")

These could be Fixes tags.

> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../devicetree/bindings/phy/rockchip-emmc-phy.txt      | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

TBC, this needs to be applied for v5.11.

Reviewed-by: Rob Herring <robh@kernel.org>
