Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D22E8D6F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbhACRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:06:57 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:46841 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbhACRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:06:57 -0500
Received: by mail-io1-f53.google.com with SMTP id 81so22875429ioc.13;
        Sun, 03 Jan 2021 09:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVytynTAT+slaIUz0c6G8Gd1TQ7fy2ZEkVU+p8nXFO8=;
        b=I1QAYit1962583v8pE6JBFw5KtUJ0FZencq500wGkde/3/pme+xRZRb1ZZHUc3GeS9
         5vCQKlQgUg4yAP9jH4FpP45zHgXI3Dd5y2KQ0zNe2//Sy2itxHjDpYnuKUJwbtdNwcwq
         TosiWsauvZ4/GWaH2HC3rFW/1QrUkea8FnICo2XhztfFnvPtYJUVcV88krCbnvTqldN9
         w4QOEZIlVoOvGy7u33P1X0yvmP6sHxLuWdkG3jtwSU593nPqjs9FukPRghAudNqbCT8g
         FhsT0M69maOVrYNNOWnFuhd1f+8x90jYK865fUYxPS3amaSnHYDc6NQ5jfw0I7esgPWA
         5hOQ==
X-Gm-Message-State: AOAM530h+X75xTC8eA3f1owGyDoSyJ7XyamfwQqCqzJGI02aYkia6T/P
        sEgzDXaLn5uJSLdaztu0dA==
X-Google-Smtp-Source: ABdhPJwKvjxwg269QlL1CKEUPrE/C2Cm7Az0f23id0BiG6pEgmCCybl80w1y42twVdmlHZGtpx1Vww==
X-Received: by 2002:a02:b60a:: with SMTP id h10mr58283714jam.99.1609693575936;
        Sun, 03 Jan 2021 09:06:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v6sm38630766ilo.61.2021.01.03.09.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:06:14 -0800 (PST)
Received: (nullmailer pid 4061481 invoked by uid 1000);
        Sun, 03 Jan 2021 17:06:13 -0000
Date:   Sun, 3 Jan 2021 10:06:13 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amarula@amarulasolutions.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
Message-ID: <20210103170613.GA4061441@robh.at.kernel.org>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223110343.126638-3-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 16:33:39 +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - add proper bindings
> Changes for v2:
> - updated commit message
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
