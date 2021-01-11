Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA72F10D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbhAKLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbhAKLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:11:31 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC86C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:10:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y8so9325908plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVzeDIeFGB9KdppVPpTXtvgJ/V3K1VlejVNrV7Jet8Q=;
        b=EQj1r9npWGL2wZJf8jEyVAgKoS/ndcMOaIW5RCfKQrdlKm0pzJPOmSL3R9SXisnhY/
         z9tRn9jY4VavBwnPJDq10o1UtGC5ykxZebPPPIw4bQnageCzxarguV6K/QayTLmptv5o
         LDJk831nzp0Lfwn76zawEgEwngJwRHfE3ICkN+6tK5655PzI/WgGSzk1m0Tgd86yhbJR
         upbD1i8ynHznVkbNaB7rA8f4RMdceJENDxzE6uwqdf056T2GlJWQ9bU7Zs9crdXQeF8w
         Z2X8iN0v6CcL+rGLQ4kcVXRPe1PXyJ0ETbEyACBvZiFAYc2YJs7qOc7Fcan1uCJxuv4O
         WWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVzeDIeFGB9KdppVPpTXtvgJ/V3K1VlejVNrV7Jet8Q=;
        b=iep15src1PKFXocura4Lzpmpr5NyFKEyGL0XhViOCVvRlTMnFXzd2CXsAxPQdrfejd
         yoSQy5JTo8M82hxi45cvkRJlBTLqgpZ0NLgR/Yq1FXo7vxoqnkKMZm4mkRa1q9l83Me3
         Nk1MS9BCp/oUXdEpM1M7d/v+B38/fRj/4LGHN5M/4sHe/uJqxFQrs7MdyE5jFUWiViwv
         7AqM3SS6X3ZHb/HQi5BV6ZBWRQmgUbhbb39p64wnPawrhsPmxWFatlh6Qy8tVCk770Al
         GsB330rxdc4guJZKGroUooydEwOedF2Qq9DwkZg3RS8YjbihBbZIouRN275kLL7F9geL
         zRDQ==
X-Gm-Message-State: AOAM532qsdINk6fOZCWD9VjCGPpnynj4DKAUOcnLlo/k8ACvS5rYtXWg
        veD+AJRt0h7d2xZVUGgcvbLCug==
X-Google-Smtp-Source: ABdhPJwH1oCOkXXjASYQcVMUknfmihkly1onOdB6y/d6jeOBZpInh9rslGy9gN3zizofeosocykzWg==
X-Received: by 2002:a17:90a:9f47:: with SMTP id q7mr17554145pjv.93.1610363449640;
        Mon, 11 Jan 2021 03:10:49 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id z3sm18325194pfb.157.2021.01.11.03.10.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:10:48 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:40:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Mattias Wallin <mattias.wallin@se.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210111111047.mgrdho7frjukxfze@vireshk-i7>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-21, 23:55, Arnd Bergmann wrote:
> * spear -- added in 2010, no notable changes since 2015

I started an email chain with the ST folks to see if there are any
concerns with this getting removed and it was confirmed by Mattias
(Cc'd) from Schneider Electric (one of SPEAr's customers) that they
indeed use mainline on spear320s and the spear1380 boards, while they
also have access to spear1310 board which they don't use that often.

-- 
viresh
