Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501662AC603
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgKIUej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:34:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33627 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKIUei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:34:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id i18so10307874ots.0;
        Mon, 09 Nov 2020 12:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3/09qeBRxObU3KgiM4c9IITJG/MWRmZ4yuU4INmyyM=;
        b=PkvMYKq2arNPxcwo4tHBoIrG9PcmT+GK33LWG1LBtfekCeVsnyXYfq9uE8Irgj9c33
         X4L8PaD0PCY6mAcFUkugPupkYLGNnDeq5K297aF4YEM14ryqsWrIHiyECvMFCSkV3Lnk
         bNSvxh+M4I1Bsv50WJ4NXwYQamdR3a8q1CPTDSaKr5njZiAHkL1zTF+8Tt5TSPlPYJ9r
         qqHA2soJBXTQU6NnZmL2PBa5n9wVj08db/CwAQ+hiizRSpulZfrHDnQDIPb1+DcEibFl
         FH75srSZULk+uq5XO/HVDkEwFP4zRpuNtOLl6SceXu60DBkuR6LfoHrKKGL/nZ4ATIv9
         tUxA==
X-Gm-Message-State: AOAM532Tu7rbfhI8CD6m4a14/YAu+QbDnZvTTHv0e8/tNyvmcO3eOV2o
        EdOsNXE9+VG4lAQ5iHWcCg==
X-Google-Smtp-Source: ABdhPJyHyzMfIXWOC0oRqZWKuAt9FgGB+32EJmzad5SlxI4WEVB1S0d7T6O5NuuGHNQUETNxR9pm1Q==
X-Received: by 2002:a9d:41:: with SMTP id 59mr11918558ota.216.1604954077920;
        Mon, 09 Nov 2020 12:34:37 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s20sm2594332oof.39.2020.11.09.12.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:34:37 -0800 (PST)
Received: (nullmailer pid 1715585 invoked by uid 1000);
        Mon, 09 Nov 2020 20:34:36 -0000
Date:   Mon, 9 Nov 2020 14:34:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: document LS1012A FRWY board
Message-ID: <20201109203436.GA1715554@bogus>
References: <20201105184808.216384-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105184808.216384-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020 19:48:07 +0100, Krzysztof Kozlowski wrote:
> Document the compatible for LS1012A FRWY board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
