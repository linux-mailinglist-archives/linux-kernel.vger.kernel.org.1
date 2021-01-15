Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20222F8953
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbhAOXWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:22:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6259C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:22:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n186so3417603oia.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvpNSvkn/fPLpmBXk1T0j4u5eWw0h0OZrt7MVAhdTdg=;
        b=heRLg2nuz55V39vYDvtz4Yguy31ONxMpxtXEFVroWQPsiQci3cn8wAOmdY9EibP5aJ
         vtTxFbD0+mLOGWSvdcFRcRY7pllXwOaVmmYITwIut7d3q4glbwULsLveb4PsutOrGMhk
         4as5/1OnBoSECvgZ0qvTlukT0F3KvfsKuNdWUSRexolgdrdiVw34ARwskSdiMIU7hvAx
         TuLq5u2z9/cT7VxMMb2Nea3D1z3kYtZZfDMPXNSB52a076rW0zkUOunaZPOrjZI07Pkx
         YMHFYfvGP+543wbh2HwZcNJaRkXwO9nJR8HnE4s2r8FwUa2P0naeWPrc527jWj0fvyIM
         1mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvpNSvkn/fPLpmBXk1T0j4u5eWw0h0OZrt7MVAhdTdg=;
        b=R7Z9g1CdFf4dsjiSjOomXc40Pjimfg+3BmGcmKL4ObAZczKr8I/GKLa61dYOtYYvgo
         A3RFTcnwVKi4crtK81IJMrZyZqlSF60BPphNNRsnjXMf0aMijfanFFTFOy5bRX6r5+k2
         spFEOQU6sdaj52Ub6GYa6O2RbE5YnoGADdKd+X7YGp2nPPDXCFN6IEOTTOasCkHcDQ4u
         GwkeDpwC9+BaSVZgI4Y1S+nqnlkeQZ57WSDnfqRhZdoz23rsAtf92GjyRcef5XgiEYKy
         RyVAm8Se027S+xwkFrJhxlbuOijzr47srHSy8zukMqOsXelOldAYPyG4NUDpEyJjhLjA
         Uw0Q==
X-Gm-Message-State: AOAM533yQBHTw5c4MlC9UK6BBvg8LJFl2xfStO2hDkQ6aAjWLS5mcXMQ
        yzgKK2DgWj1+317EIlCtXwIQKUrLTCj1XvKpNZ+ibg==
X-Google-Smtp-Source: ABdhPJxePdFi/cMZdc6WnxJDQdDlwEw/7UnPBE5bEgYMjM785hxs4Ec/iIubf5V/I+R+D3VGHtf+Zx7mDSrB5htbKGI=
X-Received: by 2002:aca:58d6:: with SMTP id m205mr7136601oib.121.1610752924862;
 Fri, 15 Jan 2021 15:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20210115170953.3035153-1-elver@google.com> <20210115215817.GN2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210115215817.GN2743@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Sat, 16 Jan 2021 00:21:53 +0100
Message-ID: <CANpmjNM9++GSuSHH+Lyfi23kW8v0aXLX+YbD20UX8k5jAAaSnA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add missing license and copyright headers
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 at 22:58, Paul E. McKenney <paulmck@kernel.org> wrote:

> This one seemed straightforward and I heard no objections to the previous
> two-patch series, so I queued them for the v5.13 merge window, thank you!
>
> If any of them need adjustment, please send me the updated patch and
> tell me which one it replaces.  Something about -rcu being in heavy
> experimental mode at the moment.  ;-)

Thank you!

I would have given the go-ahead for the other series next week Monday,
but I think that's a holiday anyway. :-)

Thanks,
-- Marco
