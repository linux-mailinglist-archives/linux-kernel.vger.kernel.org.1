Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9D1A87F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502891AbgDNRuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502882AbgDNRuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:50:10 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B3DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:50:10 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o25so11144668oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEcf9WnegdoS4TK74rJ3jgH/4y0s3Rie/mbgUIU1/FE=;
        b=UAMvKl7xtSUqKv4GH9GoENT8bjniUZLfgA1J6ygO0hUfMB3Cq7HU3VRLr7MF3tNSBc
         6acm2t0Th/b86RF+1RJx/BWkJWMT19MCvJUjMPxA6WoQDJ4po8xwBBNiKXkq5oAT6yE7
         RW500W0rIeHDSvvoMWQxe/VoG1JMqhBEZ/hfisGAcN8iIRwXRvbUeC8pbC6sXSnC6eWl
         F7DwK+3hUK3Ea3Z9HSZw8mzXP81JyPKqkZueHq7U94LiXRGo9H3tfwgZV4P6918kZEHR
         o3p4ueeWK0Y9jozDlZEN/+/mux5LBnZqKHPo3C74Kxa/VN5G2idQ3qy6k2zJ2+SIEP6v
         oTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEcf9WnegdoS4TK74rJ3jgH/4y0s3Rie/mbgUIU1/FE=;
        b=KuWlkaTaUXLs0cTwwr0W9vsaHW8ZkMypWAfy7x57Q7otYV3khtvMlrjNd53eqgVl6Q
         paHCKEwmRQb8usuaH+dtByv2U8enEf+iRbbJizPKTI04AGzgaauox2MY1XW9sZfpO4NZ
         hEDvBDfFeGirxh5QK9V6sIItM6FEGLp2v9jWkJII/VPwFzE/e3CDdVL70okqikppVR2f
         Ko25U+7PBQRvvCTgbLrRWHps2anxpUBYNrL9b8kJ9LjEBqarUpoBK/CR67jK8dA/umfq
         EHMUaKV4A5WMK1/LX6ntJgV/vKuYr9cD3xwpTFoS94EFTPRnxl3WTBh+NegP8Q6OKgwZ
         2nAA==
X-Gm-Message-State: AGi0PuajCczKxQR1nWiEJBTRQ9TJP68al1cpBVBQ3aT6TY72C6t9VDYZ
        6GbLZLToDOf9O7VhW4hAPpP/i7SEaN6by+flkkr1MA==
X-Google-Smtp-Source: APiQypJgJrLtDCVotmqMnrcmnAO6pwj12kHLl2IpqN8C6Me+Cr3pykgTBi5j4IbIKhMt9UQxCJz8SLQoM48DAyNfkU8=
X-Received: by 2002:a54:481a:: with SMTP id j26mr16403284oij.172.1586886608876;
 Tue, 14 Apr 2020 10:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009d5cef05a22baa95@google.com> <20200331202706.GA127606@gmail.com>
 <CACT4Y+ZSTjPmPmiL_1JEdroNZXYgaKewDBEH6RugnhsDVd+bUQ@mail.gmail.com>
 <CANpmjNPkzTSwtJhRXWE0DYi8mToDufuOztjE4h9KopZ11T+q+w@mail.gmail.com> <20200401162028.GA201933@gmail.com>
