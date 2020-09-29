Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBE27BF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgI2Idr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgI2Idq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:33:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:33:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ead00a43ad9adcc23f8e0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:a43a:d9ad:cc23:f8e0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86BC31EC0380;
        Tue, 29 Sep 2020 10:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601368424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zRkl9psdawzE3dNwfpL675Lq6bA7FNwxEYbUX2Cq0Jc=;
        b=ApxB9IseuUOLN/z0/ymlpfm6pRayqf3cLQH1B1wqjKIHsuqzc9SMIiz8ohjVxlJFI7EdiX
        zze4XjkydM0s9x4lcS8irgJKE6AK9jSPwF8P3QSvcXajSGfWUoZAzwIR0bNYEyO0koqYCG
        NRKjvMnIyTQhmg1pVZ8mRqxoHF9lBgA=
Date:   Tue, 29 Sep 2020 10:33:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20200929083336.GA21110@zn.tnic>
References: <00000000000052569205afa67426@google.com>
 <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic>
 <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic>
 <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928202353.GI1685@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:23:53PM +0200, Borislav Petkov wrote:
> 2020/09/28 22:21:01 VMs 3, executed 179, corpus cover 11792, corpus signal 10881, max signal 19337, crashes 0, repro 0

Ok, so far triggered two things:

WARNING in f2fs_is_valid_blkaddr	1	2020/09/29 10:27	reproducing
WARNING in reiserfs_put_super		1	2020/09/28 22:42

you've probably seen them already.

Anyway, next question. Let's say I trigger the corruption: is there a
way to stop the guest VM which has triggered it so that I'm able to
examine it with gdb?

What about kdump? Can I dump the guest memory either with kdump or
through the qemu monitor (I believe there's a command to dump memory) so
that it can be poked at?

Because as it is, we don't have a reproducer and as I see it, the fuzzing simply
gets restarted:

2020/09/29 10:27:03 vm-3: crash: WARNING in f2fs_is_valid_blkaddr
...
2020/09/29 10:27:05 loop: phase=1 shutdown=false instances=1/4 [3] repro: pending=0 reproducing=1 queued=1
2020/09/29 10:27:05 loop: starting instance 3

so it would be good to be able to say, when a vm encounters a crash, it
should be stopped immediately so that the guest can be examined through
qemu's gdb interface, i.e.,

-gdb tcp::<portnum>

or so?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
