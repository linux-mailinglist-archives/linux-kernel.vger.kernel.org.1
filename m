Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA82E8CF3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbhACPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 10:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhACPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 10:37:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD3C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 07:36:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g20so33660205ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uAg5iN1da+3ePWPpyFcYcwdlbVryPlTlINq004in4o=;
        b=JwvSuHeRlwlrwB7WNCbvDhoF9WAMsvQqnDdg1JlgaEBAtl523jcA9w4JLwOFzwHjmi
         J5aAdvP/cfMK69HOOWVaUBb3vb5UX63No14nzEv8CtO/T4JHXy3wYgJt6I6zAjl4BBV0
         dcXZIgLshs19tWbZgY8Dn1mZBLD0t5/8Ma4eM5EGJdcRIKG47CCywlKDgzHnHAr2l/BE
         +1rwAX6+ci/Met6Xd65/LU7jI+7FQX0yphF6vvViKI3Xk/zQ0hpeXEpJBmtp0+4jaxy4
         TFBsPl8wIqu3HZTYFf6Cth7xrBDz5MGz/QHrFyd6ZcE9okI8AQeOCdyDsooNE4ZkwWIE
         PUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uAg5iN1da+3ePWPpyFcYcwdlbVryPlTlINq004in4o=;
        b=ZA+E0aMAouB7BWcQH2bnvLoMG8w5jchuc4M4uG2HgN2bx+CV/tD3bzZQfGFmubXdCc
         lFc/bphcAANUnh/ONrYmBeTzXoByxWXtWNpZeWPlZPnaNkgD8VHBM1QZ1g18uI46oCoE
         rXYiRq1Z2sdKxiJ2mSOTPqkcUHx8AcnlA20RAyERe6LdJZadajLhfIeOFoLOYBX8HRR3
         ejVPwxpkbNLzOS9espg5JYzy8+5sLx38cJf8UC7e5OMzkssj6casAaeYlT7SlGTbfhzj
         wgwOthbpzn3peaLExRr2MSSyy8crGPITd1pclFg4wByh40ICNTXmpaOCqrlP7fcCU4AL
         DvXA==
X-Gm-Message-State: AOAM531IPo4YgdjPs+84NLQ7qgDn9qytyP1pCs8UGw4D10MTSsmYojVT
        CgsEntmlNF2np5O4EaQyeKyWuDDVbeJyDCY2wfpG2Q==
X-Google-Smtp-Source: ABdhPJwBQG9ecDxJyqQA1xRpLqJK9vZ/W4Bcv9YIaAwkAwRD6aujNX2wjRNwAWN4ssMWVgLFjvu+azT/F2OFkwetnMY=
X-Received: by 2002:a17:906:3513:: with SMTP id r19mr62745809eja.445.1609688218007;
 Sun, 03 Jan 2021 07:36:58 -0800 (PST)
MIME-Version: 1.0
References: <1608888807-3117-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1608888807-3117-8-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1608888807-3117-8-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 3 Jan 2021 16:36:47 +0100
Message-ID: <CAMpxmJVEMgF+GS4ssG6X6qZ4yaBTicw-acGARbshjuqv1kEZOQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] gpio: bd9571mwv: rid of using struct bd9571mwv
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        khiem.nguyen.xt@renesas.com, linux-power@fi.rohmeurope.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 10:33 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> To simplify this driver, use dev_get_regmap() and
> rid of using struct bd9571mwv.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
