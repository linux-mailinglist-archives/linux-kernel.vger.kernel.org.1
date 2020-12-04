Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F37A2CF71D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgLDWxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgLDWxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:53:34 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDFCC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 14:52:54 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id z16so4176322vsp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APDwfrMJO9jpMmlvJs1QQfYlFxkBjLtMOQGI8Flupio=;
        b=vlYT2PP85xGxgcq4Dr0LjAqfSnHTJbDN9Qw9s716INhVlK2qIKh97cH0so65YWekJV
         ZkCddAaWBBeVyc79V1Qsk0bwBXFOYV/fbRRVmb3hqZ90wFkxjB6PyGd9Fl/4pFQAhhjZ
         AM6IB7GFEBqHL1Jg9yyWo4W0Nb7mb6UJHeOQir6VApItA3LGKTPi0G3m3U6izolVWg8S
         lneowIrUY4bLqR7zyKu8N2F2ZMtJSwvpwOZjKssZqamx23Iv78VtDQw/lQdiC6Po0aWG
         caBNxURcOkyiTRCfZKEEQPiFtZ4Uo4eYHfBI8tK9v8an2dHQPAwNADLFINV3H5bQRJ9b
         cZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APDwfrMJO9jpMmlvJs1QQfYlFxkBjLtMOQGI8Flupio=;
        b=AaNQ/H9XW9OeEf6wy3A5ybdbEZ2fdstL2wVVQ3iLIcocSCuZmIwL8lM9wb8dTABFk2
         alP+6cTHDAZIQT02oKM5Qp3zKvRZ+hyAILxBjTpqv/W/P2ueIXDQ33lXOWWRG4kDS8FG
         Xa4rtIRN0nYAgUhKN6Fgz/xjmGRvdGft4VNOahrBbYRWilO93MDS4J4ingggPLZgep8H
         0SGPim822Bt92ls3gVCT8KK/3Gkv7bCsNxsyVi5eXzGRFglvLeuHBMDowU2YbayZeC+2
         JSpa71+MqEqhuGHwUIHdvmzdPMgg2Dtv6vZx0jOA0+qfaUpEvM3RnvJti5rTsJ8cIjx1
         AYeQ==
X-Gm-Message-State: AOAM532LiyvYsgasW/vLsgonZlSmPtIHKMOwm8sFio2Yz5HTV7xI9pRj
        e4NJququni78WA0g81UZp9WhrEde4M2+nZ1zrpwlBA==
X-Google-Smtp-Source: ABdhPJyEOufu1IYsUQg6fXqokcGK+WOlACM5vK4uRoSLdaEQytBNywFXfXG2M7YwyvYjCJIK/G4zrq6Skn/z29jgixU=
X-Received: by 2002:a67:ec3:: with SMTP id 186mr6679107vso.14.1607122373106;
 Fri, 04 Dec 2020 14:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck> <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
 <20201203182252.GA32011@willie-the-truck> <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 4 Dec 2020 14:52:41 -0800
Message-ID: <CABCJKufgkq+k0DeYaXrzjXniy=T_N4sN1bxoK9=cUxTZN5xSVQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, Jian Cai <jiancai@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:32 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> So I'd recommend to Sami to simply make the Kconfig also depend on
> clang's integrated assembler (not just llvm-nm and llvm-ar).

Sure, sounds good to me. What's the preferred way to test for this in Kconfig?

It looks like actually trying to test if we have an LLVM assembler
(e.g. using $(as-instr,.section
".linker-options","e",@llvm_linker_options)) doesn't work as Kconfig
doesn't pass -no-integrated-as to clang here. I could do something
simple like $(success,echo $(LLVM) $(LLVM_IAS) | grep -q "1 1").

Thoughts?

Sami
