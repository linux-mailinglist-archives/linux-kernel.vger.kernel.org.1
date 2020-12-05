Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B852CF801
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgLEAbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLEAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:31:20 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0CCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:30:40 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so10067258lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9QS9qfs/1bvx0i2KB4LSQ3IXWtT2XtucCEqs+Kaono=;
        b=uEawDuMSMsk/yBiwcAwVtKev4O5OWoFVZ7AWNMBf1EXLXXokDrZ1oL6GkVtEMB6auj
         NOORGTFb9PWt6zVVb9CPRIlCZCuFyuuudOcNkgIabxDyZQo+OwaRyN6RXm9Oe6S0hGJX
         o0xakniiOgHiU2Yac5fAX2V44euHJGEj98uQ32mdzAfOXw2SBxSOKNGRH5DQiRsjr2mx
         rM6/5w3KOx9wUYX9Yu4LERy4RBKMPfLJPAZqtMP7tS3LJn8jLbaKyNAOs+eW605brW7J
         B0NlpJK7iFrV3PUn4I780CD1WjLilrKbQdUlAoWmitEweMHHVU+ve7ejOkyagOhY4jDV
         E7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9QS9qfs/1bvx0i2KB4LSQ3IXWtT2XtucCEqs+Kaono=;
        b=LatodYK3wxNayhp5LBCvhAAh0Q8rh7fpZUmpIuyxcJxENkZ1EgzhEWuiDG/pED2wwI
         gWBv/zvN4KVwIb8aj7ySMO3c1VWI2xwBsmRvYslGR9y7z1pi7J5901zHD5pkiH7p3lnn
         ZItR0hw7CacoXRtTgY90kwXHNyJsoUDMVvef2ZveapfWXiQD81YDm4MrnX0aUABeTbGJ
         VpYU4F8vA0oYc4nGwUmOE73uYACIqWGxaB5jje2uFfr/DZTh36jWRHKItlQhSB9dEdHI
         JnhtbHChlGwL9ErrFbWtLX+QE2phEw0q2F5uF2s6spSPo8Oy36cvxoA3FU4kTw4Lu4Bk
         VdPg==
X-Gm-Message-State: AOAM530NV2zVODE0+n9RRhILOpi15j20POBLUILjpFkgVewfHzlObU5v
        +o1ah8+9OgOnkcouFyJ/ZJOstKH6LrlrPqw5yaclXw==
X-Google-Smtp-Source: ABdhPJx0N+HOYViM6evD1FHdgraY055CEVgYpEZxsobEqvQDNJKInZXEkAfboTUSuJs6V1Sk4egSbPj2zUdBG6psTy0=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr4057940lfh.260.1607128238907;
 Fri, 04 Dec 2020 16:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20201204140342.1640941-1-linus.walleij@linaro.org>
 <20201204140342.1640941-2-linus.walleij@linaro.org> <20201204223008.GH4558@sirena.org.uk>
In-Reply-To: <20201204223008.GH4558@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Dec 2020 01:30:28 +0100
Message-ID: <CACRpkda1AC2Mv6CdoB7O9vrvJVCR7dj6pAYNvSe9Z7+YhgK_cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: ab8500: Decomission platform data header
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 11:30 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Dec 04, 2020 at 03:03:42PM +0100, Linus Walleij wrote:
> > ---
> >  drivers/regulator/ab8500-ext.c   |  13 ++-
> >  drivers/regulator/ab8500.c       | 116 ++++++++++++++++++++++-
> >  include/linux/regulator/ab8500.h | 156 -------------------------------
> >  3 files changed, 127 insertions(+), 158 deletions(-)
> >  delete mode 100644 include/linux/regulator/ab8500.h
>
> There's also an include of the header in ab8500-core.c which isn't
> removed by either this or the previous patch and needs to be handled
> somehow.

Weird since I built it and booted it!
I wonder what I did wrong this time :(

OK I'll fix it up and test again. Build a clean
tree etc.

Thanks!
Linus Walleij
