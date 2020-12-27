Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972742E32BE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgL0VKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgL0VKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:10:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3BC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:09:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so20004213lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbUyUXqfcMapMitYeWLZoP4Wnr0S0nWOf4B0TWLyMPE=;
        b=ZjGcqlAH4E7BeO9qvl79px7QpzkJohOsIPnqYez7Yp7AZU2m646cWPMVTExlh5H6AG
         L0nGMbWcXZUXdM5vbJq3EqH5/tQBi/LtcamoNMGbZd/gpdngB7xayo+oAuCt15M6dMsO
         AiisxqKfzIZcGS/9WsULhR4hdotdxuwmI1whuCj9DKJQQUHTn4Jg2l4tVlUEbyTzoLgF
         1LPUD6APPGs6qndEMH7gPrUPoDy3mK/SVEQtyMXdb+LnGlgjo5jPw4Ui476wUCjrHfwq
         6M23+dH6Uy70SJi/HuDyxfbL6dAAnY3B0Y6GizLfD5ygDwXrXxjrrvq8Nr1XIiB0ou0C
         /zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbUyUXqfcMapMitYeWLZoP4Wnr0S0nWOf4B0TWLyMPE=;
        b=e2rqY3MPS0V6IGYiBUzI92cOg5+aSDEacyxekkHhXsl4IfDH03wwvjLyWeFXXAFrlI
         ynCwt+W6gTLryfyx3l4jFy9sy/ZO31dhzijos+0gm9+EnOHn0BprfVtpo9S/QBdHkgCn
         vhDzqMUFRw023lQm9cwi2Fbpi+d8gMf9A9zett6wo5J8RAHaf7vBQdTzA2f/m+6lNyfD
         iqqaYp0B8d+sKL1I1rtTLWr2mEyzQGd6D0ot53kBWCfXKrWMv3bEF6NGinYdQU84/75U
         bXFr05AHtNclmUqa1CVKS8PZKSJLygGINqkc0R6f62LQgfzYhqwPXOJkaOyPWcJWaCVt
         V+vg==
X-Gm-Message-State: AOAM533dYbtimIb9vCxmcftBvRNpEc+Jhe+Ep2MFWzyrMPyG6077dPtV
        NOAW2lcfZV6aUy3RhRC3vbAnppKTCzwx5vj3/WngDA==
X-Google-Smtp-Source: ABdhPJxyoD//S0MkIPQC23aHRggofmFph5lKG63J1ZwjkgVR2ldxLsJ+izCRMExCii3ppLi11lOz1v/sdZQT57CTD6A=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr20447406lja.200.1609103398036;
 Sun, 27 Dec 2020 13:09:58 -0800 (PST)
MIME-Version: 1.0
References: <1608539124-4914-1-git-send-email-luojiaxing@huawei.com>
In-Reply-To: <1608539124-4914-1-git-send-email-luojiaxing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:09:46 +0100
Message-ID: <CACRpkdasX+rxkG8jWVSxGDepKOr5XMhGf6k=9LEh2hN_UcxEXg@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: hisi: delete some unused variables in hisi_gpio_probe()
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 9:25 AM Luo Jiaxing <luojiaxing@huawei.com> wrote:

> kernel test rebot report that dat, set and clr in hisi_gpio_probe() is
> unused variables. So delete it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>

I fixed this in the tree before sending the pull request to Torvalds so this
problem is already solved.

Yours,
Linus Walleij
