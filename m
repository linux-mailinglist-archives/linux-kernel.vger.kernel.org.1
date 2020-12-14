Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319912DA3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441213AbgLNW4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:56:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44163 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgLNWzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:55:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id f16so17469911otl.11;
        Mon, 14 Dec 2020 14:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDeJNXcmJDhStDI87itspBY4rlKxwwiTtWBXy9ejB6A=;
        b=FXKmGQZUUOQ1Mn8sWRyaN+HAWzRUXb+wqvMqpWltsBDTfHIS14Nc2emgSrroH2KppL
         aGkFmBwIGJinbEe3cfulRlZTUeD6FeGo8xGlA41jTjCFzGLvwlSauPvtcHo/C50fcMxJ
         JZwK3JvdqXeUqsxi8c8tHz++TffS4tpOW2aMFSwmJZFUdbhlSeD+2+jwf/tob90w0KNU
         nvEVhggo8CAFnGraccsGkmRXNRnIjLbFTWZy3pRoBY8xoYJKBiGzADUbGajn6/FIXGtC
         BHNiSXDvuwSpyc4/PrqgKhimPLogdZHKtB6v7wzPdy2sgXPctQ0U1QkRxkINLklFEJJ9
         TmsQ==
X-Gm-Message-State: AOAM533ZvMTkyyfCsbglxxBvk7/uBiyV2BER1Icmsym9KqvoN6YQJUua
        gePNALvRaANDMaXRq+jtdg==
X-Google-Smtp-Source: ABdhPJx8dmNxESp5xAiVLdhAxRcRO9Lzhz16GvjnoyQTgpczBKFM8fw6YAlxrbYFOQQp59CXjA4pjQ==
X-Received: by 2002:a9d:774a:: with SMTP id t10mr21294942otl.190.1607986491560;
        Mon, 14 Dec 2020 14:54:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm4235513ooa.24.2020.12.14.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:54:50 -0800 (PST)
Received: (nullmailer pid 2534578 invoked by uid 1000);
        Mon, 14 Dec 2020 22:54:49 -0000
Date:   Mon, 14 Dec 2020 16:54:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: Re: [PATCH v2 11/21] dt-bindings: sram: sunxi-sram: Add H616
 compatible string
Message-ID: <20201214225449.GA2534533@robh.at.kernel.org>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-12-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-12-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 01:19:24 +0000, Andre Przywara wrote:
> The H616 adds a second EMAC clock register. We don't know about the
> exact SRAM properties yet, so this gets omitted for now.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/sram/allwinner,sun4i-a10-system-control.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
