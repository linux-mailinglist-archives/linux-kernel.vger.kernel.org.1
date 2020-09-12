Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E006267920
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgILJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 05:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgILJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 05:26:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45494C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 02:26:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so8296543lfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+48eoB8+wThondXw2toHob0ZQwe3LgTU2CE7AlUBMM=;
        b=OuRWaG40whjIBcB91iNEvAaHGH0XDNk5AXjxsFd+lICwB8++pB5UsygLg6jwo/lL2A
         qd53HqFUUnm3cDfBUscBkRR1u9VdxLP7qcflg9bAFk0JXmup6OrDzfQpQsCOhL9SY7XW
         vR0VT+2T1bqV19wiKfCyC3E9Nx/TcZ88mR8/c8gXF0yduk3xdoC/Ir50d7AIkuzKUjUy
         4F0dMDAIYUEth89uoIqHYVdc8C+bdXJyz5JmcupsoZY0mzUstYXOqCoD/nN76FZS7ImA
         lJD8JSIjMf3V+xJpzWOjcQptKuobR+0USHm2aAa9OpznGdsOHeTJ6ZJVdmq+wn0U96tO
         N3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+48eoB8+wThondXw2toHob0ZQwe3LgTU2CE7AlUBMM=;
        b=gxPNd1Eacd01lDRMWTYzA3CwDioL7DLY+uSuG2GLprzxBoiC1xughkYgvNeKupc7qC
         rGfEn0xzHBDNWGvDZgc+JL632yMVJNtk+PrlJf1mJdB2m5p37rY/pDVbL6S117ixhrCT
         yXrgr9dnAHqdT5o/gEjlKZwNDNMyn7V2IwglxM+AvyAgQTWYzej971Tbuc5TR5urbLDZ
         0avocTeUzXGGhXJRLOWAXpjsDQPslwDYEmK+zx8C24tb0oLTWBgq48XgLTySn+LEUf1X
         eMKL/rhz/47DgsBIr+hm77FXJwpRhViya2Gtntc8/dRUT8ZYR0nyvye4UZh/m+7jwnKf
         yfTA==
X-Gm-Message-State: AOAM530gk7I2N6fK4UZKm3TziG5xo/sU9yxNukGkh/ZU4aJjSoORfqC0
        sKV6RBjQiiUjrargxAB6g0+y2DN5qikPcosClHSLnA==
X-Google-Smtp-Source: ABdhPJxdoNVDkt5k0KwL4T1WSSnHEJDy+mY/l76Bcz8T6aGaxXWR//LA/bThMnertfCCTg+IRPpUIcuvCtcRsJJk2dk=
X-Received: by 2002:a19:520b:: with SMTP id m11mr1331733lfb.502.1599902810277;
 Sat, 12 Sep 2020 02:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200827200827.26462-1-krzk@kernel.org> <20200827200827.26462-6-krzk@kernel.org>
In-Reply-To: <20200827200827.26462-6-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 11:26:39 +0200
Message-ID: <CACRpkdZJ78LBANGOdE6+kokfJV5hUYWaXhdhG+9cFUyj6YjVpw@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpio: zynq: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:08 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

All six patches applied!

Thanks!
Yours,
Linus Walleij
