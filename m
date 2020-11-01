Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBFF2A1B54
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 01:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKAAJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 20:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKAAJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 20:09:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EDDC061A04
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:09:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so10461481wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VlOHCX4YRE1XmyBBFY7PUVk6Jiu8vtUl2sXxOWEpEhg=;
        b=SPVR+jSxVYEmCAtXocZ9jLd+b7W65umvZzToOj0nCYUnD4H6mSJc+lJ2dQEHQ2rHRP
         DnGyu53BwH7zrezBUdsWZeiMDOoNZqfy5t4t967tFqy0AvhMmykJaV8Zg24o6LPCq2n0
         4TnhWHMC3L/2b0y1ExZyLW9vaxf097DE5pDE2DgnaXuSSCyrgS1kbyldFO/UuCCLjCb+
         8l+uoJ1vpz29vicDY5Vvo0ue+vWamGqhCPjH1vZAddkgGS48SSDdj2rl2I5AHb8FAlYw
         BDqVWdk5+0FmNbzjrx3Lzrf+n605CqaShM2fahFYKQnV1ttNOKPxHyaMuEtZ8carQDVV
         0DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VlOHCX4YRE1XmyBBFY7PUVk6Jiu8vtUl2sXxOWEpEhg=;
        b=fL8x0RA+lr2ZRw4hhjmdQF97gzK+TGnZrbwEBB9wtRCHu9gG20iM7K1rDph124S6PM
         Sk6AMN5XAPk37sW+3wU31BxGDgv1eYAkBxX80NHVvd+U4l6Z6gCGsoWE4NLe8WCJAuFt
         hzi/VMHfRE3M1wBjthfp+R3Q/Q7DqY6YBmP8sPZcVbKSNVPsFSZf4rlkzusNGTOd1jhI
         /0HYWowTby724aUxmZ62LaX5X5RO6i3gmKnOodhIY4ohtCz2fLQRqzF6c30LFN3HKnM8
         jKDOGuOET9aNq7QPVl6WlcmM6dRUtjdKhQvIExPllvMTxNkFqAVbqi+2Vej+n7LwIk1I
         bnmw==
X-Gm-Message-State: AOAM5312rwa6DNH4iOupkw5sL3JvR+XVcdlxmjkObKOY2IyLT+H/qPbw
        zlinJYITH0OS6kftzBY56oNDpg==
X-Google-Smtp-Source: ABdhPJyQotBw04PBGQbmlkHMkLlyuP80edRislh4o4oebyAKAS790l4qdoppx5O9UYQMUVvYpDBJnQ==
X-Received: by 2002:adf:a345:: with SMTP id d5mr12517920wrb.55.1604189379919;
        Sat, 31 Oct 2020 17:09:39 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id r10sm658331wmg.16.2020.10.31.17.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Oct 2020 17:09:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
Date:   Sun, 1 Nov 2020 00:09:37 +0000
Cc:     Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-x86_64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6263108-2B4D-4818-B739-D66F95C53D2C@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 2020, at 23:30, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> cc: some libc folks
>=20
> On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>=20
>> POSIX specifies that the first field of the supplied msgp, namely =
mtype,
>> is a long, not a __kernel_long_t, and it's a user-defined struct due =
to
>> the variable-length mtext field so we can't even bend the spec and =
make
>> it a __kernel_long_t even if we wanted to. Thus we must use the =
compat
>> syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
>> msgrcv respectively.
>=20
> This is a mess.
>=20
> include/uapi/linux/msg.h has:
>=20
> /* message buffer for msgsnd and msgrcv calls */
> struct msgbuf {
>        __kernel_long_t mtype;          /* type of message */
>        char mtext[1];                  /* message text */
> };

Yeah that's just wrong, POSIX is very clear it's a plain long.

> Your test has:
>=20
> struct msg_long {
>    long mtype;
>    char mtext[8];
> };
>=20
> struct msg_long_ext {
>    struct msg_long msg_long;
>    char mext[4];
> };
>=20
> and I'm unclear as to exactly what you're trying to do there with the
> "mext" part.

