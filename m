Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998172A76D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgKEFKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgKEFKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:10:54 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D475C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 21:10:53 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id a4so227460ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 21:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgtCPg2jy1MtwCb8XVzsxk291jfwZdq4PtbmHPg7mS8=;
        b=lys00XBlYOVUvU51NwwpxLKlKOg77pbR9IjsuKa5UU+Ybfk55jQVtKrFyR9gqSkaRZ
         2YRRO7xxbSdLNWgbexP8cVl/07GUyOeMC0XnbE79L3Pj7Nrqr/o/tElAnB5XPAn4mIIX
         aMZByEM5vj4bNfkQong1/TJa1LbEdCQC8b71jmuaCJQ/e+p/RBX5tyxqeeaL2Y3d7xml
         dSY0eQIEm8VgPtOnZkcNJex+MOvOUiPiN3eEbnuTXbquklgGLAKmfCvcSnxYNA3Jj/Ii
         PeuyRRju6PM2W0ib84GJn/aYqUG8Ti+fWHG0hsU5xkSC2sfU8ZE8veVWcoag4NsEPxss
         OtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgtCPg2jy1MtwCb8XVzsxk291jfwZdq4PtbmHPg7mS8=;
        b=NCPhY50zmz5YGWi2pT1O7GJzxsISp8otUD0FGNQuBr1glEcdjSvquZRQoPaz1QFq1n
         5NynNjw48EnJVqdpYF3JAeDqHsaqRkEJwRAfVaDl8YvEY9fzWGkNC4JPFt1ZEmbUitvX
         gcoNitYXA4UyWQYcJUFHhzAS0EqNNxNS8OSsGW9j9ejGtg3v+enp/DOX+ZMpGB9Q9Wcw
         ImpLlotpTIy4LDAjh7JcXV+DxdY0TMnHtziJpHJ2MS/thzHytA/VPD51hKk1KvPfR3G2
         DSDxn5WEsFbuDpVbtnw1GO8Fi60/EOY2pqnUsbEz23bSup6kHosDpuQieDZqvSf0xwBC
         3y4Q==
X-Gm-Message-State: AOAM533gtGLlqYSCgkECXrxl2S1YviLx+HSlxBLwtUbqFbA/cfB2iHJo
        4CG7ZQaQhlJVyUJDjJVU/SmURoaEGEhfkXZa2kc=
X-Google-Smtp-Source: ABdhPJx1KTizNPQjkR+7oGp5ThhckyYMAsETvs36exWiPuZ+cSyIM45Rk2H4Sy45nC2AnEvKFRj8Ime+polGvvbiOV4=
X-Received: by 2002:a25:ae97:: with SMTP id b23mr1352858ybj.26.1604553052996;
 Wed, 04 Nov 2020 21:10:52 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
 <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
 <CANiq72n0FFfH6Uag5yai=tSzzOgVSLpzu5gyUr40d6Gb8GzZpA@mail.gmail.com> <CAKwvOd=eHpmKy4mQKpGA2qAZr4Ue_K+Y-1HNe07dxar7dHy0gQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=eHpmKy4mQKpGA2qAZr4Ue_K+Y-1HNe07dxar7dHy0gQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Nov 2020 06:10:42 +0100
Message-ID: <CANiq72m87PC6ydvoQv6eAh1-MkNMYjGnWPcVtVRradWsHfr2fg@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 1:33 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Yeah, that's annoying. Why don't you send me a patch that downgrades
> it from hard error to polite warning (in case someone made a typo),
> and I'll review it?

Sure!

Cheers,
Miguel
