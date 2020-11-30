Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6E2C92F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbgK3Xpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388050AbgK3Xpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:45:30 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9938C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:44:44 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id q4so4350074ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ja5iGBqziMZwVeGBVGC3tNT2ITsfFSrpoAOQrYPIRMQ=;
        b=eIXhFNYrQLrGwHzLPxYGVzWJa/DjXZ3+RK17U4inbSIH8/cLDO1KD8N72OM/zUzB53
         8yZIeDx97sYjz1uuAvgXJWY765o7D+jPAp3RstXWhEiYWpp6ZfWnqW3rRJRO93eLdG7N
         2D9TsLZvw7lNns1x8kWHXquH6wydBNpMO2aUV+NR7F+6FAuRbZwFPyrw1V0DxEKSqnp1
         vdA7qZ099dTy0qixQPzpa9880t8pAmy3P49uy+98kt3oenJTnRXEAx2MWqQdTsTmzPcS
         FKM8rzdiYWV3COU/X3eovPeyZKHokoQStzQObR4NRJfYg5/2ZfrRz9fPrSbgCSdilzFy
         91tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ja5iGBqziMZwVeGBVGC3tNT2ITsfFSrpoAOQrYPIRMQ=;
        b=gY1D1XiZZTd2CjhKnLKHBrCIP08t0inM71agGsAAQbe1AIp2Vju2XDuapRJpkEgv47
         DTROzf7empdv345Zn55ZG8eWXb/JNDBFt2hZk7ZnHtug/DUq6gem+FQHiD0chhOpZ3OU
         chUlzEWyjdzojHwFTwPrQXDIR4CovC9DY25QKK2qFlCCuCYWzJmxc8XemJQ34tFpZRr2
         yTlTPkZE58hpMeWcSCdUbKrRfeMMnNQ0nLZ45jXE4xFB3V3ASBTGCyEkuNBlULB901ta
         5JGd3bMVqvTjZKVuv6riLCXiDlIsa3C8cYY/22GooOgyBRUuLElelzYacBX9uixrWl8A
         fcxg==
X-Gm-Message-State: AOAM53110SaLXDqCWqtsyf6jvV9iuySuDJkLNpuImK+un2JuL5HLZd7A
        ovMNsCLhsWu6fIGtEj8d4lqYaxXVltbkW+Wc4zeQ/Q==
X-Google-Smtp-Source: ABdhPJwCzKcJqz39IP46Bo7yz6o/13jgHbjOX0vtta6vuRLC/rbSBznCfSrqxtOCA/emfEwjuB/DVNaoOwhY3XJ9gtU=
X-Received: by 2002:a9f:2595:: with SMTP id 21mr286471uaf.33.1606779883895;
 Mon, 30 Nov 2020 15:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-15-samitolvanen@google.com> <20201130115222.GC24563@willie-the-truck>
In-Reply-To: <20201130115222.GC24563@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 30 Nov 2020 15:44:32 -0800
Message-ID: <CABCJKueSjSdpztOsDExCaLyQ+Pip+r6bY=Y1hR=VTOODmoSZMQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] arm64: vdso: disable LTO
To:     Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:52 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Nov 18, 2020 at 02:07:28PM -0800, Sami Tolvanen wrote:
> > Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
> > point in using link-time optimization for the small about of C code.
>
> "about" => "amount" ?

Oops, I'll fix that in v8. Thanks!

Sami
