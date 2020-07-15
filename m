Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F62221778
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGOWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 18:03:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46442 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOWDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:03:55 -0400
Received: by mail-il1-f193.google.com with SMTP id p15so3326655ilh.13;
        Wed, 15 Jul 2020 15:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yHrzpTpE71ECQpRuBTkBYfolEU5GSatuGLtkblRjLXQ=;
        b=a1t3tVYRY+oYfZz8gtWmPSxGSzexC1/MfPl9vmfGnuBWFB5Ot/q+ul2c/0J6R5KY2K
         fyTA4P25HiKvKyJv+jrCxtSQj/NfKacrHEJJA3jVb911aCmKQys5V/PxBxz47lwQZyq/
         K44eLxRpvvGZgEqovCfuCUhTMoe64YUyPZY+L7zkOZsoEXSOk/eE17GD/VkSWAbwC4ad
         7DiU9oQNwmocWD7IQXeQ64Kl0IEl18XUqUxLqgnb1YkkPL3GFd5SB/+h0WjuOPnvIp5S
         Pl4CFUv4+hMkK/Bz5gYtkLLql0TLfPljahUHmzEF61ydel882Jb8Q6qTFj9KGdTagt3B
         VTEA==
X-Gm-Message-State: AOAM532ajJELezW+GzBhz4U6DdXD7HiSUmnDmGoOv1FV6mWjnJqKDM7X
        jH6UzDSrPui37QKAdZ/XCM/LzKvDaQXV
X-Google-Smtp-Source: ABdhPJwQfgtE3w4Fk0lEUwsl0trZOdpbFojfWp4McLV3EX5OCRGWVOQ+wQEZIn4mHN/f9ehOeeUbbw==
X-Received: by 2002:a92:d2c6:: with SMTP id w6mr1558062ilg.24.1594850634592;
        Wed, 15 Jul 2020 15:03:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t21sm1794626ioc.0.2020.07.15.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:03:53 -0700 (PDT)
Received: (nullmailer pid 896331 invoked by uid 1000);
        Wed, 15 Jul 2020 22:03:52 -0000
Date:   Wed, 15 Jul 2020 16:03:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Message-ID: <20200715220352.GA896275@bogus>
References: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jul 2020 19:33:47 +0200, Marcin Sloniewski wrote:
> Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
> Website: https://www.seeedstudio.com/
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
