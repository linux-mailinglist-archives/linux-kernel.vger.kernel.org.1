Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743952F975B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbhARBa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbhARBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:30:51 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A627CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:30:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n2so12711614iom.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o84I7uRlMoUbwGmPe+8++9XgEZ5A53fJCbCCjWoj0Hg=;
        b=FQTJvOGOApQKD/DLnsW6zgk8O+tDz/OhgtJ0Ao1rFoLUb6YcpizHbw982aj0v89U54
         5WmvoovqFAyiWkyN8/cJ22KvL2BU/7Et8jGNxEcksljdqgmRbIkGysJG/5ZA0mjP2pd8
         sSd2v/FCEdstsV6kaxrBjoygSeRfkSHnQ9/dawWZHwxfm63upSSWgTeTmRiQ7fP0Rl/x
         nHKFdZQIpbwmBb4JzPxsf7LUq5WBixDtdzdD3xZunsa5BJ7z0WW8llYoefzju/hzpkJw
         ny8BYoysiBho1Oa1SWvLi5aA9E/jXK816SoblhECP3LFyARb3NUKi+CN2dJu45NTzq5Y
         SiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o84I7uRlMoUbwGmPe+8++9XgEZ5A53fJCbCCjWoj0Hg=;
        b=Zc321T4kiXWRkCD+aJzl18nLxSGTkz7Iv+4atR/C3ZqE4RYnjgrzvPvKYursey4jeq
         etC4TWxdBqVkeOfQD0KKD0cgOAf6KM7+VxN+Ei+2npEHkVYyuUTHeUKg0G7OpWD6SpyX
         /N0nUv/7rouXdCv5Z+DHZpdm3vfcafPiAcj60MS1aILERnZZiJZ3xdQg0D59Vguf0GZj
         W98FgI7MH/U966SwLzhfVScqGmzD0ST4c3gIafk8dbXIpBXvuIwQUuW8iX/XxGfllw/R
         9nEaE80MN7w1BoQxft2Z+f9QHJ+l6GS5dyUNPkMXCv9Z3DeTeMuRvTT96Xa9LqgjVJa5
         uhgQ==
X-Gm-Message-State: AOAM532AhBSeN70Q89pWcoEOP5Et2EIIJNOJdtjHqJK62+QTNi4ql6Jh
        Xlgb79tLPjOErMRj63AMCd8R0hg31ANrUtazQ43I++8GhWxttw==
X-Google-Smtp-Source: ABdhPJxJzT0P2/29OK2ubdkU5YH8ML5FAsykZPqFOkQXYkm2aQmUMwoeFoHuX7zGMtw0Lm8OMwpLWM7P0kF/VpK6WFw=
X-Received: by 2002:a92:6403:: with SMTP id y3mr19156474ilb.72.1610933409961;
 Sun, 17 Jan 2021 17:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20210117035140.1437-1-alistair@alistair23.me> <20210117035140.1437-2-alistair@alistair23.me>
In-Reply-To: <20210117035140.1437-2-alistair@alistair23.me>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 17 Jan 2021 17:29:58 -0800
Message-ID: <CAOesGMiLZGdjQTLj48B8dXV1vv2p-NG751m-bh61mJ-10N-rAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] remarkable2_defconfig: Add initial support for the reMarkable2
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alistair23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On Sun, Jan 17, 2021 at 3:09 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> This defconfig is based on the one released by reMarkable with their
> 4.14 kernel. I have updated it to match the latest kernels.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

It's awesome to see upstream support for contemporary consumer
products being posted, thanks!

When it comes to a dedicated defconfig, is that necessary in this
case? The needed drivers should be possible to enable either in
imx_v6_v7_defconfig, or in multi_v7_defconfig (or, rather, both)?

Adding new defconfigs is something we're avoiding as much as possible,
since it adds CI overhead, and defconfigs easily get churny due to
options moving around.

In some cases we do it once per SoC family (i.e. the i.MX defconfigs),
but we avoid it for products.


-Olof
