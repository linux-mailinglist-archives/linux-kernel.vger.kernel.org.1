Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12026ABFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIOScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgIOSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:13:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFCC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:04:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so2380611pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2yuM9K/g3v3IWVnsZSay3LazI4xrYVdjzE0nJv3Z6E=;
        b=i5ppXVeHVqikPXUMtlZUEOZ+Y7P0tkaESXeHwXNwUaVb6+Wv2GKluiYcs8ZGPyM4On
         U+MQk9mX5PilB1VQuP0D7VWAtK2ItWJw8tlZngcS2teBroefv2vMYV8Qug2QVJN/p4rj
         to2Vn+PIjWw4cbTKV60pBxS324atxpqwddQS6b3ln0Hazk2yAiXJQmvqbdMOsLCviDYK
         6dwlhVi06aQ9FQuY5uxuhAtmiuAQar0KaNJmovLRUZ8ikhGLPBOpALkQ2wiZMJmc1o2Y
         AmoVrIARjNGHIoCh9Eh+k6VmT+UiAqE6pthUQun2Lhbq9ciYNuzLhK7da1JorO/XSX7r
         VOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2yuM9K/g3v3IWVnsZSay3LazI4xrYVdjzE0nJv3Z6E=;
        b=CN/dcSKOYB+gqMW0FRkH094S7RY0PGxRDtcyPKdjJjtbWMwvX5cxe7Hmok+MMkaXYE
         yXTCAIh1N+cAEObD6JM63cP2NsgZwBpTB9k3/amK8uVtMhmFP3VLXMSEY0fxVv2O8gQ1
         +o/Qg6pZqXgQ+ZnV6UIez97nA7fNFUh2EDACrED1GfgiZomxErfK8K9S9gMG12IAsoEb
         33m0tUoiPzAdNVUaoqBM1fVWSaP3Z0+E6L5rsiwNXlbqOKeNmg/nj0yA1bApEd9ZFmIb
         12P2aS307/sglSM3z3nx4aUhN0apQrxaysJ1/5wW4ocYm9OC3NDIVR42+3z4Z3a+Jtst
         ZBeg==
X-Gm-Message-State: AOAM5328yuuUBMqXvOf3iCuhNi1pTSDL5t5f3Nd4ug8Ym5wGE94ewt0t
        p7uKH9T10feRY6ubxGsBe3uGBH28GUubwl10fPp7DA==
X-Google-Smtp-Source: ABdhPJxVO4o7U359dFVF1ZgIxgLnE+gsz4NWTpl+T+FbHrsOvgyE10hdHGWuMKQbjAHZsdKWINNWT9aZsVhOchRhZjY=
X-Received: by 2002:a63:7882:: with SMTP id t124mr5873220pgc.381.1600193096424;
 Tue, 15 Sep 2020 11:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic>
 <20200915173430.GS14436@zn.tnic> <CAKwvOdnqJJ8Ot6sRvVUTyuwA_zhRQXOnMU9KS6aVcTqRGb3JmA@mail.gmail.com>
 <20200915180141.GU14436@zn.tnic>
In-Reply-To: <20200915180141.GU14436@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 11:04:45 -0700
Message-ID: <CAKwvOdmVTh8Erha=e97RUp4w-LOq==gV2wyj_0vi176_ZrhTGQ@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:01 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 10:41:24AM -0700, Nick Desaulniers wrote:
> > We want them finding bugs in unreleased versions of the compiler,
> > before those bugs in ship in release.  This is a good thing.
>
> The bug report should probably say that compiler used is an unreleased
> one so that I can prioritize better.

That's not unreasonable.  Calling attention to W=1, randconfig, or
unreleased compiler would help.  I tend to deprioritize the first two.
-- 
Thanks,
~Nick Desaulniers
