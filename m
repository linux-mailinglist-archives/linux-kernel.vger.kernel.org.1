Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4142850E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgJFRg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:36:26 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42800 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgJFRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:36:24 -0400
Received: by mail-oo1-f67.google.com with SMTP id l18so2261631ooa.9;
        Tue, 06 Oct 2020 10:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zab/6vlgKQv5s8OglqXpbzcgQo7SHEbrINSkhUR0UNk=;
        b=uZVYrDwR1eT21Q3rgmexir35FVADL/6aWpZJrJbtFSy/rBvHQ9Ek77GeWqjy+tHY9E
         W2bySwLmoxIFFjgzrrVP6bhNrdeHxeJWIKI1Pu2gd5/sBJBsDX8J4PTy5XoRcoiw4tiD
         SgCQFlID6L9cDoYtDvu+jpt0EdcWrAd3LhH3MhaPXeYZNM5zhWp0nCnz6+sVacXk8Okq
         qF6OYdkNHxBzeyt5rc0vBz3Igu0Bsy/Nt5OM53mMTEaIwN/HfhEFszi0Jw42A1pMcfQ0
         EBLXUdh9YZ6jIjEFt5qjZZzpTny8wj1bdJsg8tjGi+A5A3N9twXLup1iDwhWmEBaxjui
         brRw==
X-Gm-Message-State: AOAM532zdvynZBuUPS1ydnyecF7eNdVBb2H2Wp/KuMbuYpCKWaMmRGnZ
        4D+4QDwSftYMvQXCsiEcmw==
X-Google-Smtp-Source: ABdhPJyXyc9tFRer/0yizocvLpctx+GNLOQGNj3t0xAR0Q9jwdpdhuV0zAGEGWARM/wmg2FvQMilpA==
X-Received: by 2002:a4a:c011:: with SMTP id v17mr733100oop.89.1602005783118;
        Tue, 06 Oct 2020 10:36:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p20sm1245961oth.48.2020.10.06.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:36:22 -0700 (PDT)
Received: (nullmailer pid 2502055 invoked by uid 1000);
        Tue, 06 Oct 2020 17:36:21 -0000
Date:   Tue, 6 Oct 2020 12:36:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: Re: [PATCH v2 02/12] dt-bindings: vendor-prefixes: add Revotics
Message-ID: <20201006173621.GA2502026@bogus>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930190143.27032-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 21:01:33 +0200, Krzysztof Kozlowski wrote:
> Document vendor prefix for Revotics (Revolution Robotics, Inc.).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
