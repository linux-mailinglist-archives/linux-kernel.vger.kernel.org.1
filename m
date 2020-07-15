Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E722177D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 00:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGOWEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 18:04:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36187 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGOWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:04:14 -0400
Received: by mail-io1-f66.google.com with SMTP id y2so3943674ioy.3;
        Wed, 15 Jul 2020 15:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E37MfxaXBonMzoJ0Y6eNBX3gbAQt9fHjppNBFmFe8vc=;
        b=Hi6Af845tXzfUzBzD0aEyqXGPcjHO/bXJLS9Bc8aSu7abBo2Cta9zKRmtRBiivflOa
         F0qqYSZUIzaK5fzRCBS0krau3zqOCufin2YTN7THqfN5L1Zq3TyZF1AzBR/lZEpWecxw
         o4tdWdkZtIDCeBbqKCz8Nz0xUs2KmYSnU2gqRnfCUxlFUzVO6nRzmg0HZWf8yDg9fEJy
         N+wdF5YjRo+cexQHw1qTbxnAAtKSx+RePeABo71AsZ2AR43lJtxFuOdr9cYI8XgyJMTH
         MdAb5XCpdWXn91ACvDtcY1PT8rqfINhJs6R5tiP7wfKJAaoG86mYje0s6EiS4kkU0vjK
         AkVQ==
X-Gm-Message-State: AOAM530glI/OxvJH7bsAN78Jlqy78dkecw1GeRacOgcwFrYiWVdKkOoN
        yr2ZztCSv1EFVWMSpvmE5/+pTEWwvTNL
X-Google-Smtp-Source: ABdhPJzouTdezAv7Crm966GCqFA5Lv1wlXaFJfHLEjYkjPNUu4yL/+ft5CjlkhuuO+xKMTd6IFC6zA==
X-Received: by 2002:a05:6602:1491:: with SMTP id a17mr1427701iow.198.1594850653650;
        Wed, 15 Jul 2020 15:04:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x12sm1826088iov.43.2020.07.15.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:04:12 -0700 (PDT)
Received: (nullmailer pid 896818 invoked by uid 1000);
        Wed, 15 Jul 2020 22:04:10 -0000
Date:   Wed, 15 Jul 2020 16:04:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        allen <allen.chen@ite.com.tw>, Lubomir Rintel <lkundrak@v3.sk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Message-ID: <20200715220410.GA896770@bogus>
References: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
 <20200706173353.20525-2-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706173353.20525-2-marcin.sloniewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jul 2020 19:33:48 +0200, Marcin Sloniewski wrote:
> Document device tree bindings of Seeed SoM and carrier board.
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
