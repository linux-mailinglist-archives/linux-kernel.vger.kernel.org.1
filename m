Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB61F13D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgFHHsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgFHHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:48:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88715C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:48:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so16333159qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JCPS19CaUQP630TLP6xE2eKVXHvtdh4rKflyJaXzUI=;
        b=dsHQRk7TzE4W5RbnT2gIPvqgUUDKglPc0Wg87phfkVYr0rH7NcOLAFihdA8PeCfiTi
         Agea6ODCgvLz6CPommjxw4kTsrJAZtyJogo9aW27PNDtT8Syp0gX93Q5Jislx0yz2Axy
         c34qFLnAwfoRoI9LuiGEYNOn61R5bZSyNCQn0CNJTiADJ8Bd3/MGNeAAPW83PEoMn8Pt
         ptUWyJKC3P+dq+3073FozGzka9XfrfasZcebBH4qXdKEfB17ER0if7vYGzPgfrBGvIi3
         7m6WTnltZbqocZ6ZsbtEnDwwRdEVzpqnKBvK9G+90lLIccwnf94iiKonWkV9RpnLcsC1
         C6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JCPS19CaUQP630TLP6xE2eKVXHvtdh4rKflyJaXzUI=;
        b=k+NKYQxMmmOScuiSv+BhEb10nRIMCNkty2eZpeqwRlNyTLbiO/2z5O1s6sPA4IB3J3
         fySEhWB2gtqoq9RWx6KPGXqR+JJQO+7SLXOcPrvUYtUWlqIe45aERqaqNDj9m8JBIGRT
         /76TfO4tTPZ8pT2ejEOWlKbXaxBw/17uX0dsYrA6XvWn5N8vf72YG5u4DAUwXcKKTn0r
         ukcifzKX1bViuZq+1dS1gw3VZEuQS6QP70Pvg//7bXRDBcJlhYfTgGc4czORlsStxuzz
         PeG9jl6i/VoKX6OOEkdBvkwMX7a6G4xIjLVlVmr/ll4NuNXecJ5FjiFa0Xtd3H/7ntK5
         yZtg==
X-Gm-Message-State: AOAM530lMxD5DdDWMm+SKlTmzWnpAGDQsZD3NHukkBGvqowfK6LDwXPb
        cJ8uJKqcf8WXKHoZoxLhfyPcTzVjJ/PJEii3EQ/FLTZ0VAc=
X-Google-Smtp-Source: ABdhPJzwNAFfdKKL21CZ9LTCApzUFZdweCIK8eT8vBkDN0LUfY+yBScG98/QWKmhwQuSBW95rZwdnJD9Aipxp1MW86A=
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr20254266qkj.43.1591602496315;
 Mon, 08 Jun 2020 00:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei> <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp> <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
In-Reply-To: <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Jun 2020 09:48:05 +0200
Message-ID: <CACT4Y+Z58Z8u1g8SBy-i1WxLMrdmXvggsLFAhfbLc8D=uffPyA@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 3:27 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello, Dmitry.
>
> Linus is asking me to avoid build-time switching based on kernel config options,
> and is suggesting me to use boot-time switching based on boot-config file feature
> (which is available since 5.6). I have several concerns about use of boot-config file
> feature in syzkaller.
>
> (1) To use boot-config file, syzkaller will need to add "bootconfig" option
>     to the kernel command line. This will be doable by patching
>     https://github.com/google/syzkaller/tree/master/dashboard/config/ *.cmdline
>     files.

Hello Tetsuo,

Yes, command line arguments are easily changeable. Please send pull
requests to syzkaller, if you want to change something.


> (2) The boot-config file is embedded into initramfs file. Since syzkaller builds
>     kernels with almost-allyesconfig, booting syzkaller kernels do not require
>     initramfs for loading kernel modules needed for mounting the root partition.
>     In fact, according to "unexpected kernel reboot" report which contains boot messages,
>     I can't find "Unpacking initramfs..." message. It seems that syzkaller kernels do not
>     use initramfs file.
>
>     Is it possible for syzkaller to enforce performing steps for creating an initramfs,
>     embedding the boot-config file
>     ( https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config),
>     and loading that initramfs whenever booting the syzkaller kernels?
>     By the way, I do worry that people forget to perform these steps when they do
>     their tests without asking syzbot...

I think we have some confusion between syzkaller and syzbot here.
syzkaller itself does not enforce/require any kernel configuration,
hardware nor use or not use of initramfs. In fact, qemu VM type
supports initramfs today. Or syzkaller can work with bare machines
where all setup is up to the user.
syzbot is just one deployment of syzkaller with a particular
configuration/hardware.

If this feature is useful for any linux kernel fuzzing, then we need
to have a plan for all users and setups.

And, yes, an additional context is kernel developers reproducing bugs.
Not all of them may be happy about any additional steps, nor will
follow them.

Answering your question, syzkaller can do some sanity checking of the
provided machine/kernel and reject working with it. If you tell me
what exactly needs to be checked, I can think where this code should
go.
However, again, I am not sure if one is using, say, Android phones and
they don't envision use of initramfs, then what?

For syzbot, the build happens here:
https://github.com/google/syzkaller/blob/7751efd04aebb07bc82b5c0e8eeaca07be1ae112/pkg/build/linux.go#L72
I don't know if initramfs is supported with GCE machines and what
exactly is required.


> (3) Since syzkaller keeps track of "kernel tree", "commit of the kernel tree", and
>     "commit of the syzkaller tree" in order to guarantee reproducibility, it would be
>     possible to identify the "your-config" file used for tools/bootconfig/bootconfig
>     command. But since "#syz test" command currently accepts only "kernel tree" and
>     "commit of the kernel tree" arguments, we might fail to use intended "your-config"
>     file when doing reproducibility test. Can syzbot solve this concern?

Most likely it's possible.

> (4) Of course, "your-config" file would not change so frequently, but "#syz test" command
>     relies on external file in "syzkaller tree" makes it impossible to try different
>     configuration when I have to ask syzbot to test. (Since I don't have hardware which
>     syzbot is reporting problems, I have to ask syzbot when I can't reproduce the problem
>     in my environment.)
>
>     https://syzkaller.appspot.com/text?tag=Patch&x=135f254a100000 is an example of
>     need to enforce CONFIG_DEBUG_INFO_BTF=n in order to workaround build failure during
>     "#syz test" command. If we bring "which twist options should be enabled" to an external
>     boot-config file, I can't ask syzbot to try different twist options (except directly
>     patching the kernel source which handles "which twist options should be enabled").
>     Can syzbot solve this concern?

The CONFIG_DEBUG_INFO_BTF relates to build config. This can't be
solved during boot, right? So what is the relation?

> (5) Anything else?

Reading:
https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config
It seems that boot config is just a more complex way to provide
command line arguments. syzbot already supports command line
arguments, and it looks much simpler and no additional work required.
Why do we want to use boot config?

Next quarter we will be additionally busy with interns, so I can't
promise any time availability for syzbot improvements. But pull
requests are welcome.
