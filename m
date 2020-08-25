Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89BC251439
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgHYI3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 04:29:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51197 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHYI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:29:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id t2so1544653wma.0;
        Tue, 25 Aug 2020 01:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkVGZDX8kJI9mI1G++5UxoqItzmkNicQe/GJs1RM9xw=;
        b=GQdATXdzIx/wDTfKHLjQWZZiCS/UNragrmuNSvhWq66KgK0U1kf2InULpc0/RhKI83
         cGsFH9vFgFTMBMtYdXmFlwjvN6e+v8N2/jg1+EVhkjBr82qRxNZqqKQtqshKU7kGoBI9
         ooeQz8Pl56yPa/d/Ry5WkPY4evEYWxeoeVCy2ZVBln/BOtVTGPDQvRkoDaj3BmJELNL4
         j6qe8iM3Cx+niXE8+eQ32yyV8K1xtzj8rkj8xjXvg9iHQN09aOfAdoipq6PwH3VB/mke
         cUw86Wv0l16xrOBu5fh9qd22IUJz4/ilicBvs4hgt3hqptr5dyGaW2oafAqFpH8vF9x5
         k85g==
X-Gm-Message-State: AOAM532xmEIgsVlCskeskzaHVFm0Q5eXqBgnEC1+ehqCm0lfgvMIVzi1
        OcEK6DD8HIzrqhnys7ATRDs=
X-Google-Smtp-Source: ABdhPJyGZYBTYvBnIb1U6Pi6IZyfXdLtVJVjvq4o+WqdI5gMCjQzeo/6wd0xJgWYZ/5Vtdr46sQ3cw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr940487wmb.54.1598344185330;
        Tue, 25 Aug 2020 01:29:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id k204sm4973101wma.21.2020.08.25.01.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 01:29:44 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:29:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Message-ID: <20200825082942.GB12902@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824190701.8447-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:06:48PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects regulator names to be lowercase.  This fixes
> dtbs_check warnings like:

The subject here is not correct. Copy/paste error. I'll fix it up.

Best regards,
Krzysztof

