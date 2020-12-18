Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543E82DDD4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgLRDc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgLRDc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:32:29 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FFC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:31:48 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x2so688286ybt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThANl8keVovxssa+E4sSSWUNAQHe9R0+iBJSgPR0CjQ=;
        b=BGDeqVqg2cLTQpuTxvKjP3gI1MA/xd0DtKQcKLx4FK+dti4am/s0al9JZXeObimQEH
         FpKJ8PVzPwDmAkpsOF4KLpYEeVi/VfTlHCXtbTDC6YmEOxGHklwOg5u5mdT2kC1fZ66y
         1akom9kaRqC2uctz9K9+JGJiQOcJkKtDpCl4JnpX8GTPSy3wlyO7rQCeFR378LDnX/sF
         MWOSuXFxTUrcVP2SJt+c8RYU5gyFeOpQOL3tNiVFvj1oa41q+wJ2gc5Rapnn6YUuZxuF
         3eC12VSmOgcOdX/zjESdnveGmA8U1gUB1+bQ2tWAGHoVMsjwozsLkJwhW8LZj2n/9QMz
         9flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThANl8keVovxssa+E4sSSWUNAQHe9R0+iBJSgPR0CjQ=;
        b=A1sjt0peXpPfQwGyQmRrhMtKt6QJKtkz2gBj5HMUUqDIaQGp52bFRuvKQQbo5J3tQw
         Xb3tKLiQyOZeZ8jqydCjHJAwq0Rz3EqKMCQjlaLl7FSou1rDY3XQjie/w9nTcjDhn8oU
         QeRXHUxrM2uudLdit52vM30+VKfeG/H0gPwiswR5KxHoMAavc9a9oX8+xkZf0Su68crM
         cW0RpZukaLTdZuhLdVrQWAzx5gb1BRX0EWyj7cM2shcAa593pIG+ybAvr7We/vGNtV6n
         a8b8ePdTsSnYTudM91Tpwsu/q64li5xBbGa+pdfbPA+rvInGAnPk3cME9JvKYc0a1imk
         EghA==
X-Gm-Message-State: AOAM531hhX2KlmUFsl1rwR0Z8OQczbzEAF5K/219qhHA5WAVAU9fzDXY
        OBzNJbptmu54rUkIU8X5McEitQqyj+unTm+9m00=
X-Google-Smtp-Source: ABdhPJy3Ll+wqRsWhylSQD2sMWYDJMdZvDekK95mrGCAw0tru6i060Gt6bRNUlm4ijpFCEDlDaAlEh5irfsknjEpXPE=
X-Received: by 2002:a25:284:: with SMTP id 126mr3402389ybc.22.1608262307575;
 Thu, 17 Dec 2020 19:31:47 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com> <20200710125022.alry7wkymalmv3ge@wittgenstein>
 <20200710225934.GA16881@localhost> <CAHk-=wipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5WC=KkgAjRRw@mail.gmail.com>
 <20200711210317.GA60425@localhost> <20200728204037.GC1012@bug>
 <20200729063417.GD286933@localhost> <20201217214506.GD28574@duo.ucw.cz>
In-Reply-To: <20201217214506.GD28574@duo.ucw.cz>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Dec 2020 04:31:36 +0100
Message-ID: <CANiq72=rFzxMyxDNkobdnMZohT_qT0KfGCincYBteyoJbtr2Gw@mail.gmail.com>
Subject: Re: Linux kernel in-tree Rust support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Geoffrey Thomas <geofft@ldpreload.com>, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:45 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Well.. not everyone has 32 cores in their notebook.

It is true that complex Rust, like complex C++, does have high
compilation times. But it all depends on how much one relies on
certain language features. Straightforward Rust code is quick to
compile.

For reference, some quick stats :-)

On a given machine, building v5.10 with a minimal config under -j3
takes 3 minutes. With Rust support enabled and 4 trivial Rust modules,
it takes 50 seconds more. "A big increase!", you may indeed claim, but
those 50 seconds are basically all spent on the shared Rust support.
The actual Rust modules compile very quickly afterwards. For example,
touching either `drivers/char/mem.c` or one of the trivial Rust
modules takes the same time in that machine: 10 seconds.

This is for a minimal config -- when you start dealing with
`allmodconfig` builds, or when you start having a hundred Rust modules
instead of 4, the upfront cost becomes very small per Rust module.

> Okay. I did some refactoring recently and I really wished kernel was
> in Rust (and not in C)... so lets see what happens.

Indeed, I think it is definitely worth it.

Cheers,
Miguel
