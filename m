Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C52A1B35
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 00:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgJaXa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 19:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgJaXa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 19:30:58 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5A222226
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604187057;
        bh=NiXT55EirTMdex6RjlDkbN/vbBrVFaP485bHGWCO6E4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dXqdmMyjvNyWBhYAMxhhjYj7oae9vUebsicuAUnuKYeBiRQMnasTH4xwLOgH84ObT
         umaXdlp5p4XtnvXEk38MFX9jYMEHm2sE3fmJpg5lplbRR6PqFiSBioMrnAX7JUXI5m
         T/67WvRKrz1L19uglgVLjeWO7TP+IBOxFS1GkYxc=
Received: by mail-wm1-f48.google.com with SMTP id c9so4474167wml.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 16:30:57 -0700 (PDT)
X-Gm-Message-State: AOAM53312gKK00Zic3Rs0Jj6ZUQBpiynnYDrk4YvJnKWduqD2I9V50fX
        Rhb/deov61fTJEvLYz250XJx74Z3/ugJ4k4UnEYfOw==
X-Google-Smtp-Source: ABdhPJwAS23u79Sr0FTRMnbrO6uRiEcl3t19Nlc1WVNEguzhkE1JA1Yt6a+msokBlTWwd6TBvYQieljl+lHgGmsP2Es=
X-Received: by 2002:a05:600c:230b:: with SMTP id 11mr4749148wmo.138.1604187055745;
 Sat, 31 Oct 2020 16:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com> <20201012134444.1905-1-jrtc27@jrtc27.com>
In-Reply-To: <20201012134444.1905-1-jrtc27@jrtc27.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 31 Oct 2020 16:30:44 -0700
X-Gmail-Original-Message-ID: <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
Message-ID: <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
To:     Jessica Clarke <jrtc27@jrtc27.com>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>
Cc:     linux-x86_64@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc: some libc folks

On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> POSIX specifies that the first field of the supplied msgp, namely mtype,
> is a long, not a __kernel_long_t, and it's a user-defined struct due to
> the variable-length mtext field so we can't even bend the spec and make
> it a __kernel_long_t even if we wanted to. Thus we must use the compat
> syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
> msgrcv respectively.

This is a mess.

include/uapi/linux/msg.h has:

/* message buffer for msgsnd and msgrcv calls */
struct msgbuf {
        __kernel_long_t mtype;          /* type of message */
        char mtext[1];                  /* message text */
};

Your test has:

struct msg_long {
    long mtype;
    char mtext[8];
};

struct msg_long_ext {
    struct msg_long msg_long;
    char mext[4];
};

and I'm unclear as to exactly what you're trying to do there with the
"mext" part.

POSIX says:

       The application shall ensure that the argument msgp points to  a  us=
er-
       defined  buffer that contains first a field of type long specifying =
the
       type of the message, and then a data portion that holds the data  by=
tes
       of the message. The structure below is an example of what this user-=
de=E2=80=90
       fined buffer might look like:

           struct mymsg {
               long   mtype;       /* Message type. */
               char   mtext[1];    /* Message text. */
           }

NTP has this delightful piece of code:

   44 typedef union {
   45   struct msgbuf msgp;
   46   struct {
   47     long mtype;
   48     int code;
   49     struct timeval tv;
   50   } msgb;
   51 } MsgBuf;

bluefish has:

struct small_msgbuf {
long mtype;
char mtext[MSQ_QUEUE_SMALL_SIZE];
} small_msgp;


My laptop has nothing at all in /dev/mqueue.

So I don't really know what the right thing to do is.  Certainly if
we're going to apply this patch, we should also fix the header.  I
almost think we should *delete* struct msgbuf from the headers, since
it's all kinds of busted, but that will break the NTP build.  Ideally
we would go back in time and remove it from the headers.

Libc people, any insight?  We can probably fix the bug without
annoying anyone given how lightly x32 is used and how lightly POSIX
message queues are used.

--Andy

>
> Due to erroneously including the first 4 bytes of mtext in the mtype
> this would previously also cause non-zero msgtyp arguments for msgrcv to
> search for the wrong messages, and if sharing message queues between x32
> and non-x32 (i386 or x86_64) processes this would previously cause mtext
> to "move" and, depending on the direction and ABI combination, lose the
> first 4 bytes.
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>
> I have verified that the test at the end of [1] now gives the correct
> result on x32 ("PAYL" not "PAY" as I erroneously claimed it should be in
> the above email) and that both i386 and amd64 give the same output with
> that test as before.
>
> [1] <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
>
> Changes since v1:
>  * Uses the same syscall numbers for x32 as amd64 and the current x32
>    rather than (further) breaking ABI by allocating new ones from the
>    legacy x32 range
>
>  arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index f30d6ae9a..f462123f3 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -77,8 +77,10 @@
>  66     common  semctl                  sys_semctl
>  67     common  shmdt                   sys_shmdt
>  68     common  msgget                  sys_msgget
> -69     common  msgsnd                  sys_msgsnd
> -70     common  msgrcv                  sys_msgrcv
> +69     64      msgsnd                  sys_msgsnd
> +69     x32     msgsnd                  compat_sys_msgsnd
> +70     64      msgrcv                  sys_msgrcv
> +70     x32     msgrcv                  compat_sys_msgrcv
>  71     common  msgctl                  sys_msgctl
>  72     common  fcntl                   sys_fcntl
>  73     common  flock                   sys_flock
> --
> 2.28.0
>
