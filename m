Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC252D256C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgLHIJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgLHIJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:09:39 -0500
X-Gm-Message-State: AOAM531KqWTf1bliUheTV+JFQbgQKCdg9zvsnyFRXkQPt0688OgOdZNo
        wh2znYJwOKLssJfFfmAAm+AND7yN0hWYf5pgYz0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607414938;
        bh=LhPpJxC4F5Q3Y/fX73/+10L00v+eOApqEJLmH8dkajo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cpzu6RDtnB0yEkEvK7aYyfX1tX24iW65gKao2x8SM/84+WA1x0BAwUXuqCcnVbv+e
         PeUt37/U84dLpYuRmZNeWe6ZwPEDOygOGBiWyHexzkBOu8QK+YdC4kuFyP9Hlo+B0c
         N3hqLr1B8i3Pe1K3CGNcOSf75SsflNb9SRY79KVhR2BX6kPR5QRP5ynOGZ8Qh/O7xX
         qhqsqNu2wXsuHr5CskyKAcQbUiRx35S5KDc/z83jqdoiDPAq1kbyU9IO9uE5RQqImf
         Hp2jvkBe+9Mt0gVlmb7NKwtlX3kJCbYsZlwMi1VOkTord1YXXvTbh4GV+skabNq9zR
         fZYZKwLJdw+Bw==
X-Google-Smtp-Source: ABdhPJwe1x41l8I7WarLwBmKZ2PsxA0cxVWQLgoGcW+CucDX3vRQbuP0kctQJUR/b8oR9+p75TThDyXXV7jUAio3k2g=
X-Received: by 2002:aa7:d593:: with SMTP id r19mr24099686edq.246.1607414937105;
 Tue, 08 Dec 2020 00:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
 <20201208043700.23098-3-quan@os.amperecomputing.com> <CACPK8XdsbgKKr=icLxV=PZB9U03ZGWXQwCWgFvoqgCj9K_fbVg@mail.gmail.com>
In-Reply-To: <CACPK8XdsbgKKr=icLxV=PZB9U03ZGWXQwCWgFvoqgCj9K_fbVg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 8 Dec 2020 09:08:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc2wY+tcXpZRkdKodr+SgQSbW=+qWYU6E1t8CXE0D9iNA@mail.gmail.com>
Message-ID: <CAJKOXPc2wY+tcXpZRkdKodr+SgQSbW=+qWYU6E1t8CXE0D9iNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jade BMC
To:     Joel Stanley <joel@jms.id.au>
Cc:     Quan Nguyen <quan@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 05:42, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 8 Dec 2020 at 04:37, Quan Nguyen <quan@os.amperecomputing.com> wrote:
> >
> > The Mt. Jade BMC is an ASPEED AST2500-based BMC for the Mt. Jade
> > hardware reference platform with Ampere's Altra Processor Family.
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> > Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
>
> Thanks, I've applied this to the aspeed tree.

Did you review it already before (which would explain tags being there)?

Best regards,
Krzysztof
