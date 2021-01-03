Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9B2E8D71
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbhACRHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:07:25 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:33340 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbhACRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:07:24 -0500
Received: by mail-io1-f54.google.com with SMTP id w18so22974446iot.0;
        Sun, 03 Jan 2021 09:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgP/Z7iP0iTUvzMj6+3xsjpKTpM0CQL2NDyZVdTnzec=;
        b=riOeOvcEgaUbboCdcmRDTEr/NHwakpCSOZE1HRCuNKE8Nd33wjfVMR3hYkMjqrXBVD
         gVIgaS+A/Xfm+7+ZmHsEah5FOexvMRWenuzswhQn0bcuYuvYq+hKMr18er+9v/95Jn8r
         sYiq9AHaRKS8vEv0inKW5EFqjYHNxg6FOe1KGSbfvB8FvThu+uUg/t7YAC7+bNIR24K7
         kusEPdwgEcPWDuTybD7rzlLxGejn+Ld7DkFX0EJnk+gYHQL7qvHkkYWJV182SPhYMjub
         XUiInm6wjNgjy+E+gaP1C9PKGjBNLWjqZW4quEBXUL7CY7WqX0+rOFAEUcLQDTNC2iQU
         Dtrw==
X-Gm-Message-State: AOAM532Yl3KnTsrEfmvDqcnp8IovVKbhSvPlpxoDUGdW2Qupx/mUgRiQ
        5YZ9gdKrGHfqBN1WS3oxTg==
X-Google-Smtp-Source: ABdhPJxAdY7IBVRWTPfatdv3W3jktnhKIp1SChlxMEqbqW/CYyx9rS4OfLZH0Qivf7OEns/oR4eqeQ==
X-Received: by 2002:a05:6602:2207:: with SMTP id n7mr57272285ion.130.1609693603975;
        Sun, 03 Jan 2021 09:06:43 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t18sm38759053ils.16.2021.01.03.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:06:42 -0800 (PST)
Received: (nullmailer pid 4062305 invoked by uid 1000);
        Sun, 03 Jan 2021 17:06:40 -0000
Date:   Sun, 3 Jan 2021 10:06:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini EDIMM2.2 Starter Kit
Message-ID: <20210103170640.GA4062272@robh.at.kernel.org>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223110343.126638-6-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 16:33:42 +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
> Board from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Evaluation board for
> creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - fix dt-bindings
> Changes for v2:
> - update commit message
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
