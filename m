Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384FF2AC607
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgKIUfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:35:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38864 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:35:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so8563445otf.5;
        Mon, 09 Nov 2020 12:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1avu2iEskDLw5dPeTcxeu1siSaN8cVSq0rayrGyn0Lo=;
        b=NBCWj7a+Ygv4zeHchZpoH9vbSdQk84BgMGkri6dg2CnQbsFC78Rj6l/rXMYy9jDEHn
         e5WVI4kA579P/Z0tnelXrXTZcD2iiwByvhmEsCMlsCZS8P+woWogdYrrlsUhVzR+Kjlj
         SlDRpvXRCon3VIDkAEk+dq7rlP5L1Np736xLh1yWgf+QgD9Nm29b6GPYE+OULdM+dyEm
         AucvBlZ/x+2Dc04dYBH2bQ2AJTCwml5KC09l/wxiT+IFHp5SzloPQo3SJKnQdyNPzp4g
         AdLrH+42LaK/UGhxDPq9iQdIyDaRPtUzsBVYcvqHEvyEGoXYN67LvymcQ+xxFgJItTA7
         7Uzg==
X-Gm-Message-State: AOAM531iCypscN6fB4Dp6gufr5Xjd4b6otMex9feGG1cMzGN3mc+hYjb
        xy6PWU3nUAmSRJszHwBijw==
X-Google-Smtp-Source: ABdhPJy4/ny/cgmVQ0Ip4dehbRsJqNST+NEAaY+27F3g/NyLCgcYv/RqAnqMcG5qu8OW/6S0ttn7ZQ==
X-Received: by 2002:a9d:d37:: with SMTP id 52mr11329535oti.60.1604954107908;
        Mon, 09 Nov 2020 12:35:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p12sm2441000oti.35.2020.11.09.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:35:07 -0800 (PST)
Received: (nullmailer pid 1716317 invoked by uid 1000);
        Mon, 09 Nov 2020 20:35:06 -0000
Date:   Mon, 9 Nov 2020 14:35:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: document SolidRun LX2160A
 boards
Message-ID: <20201109203506.GA1716287@bogus>
References: <20201105184808.216384-1-krzk@kernel.org>
 <20201105184808.216384-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105184808.216384-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020 19:48:08 +0100, Krzysztof Kozlowski wrote:
> Document the compatible for SolidRun LX2160A based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
