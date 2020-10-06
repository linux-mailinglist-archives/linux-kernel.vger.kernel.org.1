Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4282850F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJFRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:38:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42404 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:38:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id 16so5820096oix.9;
        Tue, 06 Oct 2020 10:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQtLQS/qaJ16lAKmbyiuA4X3E71wZ6EPZkBBROE4Ewo=;
        b=IRH6W5jZXL1lYHavJWBIoJUAN9sbygflts52Fy3VOWss3n9Tggkgdc9a4aWlldOqzz
         wHfE+Ofm/esXOgQxaTz/FGrdaHImeMBtTnxZXgse2VvkxIaFCFZavc6DyoF+YN5CPQVQ
         QmfWagHcW5NLIjuQWfs4c4egt6hOE18sZhBRiIhY8/JV7m1BQ8RfsyVKMIsvkyCUlDBg
         V0SyphXDpk7IxQy7sHMrFMQNbT1iuU14EeYUcmuVyld4taWBg8HhQqDAdMo8YROSiNeE
         26i+5B9jAi6br5O7VT2twqF1QFahK+iFXwFHR3itU3qSGs7DEJg45+5E3MTnhWN0FSaP
         xsDQ==
X-Gm-Message-State: AOAM531/1/CbKzzcwMZo7mD3sSa0xKnKliNt/38M6LekenIDpImHFcOj
        qq48XkGekloLaiG2u4TVyg==
X-Google-Smtp-Source: ABdhPJxIbemUkYz9uJjI7Uv+Hp6Cxt0ZZO20t/9vSkIjEySeROSvgggh+pDoA1u0ubynNJpRF9vZPg==
X-Received: by 2002:aca:ed90:: with SMTP id l138mr1477346oih.178.1602005928359;
        Tue, 06 Oct 2020 10:38:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g26sm1280518otn.77.2020.10.06.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:38:47 -0700 (PDT)
Received: (nullmailer pid 2506338 invoked by uid 1000);
        Tue, 06 Oct 2020 17:38:46 -0000
Date:   Tue, 6 Oct 2020 12:38:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 01/12] dt-bindings: vendor-prefixes: add Element14
Message-ID: <20201006173846.GA2506290@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:48 +0200, Krzysztof Kozlowski wrote:
> Document the binding for the Element14, a Premier Farnell company.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
