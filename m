Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C02AC7F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgKIWCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:02:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41031 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgKIWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:02:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id m13so11935846oih.8;
        Mon, 09 Nov 2020 14:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIBC7H//iDYtazdS7WzXjRNWAC+J4eWK8kE3CjiPjBY=;
        b=BxtT2oEHTANFOmkwIhidxBmX/d57vaLzYeSnBzwqEAJZUx8kgkjGbZZveQkGPkqIff
         FMeiC4gEA1EP/lML+etZtoQeDThEFOor43jlGPrXKBIkIH9nnCMUahwBopXqk2D+mGQI
         VimS6BVImYWQf8oUZEmpxMEvjC4d+MI1dmWJvAd4w5OGfRnYq5TFWRIQZ1LDrIKxqCF7
         4C2mu3OIgnBPS9/1uv2s6v3QoFSvg7YhQ9J7FFytsdQwRfV/LCMSiJYka+VC3/OPTGTC
         acks3sfb7C9ml+zHgEJVYoBIEMddfEEcYnn6u7VXyTAiWKuIi1dLxzXp/WGdb53YWwx1
         v8dQ==
X-Gm-Message-State: AOAM532Wlly62xYIL2eAnIW2x+ulgmn1rYmIHEKtyaHznTHD2KJ0GUou
        +Ie6OwefDP66Smn9CS0LGQ==
X-Google-Smtp-Source: ABdhPJwmPwDEGaa78me7BjlLt0XxRZfA7eXMNUDzlGTxzEA+UtwCpwmAlklWXtuicol/fRueVMb2Gw==
X-Received: by 2002:aca:4d06:: with SMTP id a6mr838895oib.84.1604959357344;
        Mon, 09 Nov 2020 14:02:37 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm2658786oif.43.2020.11.09.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:02:36 -0800 (PST)
Received: (nullmailer pid 1834614 invoked by uid 1000);
        Mon, 09 Nov 2020 22:02:35 -0000
Date:   Mon, 9 Nov 2020 16:02:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, krzk@kernel.org,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: fsl: Add
 beacon,imx8mn-beacon-kit
Message-ID: <20201109220235.GA1834565@bogus>
References: <20201107144811.1977108-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107144811.1977108-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020 08:48:08 -0600, Adam Ford wrote:
> Add beacon,imx8mn-beacon-kit to list of compatible options.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> V4:  Add RB note
> V3:  Correct Typo and move to Nano section
> V2:  New to series
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
