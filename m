Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF94226D88E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIQKLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIQKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:11:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD50C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:11:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so1545638lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lfw0pZf5vdHHfUgrNrha2M81cLTyzq4YBGGNWikohdY=;
        b=r+Kz5XIFz8QCzp8/AA7bNJnv3b8feF0M0xrOJ5VjvCOpthdYjDaVbcPUorey50eUNa
         PEl3eOaD0CPYpiiGibnS7NE1TqKumseLLBpPMCTWud4QTFiZbEM/DoGbg1bHTFBGN9W3
         czsnyKdh7XPc8QYSZ3S86G6qbtlpbVyq/mGtYE9cllNsV+4KqA1CxKkvCjTc7cT+k0vV
         3XqNTzeUqNtRFvC04ygTXRbteQiov6HS6XUgV5XttkBXS0itMX5Gx22VULMye1fCilTn
         K3eKb9lPbkyiqtcqDqHBGBrjF1Gt5rGC/25IISA8QX/vphb2czs3qYxLicWhFbkBwcVF
         7Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lfw0pZf5vdHHfUgrNrha2M81cLTyzq4YBGGNWikohdY=;
        b=WbOvnXs5aEjsJfzpYnj+ZOJYpqQA6rFut/XE94ythvzfJQ0e8Hc2RJSxX1GRuzf4c1
         jwM4nukjadJrY52XA18fHdmULtQWGnh/zhs+fH3zVgMCHVLmx51Tya3b1URO1QFwenWK
         mZh54LvqQGSaXhh0/trO2XjghJ/n4MO51OHrj7Bv2mPjZdHB1xxuLUpSaLBMJAKY1OL3
         8Zo5kCgQ60SGoKhsDhOT4+FEHeq2y542AuzGZnjalOJ20KwBmEeoBdiF6A1Lo+7zu5Mx
         q9vNLWKWQJynTeZttzde/6B0wuS/JuAwtNq+fSgw+qX28M/dt1F63sUx76oQHdLfNmwl
         Bv7g==
X-Gm-Message-State: AOAM533ylAqf61VTOYLIgsI8P1Dm/nqxEON6WQYUKAgFHN1zrGMCZRCu
        4f4i0qzbg8Y1bkXmtSfYHbikS0oPPYUGIw+KQ+8M9A==
X-Google-Smtp-Source: ABdhPJwkybZnzh/PBSyDbtaU5yAZWDqp/QKyibrBWXaK9jZZrwcspAA2liHQsjYBnpIa7qF0RNRZcO2IKI9JXPm1lUE=
X-Received: by 2002:a05:6512:20c3:: with SMTP id u3mr8126055lfr.572.1600337484779;
 Thu, 17 Sep 2020 03:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-9-maz@kernel.org>
 <CGME20200914130601eucas1p23ce276d168dee37909b22c75499e68da@eucas1p2.samsung.com>
 <a917082d-4bfd-a6fd-db88-36e75f5f5921@samsung.com> <933bc43e-3cd7-10ec-b9ec-58afaa619fb7@nvidia.com>
 <3378cd07b92e87a24f1db75f708424ee@kernel.org> <CACRpkdYvqQUJaReD1yNTwiHhaZpQ9h5Z9DgdqbKkCexnM7cWNw@mail.gmail.com>
 <049d62ac7de32590cb170714b47fb87d@kernel.org> <a88528cd-eb76-367a-77d6-7ae20bd28304@nvidia.com>
 <81cb16323baa1c81e7bc1e8156fa47b8@kernel.org> <e317b2fe-52e3-8ce7-ba77-43d2708d660f@nvidia.com>
In-Reply-To: <e317b2fe-52e3-8ce7-ba77-43d2708d660f@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Sep 2020 12:11:13 +0200
Message-ID: <CACRpkdaaB-cxnHYkFLpRV75hM7pP3_oAqHUqJkTcykAZF5exow@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard interrupts
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:49 AM Jon Hunter <jonathanh@nvidia.com> wrote:

> Linus, what -next are you testing on? I am using next-20200916.

That's what I use. But the Ux500 graphics are simple and does not
use CMA and that is why I don't see this crash (I assume).

Yours,
Linus Walleij
