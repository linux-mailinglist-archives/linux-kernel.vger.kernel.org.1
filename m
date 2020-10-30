Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D122A0D67
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgJ3SaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:30:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34847 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJ3SaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:30:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id n11so6430279ota.2;
        Fri, 30 Oct 2020 11:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dv5/9TRmWxsCKSlwoZsNXaTRpBmSTC+OSZ/G8xBXKjY=;
        b=XtMOUBuMo8oGgMMm2rQwwj1/zdavbTqqx9u3x3Ttnb3JtNvXejTC2odZ8EJXFK5051
         5lo98pRPb6Jx0RL4nB92Y3/NihkHiFTw5HQk3bl+qEE4UgD/cBCEUc5YVYjewYpM6+07
         BIEmumfSD9f8kqWe59/9xd9IeQwf2jA6xISXsd0LYtfx/UX5eORxdWWfp+4iIzivVtm3
         j3Q9g6oH9ncsn8rKIQlQR+nI47L88bib9O7kDnUeCu5JN9ynvaUpWLjOsWAG5JoVd0em
         f3mumhmavdqyLZWRovjtRnwXersMYlgE1OvFFjeBDMFrll4peW92mDpZS59BTLyHNc8w
         PZGQ==
X-Gm-Message-State: AOAM530XVK3PTMmYEK2fdoLu4hTEK/pEuTpmQ2DBgCXTdNmSuUbK6M2e
        wFNo1m1FVHcyTCLwgYdesQ==
X-Google-Smtp-Source: ABdhPJwjWL4uU6/aU2QZ0loH5aDVm4Xsq6nUjJcBJGPH4rXLCHsLYkXhQjxd9hQN/sDQiCs1RPI2Tg==
X-Received: by 2002:a05:6830:149:: with SMTP id j9mr2773186otp.187.1604082623332;
        Fri, 30 Oct 2020 11:30:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v11sm1499753otj.73.2020.10.30.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:30:22 -0700 (PDT)
Received: (nullmailer pid 4108144 invoked by uid 1000);
        Fri, 30 Oct 2020 18:30:21 -0000
Date:   Fri, 30 Oct 2020 13:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>, marex@denx.de,
        abel.vesa@nxp.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: clock: imx8mn: Add media blk_ctl clock IDs
Message-ID: <20201030183021.GA4108109@bogus>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024162016.1003041-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024162016.1003041-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Oct 2020 11:20:13 -0500, Adam Ford wrote:
> These will be used by the imx8mn for blk_ctl driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  include/dt-bindings/clock/imx8mn-clock.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
