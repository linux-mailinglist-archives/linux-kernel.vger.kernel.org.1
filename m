Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13C11E4BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgE0R24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE0R2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:28:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF5C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:28:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so9250168pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFnj+ie2MtneCS/evX/ZluPtSFLWtigbTQzNUbxK00k=;
        b=Ky1qqSC8sGjlOrTziUzHIbiwNaWHHocAD08wV/tv2onL6WH5zm+e02G048rm7MMDep
         DCc1AI9EcQ+QnrbGR5KrnxLwKNM8tnRw+IQTNxvdCkUTBviaQLLW2m8YmCcFyyI9nmeQ
         hmG25wC1Z1LTBuydrWYvavtiWigaVh9LjMoYnv302ZSNsc8JVNS/GSVvnG2Gkhl9HvVn
         Ei2FrQI0A0JTmtost4lPh/OyPKn1TqlObwU9P+xNmIbD2InZ/QwvWwRKFTQWal+8Cc4D
         CDE4XLn+lSOb4c56lAmoujD3F9OTjDlTqcqB9m9CmYPGCYqomUOjAKXMSfpQVVW6ATY1
         iTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFnj+ie2MtneCS/evX/ZluPtSFLWtigbTQzNUbxK00k=;
        b=FLEz//NqiNHd3WHFgc4sXQyGKgFraudTDrbXaAfapI3cu3Y3yMEpPufLtyG7BTGLCg
         00Jng9s+/QwQ2REV3AXoJEymiJcDJE30G8Nhy/yFdDmuEQruArBHlpaW2N+XE8lbilZt
         YDZsy5ytwBS9aKPzIN96s5D+GKPeqUdDzvA+A0PevV0dkGbKP0s2Bj40IOJ/AFmxrbiA
         1TbBf3zuazOce2tSn1I76kgvHAnK/vCAg1H1fhzkhmt+unfuJwl2J7FUAJPKVm/IeOdF
         r6cJugpglksdjr9hzICIjq1A0FUo6DYjfs7z4G3hTyilEcF/RrMB2pLH+NAAVtS6+jKj
         Dxrg==
X-Gm-Message-State: AOAM531nrxZGCM7t0kN16Q07pD6fukGKP3UBN5dkcHC4qIVkUq307iwD
        iglUbitVV/Y0FEMzgjQTQ6PjXsD05R3/wswyeDXvOA==
X-Google-Smtp-Source: ABdhPJyeuK37fJhKLfBA8uGQHGR65zBBNcwnWp0A1w2+kyRxmJO+mGP5rc8u/fLIcmnCwVN6cfAKjAZ5Xg83d2JcKEg=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr6827669plz.179.1590600534489;
 Wed, 27 May 2020 10:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134016.753354-1-arnd@arndb.de> <20200527152406.GD59947@C02TD0UTHF1T.local>
In-Reply-To: <20200527152406.GD59947@C02TD0UTHF1T.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 10:28:43 -0700
Message-ID: <CAKwvOdn637hSboMnMV=S5f1wbiEnc6qtnrn=fpeCGtvr2W_Daw@mail.gmail.com>
Subject: Re: [PATCH] arm64: disable -fsanitize=shadow-call-stack for big-endian
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, May 27, 2020 at 03:39:46PM +0200, Arnd Bergmann wrote:
> > clang-11 and earlier do not support -fsanitize=shadow-call-stack
> > in combination with -mbig-endian, but the Kconfig check does not
> > pass the endianess flag, so building a big-endian kernel with
> > this fails at build time:
> >
> > clang: error: unsupported option '-fsanitize=shadow-call-stack' for target 'aarch64_be-unknown-linux'
> >
> > Change the Kconfig check to let Kconfig figure this out earlier
> > and prevent the broken configuration. I assume this is a bug
> > in clang that needs to be fixed, but we also have to work
> > around existing releases.
> >
> > Fixes: 5287569a790d ("arm64: Implement Shadow Call Stack")
> > Link: https://bugs.llvm.org/show_bug.cgi?id=46076
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I suspect this is similar to the patchable-function-entry issue, and
> this is an oversight that we'd rather fix toolchain side.
>
> Nick, Fangrui, thoughts?

Exactly, Fangrui already has a fix: https://reviews.llvm.org/D80647.
Thanks Fangrui!
It seems it's easy in the codebase to check the specific ABI, which
isn't explicitly LE, rather than use a method that checks the ISA
regardless of endianness.

-- 
Thanks,
~Nick Desaulniers
