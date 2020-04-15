Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF84E1A903E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 03:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbgDOBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 21:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388394AbgDOBPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:15:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF38C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:15:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m19so1253067lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvbuSscSXBsGL/GmoZ2Ki3V2n2IzYZiY8+qGcDMzfRE=;
        b=OAv1tYuOYW1pWzWjNqoVgXCzHoJ19qAn4sLhF0FL2MHW5t5O+p5PVM2/lrIDnET29J
         BVqxgncza4Pc2CQi/JyDk/zwHCjeYzn9IwtV8jXQnE7y2JPDGjW/ZXk9W82DYaHt+ex5
         FqIlpKRRfxCel0V469hcJFwVAi+/x9f9UVjFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvbuSscSXBsGL/GmoZ2Ki3V2n2IzYZiY8+qGcDMzfRE=;
        b=Z05twHILne7MXBcJgCetXMxVWg+tf24y6yhPjFEp6zQJQ8c2KtceVfMDskYfyn/UQK
         pBCSOJFafYa+oggvaqc0PwWn3Mb5C4E+j50Dht8HC386R6kYxuWWUxWP0HEggLlNYMDb
         v518ZicAEa0AJ8LdqdPnuKIvkR2Y+rrjRXY+McV0rxWXpxNphG2q837QeL8YhxzN2UT2
         K5xruTKgLgtEAkJS7jHdFnofWJDA/XcN2c3P0anPuFs+fGBHQyiE2LqjEk3Q6f68Flna
         wLPLeXqn6jKs9hTwKT4Lh3+PqZLQINrZfarjzoOnIAS1QOt1TATi5efHfENMFgkkXPXd
         ckBw==
X-Gm-Message-State: AGi0PuZSy2VYpj9L5721d849QjIZJmOx6I/0uQAD0Sg7/Q2bwoi963Tn
        QAfVQjNs7tu/irSOvXiwN8fU+0ofOZY=
X-Google-Smtp-Source: APiQypIfuo6gziLXwqWIdP8BTcaHsByFsBiCF9e7/CLHTv/KUJzUzM0UBGR5Uz0udKihGWRnV7WjfQ==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr1428801lfr.88.1586913309773;
        Tue, 14 Apr 2020 18:15:09 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id w1sm8231456ljw.48.2020.04.14.18.15.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 18:15:08 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id l14so1864779ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:15:08 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr1624159ljp.241.1586913307698;
 Tue, 14 Apr 2020 18:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
 <f2b9ef2a-8449-72fc-4f87-8bf65d713800@i-love.sakura.ne.jp> <6e3864f5-fdaf-874a-b326-1c79816d7141@i-love.sakura.ne.jp>
In-Reply-To: <6e3864f5-fdaf-874a-b326-1c79816d7141@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Apr 2020 18:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLfHaF8F-L9axpYcNtECa=Rw_LWJ98GP6ByUB+O98tAQ@mail.gmail.com>
Message-ID: <CAHk-=wjLfHaF8F-L9axpYcNtECa=Rw_LWJ98GP6ByUB+O98tAQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:06 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I can't judge whether this WARN_ON() makes sense outside of syzkaller.
> But I'd like to suppress this WARN_ON() under testing by syzkaller so that
> syzkaller can spend resource for seeking for different bugs (assuming that
> suppressing this WARN_ON() is harmless).

That's crazy talk.

Either that WARN_ON() is valid, or it's not. It doesn't matter if it's
syzcaller, and we would never change the behavior of it depending on a
flag - compile-time or dynamic.

There's no way we'd accept that as some "#ifndef CONFIG_FUZZER" thing either.

If that WARN_ON() is a problem, then the people behind it should be
appraised of it, and it should probably be removed. I'm assuming it
was some kind of "I don't think this can happen, so if it does, I want
to see how it happened" WARN_ON.

                Linus