The intent was to show that, despite the 8 being passed to
msgsnd/msgrcv (due to the `char mtext[8]`), an extra 4 bytes were being
copied when using long, namely mext, and that using __kernel_long_t was
giving the behaviour that should be observed for long, since the 4
bytes of mext in the destination buffer were left untouched and thus
still 0 from the memset.

> POSIX says:
>=20
>       The application shall ensure that the argument msgp points to  a =
 user-
>       defined  buffer that contains first a field of type long =
specifying the
>       type of the message, and then a data portion that holds the data =
 bytes
>       of the message. The structure below is an example of what this =
user-de=E2=80=90
>       fined buffer might look like:
>=20
>           struct mymsg {
>               long   mtype;       /* Message type. */
>               char   mtext[1];    /* Message text. */
>           }
>=20
> NTP has this delightful piece of code:
>=20
>   44 typedef union {
>   45   struct msgbuf msgp;
>   46   struct {
>   47     long mtype;
>   48     int code;
>   49     struct timeval tv;
>   50   } msgb;
>   51 } MsgBuf;

I was initially concerned by that, since msgbuf is a thing that FreeBSD
also defines but is completely different (used for console messages),
but it appears that adjtime.h, where that is defined, is only used in
libntp/adjtime.c and adjtimed/adjtimed.c, with the former only
including it if NEED_HPUX_ADJTIME, and the latter only being enabled by
configure.ac for HP-UX. So I do not believe that code has ever been
compiled on Linux (though that doesn't mean it's good code for HP-UX!).

> bluefish has:
>=20
> struct small_msgbuf {
> long mtype;
> char mtext[MSQ_QUEUE_SMALL_SIZE];
> } small_msgp;

Which is standards-conforming but unfortunately currently causes memory
corruption for the 4 bytes after it, just like any other correct user
of msgsend/msgrecv on x32.

> My laptop has nothing at all in /dev/mqueue.
>=20
> So I don't really know what the right thing to do is.  Certainly if
> we're going to apply this patch, we should also fix the header.  I
> almost think we should *delete* struct msgbuf from the headers, since
> it's all kinds of busted, but that will break the NTP build.  Ideally
> we would go back in time and remove it from the headers.

I agree that it should not be in the header. Failing that though we
could change the type as it is just wrong on x32 and as you say nobody
should notice (and if anything it'll be because things *start* working).

> Libc people, any insight?  We can probably fix the bug without
> annoying anyone given how lightly x32 is used and how lightly POSIX
> message queues are used.

That is my hope...

Jess

>>=20
>> Due to erroneously including the first 4 bytes of mtext in the mtype
>> this would previously also cause non-zero msgtyp arguments for msgrcv =
to
>> search for the wrong messages, and if sharing message queues between =
x32
>> and non-x32 (i386 or x86_64) processes this would previously cause =
mtext
>> to "move" and, depending on the direction and ABI combination, lose =
the
>> first 4 bytes.
>>=20
>> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
>> ---
>>=20
>> I have verified that the test at the end of [1] now gives the correct
>> result on x32 ("PAYL" not "PAY" as I erroneously claimed it should be =
in
>> the above email) and that both i386 and amd64 give the same output =
with
>> that test as before.
>>=20
>> [1] <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
>>=20
>> Changes since v1:
>> * Uses the same syscall numbers for x32 as amd64 and the current x32
>>   rather than (further) breaking ABI by allocating new ones from the
>>   legacy x32 range
>>=20
>> arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl =
b/arch/x86/entry/syscalls/syscall_64.tbl
>> index f30d6ae9a..f462123f3 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -77,8 +77,10 @@
>> 66     common  semctl                  sys_semctl
>> 67     common  shmdt                   sys_shmdt
>> 68     common  msgget                  sys_msgget
>> -69     common  msgsnd                  sys_msgsnd
>> -70     common  msgrcv                  sys_msgrcv
>> +69     64      msgsnd                  sys_msgsnd
>> +69     x32     msgsnd                  compat_sys_msgsnd
>> +70     64      msgrcv                  sys_msgrcv
>> +70     x32     msgrcv                  compat_sys_msgrcv
>> 71     common  msgctl                  sys_msgctl
>> 72     common  fcntl                   sys_fcntl
>> 73     common  flock                   sys_flock
>> --
>> 2.28.0
>>=20

