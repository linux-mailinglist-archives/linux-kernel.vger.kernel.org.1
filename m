Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80048285102
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgJFRkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:40:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46802 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgJFRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:40:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id m11so7434038otk.13;
        Tue, 06 Oct 2020 10:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRCs5ilbPCBY2wd/DiRa/ub7I9FEFWUXHuLz7s6qj7o=;
        b=lPAT7IapjxP41ragdrBAD9SPevFiEBoDVH9J64ykZql+2+F/wWyV0mLUmcIr5hSYnw
         PXbceeJA5/qCjgKHNKN9oKrzcj5tbpp7MUQoZ8VTqmc1ATa9eIss4pwXAAHHpyD2fBhR
         vN9adhJYFXMotjlRxnmTOe2PQsv/xtUtm8dLt9VMvTDT+OAfWrZWUfKD4eQnX0cW9kpR
         bOq0/iJ6ES0M7/QyhI/4YseAIXWuZNvSDO1p+4IZ0irwHmx52JaVGLHfkOFXkzfuvbS2
         S9B9MGhhlGBXG+84j01ha7c7iTNI8+/+OCKv9qyfffGIo7E7AjUAge4Sv49eN3IErHNz
         Awtw==
X-Gm-Message-State: AOAM532hRkGYNU4+4Mj7h8gVw2O4VRczXO2DV0+sCJ5Zbsbf5CEDDEhS
        MkDFgEDUWhfjw1Z689PnIQ==
X-Google-Smtp-Source: ABdhPJyGAD8S6JSIf9uFFG3rLcau1AGzqNd6iMGxLcty+MEapRy3CiC9YWkrAIGZXY01QO/4LQp3Sg==
X-Received: by 2002:a9d:3a64:: with SMTP id j91mr3513344otc.207.1602006031966;
        Tue, 06 Oct 2020 10:40:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm1241853otl.71.2020.10.06.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:40:31 -0700 (PDT)
Received: (nullmailer pid 2509474 invoked by uid 1000);
        Tue, 06 Oct 2020 17:40:30 -0000
Date:   Tue, 6 Oct 2020 12:40:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, linux-kernel@vger.kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 05/12] dt-bindings: arm: fsl: document i.MX6SX boards
Message-ID: <20201006174030.GA2509422@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-6-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:52 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6SX based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
