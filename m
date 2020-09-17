Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BEA26D4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIQHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIQHlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:41:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:41:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b12so1092054lfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzGRfdSlTsnA6ugMb6NVstzypnemez8bSdibR9WaXZI=;
        b=n9IUahF4nx7eVElB/b5yWlOaTpw9Io8kHvS+30WVF70Vvg5Rs4hKZ7sjWxfbQXCL6U
         HknbOUTOEMlKX8yT9+2zjSIvUrlhFXl6wOHqUopLSO3WaKLX2wJXbImMlr6kHNkdXflD
         WPlirGqKCrNnSytHO+6HX3dHHHypAzcaWjAWw5/gS2dFyRNCyUbAlSVqC3VkElPX2DZ9
         UO0U4136FDAdV6SdfKKHfhd1ptDfdmFMjIG4VZLwtWJJnUkee3hs4kmm0xC/cmttQvUr
         PTbBysSr02mkeQO1rIPMPimPK15nN/p1pYu1DUyruNPcK1vjY2rwqm8MfM7t7cE1oPCQ
         5kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzGRfdSlTsnA6ugMb6NVstzypnemez8bSdibR9WaXZI=;
        b=b4GZNVZ8xt7tca0j99gyLD9LWkq1fIRMypwSYrQOwki+a0/c9ZSiDqrqTp0DKzvoAM
         pcrPOUlPo+LaQ6h0aAQgSN2qXrqkOFzyme9wOd33MBcFATXZcipFqsYgjbY1M46tLJ/q
         czCU0XrFJjmXOn/CTaIlw/DXQaBeJ6lW7QqVG3DOA0jnagQ6lmOpLFlB6DctkzxaVImK
         WxnV023h+HeimNekiL8yDS1jIn8Gknx1Ic3/rEZV2DWcnUosIAyDyq5VF47ei3n5gVUo
         XIcDyQXUB0MEr6aVGpKQVYAmLhgpUvsD5C16y2JrGiF57ZAYdkq348q60YEL8nWGtowA
         L+BQ==
X-Gm-Message-State: AOAM530O9IuT4M/HJZBU4smuhUhTMJecN+DTlfsWWwsKJKEeN6i/MwlM
        xGIQYQEngTW71NmIJdh3dwmzCoZnYGrI7Wo1gO5ddQ==
X-Google-Smtp-Source: ABdhPJw0G6CbvuXojTz0DEQfjC8hW/vyZAE4oeQjTVpHpNO2gXIiI69QIvEFy8ZZF35IJs0vUQ1miDcDwk3aoGuHm0Y=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr8308729lfg.441.1600328467251;
 Thu, 17 Sep 2020 00:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-9-maz@kernel.org>
 <CGME20200914130601eucas1p23ce276d168dee37909b22c75499e68da@eucas1p2.samsung.com>
 <a917082d-4bfd-a6fd-db88-36e75f5f5921@samsung.com> <933bc43e-3cd7-10ec-b9ec-58afaa619fb7@nvidia.com>
 <3378cd07b92e87a24f1db75f708424ee@kernel.org>
In-Reply-To: <3378cd07b92e87a24f1db75f708424ee@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Sep 2020 09:40:56 +0200
Message-ID: <CACRpkdYvqQUJaReD1yNTwiHhaZpQ9h5Z9DgdqbKkCexnM7cWNw@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
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

On Wed, Sep 16, 2020 at 5:11 PM Marc Zyngier <maz@kernel.org> wrote:

> Can you try the patch below and let me know?

I tried this patch and now Ux500 WORKS. So this patch is definitely
something you should apply.

> -                       if (is_frankengic())
> -                               set_sgi_intid(irqstat);
> +                       this_cpu_write(sgi_intid, intid);

This needs changing to irqstat to compile as pointed out by Jon.

With that:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
