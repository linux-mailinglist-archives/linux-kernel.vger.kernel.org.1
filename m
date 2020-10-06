Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD02850FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgJFRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:39:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38396 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:39:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id 26so13442669ois.5;
        Tue, 06 Oct 2020 10:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Bihno6MGKyxcVBpHkYTk8xAc9lFXRujrVwMLMM15no=;
        b=YKRpHZfvY4X4T530h7vSlHoVp/ZIbn4xUKEt9g9v9Qps9MY16nmDQ9D3kwLVsTiLZI
         uET3b/bf6YTIe5TqX1bVYIyqXUFFkGLlbRA7TOobhc79v8VV8YyPcb5Nx+ZdF7G/XcAr
         7Fl/aghF6jq/rE5GkfppIg+WjgzH70D/T5JT37SA8nEqM7C9hB6wAcPbSutssbRb2iMT
         VF6/WF+2yQKYFDoNu6+4G9xy1cd4tSF9jyi2dRC6/kwIMyduQqhHNUGP5c82JSU97soe
         JTgUsDkvAxIovkK27jbapZWu+hE+D6vO4kXq9rZWVdSDcgW1AiksPX/S4CUd1YpLg/gF
         g3PA==
X-Gm-Message-State: AOAM533PMSuu7UYXG5RTmZZwfZnE08RIUOAqABg9/VmepMNWvOrbiJaa
        nOD0VleeeatPTyeCIV6Fxw==
X-Google-Smtp-Source: ABdhPJxv/Hxh5bZaamTZCuvpd419WcSnXwl6qKoTXq/P8ma1/IGT6Sam1N/ohNnlPP7MCcR1mzA9RQ==
X-Received: by 2002:aca:bf82:: with SMTP id p124mr3188131oif.133.1602005962894;
        Tue, 06 Oct 2020 10:39:22 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 2sm1297312oty.59.2020.10.06.10.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:39:22 -0700 (PDT)
Received: (nullmailer pid 2507327 invoked by uid 1000);
        Tue, 06 Oct 2020 17:39:21 -0000
Date:   Tue, 6 Oct 2020 12:39:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 02/12] dt-bindings: arm: fsl: document i.MX6Q boards
Message-ID: <20201006173921.GA2507273@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:49 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6Q based boards.
> The Toradex and the Armadeus boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 83 +++++++++++++++++--
>  1 file changed, 77 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
