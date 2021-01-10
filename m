Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0C2F0492
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAJAZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 19:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbhAJAZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 19:25:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9871AC0617A3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 16:24:49 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so32244687lfo.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 16:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaNjSrG8taLJEzXd4CfVhlhv+S87fFrkBRWdE4GXbNU=;
        b=G8CJ6yX91fKSLE4hDDwBLWMD7zoM/coT9SC/zm9kWRyySwDSMvvyHUFNWSMzgok6SO
         Lxn5dJDH31e0i0pe1U/qnjX/hiAuZbs90ZAqY53pPMVzmMtdgDerq08JTffI9NWSBSZB
         IfDutdLr9GtspwSxrBNesP1zKWI00tRSii4fBGexW6C4Ohc2o38OTrpecKWH23DWz6i2
         bowTwVCAvxljAKg9BdqEjSeu2IgVTWok6FxoKbkoB5v6Icvu5MCHgA0lOGkOWlts6Tpe
         NpwdN2lgiOrjYeo1D8JDG442LUnAaM5m2E4VpvSD8San20rdGlIh90BG+347KxbSHL+X
         m1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaNjSrG8taLJEzXd4CfVhlhv+S87fFrkBRWdE4GXbNU=;
        b=gWq9wMENfxkKR4vUq9plUKsCsqqkTUmRpUY1MIuX6XSteo3Zp9J2RDuLIitf5zs8kh
         Ui3jb+zImc1o3+h7TD70lqJ4ipHjr2jUmTuYu4GzYeP/9UuEvbI/jWVCtIBtL1bxMzhS
         3XX7S+oUG99fkYs5uxg7FghDIOho422jQVddhh+MLFgUdX6PkfQNOjllh4Mj5jSqZzpv
         jTbxWUhoCA9/ctPuyk4TuzFmRh05p8mBcMtlos+mm90l0HN5Ny+5mO4bFLXD8RcuAJ7U
         EKU94dY0rJP27+NNofypTiwPKcruvoqMo4tLvE4/tTjE4TN9y0bA6cnSHUlPiNbyvYwp
         KWuA==
X-Gm-Message-State: AOAM5322Dchg594wdj8u4YniKS+9869NydyaVNi5WW+NbfWYSGCGu68X
        iCsWZEf3quyGFzmvLp7aTm3AI9BvgjukdI5uFmi0mw==
X-Google-Smtp-Source: ABdhPJzWhUb8OaCqZ+wGW3wghfI4OfSe4HcyYD2SElJtQEE0jHkfmLE53PIQAkoRBbNxCjll818U9BU6+WvJ1RvEg5U=
X-Received: by 2002:a19:6557:: with SMTP id c23mr4137115lfj.157.1610238288101;
 Sat, 09 Jan 2021 16:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20210109140204.151340-1-angelogioacchino.delregno@somainline.org>
 <20210109140204.151340-2-angelogioacchino.delregno@somainline.org>
 <CACRpkdbETKnhgR2-T+s3ChY4v-C5ErdPEp2WcMSZHzJ=O-fHig@mail.gmail.com> <111b918d-2b43-be81-2dbf-e984750b0ef7@somainline.org>
In-Reply-To: <111b918d-2b43-be81-2dbf-e984750b0ef7@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Jan 2021 01:24:37 +0100
Message-ID: <CACRpkdZXgN91jKBDvf=P5_6ObOaacQa2PGL3-jP1gBW__ZyOaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Mark Brown <broonie@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 12:11 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@somainline.org> wrote:
> Il 09/01/21 23:11, Linus Walleij ha scritto:

> > The major review comment is that it'd be nice if you look into
> > using regmaps register cache instead of rolling your own,
> > and also possibly using regmaps locking rather than your own
> > as a result of that.
> >
> Actually, I really tried to use regmap's FLAT register cache and after
> many, many tries... I had to give up. I just couldn't get it working. :(

This needs to be root-caused. The register cache in regmap is for
using not for decoration.

What is the problems you are seeing?

If it is fundamentally so that regmap has limitations that is one thing,
but I want to rule out that we're just not using it wrong or that there
is a bug in it that we should fix.

Looping in Mark Brown the regmap maintainer.

Yours,
Linus Walleij
