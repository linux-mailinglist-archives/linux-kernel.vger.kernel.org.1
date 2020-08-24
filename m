Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1B24FB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHXK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:26:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36714 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:26:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id x7so2046976wro.3;
        Mon, 24 Aug 2020 03:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8R34Al7fvJPaWN8S2QHL74CN5asy6YEq8ScLgm8T2TA=;
        b=jX61YJ4ZQr9+mox1r4Bkyt7jn5bAHaXBhn9Px/x5/ATX5Ma2Xbx/Q4+i6gzWlYFUwx
         tBAvFTfLNbedCI4UgXDOmuTPbmlBQELMiAzRGepZXWvg4ACU4b28XY1IuEwi/gGQ1J2P
         dG0fuAGWr7cnXIM99pE4ETxOWDxSVdSbMDxlq9/ZIISIRibbjDmJb8mVV8IV687l18YB
         wNVzhNzktXUv5x8XO/r+wHgD2MFVF0TJStLGQkaFvEhGqiRlZkv+7lObQ3qWrp+kZ6uh
         /hD7Q76uQky7Ks9cozp9c1ac1dEcXA0Z9hrxUNrR04ZMWGED6kIS9uUi2O0zQwZJ+ePb
         Pkug==
X-Gm-Message-State: AOAM530W5yUo8pbrnA0QWXbk7b7byycnGLIIE4GOuDmGzTimUwK0xw8r
        9YYGYcOOibeBf0qmvoNldlU=
X-Google-Smtp-Source: ABdhPJz83ri0NMa5qVnMOEgtU++aRNMCS0JubGDKvIbjf3992TdsdYRLXjTgcbOWYWJrWMcvf+QH4g==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr5542354wrm.301.1598264803981;
        Mon, 24 Aug 2020 03:26:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id x8sm19586652wrq.42.2020.08.24.03.26.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:26:43 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:26:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: zynqmp: Remove undocumented u-boot properties
Message-ID: <20200824102641.GA25860@kozik-lap>
References: <8ba339425b9c9f319bdedce7741367055a30713c.1598257720.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ba339425b9c9f319bdedce7741367055a30713c.1598257720.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:28:45AM +0200, Michal Simek wrote:
> u-boot, DT properties are not documented anywhere in Linux DT binding
> that's why remove them.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 5 -----
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 1 -
>  2 files changed, 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
