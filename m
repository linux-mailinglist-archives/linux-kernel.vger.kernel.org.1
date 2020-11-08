Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6D2AACE6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgKHSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:45:35 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43312 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKHSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:45:34 -0500
Received: by mail-ej1-f67.google.com with SMTP id k3so9130385ejj.10;
        Sun, 08 Nov 2020 10:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YD4uuqWXkQV3czUc7Aul7nJKXC3Npr6cWGG5aeaQRw=;
        b=ipU0i+PBqGEA6PvXqp0+aQ52LNc7Me96IHoDWqJpYBOyS441qml2Ct3rzxD2iHL9e7
         TWq5bggMq78fYNmj0l2eU9jVB6bP85dBDyqwgMpCI8NWlzaEIWU2tfqDcNizXYd83a0b
         mNdTYktv05hJEkxjB1H1+zRzRTAIVMXDZCa+iIoTSkOfIjUYm6clwJ4vsSR9vt9Sfbjq
         OTExa71qgI8U2E3qHWBC7zr/EevkBamVAZi5FTJym7stLJf/Ulxnl56rt76BdMOg0bxu
         pF8sZq9OYwqOeeUjDWknlkFRDc0tI6UbgLqH1oW6ecb9dikFLscVXSYBpeYoEGHlDxok
         MLfA==
X-Gm-Message-State: AOAM530Juu4u4CJXXmccZMZ1037WAPjJJsjJgFTivlt2tCyiYD913Oe2
        M1XzHWVArMm8n9dxZzlTVQk=
X-Google-Smtp-Source: ABdhPJwUGfRUg7Xan1d0K61JVp8m6jytOvKuM51QpaP8fiffTBGGr+2u+CTl2f4T4PQ+GwuKpYYMuA==
X-Received: by 2002:a17:906:6a94:: with SMTP id p20mr11172699ejr.499.1604861132855;
        Sun, 08 Nov 2020 10:45:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dn20sm6733832ejc.63.2020.11.08.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 10:45:31 -0800 (PST)
Date:   Sun, 8 Nov 2020 19:45:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/5] arm64: dts: imx8mn: add GPC node and power domains
Message-ID: <20201108184529.GB7078@kozik-lap>
References: <20201107140026.1974312-1-aford173@gmail.com>
 <20201107140026.1974312-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107140026.1974312-3-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 08:00:23AM -0600, Adam Ford wrote:
> This adds the DT nodes to describe the power domains available on the
> i.MX8MN. There are more power domains, but the displaymix and mipi
> power domains need a separate clock block controller which not yet
> available, so this limits it to the HSIO, OTG and GPU domains.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Fix missing includes
>      Remove interrupt controller flag
>      Remove domains which interact with blk-ctl
> 
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
