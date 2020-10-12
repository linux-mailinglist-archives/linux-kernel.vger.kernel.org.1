Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2FA28AC80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgJLDby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgJLDby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:31:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D333C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 20:31:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e18so17407107wrw.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 20:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/RwMXJljwgJ1PXkjaVh77plNDkDpoRSZKG579TGUD20=;
        b=V3fx63zfE7IgPplHOWigxbSKrae2vu0TFMZbyQG2Vk4h033yVQAtRo+yj2w9OW5BgX
         ziXDGCa2HjSC+3utqpctJjlligRiEY4gjieHiaXdkoewyFtS34dZqqXTno2YqCpHKt2F
         rmq/E0DAXimvuREsQ/5nLTq8nakp9PwI6qnavY7X4fEKoYZnpUVfPxQ/pluz450cSmr5
         CeeTU2QGBwUhTodmpF4d1/O4yADR240wf5s3eR0mskBsxZXyHpHI9M+fcLkr3DQUcy6M
         56DIVL7Ow0/o/6BIH2Vkl5gt0uyZJcxZH1CuBua8qZk1tuj3RvSspSS7x2eK6Hv5uPZr
         Ff9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/RwMXJljwgJ1PXkjaVh77plNDkDpoRSZKG579TGUD20=;
        b=orI5cN6jmLJFGbP/GBzVilU3QX0sq6xe6urnb003ZCYR8mP1APgg46NPALSqs8RioH
         Lwlf6zSnzBSXTPuqCPYB3aSKcvmjd/wFsModTciXLRsGZPk6iKbOoCBeKh/87JpzClm1
         Lbdifi6qx8by692jmhTahUs9ISoIPg3i6Sqozb3Km9pp7dDZj2nL67u1MNVPwY8SEROM
         flhFuzG1wkY0d+e1VVmRc2EbSC1QApx5r3fsL5QZ2aHo6b1c/WbDwPskJyyZWLuqIkur
         QTcDV1ecFt8ogX0wiGFMv1PJYZkj4swK+VSy2AG43gv9DQiPuYaDSZhefZDd7qOLXhqB
         58RQ==
X-Gm-Message-State: AOAM533PD8yPYok40WTKCQXGEl+k265K0hRkV9yOK++y5ilxUQ76UEMv
        mJi8U7WnCsinHzjwJK4ghqBwug==
X-Google-Smtp-Source: ABdhPJwYD0sYijA84DrCgm8V2rXxpLIPN9C31pMLvUaqZVXZqe2LZipTjHsJvIJU8IYh+wV4XZZIKA==
X-Received: by 2002:adf:a557:: with SMTP id j23mr3499614wrb.95.1602473512086;
        Sun, 11 Oct 2020 20:31:52 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id s19sm31206883wmc.0.2020.10.11.20.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 20:31:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CALCETrV4BFQ_Cdt98NTWnzQ1H4eJfzOpz_UO=Ak+i6jDQAmcrA@mail.gmail.com>
Date:   Mon, 12 Oct 2020 04:31:50 +0100
Cc:     linux-x86_64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
References: <20201012014837.14305-1-jrtc27@jrtc27.com>
 <CALCETrV4BFQ_Cdt98NTWnzQ1H4eJfzOpz_UO=Ak+i6jDQAmcrA@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Oct 2020, at 04:02, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Oct 11, 2020 at 6:48 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>> 
>> POSIX specifies that the first field of the supplied msgp, namely mtype,
>> is a long, not a __kernel_long_t, and it's a user-defined struct due to
>> the variable-length mtext field so we can't even bend the spec and make
>> it a __kernel_long_t even if we wanted to. Thus we must use the compat
>> syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
>> msgrcv respectively.
>> 
>> Due to erroneously including the first 4 bytes of mtext in the mtype
>> this would previously also cause non-zero msgtyp arguments for msgrcv to
>> search for the wrong messages, and if sharing message queues between x32
>> and non-x32 (i386 or x86_64) processes this would previously cause mtext
>> to "move" and, depending on the direction and ABI combination, lose the
>> first 4 bytes.
> 
> This has a few problems.
> 
> First, the 512-547 range is a legacy wart and we shouldn't extend it.
> I thought I had documented this, but I didn't -- oops.  Patch sent.
> The correct way to do this nowadays is to use the same number twice,
> once for x64 and once for x32.  If you try to do this and encounter
> problems with the build, please either fix them or let me know :)

Yeah, that makes more sense. Not sure what I was thinking; changing the
syscall number is clearly a breaking change that's a huge no-no (at
least without also providing old_msgsnd/msgrcv entries, but as
discussed at the end it's unlikely any userspace code actually wants
that behaviour).

> Second, since this is an ABI issue, can you please include a little
> test case that compiles for i386, x86_64 and x32, works correctly on
> all three with whatever patch you send, and fails on x32 without the
> patch?

