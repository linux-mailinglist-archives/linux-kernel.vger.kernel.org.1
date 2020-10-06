Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA8285100
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgJFRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:40:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39445 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgJFRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:40:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so4529840otb.6;
        Tue, 06 Oct 2020 10:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Yq9XEktuiD8MU5R2gfK0pePCciIt+8eSwnnzKpptiw=;
        b=nuUrz2c4rzP1zWc6FhGP9JKJKbRUviRZct1uzo8CF/xjCVQ6IL/2zw1+NtxOITYqD4
         sEhkUfCbIMfaNZUoDu1u/NTP88iBvOydER/9z1hLoJGshs+UHQo96+aiX3HYxunHpuER
         H9IBo9QP2wi4JoGUibwUUWPfJrj+dX3VBT3VFM+vYgmicPJ/d87VLvwWe/QqS+QASCSD
         UCTL69dhW4fbQojat4TgwRdq/FqSIJ/+Cp27gyGf8BuiTjV0PFU7/mzchgXlebHrayHD
         N5p5m4IK9z06iHUFrqTVBAcU0OyOk/XDcWWgCG0Pts5nuTYenvJxevyccLyLOsPFnvwA
         p8HA==
X-Gm-Message-State: AOAM531H1/a26eBbdUKdlS+bFPoD0qceai6bqsY6OrBU+0XUAs0FNpNT
        rSWd9JtdsTJAW+uqWjSgGqzyzciLKulv
X-Google-Smtp-Source: ABdhPJzVWuzDN/nLLZLYWDQRW/2/qXjyBvK+gQfa9cX2TGbaazJyBENz7j5xPmHvLQbeCr5FwK7vWw==
X-Received: by 2002:a9d:3407:: with SMTP id v7mr3576012otb.117.1602006011043;
        Tue, 06 Oct 2020 10:40:11 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y194sm1374604oie.22.2020.10.06.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:40:10 -0700 (PDT)
Received: (nullmailer pid 2508810 invoked by uid 1000);
        Tue, 06 Oct 2020 17:40:09 -0000
Date:   Tue, 6 Oct 2020 12:40:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anson Huang <Anson.Huang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] dt-bindings: arm: fsl: document i.MX6SL boards
Message-ID: <20201006174009.GA2508773@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-5-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:51 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6SL based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
