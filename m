Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A627D69F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgI2TQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:16:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36239 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:16:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id v20so6735754oiv.3;
        Tue, 29 Sep 2020 12:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D59NWuJQnE1Mz2HuGvTukTbgJbkrNZRJDj677QESjNA=;
        b=XIwxjgNX+AxqOfk+c6Y1COn8JgD9ttAbVB4Yf7PKEm2lgfvWtvU36qNtN19NFot0BL
         9bByka/Yx530hZAfBeiDRwMP8ETP7mpksYxxI4E6DX6h5tEjpgf2FNZ3hHykLgUolwIn
         DEdGFe3jeKjJTO4F8ZvIbUUWlmvdexlbDNcNvPJwIBfsEUc4DdDUqnXxa6aVcznVMfGs
         7kbSiDunVrX20uMC2hbygk1UDacC1Wwc7wa/ay2aOPn52E4ji4hloSAvGvNaZw6ozqiR
         Qjhi4gsCSMBlNul8i45/ypFt8hToIHmgCAv6ewXw2HQX3ILWnVTqm4VGSIHerc2DZvq6
         3lNQ==
X-Gm-Message-State: AOAM533BbeU9R/RbfWpFzXq4WZhwqycyIQINBSEzu3DJPteHS622+gww
        4AWphhaW/QbC/bA77ya+6A==
X-Google-Smtp-Source: ABdhPJzjYsjZpNi6p/YtiTbLhLvgNujatyET8Blov0E/IidiLS9isuU2ssew/Pgc+wpG0Q1LUp9WdQ==
X-Received: by 2002:aca:7205:: with SMTP id p5mr3640810oic.3.1601406975003;
        Tue, 29 Sep 2020 12:16:15 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h14sm1274960otl.0.2020.09.29.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:16:14 -0700 (PDT)
Received: (nullmailer pid 993916 invoked by uid 1000);
        Tue, 29 Sep 2020 19:16:13 -0000
Date:   Tue, 29 Sep 2020 14:16:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Robert Jones <rjones@gateworks.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 05/14] dt-bindings: vendor-prefixes: add Zealz
Message-ID: <20200929191613.GA993839@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-5-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:02 +0200, Krzysztof Kozlowski wrote:
> Document vendor prefix for Zealz.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
