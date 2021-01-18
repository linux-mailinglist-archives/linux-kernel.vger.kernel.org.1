Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA82F975E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbhARBho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbhARBhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:37:40 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2896C061573;
        Sun, 17 Jan 2021 17:36:59 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q2so28244234iow.13;
        Sun, 17 Jan 2021 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfNnYS70YYT+KKpWoQOHcvinZdhkMmB9Nh5BXOWv9OA=;
        b=R7m19pPqIfYemBrQkE5Ycj9Dxh8R7ZmLLB8qWVg7KkTVLoR8nXjXXqfjtQJayWvtmu
         MtXFDProp8SrEVzTD0cnptS6K5gMAZm0oFvtVr6/jr8r+2LkXN+3ALTUFzjWj+KPWUF0
         5AFkh7HDkANj8ZhcvMWPPpMoAOzF/xI6eYKYqD/e3tYicI5Nl/+jwkyUAdj8evAjSFgx
         5Q7102b+RP+CGzCCBR34r1hX0XaYgkm/VY8WauaVBG8INgJ80WkYbIrWUU9JyYjwf57S
         /rlD++oTGgrlT8JFJeM1RaRdfexbkwKswnNfJIxRzS89M7zzYreKflqLBNtgmXkgM91H
         Tz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfNnYS70YYT+KKpWoQOHcvinZdhkMmB9Nh5BXOWv9OA=;
        b=T54TkOIbrg18mrWmHWRKnoukMq5N6eQ1BIgDzL1FWd3V0+y+cqimK2UDc9bbR0ZSas
         gCeYbeLcAN+Z3zL1IfL4vm2sgsV8xiWTQsO04g/+h7dq1jH6BqnpEH8o8lMPnMuTZNQg
         HiR239XiBkz8cKifuS+rxCvy4vHIH7tVSAoPGA0LR7hIQLsQpM+ONE0NZChaLJLJto6Q
         cEB7prkiarzE+r3N8BLosm8XsCb06R1Pmlr9OwbUq/ZvLDOA9cUzeEipmNeU1Ojlm4oI
         3F1EymUTNY2ePHnH/1wqnBNkKGxuOhOKnT4N3gxqZl1VBSB1L5F3sVMz7LtEaeLFXyo4
         evGQ==
X-Gm-Message-State: AOAM532+MUFijWvpKHBM7oLx+gwZS8RZMbyeuMwkiHsbRj485/sbE4Mn
        G08UebXMeiy/bd1bYXVqaot4OwCd1ipapsG8ibM=
X-Google-Smtp-Source: ABdhPJxEGvC3cb0SdFB3Xs+NJy0lx/f5SRiYnp1z5ij6m2XooQjXFUsDMx47Se3pRjVgG8cervPwNGsD6c+lccBl/ow=
X-Received: by 2002:a05:6e02:194f:: with SMTP id x15mr19561190ilu.177.1610933819152;
 Sun, 17 Jan 2021 17:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20210117035140.1437-1-alistair@alistair23.me> <20210117035140.1437-2-alistair@alistair23.me>
 <CAOesGMiLZGdjQTLj48B8dXV1vv2p-NG751m-bh61mJ-10N-rAw@mail.gmail.com>
In-Reply-To: <CAOesGMiLZGdjQTLj48B8dXV1vv2p-NG751m-bh61mJ-10N-rAw@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 17 Jan 2021 17:36:33 -0800
Message-ID: <CAKmqyKO_xxrzMHB7Fuxq_5xT6JH8sOudKAKgug_FiS08MiJ94w@mail.gmail.com>
Subject: Re: [PATCH 2/2] remarkable2_defconfig: Add initial support for the reMarkable2
To:     Olof Johansson <olof@lixom.net>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 5:30 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi Alistair,
>
> On Sun, Jan 17, 2021 at 3:09 PM Alistair Francis <alistair@alistair23.me> wrote:
> >
> > This defconfig is based on the one released by reMarkable with their
> > 4.14 kernel. I have updated it to match the latest kernels.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> It's awesome to see upstream support for contemporary consumer
> products being posted, thanks!

No worries!

>
> When it comes to a dedicated defconfig, is that necessary in this
> case? The needed drivers should be possible to enable either in
> imx_v6_v7_defconfig, or in multi_v7_defconfig (or, rather, both)?

Most of the defconfi could be shared with a standard imx7 config, but
some of the extra components like the Wacom digitiser,
cyttsp5_i2c_adapter, max77818 and bd71815 might be better off in it's
own defconfig.

If the maintainers are happy with enabling some of those in a imx7
defconfig then I'm happy to do that. I have tried to split out the
config changes (I have two otehr series that build on this one) so it
should be easy to rebase it all on a standard one.

>
> Adding new defconfigs is something we're avoiding as much as possible,
> since it adds CI overhead, and defconfigs easily get churny due to
> options moving around.
>
> In some cases we do it once per SoC family (i.e. the i.MX defconfigs),
> but we avoid it for products.

Makes sense, I will update my patches not to use a custom defconfig.

Alistair

>
>
> -Olof
