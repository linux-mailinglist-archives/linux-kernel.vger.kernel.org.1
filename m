Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6827D6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgI2TSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:18:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43674 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2TSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:18:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id n61so5558091ota.10;
        Tue, 29 Sep 2020 12:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeGhVbEqPx1oDD2M5M+TUTVsnabyJCp0cJtlo3CSbtY=;
        b=DBoNVKEvEsa6mJJ6RjaHYqQKMAWnCiJUvwqeeQ1vEsnDEA1wS1CkQb/Zw0vJ7Oq4n8
         7j5VZv1KpLptnLBD9wgAwpyQWhgl/rWZykP3OTVWm2BdV4LFXn6j3LpuQiyAy+ImfjWi
         Qv4J997AXrfP8zYZ65UDl5DM5RTwjSk/noaWFGDLHeMJrg9154TwCFj4/Ysw147Ml5yj
         eL3fuO2248hDMN/i5eDN2bQEMISiNfUjZkDOKWmAwiIP45Nv+hUktB3rTE7arcEa1mCQ
         IIVBq1wTDx7GmyBTGrom/V5GoGJc4c4gwZWnXF+fqtojEIb8j6+INyDpxe4kCte8hbqQ
         JiCQ==
X-Gm-Message-State: AOAM531qYObTjuOwhZtEnxJirUni3s/Vq5y5WFy2X8QxXtR9EvXC6zzc
        olXSdqwegsqclBYICtAlqA==
X-Google-Smtp-Source: ABdhPJymAAAhE42/qB57SUdAxqdSq8ODJgUREV1cCr0pPgBkZJjWE5cbU9QhCPJtMZWaJkfgysNSIg==
X-Received: by 2002:a9d:d01:: with SMTP id 1mr3545460oti.201.1601407082600;
        Tue, 29 Sep 2020 12:18:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm1206225otj.40.2020.09.29.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:18:02 -0700 (PDT)
Received: (nullmailer pid 997182 invoked by uid 1000);
        Tue, 29 Sep 2020 19:18:01 -0000
Date:   Tue, 29 Sep 2020 14:18:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jones <rjones@gateworks.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: Re: [PATCH 08/14] dt-bindings: arm: fsl: document i.MX53 boards
Message-ID: <20200929191801.GA996934@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-8-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:05 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX53 based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
