Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6ED26AB44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgIOR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgIORkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:40:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFDC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:40:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so150530pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPSpjHBCelnP8UAXZSapN435KbhWggIRrKC2Ye8r8Z0=;
        b=MOD+7WcNAr3pjvDJPRGmwJqfPrZF/f34m/WYC8EMYYfzqG659uWpw24ujOQVUim6Nc
         aqeLCq5fi/3QEqq8gXZ87GacMQOoS/BuSqa+uWSGEY5tcEG0aWTHJPfut5hwumeCRXcE
         wjmCtyhd57XgvqsvmcbcvFVZaIl2fDNbN1le4LlrSbwvfD7GgsiFT++ZSp08a4O064Nd
         Q6ett0+tjRer4jerjLxMfGx00PSUeRRhidjd747FBkQ5RarwqPfspO/V9bkb6NuoFyK1
         5uKFAWlpesIx5EBhmryss+otr2pvAE3DRtfdP7lo/i8s5s1XPwZFG/NKRHyVqoCpfVop
         xLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPSpjHBCelnP8UAXZSapN435KbhWggIRrKC2Ye8r8Z0=;
        b=H41a/Uv37PL1LuI4V1y7w3TE/TZRoLfAlvzz3lR9iX0VzDPwFsJg3pGvi856EY8Bx0
         GC6/+5lmr9ibkA8NBwEuIlajYbhS3rVH6d0BlYUkNgHGTFsmtoMr/UYVFPPp1qhvSWuK
         9CMW4Yy+NXIau9mr5pFn/sWfWuI2+zjiK+jt86n5ySFIVHh4ot9iyTBEIi8yGo+Tg8RU
         PFcj0JUsVGT7GCFDMnkn6iTCrI7x07eeM4ewNWl0BeIblWFhaOspNJ7wryplyC8IwjBE
         YQG1H83hjZgCqKHCj15fTA3PErxk4ShsS/YMcd8BAFWzmQfh6zemLOSMxTRrDxiRTTa1
         v5cg==
X-Gm-Message-State: AOAM533B5i9i19h26FYkR7f5891keMY5A630U09l76mxzY/UVcxQxHSH
        WlGJttaTLfiFWUMrImJ7bSbQdjr6THdtphfBo79SQA==
X-Google-Smtp-Source: ABdhPJwrYmlIYo3+eADiFNnZB0LjGNjunepDbkYLwHFbLSiMOmbX6wZbo2F1a6nwzeV1ZfPtHK16uHEktxgTrbwlEes=
X-Received: by 2002:a17:902:7295:b029:d1:e3bd:48cc with SMTP id
 d21-20020a1709027295b02900d1e3bd48ccmr4255700pll.10.1600191631819; Tue, 15
 Sep 2020 10:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic>
In-Reply-To: <20200915172152.GR14436@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 10:40:19 -0700
Message-ID: <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kernel-dynamic-tools <kernel-dynamic-tools@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 12:02:48PM -0500, Josh Poimboeuf wrote:
> > If somebody can share the .o file, I can take a look.
>
> If only I could reproduce...
>
> So I built:
>
> /home/share/src/llvm/tc-build/install/bin/clang-12 --version
> ClangBuiltLinux clang version 12.0.0 (https://github.com/llvm/llvm-project 74a9c6d7e1c49cd0e3a8e8072b8aa03f7a84caff)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/share/src/llvm/tc-build/install/bin
>
> and I don't trigger that warning even with that compiler.
>
> What I do get is a lot of those pairs:
>
> init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
> certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
> certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup

+ Kernel-dynamic-tools

> ...
>
> and a link fail at the end.
>
> ld: arch/x86/events/core.o: in function `events_sysfs_show':
> core.c:(.text+0x469b): undefined reference to `stpcpy'
> ld: arch/x86/events/core.o: in function `events_ht_sysfs_show':
> core.c:(.text+0x46f7): undefined reference to `stpcpy'
> ld: drivers/tty/tty_io.o: in function `alloc_tty_struct':
> tty_io.c:(.text+0x2da5): undefined reference to `stpcpy'
> ld: drivers/tty/tty_io.o: in function `tty_register_device_attr':
> tty_io.c:(.text+0x6a09): undefined reference to `stpcpy'
> ld: drivers/tty/tty_io.o: in function `show_cons_active':
> tty_io.c:(.text+0xa819): undefined reference to `stpcpy'
> ld: drivers/scsi/scsi_transport_sas.o:scsi_transport_sas.c:(.text+0x6139): more undefined references to `stpcpy' follow
> make: *** [Makefile:1166: vmlinux] Error 1

b4 am https://lore.kernel.org/lkml/20200914161643.938408-1-ndesaulniers@google.com/
-o | git am

>
>
> I'm thinking clang12 is too unstable to take it seriously...

-- 
Thanks,
~Nick Desaulniers
