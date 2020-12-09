Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBE2D38B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLICUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLICUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:20:03 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC4C0613CF;
        Tue,  8 Dec 2020 18:19:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so661907qkc.12;
        Tue, 08 Dec 2020 18:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cZeETuOaHuzt2Vvd1AgHUQFc1tVzHtDBun/9sMNcHA=;
        b=Prp5KC+l5Qcfvh9IzzGs4P4XGezAoVWjjjvy04CNCPHOHidRwdQ3s9ercRfbsy0xSl
         gEWfsYhhjY6DjFdiLNVkakemH09BwdQ8lOkV9FKYAwu7OKhMBifOMG7qzursMSBEFbpo
         JSZ83Yl7PnpZwS1Xr6WGsCamZgGSHGnTA5wek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cZeETuOaHuzt2Vvd1AgHUQFc1tVzHtDBun/9sMNcHA=;
        b=fqZJ6TQP/3RG9k8kAQBLeyb9ajQmh0iN45tMIiqLD8yNhApfoMSWRIW/hXEJXhNLnI
         fDaJOB1xbf29VgvF/5X7f8c2mkxYfYyTmnW1GsJan6doBdk9XQGrS5li62/RZESxWRll
         4JHI3cC2+WLDZ0OWCsf1NbQf/8ZFuiKtv2ebqzx7AAHeWxcE2zBr3ptku4rHH2L2voHQ
         TwNmj5YCW1wEa9K1EYrVp4hvascahr2HZmx6/3hHo6eqa5hPvcdkFxClhzhE1cQze/iE
         OiixbViu0TXox/0aT6QiwsY6o0tDmew2vmr0d7iKkLIwNV0PE8qbaJWuCeqq6qtH+CaZ
         M7zQ==
X-Gm-Message-State: AOAM531idoxNbL5VMDqLFhHEGyltwJuu2I+0wTziDI4PnAxW/AYH25pz
        MgsNva+NU4DLi1x6Sxxso+GiW+y0lCrLaipLWUE=
X-Google-Smtp-Source: ABdhPJyc6btv5VUv0Mqhezo+2CB3ZLlv01s1FeTPQ0wb3A3KL9BweIkDsU1kcqFzGjk8eV1sb9E3E6AN1rd0R41KEbY=
X-Received: by 2002:a37:490a:: with SMTP id w10mr266374qka.487.1607480356757;
 Tue, 08 Dec 2020 18:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
 <20201208043700.23098-3-quan@os.amperecomputing.com> <CACPK8XdsbgKKr=icLxV=PZB9U03ZGWXQwCWgFvoqgCj9K_fbVg@mail.gmail.com>
 <CAJKOXPc2wY+tcXpZRkdKodr+SgQSbW=+qWYU6E1t8CXE0D9iNA@mail.gmail.com>
In-Reply-To: <CAJKOXPc2wY+tcXpZRkdKodr+SgQSbW=+qWYU6E1t8CXE0D9iNA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Dec 2020 02:19:04 +0000
Message-ID: <CACPK8Xc0pq3GW91+E4CwA8PSnF8=ouf6EpikMk3OaEwRh_88DQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jade BMC
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

On Tue, 8 Dec 2020 at 08:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 8 Dec 2020 at 05:42, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Tue, 8 Dec 2020 at 04:37, Quan Nguyen <quan@os.amperecomputing.com> wrote:
> > >
> > > The Mt. Jade BMC is an ASPEED AST2500-based BMC for the Mt. Jade
> > > hardware reference platform with Ampere's Altra Processor Family.
> > >
> > > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > > Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> > > Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
> >
> > Thanks, I've applied this to the aspeed tree.
>
> Did you review it already before (which would explain tags being there)?

Correct, these were sent to the openbmc list initially:

 https://lore.kernel.org/openbmc/CACPK8XdabEgp2Qi0Ud0BJ9oCK2BJ6L-F2Wg+OOEvzTALRLDadg@mail.gmail.com/

Cheers,

Joel
