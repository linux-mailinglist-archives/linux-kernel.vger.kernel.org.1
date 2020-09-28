Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E927B628
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgI1UYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:24:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI1UYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:24:03 -0400
Received: from zn.tnic (p200300ec2f0722007a3ac295e7df05a2.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2200:7a3a:c295:e7df:5a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CCF71EC0409;
        Mon, 28 Sep 2020 22:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601324640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/Vc/EOWpwj9Re8MBl2KQeXE6/D+XkoCsL9dg0BIB/+M=;
        b=LJzByyTuouI26OvCqH9CQiy1LAqR9Ph0oyLxC3Cd7SFaYOnSrETykMBU3/0A1zIbxWEMhD
        518+V9wZQkoBaA1x86oe5f80kUZTp2gwaStEuB4FI6shvVMFcospChGJR3o6OZmib+8N6E
        9b3zWcFap9KNEw5op4D9lwd3ph92eZo=
Date:   Mon, 28 Sep 2020 22:23:53 +0200
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
Message-ID: <20200928202353.GI1685@zn.tnic>
References: <00000000000052569205afa67426@google.com>
 <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic>
 <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic>
 <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:33:57PM +0200, Dmitry Vyukov wrote:
> It may be related to VMs, but also may well not be related to VMs.

Right, and so I tried to set it up on a test box here, it looks like
it worked, see below. I'll let it fuzz in the coming days and see what
explodes...

2020/09/28 22:19:51 booting test machines...
2020/09/28 22:19:51 wait for the connection from test machine...
2020/09/28 22:20:27 machine check:
2020/09/28 22:20:27 syscalls                : 3389/3739
2020/09/28 22:20:27 code coverage           : enabled
2020/09/28 22:20:27 comparison tracing      : enabled
2020/09/28 22:20:27 extra coverage          : enabled
2020/09/28 22:20:27 setuid sandbox          : enabled
2020/09/28 22:20:27 namespace sandbox       : enabled
2020/09/28 22:20:27 Android sandbox         : enabled
2020/09/28 22:20:27 fault injection         : enabled
2020/09/28 22:20:27 leak checking           : CONFIG_DEBUG_KMEMLEAK is not enabled
2020/09/28 22:20:27 net packet injection    : enabled
2020/09/28 22:20:27 net device setup        : enabled
2020/09/28 22:20:27 concurrency sanitizer   : /sys/kernel/debug/kcsan does not exist
2020/09/28 22:20:27 devlink PCI setup       : PCI device 0000:00:10.0 is not available
2020/09/28 22:20:27 USB emulation           : enabled
2020/09/28 22:20:27 hci packet injection    : enabled
2020/09/28 22:20:27 wifi device emulation   : enabled
2020/09/28 22:20:29 corpus                  : 458 (deleted 0 broken)
2020/09/28 22:20:31 seeds                   : 620/667
2020/09/28 22:20:31 VMs 1, executed 0, corpus cover 0, corpus signal 0, max signal 0, crashes 0, repro 0
2020/09/28 22:20:41 VMs 2, executed 12, corpus cover 0, corpus signal 0, max signal 0, crashes 0, repro 0
2020/09/28 22:20:51 VMs 2, executed 28, corpus cover 5578, corpus signal 5925, max signal 10155, crashes 0, repro 0
2020/09/28 22:21:01 VMs 3, executed 179, corpus cover 11792, corpus signal 10881, max signal 19337, crashes 0, repro 0
...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