In-Reply-To: <20200401162028.GA201933@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Apr 2020 19:49:57 +0200
Message-ID: <CANpmjNOJ-LZXv29heKZ5LazF5e99BC7-fXi7G0EsSNQd_yiyPQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in glue_cbc_decrypt_req_128bit / glue_cbc_decrypt_req_128bit
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+6a6bca8169ffda8ce77b@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 at 18:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Apr 01, 2020 at 12:24:01PM +0200, Marco Elver wrote:
> > On Wed, 1 Apr 2020 at 09:04, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, Mar 31, 2020 at 10:27 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 31, 2020 at 12:35:13PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    b12d66a6 mm, kcsan: Instrument SLAB free with ASSERT_EXCLU..
> > > > > git tree:       https://github.com/google/ktsan.git kcsan
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=111f0865e00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=10bc0131c4924ba9
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6a6bca8169ffda8ce77b
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+6a6bca8169ffda8ce77b@syzkaller.appspotmail.com
> > > > >
> > > > > ==================================================================
> > > > > BUG: KCSAN: data-race in glue_cbc_decrypt_req_128bit / glue_cbc_decrypt_req_128bit
> > > > >
> > > > > write to 0xffff88809966e128 of 8 bytes by task 24119 on cpu 0:
> > > > >  u128_xor include/crypto/b128ops.h:67 [inline]
> > > > >  glue_cbc_decrypt_req_128bit+0x396/0x460 arch/x86/crypto/glue_helper.c:144
> > > > >  cbc_decrypt+0x26/0x40 arch/x86/crypto/serpent_avx2_glue.c:152
> > > > >  crypto_skcipher_decrypt+0x65/0x90 crypto/skcipher.c:652
> > > > >  _skcipher_recvmsg crypto/algif_skcipher.c:142 [inline]
> > > > >  skcipher_recvmsg+0x7fa/0x8c0 crypto/algif_skcipher.c:161
> > > > >  skcipher_recvmsg_nokey+0x5e/0x80 crypto/algif_skcipher.c:279
> > > > >  sock_recvmsg_nosec net/socket.c:886 [inline]
> > > > >  sock_recvmsg net/socket.c:904 [inline]
> > > > >  sock_recvmsg+0x92/0xb0 net/socket.c:900
> > > > >  ____sys_recvmsg+0x167/0x3a0 net/socket.c:2566
> > > > >  ___sys_recvmsg+0xb2/0x100 net/socket.c:2608
> > > > >  __sys_recvmsg+0x9d/0x160 net/socket.c:2642
> > > > >  __do_sys_recvmsg net/socket.c:2652 [inline]
> > > > >  __se_sys_recvmsg net/socket.c:2649 [inline]
> > > > >  __x64_sys_recvmsg+0x51/0x70 net/socket.c:2649
> > > > >  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
> > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > >
> > > > > read to 0xffff88809966e128 of 8 bytes by task 24118 on cpu 1:
> > > > >  u128_xor include/crypto/b128ops.h:67 [inline]
> > > > >  glue_cbc_decrypt_req_128bit+0x37c/0x460 arch/x86/crypto/glue_helper.c:144
> > > > >  cbc_decrypt+0x26/0x40 arch/x86/crypto/serpent_avx2_glue.c:152
> > > > >  crypto_skcipher_decrypt+0x65/0x90 crypto/skcipher.c:652
> > > > >  _skcipher_recvmsg crypto/algif_skcipher.c:142 [inline]
> > > > >  skcipher_recvmsg+0x7fa/0x8c0 crypto/algif_skcipher.c:161
> > > > >  skcipher_recvmsg_nokey+0x5e/0x80 crypto/algif_skcipher.c:279
> > > > >  sock_recvmsg_nosec net/socket.c:886 [inline]
> > > > >  sock_recvmsg net/socket.c:904 [inline]
> > > > >  sock_recvmsg+0x92/0xb0 net/socket.c:900
> > > > >  ____sys_recvmsg+0x167/0x3a0 net/socket.c:2566
> > > > >  ___sys_recvmsg+0xb2/0x100 net/socket.c:2608
> > > > >  __sys_recvmsg+0x9d/0x160 net/socket.c:2642
> > > > >  __do_sys_recvmsg net/socket.c:2652 [inline]
> > > > >  __se_sys_recvmsg net/socket.c:2649 [inline]
> > > > >  __x64_sys_recvmsg+0x51/0x70 net/socket.c:2649
> > > > >  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
> > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > >
> > > > > Reported by Kernel Concurrency Sanitizer on:
> > > > > CPU: 1 PID: 24118 Comm: syz-executor.1 Not tainted 5.6.0-rc1-syzkaller #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > ==================================================================
> > > > >
> > > >
> > > > I think this is a problem for almost all the crypto code.  Due to AF_ALG, both
> > > > the source and destination buffers can be userspace pages that were gotten with
> > > > get_user_pages().  Such pages can be concurrently modified, not just by the
> > > > kernel but also by userspace.
> > > >
> > > > I'm not sure what can be done about this.
> > >
> > > Oh, I thought it's something more serious like a shared crypto object.
> > > Thanks for debugging.
[...]
> > >
> > > Marco, I think we need to ignore all memory that comes from
> > > get_user_pages() somehow. Either not set watchpoints at all, or
> > > perhaps filter them out later if the check is not totally free.
> >
> > Makes sense. We already have similar checks, and they're in the
> > slow-path, so it shouldn't be a problem. Let me investigate.
>
> I'm wondering whether you really should move so soon to ignoring these races?
> They are still races; the crypto code is doing standard unannotated reads/writes
> of memory that can be concurrently modified.
>
[...]

Wanted to follow up on this, just to clarify: The issue here
essentially boils down to a user-space race involving an API that
isn't designed to be thread-safe with the provided arguments (pointer
to same user-space memory). The data race here merely manifests in
kernel code, but otherwise the kernel is unaffected (if it were
affected, a real fix would be needed). I.e. if we observe this data
race, KCSAN is helpfully pointing out that user space has a bug.

There are some options to deal with cases like this:

1. Do nothing, and just let KCSAN report the data race.

2. Somehow make KCSAN distinguish in-kernel data races that are due to
user space misusing the API. KCSAN can still show the race, but
clearly denote the nature of it by e.g. saying "KCSAN: user data-race
in ..." (instead of "KCSAN: data-race in ..."). This will require one
of 2 things:

    a. Distinguish the access by memory range. This doesn't seem
great, because I don't know if we can apply a general rule like "all
races involving this memory are user-space's fault". What if we have
data races in the memory range that aren't user-space's fault?

    b. Mark the accesses somehow, either by providing a region in
which all races are deemed user-space's fault. This is likely more
problematic than (a), because saying something like "all races in this
section of code are user-space's fault" may also hide real issues.

Because none of (2.a) or (2.b) seem great, at present I would opt for (1).

Anything better we can do here?

Thanks,
-- Marco
