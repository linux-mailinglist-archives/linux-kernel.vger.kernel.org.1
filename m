Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9D2BA337
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKTHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgKTHaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:30:52 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED990C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:30:50 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so12045666lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZFpaqVmcKbfAHLiOBNeFi+7FlSVWuIQWiwUi+OOx+E=;
        b=QJwp3PHYVooyM7k9n+n+Y5pwyTdmzi20Yw+rgCKXo07Seta1Tl1Z4kSgO0Nju3JeLB
         5xxDrmPrKThlGhD8o0hKXpAIk/v8yjXoQWYD/awUcJi4hWSs6Amg8EpGEZnBIpUYGerA
         xmHrswhglrBbt8Y5w6xg2N3hgUlEz5h1tty8+Xd05zWpHwVIyqPQEhAS0hG5xT9byOIB
         7ObUEgWmg8Nqnb5QQULE37w3/KP3fC0qqebhVbkadrXQ7HYn7kHUTJQ3zdtFi/ztZedg
         9K4w9pYrHquJM/AnBLmJKP3KQQgWJuGwP2wGf8SEJVftIo7ysSd9ZkBI5dWIgK+OyOsL
         JV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZFpaqVmcKbfAHLiOBNeFi+7FlSVWuIQWiwUi+OOx+E=;
        b=n0QQBJ1wFRaXbCetA+FJvsuvq5sI9jqRPFQQOdxatmKAw+I4+X5U/cO4ga6yhYwA6X
         M6gY57mN+nYwnVP+RjVdPNmNMk3lfrbGNFcPDLR+dJBYI80oSlHvZyys9LXCpGRBJqk3
         aMT17DJpy70mlwbj358+mhBW6zsVTmjbo7UvfczkxD0qV3CsFLQv9MRQja86+eF0BYTb
         5qCIBUXp/SQ+cLAH/qv5ux5CjiF3MAeAv5GBQkXiAfbRdGmpKNYYlhk8enCzRI6OmcMb
         4i5mH1Kwq5ytNsUlWhhKmdLB6Dk15EUDElXyVJyM3vy2qgblP6ZOSjWcJ49YOmB+LqEu
         We6Q==
X-Gm-Message-State: AOAM5325ZVhSuySY9kKQ6LnL+JkmhOnmDUL/2f6UMyuXfGv870M7Yb9y
        4i6jdzVRCyfQePON3wdZTO8vpci5FP+1ngpLPGXC0w==
X-Google-Smtp-Source: ABdhPJzJALLcWMeZOVo6FqhUBH/PZiWo6vMMLt5m+qfLwdaS+NzHhdQiB9DaaRo44bs8H3N+bl7OrDhVjfkjOkxIyfE=
X-Received: by 2002:a19:4bc2:: with SMTP id y185mr6788535lfa.243.1605857448241;
 Thu, 19 Nov 2020 23:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20201119082209.3598354-1-davidgow@google.com> <X7dhwNFehhCRs7Ry@epycbox.lan>
In-Reply-To: <X7dhwNFehhCRs7Ry@epycbox.lan>
From:   David Gow <davidgow@google.com>
Date:   Fri, 20 Nov 2020 15:30:35 +0800
Message-ID: <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 2:27 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi David,
>
> On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> > Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> > 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> > functions, it should depend on HAS_IOMEM.
> >
> > This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> > HAS_IOMEM.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  drivers/fpga/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 7cd5a29fc437..5645226ca3ce 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -142,6 +142,7 @@ config FPGA_DFL
> >       tristate "FPGA Device Feature List (DFL) support"
> >       select FPGA_BRIDGE
> >       select FPGA_REGION
> > +     depends on HAS_IOMEM
> >       help
> >         Device Feature List (DFL) defines a feature list structure that
> >         creates a linked list of feature headers within the MMIO space
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
> Do you think we can add a Fixes: tag for this?

Sure. I think it should be:

Fixes: 543be3d ("fpga: add device feature list support")

Let me know if you want me to re-send the patch with that included.

Cheers,
-- David
