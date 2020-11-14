Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27A92B2E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgKNQA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 11:00:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40594 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKNQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 11:00:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id a3so19112484wmb.5;
        Sat, 14 Nov 2020 08:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktcJH8TIO4zsVVKEg+gtHPaiImzQ8Lzm0V35yxlND+Q=;
        b=VXOShbNAmNQjSTOFlg6KWW9HygvhvU6J7J9/3rNEXpKmp0Sl3IcA4zg3N03lVU7X2Q
         T6CesamS+tK87JWzwUHMNt33FrjqBiGZ7a9n+QzpTv9liWaPz6pZqu+GKLq3UlFfCCyS
         ZXzETPDfdtOv0Oj5//Qa4bSbVTB+TBwNJQKCGvhROy3MyU4EBLf0L2a5525Uff812Xc3
         h3dYHm4wMlpapGBfsvJdK/WucH8iPJbe6EjOHGtE6UzIF/vnbYp5XARf41pRo5FpJ+mi
         2vDfhwPFSEK4US/YCi/5oWK8u1OkQyeyDpzz6UN59ZeBc9l8Rffdq++QN0XYTj3pOgQP
         p3hw==
X-Gm-Message-State: AOAM531Oiw1mlKHa8u0r4s/gXVbHf8X1GmdPIQTqrDPah2NrzhZScJkX
        j2UzEIJYKpSj6vlbNJm0Ndc=
X-Google-Smtp-Source: ABdhPJxdgy7ENtxm9ZZKd5kxwXE3hq/x/9jC8C9fx9r2p4SlZOO+6axS+nbGnOgTfE+9mgni8wMIkg==
X-Received: by 2002:a1c:6456:: with SMTP id y83mr7697917wmb.59.1605369655021;
        Sat, 14 Nov 2020 08:00:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g131sm14364836wma.35.2020.11.14.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 08:00:53 -0800 (PST)
Date:   Sat, 14 Nov 2020 17:00:52 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8m: add nvmem-cell related stuff
Message-ID: <20201114160052.GC14989@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-3-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113110409.13546-3-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:04:08PM +0800, Alice Guo wrote:
> Add nvmem-cell related stuff for the soc unique ID.

Do not silently ignore comments during review. Let me repeat my comment
from v1:

Subject and commit msg: please do not add "stuff" but describe what
are you adding and why (what is the purpose, feature, benefit).
"Stuff" is too generic.

I can rephrase it, since maybe I was not understood. Do not use words
like "stuff" or "thing". Instead describe exactly what you are adding
and answer to the most important question: why are you adding it.

Best regards,
Krzysztof

> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
>  4 files changed, 24 insertions(+)
