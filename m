Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0B293C26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406597AbgJTMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:47:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406408AbgJTMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:47:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id e17so1953657wru.12;
        Tue, 20 Oct 2020 05:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvJQA+Q+e5Z9wPDLjRmu3ONt1k4GttLd7/AaewkwhiE=;
        b=pBsBZiwmKJRGxORJX0S20/NPe8nQCCUVVqV0/q12oK/a0eVzsgGm3ZMveYFMr375JV
         2CDyvH5Bq6cj0edtcMDmBQqK+j8FqghAyfVbAWO+cryQWvwgckWALkIkY8lVM9Fd/RF+
         adW4bPRzL8vVkGjQYtYYg0Vu7/amAU2Yvl3lnS9sQkwg74aYBU5h3xc/CcWcoMk6L34D
         iJ5Y9YMNbAGOKf6h8ZRn8/quejvOVTlD3OcgDzfasYjMNpUomAkh76nNcETb/iU27aYx
         JYmzBJXONPIKj+FaswwZxQGv53AyfeWT1OfYrqJjjpF1GYU5Zm64ov2rTgsxlM60vvM4
         ciJQ==
X-Gm-Message-State: AOAM5321rV3b4nVDyvUcFfxwY3d22j9jvho83vtIlqnV7PrG59U8aAwF
        V4SdwRxVbcmFxtsf8SNwctM=
X-Google-Smtp-Source: ABdhPJw+FAODArwz99ehub8tp1gBdHMTIm7G3ZxRt2ocggJztRwWof7f87ccXJi8q+YzSQXzGYrpxg==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr3549813wru.271.1603198046534;
        Tue, 20 Oct 2020 05:47:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id b25sm2537084wmj.21.2020.10.20.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:47:25 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:47:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/29] arm64: dts: layerscape: Harmonize DWC USB3 DT
 nodes name
Message-ID: <20201020124722.GA128217@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-28-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-28-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:57PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 4 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
