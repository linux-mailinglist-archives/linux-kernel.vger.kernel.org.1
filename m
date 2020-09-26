Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685942798C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIZMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 08:08:40 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86673C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 05:08:40 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j3so2884480qvi.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQkrRdJ6c6oJ77YZati+E5lioU8KClKXmW+hw7Drfk4=;
        b=K4ESyNpOCCwXUJhYmHekDwVj8zh0O55W+lCLu2pMyXRr2VecPYniCTYPtLye2pY+Za
         eRfi3XyXkH3N/pCAQopXir+OKOI8ysHk3awEru0e0cV+cFuKiij/C5c3Cw35UrvhTygm
         8biB5atUVv7rPqdaf2z0QDKPP1MCBFPo5htOBgOivu9vpc9e84C89ofwffYF+Os/done
         071cJjqYmbAwM6i9iFHmIywvWaG4bQDRx6HMtdkPT1HtLGqWt9muIL6iocpRWoqi+/kL
         SiISRd2mZ2/J07Zpawk2nFkkLryvLmXr8uHNtWrxaMPNAGsKK8dM4by9HtDx/hT9NCot
         AX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQkrRdJ6c6oJ77YZati+E5lioU8KClKXmW+hw7Drfk4=;
        b=dqvpComh8d3HXRgFmg7kl5ut0/Mg9Os8CQ/i2tazUAM6u4UzotfMuUWr8uwOj13Kkg
         0gazA1sZl04SecBzcnft3NmVfvcSnqn7LWWRjg27S4TbKpVelJjOCl7s1RUnXYuCM2ae
         wfQ90Jeo1oMyZFDnv7XPQuXesmJ/Qcm5yLn7nv0cb+diA3c9F5bP827sPLk4R6BYWczY
         jC9duPsvDHR/FFcmdOx/M9zFaXNo0PibYytm39uufnNah9eUXJG1FB33Zny58jNLb2EA
         xDvLJ1lQDkK0SCZLwErN3wmT66RHasyoqwQaFCoPXvyJsu0GLuKwKkcezpKNu09qn3Kq
         5EGw==
X-Gm-Message-State: AOAM531sV79C85mgpyWjmCDjCzbriZtVWpgbl+oI7Klvyidcx9OAbkAs
        gUxk63L8bLdVq/P4fuVHy1CP9PBE9SiQGqvYctmQFA==
X-Google-Smtp-Source: ABdhPJwDVzQJQq1brXwhLfW4NXjB74Y0KAikBD17AQ1rNIFW5GFnuzoCutYzdnotI6ndNCdn6QsBGpCI3kVlda6Kms0=
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr3314961qvv.11.1601122119258;
 Sat, 26 Sep 2020 05:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200919110831.GD7462@zn.tnic> <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic> <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic> <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
 <20200923103431.GF28545@zn.tnic> <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
 <20200926112119.GA22089@zn.tnic>
In-Reply-To: <20200926112119.GA22089@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 26 Sep 2020 14:08:27 +0200
Message-ID: <CACT4Y+YbEhu2XHoPT9g7Bi7fhjqCkXMBhgjH5yqm7vHy3UEHjw@mail.gmail.com>
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 1:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 23, 2020 at 05:20:06PM +0200, Dmitry Vyukov wrote:
> > It's a random fuzzing workload. You can get this workload by running
> > syzkaller locally:
> > https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md
>
> Yeah, the my.cfg example suggests that the syz-manager starts the guest
> and supplies the kernel, etc.
>
> Is there a possibility to run the workload in an already existing guest
> which I've booted prior?
>
> I'm asking because I have all the infra for testing kernels in guests
> already setup here and it would be easier for me to simply run the
> workload directly in the guest and then poke at it.

+syzkaller mailing list

There is also "isolated" VM type, which allows to connect to a set of
external machines via ssh:
https://github.com/google/syzkaller/blob/master/vm/isolated/isolated.go#L29-L37
However, it's better to have lots of them and with a console cables,
and still sometimes they may brick for various reasons.

There is also syz-stress utility that may run some workload directly
on the underlying kernel:
https://github.com/google/syzkaller/blob/master/tools/syz-stress/stress.go#L29
However, it does not use corpus/coverage, so I don't know if it will
be able to reproduce these crashes or not. It will also be up to you
then to restart the VM/fuzzing every minute.
