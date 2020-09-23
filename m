Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9511C275B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIWPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:20:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08892C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:20:19 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ef16so150799qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTeQf/iiIfTaaX6G70ASCG2VDP9jJjAH1D6D+4QSlxU=;
        b=G7Jy7Xyxk2moVyIN3RSXtONJjkbRXAqVY345iwtIqc9zIxIcQLNCl0CygkRLmK7eLH
         gOoFQvsui2zCaH59wJi0E+/HJ531+pftSyoVq6COZu9x2J9rmk/Gjs3e1PAE/cxViWnt
         MIDk3jFqqTdbT329SR/p7+UYstc3kG5Jlbqresvlv2Qrkld1Lk404zDKgTMhIVhZLMOM
         Zrf/9uZ+EkyO6Qa4x/TCeMqZgIbhtUmpLeHWLk62x45yK0SNGSwS+0+UVRMw0kqOXycZ
         g7xq/da0ESu0DZcRLUSoTPN3R2KxcWRh3RA1ITw3RjHKbBHASoOWBxlWahezB9sFj81h
         P/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTeQf/iiIfTaaX6G70ASCG2VDP9jJjAH1D6D+4QSlxU=;
        b=oIinut+3AUhKbmK0szMzZJQcljznSfJlaAAxe95YYFsIgs6aXXdR3NCmYpzXpmrO6p
         FdH+n3Zrxrh+YPSri69K+6p0Az58VS63rLbGJZSYOEnvzMig99cswZ3065cAbBJBUcs3
         wJ+dLbLp/5VGo+dRwZYlo45FvCltHS3mXje6I2ZzmmlMkHS97TAav+gg36IMHP3dAN0y
         Tu5Ar2ym3IS77SEs+qIKTd++JXVl+edFkm3CCtXRuak1Hsc6oJHzxMrajt8U0xP6rmCV
         DUl+RAHGddlc+2HdT31XlB4YQ7Eo9o9CvCdfeYWVEow9zyebZYHjI/A7lJEeaX4g0kmB
         BClw==
X-Gm-Message-State: AOAM532w12MBJa6/zjDUZRSStqPcyiW4s0gFONB++O7son6ycFJXR4aN
        lKupyhRc3veoLJ5nXoPUgWnG+ElS5LPyPdUCD5w2sw==
X-Google-Smtp-Source: ABdhPJyAQS6RFxXx1dnQ0DAIyqDJyYaUfxhD8NYS023WNlD6E/TbnQtbldERncFaLnVTXYDN8gvh2SrVah0PW5uJ7hQ=
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr403443qvw.26.1600874417945;
 Wed, 23 Sep 2020 08:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic> <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic> <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
 <20200923103431.GF28545@zn.tnic>
In-Reply-To: <20200923103431.GF28545@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Sep 2020 17:20:06 +0200
Message-ID: <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:34 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 23, 2020 at 11:24:48AM +0200, Dmitry Vyukov wrote:
> > 3. Run syzkaller locally with custom patches.
>
> Let's say I wanna build the kernel with clang-10 using your .config and
> run it in a vm locally. What are the steps in order to reproduce the
> same workload syzkaller runs in the guest on the GCE so that I can at
> least try get as close as possible to reproducing locally?

It's a random fuzzing workload. You can get this workload by running
syzkaller locally:
https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md

The exact clang compiler syzbot used is available here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
