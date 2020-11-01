Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022102A20C3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgKAS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgKAS1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:27:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F854C061A04
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 10:27:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v5so7320692wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VtLE3rxZT53rdC1fUXGq8+afQZ1wElhCRjZZOGymewc=;
        b=PeQGx2RMl6yCVQLWcLRY87O0353uPvFb5OftQsVzAfDFp1Q0Uo7pV7zpiVxtYHLMcs
         u1paujjkFMty+oY+enUrBr8NhX1j8WrdfEdaRX1kYDyHamblSgHaiO3Y8ZgZ3mo0oi3T
         HLzz6efiPYzhgnndTzrQq8rtDLiPlz38CAbRcQJgR8YLGL0s/FwQxlHB/AGjYKgfk566
         Y+vjvPlKn2uAlYy8bq9qQMPxmE7fo/EvI+ic6duHzAvtGwM1w6+uwpkIxvpqMSwX+35+
         Jkb8MKGbyM8TwqtxVSVW7VvuB/JFLlJGXXISpv1r4UFPlyx95fGGKjwuQDxp00JekRJu
         oLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VtLE3rxZT53rdC1fUXGq8+afQZ1wElhCRjZZOGymewc=;
        b=d+5+Lqfn8kOaJnrGD1JtCvMchw4p8zvnmp6y0eGTYefkKdy/AYUVi52uZWkwUY95uY
         mydhKNgnsiPE6wguXGKMtKfJD4V+Pw3bausf2nZzFnZxH1gn6ZJ/7pRpqjIYzUiBz2DU
         Vh6rcy1CU+s/HmmBkCwnAqpLhfEKnr2PGhnJey+T9iQ0b6pv8VbOtfFgyYLwrbuzYnVR
         VHMSVziTtqiYp37tQVO20QUQLFLJvKlzcGiayujFf7fx2sIcgtOuT3Q4fm3Iq+BOhGyJ
         9vrVQ5GBmdPzQ6nXF5LSfipAyJgxDPKf/9PgVkb4SRupwm+UKluY1W6bEF2UMtpP/YlI
         weZA==
X-Gm-Message-State: AOAM530EwMR0wDNwItnBBpeE/BWZWim3yT+pi9fB7FOYzUOhlfflzuDF
        Nt59eXg9sH2W7tM1PIymgxF8JQ==
X-Google-Smtp-Source: ABdhPJxyuGgSpOogELW0c4TimJmhkl2q1aORYnSLVOviQ420tXetOewxkXHxn76VqF6KcOzQKv+sxg==
X-Received: by 2002:a1c:2ece:: with SMTP id u197mr13923721wmu.58.1604255231021;
        Sun, 01 Nov 2020 10:27:11 -0800 (PST)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id l16sm18616017wrx.5.2020.11.01.10.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 10:27:10 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
Date:   Sun, 1 Nov 2020 18:27:10 +0000
Cc:     Rich Felker <dalias@libc.org>, Florian Weimer <fweimer@redhat.com>,
        linux-x86_64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
 <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2020, at 18:15, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>=20
> On 1 Nov 2020, at 18:07, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> On Sat, Oct 31, 2020 at 6:50 PM Rich Felker <dalias@libc.org> wrote:
>>>=20
>>> On Sun, Nov 01, 2020 at 01:27:35AM +0000, Jessica Clarke wrote:
>>>> On 1 Nov 2020, at 01:22, Rich Felker <dalias@libc.org> wrote:
>>>>> On Sat, Oct 31, 2020 at 04:30:44PM -0700, Andy Lutomirski wrote:
>>>>>> cc: some libc folks
>>>>>>=20
>>>>>> On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke =
<jrtc27@jrtc27.com> wrote:
>>>>>>>=20
>>>>>>> POSIX specifies that the first field of the supplied msgp, =
namely mtype,
>>>>>>> is a long, not a __kernel_long_t, and it's a user-defined struct =
due to
>>>>>>> the variable-length mtext field so we can't even bend the spec =
and make
>>>>>>> it a __kernel_long_t even if we wanted to. Thus we must use the =
compat
>>>>>>> syscalls on x32 to avoid buffer overreads and overflows in =
msgsnd and
>>>>>>> msgrcv respectively.
>>>>>>=20
>>>>>> This is a mess.
>>>>>>=20
>>>>>> include/uapi/linux/msg.h has:
>>>>>>=20
>>>>>> /* message buffer for msgsnd and msgrcv calls */
>>>>>> struct msgbuf {
>>>>>>      __kernel_long_t mtype;          /* type of message */
>>>>>>      char mtext[1];                  /* message text */
>>>>>> };
>>>>>>=20
>>>>>> Your test has:
>>>>>>=20
>>>>>> struct msg_long {
>>>>>>  long mtype;
>>>>>>  char mtext[8];
>>>>>> };
>>>>>>=20
>>>>>> struct msg_long_ext {
>>>>>>  struct msg_long msg_long;
>>>>>>  char mext[4];
>>>>>> };
>>>>>>=20
>>>>>> and I'm unclear as to exactly what you're trying to do there with =
the
>>>>>> "mext" part.
>>>>>>=20
>>>>>> POSIX says:
>>>>>>=20
>>>>>>     The application shall ensure that the argument msgp points to =
 a  user-
