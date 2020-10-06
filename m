Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD12850EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgJFRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:38:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43355 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:38:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id n61so13030862ota.10;
        Tue, 06 Oct 2020 10:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbBFnW9yhzJjCJNuXk7sbEXNu2jjVWDtDiurz+K5NHk=;
        b=cn+IdWCmVJSmVS34UWDevT36Gavq1eqDTVc9qlD6vSu1hDu6Mnhsr2uML+BPNnMSoz
         ogP2E6BuT3kLsMuajaQgnHCFvqHw5eIyB0Cvpi57gQK0vCLZ2jAJvlsD1vIZahj4jqvi
         CZHAS+J6IX5kC0QMBaaljcYqXpDzaC8H00YBU9JdWw3TlzvFU+bNc0QXtrZ74Ogt/V9z
         gGmduXpJdV8S8JOIud/IF6y95jGb+jXBGbIC17aZnXHTV3Vz2q2rOeUmhDUOp95cBRXk
         qkDJIIwfjoPwJcPEF1lZFHttZcyj6uXvB7v0ijjKeGUAcLZKGR9rhoBZhdr/ekrcYWHS
         4Z/Q==
X-Gm-Message-State: AOAM531p1oO6vftxqrkEsf1nuUS503AWhFgUjtQl0O03ZAyONta1+xG5
        Q+eAJN/nleLq3LTAhCDsmw==
X-Google-Smtp-Source: ABdhPJzxqAzlk14JjP2sXXb4BVqyrQCRjZXpris2+77tmgj23A21I2jWDC086fNKoQ6IBKe4tLwnLg==
X-Received: by 2002:a9d:4047:: with SMTP id o7mr3810750oti.49.1602005905090;
        Tue, 06 Oct 2020 10:38:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a14sm1264653otp.34.2020.10.06.10.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:38:24 -0700 (PDT)
Received: (nullmailer pid 2505586 invoked by uid 1000);
        Tue, 06 Oct 2020 17:38:23 -0000
Date:   Tue, 6 Oct 2020 12:38:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Robert Jones <rjones@gateworks.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Heiko Schocher <hs@denx.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 10/12] dt-bindings: arm: fsl: document i.MX6DL
 Aristainetos boards
Message-ID: <20201006173823.GA2505536@bogus>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-11-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930190143.27032-11-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 21:01:41 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6DL based Aristainetos
> boards from ABB.
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use ABB vendor prefix
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
