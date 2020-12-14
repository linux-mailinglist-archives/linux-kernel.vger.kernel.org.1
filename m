Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4602DA3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441283AbgLNWyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:54:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33103 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441156AbgLNWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:54:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id b24so12994otj.0;
        Mon, 14 Dec 2020 14:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqra1QTGjIaQMS8ZO3kXNg7XHyLC+qgPhovHA2Dd1cY=;
        b=ZAZAg0O5yE7bOMI/C9vE99Vv9toIwTEsaK998Vw7K0VVyxanFYy575yIiviQvfrH40
         VjDqM/+z3ikfmPE4qJYZvnykjWvqNNitEmFEpgmGgqiVmlpl68QTDNj8RwBEAnuw5rO0
         SBHgP+HA2Gt0JhVPa+9S0G/fTc9glwBU9MKZ4sW4mU4dQ+iJK/oPsPLCmplW/7YkT5vQ
         2xKXaQggbSfSr/6JvcpPfSvp3+QQ6f6dxJZ5Uks6qNpa3LN3ix0fprYREePxBBilFNIi
         k8hc2Hr/MlCFOlCtKWccJeH1Yxp0CNqmAw9S01566Ca2v+qzVrTEZ5G0bU3o0MxH+pZv
         WyzA==
X-Gm-Message-State: AOAM5313A95otq4ZXG7dIJCMzYfDvj87cl7xiAQD2DNjjjvFC3f9zKBQ
        Ru0Aa0x0Za1xMDckXATFRA==
X-Google-Smtp-Source: ABdhPJydZnn0tJjFmNOqdiiIDPOs6c6PDGcOlM5zpPu6lj/tickohyS5os9MPobP9kqx2P3AcAyz1w==
X-Received: by 2002:a9d:223:: with SMTP id 32mr21528781otb.84.1607986431960;
        Mon, 14 Dec 2020 14:53:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm3502009oov.23.2020.12.14.14.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:53:51 -0800 (PST)
Received: (nullmailer pid 2533125 invoked by uid 1000);
        Mon, 14 Dec 2020 22:53:50 -0000
Date:   Mon, 14 Dec 2020 16:53:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: Re: [PATCH v2 05/21] dt-bindings: clk: sunxi-ccu: Add compatible
 string for Allwinner H616
Message-ID: <20201214225350.GA2533079@robh.at.kernel.org>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-6-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 01:19:18 +0000, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