>>>>>>     defined  buffer that contains first a field of type long =
specifying the
>>>>>>     type of the message, and then a data portion that holds the =
data  bytes
>>>>>>     of the message. The structure below is an example of what =
this user-de=E2=80=90
>>>>>>     fined buffer might look like:
>>>>>>=20
>>>>>>         struct mymsg {
>>>>>>             long   mtype;       /* Message type. */
>>>>>>             char   mtext[1];    /* Message text. */
>>>>>>         }
>>>>>>=20
>>>>>> NTP has this delightful piece of code:
>>>>>>=20
>>>>>> 44 typedef union {
>>>>>> 45   struct msgbuf msgp;
>>>>>> 46   struct {
>>>>>> 47     long mtype;
>>>>>> 48     int code;
>>>>>> 49     struct timeval tv;
>>>>>> 50   } msgb;
>>>>>> 51 } MsgBuf;
>>>>>>=20
>>>>>> bluefish has:
>>>>>>=20
>>>>>> struct small_msgbuf {
>>>>>> long mtype;
>>>>>> char mtext[MSQ_QUEUE_SMALL_SIZE];
>>>>>> } small_msgp;
>>>>>>=20
>>>>>>=20
>>>>>> My laptop has nothing at all in /dev/mqueue.
>>>>>>=20
>>>>>> So I don't really know what the right thing to do is.  Certainly =
if
>>>>>> we're going to apply this patch, we should also fix the header.  =
I
>>>>>> almost think we should *delete* struct msgbuf from the headers, =
since
>>>>>> it's all kinds of busted, but that will break the NTP build.  =
Ideally
>>>>>> we would go back in time and remove it from the headers.
>>>>>>=20
>>>>>> Libc people, any insight?  We can probably fix the bug without
>>>>>> annoying anyone given how lightly x32 is used and how lightly =
POSIX
>>>>>> message queues are used.
>>>>>=20
>>>>> If it's that outright wrong and always has been, I feel like the =
old
>>>>> syscall numbers should just be deprecated and new ones assigned.
>>>>> Otherwise, there's no way for userspace to be safe against data
>>>>> corruption when run on older kernels. If there's a new syscall =
number,
>>>>> libc can just use the new one unconditionally (giving ENOSYS on
>>>>> kernels where it would be broken) or have a x32-specific
>>>>> implementation that makes the old syscall and performs translation =
if
>>>>> the new one fails with ENOSYS.
>>>>=20
>>>> That doesn't really help broken code continue to work reliably, as
>>>> upgrading libc will just pull in the new syscall for a binary =
that's
>>>> expecting the broken behaviour, unless you do symbol versioning, =
but
>>>> then it'll just break when you next recompile the code, and there's =
no
>>>> way for that to be diagnosed given the *application* has to define =
the
>>>> type. But given it's application-defined I really struggle to see =
how
>>>> any code out there is actually expecting the current x32 behaviour =
as
>>>> you'd have to go really out of your way to find out that x32 is =
broken
>>>> and needs __kernel_long_t. I don't think there's any way around =
just
>>>> technically breaking ABI whilst likely really fixing ABI in 99.999% =
of
>>>> cases (maybe 100%).
>>>=20
>>> I'm not opposed to "breaking ABI" here because the current syscall
>>> doesn't work unless someone wrote bogus x32-specific code to work
>>> around it being wrong. I don't particularly want to preserve any of
>>> the current behavior.
>>>=20
>>> What I am somewhat opposed to is making a situation where an updated
>>> libc can't be safe against getting run on a kernel with a broken
>>> version of the syscall and silently corrupting data. I'm flexible
>>> about how avoiding tha tis achieved.
>>=20
>> If we're sufficiently confident that we won't regress anything by
>> fixing the bug, I propose we do the following.  First, we commit a =
fix
>> that's Jessica's patch plus a fix to struct msghdr, and we mark that
>> for -stable.  Then we commit another patch that removes 'struct
>> msghdr' from uapi entirely, but we don't mark that for -stable.  If
>> people complain about the latter, we revert it.
>=20
> Thinking about this more, MIPS n32 is also affected by that header. In
> fact the n32 syscalls currently do the right thing and use the compat
> implementations, so the header is currently out-of-sync with the =
kernel
> there*. This should be noted when committing the change to msg.h.

Never mind, it seems MIPS n32 is weird and leaves __kernel_long_t as a
normal long despite being an ILP32-on-64-bit ABI, I guess because it's
inherited from IRIX rather than being invented by the GNU world.

Jess