Test is below. Only verified to break on x32 (and work on i386+amd64)
currently; once I have v2 built I will check all three give the
expected output (NB: for x32 that means only "PAY" should get printed
in the second case since the __kernel_long_t runs over into the start
of the message payload, whereas on the other two you should get the
full "PAYLOAD" since long == __kernel_long_t).

> Third, how does this interact with various libc implementations?
> msgsnd(2) and msgrcv(2) have glibc wrappers.  Have they never been
> tested on x32?

The wrappers aren't anything interesting, they just use SYSCALL_CANCEL
with either msgsnd or irc + IPCOP_msgsnd, so glibc doesn't care about
the struct layout one bit. Of course it does care about the syscall
numbers though...

As far as testing goes, well, I guess 4 byte buffer overflows just
don't get noticed that much. I noticed this not because of that, but
because someone was trying to get fakeroot to work when mixing amd64
and x32 processes, but noticed that mtext was moving around (although
they though that was how it was meant to work, not that this was a
bug). Pure x32 fakeroot though has been in use for the entire lifetime
of the Debian port, as with all other architectures, and I'm not aware
of there having been any issues discovered, despite the fact that its
default implementation is SysV IPC (as opposed to the TCP alternative).
So yeah, it's been tested, but it's not actually quite so easy to
notice.

> Fourth, if there is some deployed code that uses the buggy x32 path
> and actually works by accident, do we risk breaking it if we fix the
> bug?

I highly doubt it. Very few people know of __kernel_long_t, so you
would have to go out of your way to make it work on x32 (and go against
POSIX and the Linux manpage), and that's *after* somehow noticing that
there's a problem which nobody seems to have done, plus msgsnd/msgrcv
is rare in and of itself. A crude search through the Debian archive for
kernel_long_t.*mtype[1] doesn't turn anything up. So yeah, there is a
risk, but I think it's about as minimal as it's ever going to be,
especially given x32 being already rather niche.

Jess

[1] https://codesearch.debian.net/search?q=__kernel_long_t.*mtype&literal=0

Test demonstrating

debian:~ jrtc27% cat sysv-msg-test.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#include <asm/posix_types.h>

struct msg_long {
    long mtype;
    char mtext[8];
};

struct msg_long_ext {
    struct msg_long msg_long;
    char mext[4];
};

struct msg_kern_long {
    __kernel_long_t mtype;
    char mtext[8];
};

struct msg_kern_long_ext {
    struct msg_kern_long msg_kern_long;
    char mext[4];
};

void
do_long(void)
{
    struct msg_long_ext msg_long_ext;
    int msqid;

    msqid = msgget(IPC_PRIVATE, 0600 | IPC_CREAT);

    msg_long_ext.msg_long.mtype = 1;
    strcpy(msg_long_ext.msg_long.mtext, "PAYLOAD");
    strcpy(msg_long_ext.mext, "EXT");
    msgsnd(msqid, &msg_long_ext, 8, 0);

    msg_long_ext.msg_long.mtype = 0;
    memset(msg_long_ext.msg_long.mtext, 0, 8);
    memset(msg_long_ext.mext, 0, 4);
    msgrcv(msqid, &msg_long_ext, 8, 0, 0);
    printf("mtype: %ld\n", msg_long_ext.msg_long.mtype);
    printf("mtext: \"%s\"\n", msg_long_ext.msg_long.mtext);
    printf("mext: \"%s\"\n", msg_long_ext.mext);

    msgctl(msqid, IPC_RMID, NULL);
}

void
do_kern_long(void)
{
    struct msg_kern_long_ext msg_kern_long_ext;
    int msqid;

    msqid = msgget(IPC_PRIVATE, 0600 | IPC_CREAT);

    msg_kern_long_ext.msg_kern_long.mtype = 1;
    strcpy(msg_kern_long_ext.msg_kern_long.mtext, "PAYLOAD");
    strcpy(msg_kern_long_ext.mext, "EXT");
    msgsnd(msqid, &msg_kern_long_ext, 8, 0);

    msg_kern_long_ext.msg_kern_long.mtype = 0;
    memset(msg_kern_long_ext.msg_kern_long.mtext, 0, 8);
    memset(msg_kern_long_ext.mext, 0, 4);
    msgrcv(msqid, &msg_kern_long_ext, 8, 0, 0);
    printf("mtype: %ld\n", msg_kern_long_ext.msg_kern_long.mtype);
    printf("mtext: \"%s\"\n", msg_kern_long_ext.msg_kern_long.mtext);
    printf("mext: \"%s\"\n", msg_kern_long_ext.mext);

    msgctl(msqid, IPC_RMID, NULL);
}

int
main(void)
{

    do_long();
    do_kern_long();
    return 0;
}
debian:~ jrtc27% ./sysv-msg-test
mtype: 1
mtext: "PAYLOAD"
mext: "EXT"
mtype: 1
mtext: "PAYLOAD"
mext: ""

