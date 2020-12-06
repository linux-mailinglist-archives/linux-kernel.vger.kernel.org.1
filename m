Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A912CFFDF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 01:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgLFACR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 19:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgLFACP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 19:02:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B179C061A51
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 16:01:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a12so2186819wrv.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lvxTydcJevvZImmvtiNDvHx9+ODAD7OdhHkJ/TimnPk=;
        b=DRI3n4HzmCxWUWVMPAIE6+hmnIx9SlREnMvwhKCbcl4tU/XlQgBzSyyX9WK7ziKCG4
         RZRTFHL+XV54jD9skdvLt36lxMr0bgQkgMs/7yJbCPT+/X470gAOxhu38zaU+iw/0q5N
         cxWhDfCza/gmtPflk3ISwj3xM6qcAtgYkn0GhoGj+t22Gik+hRk0XeibI9R/7qo1N7y7
         9YEUpHmvOfaFz7i6fzQ5TL3u6PDE6K7G/pstrc7tSweG3NsSGBoFwDcFQBO53GC4zs2o
         +ow6m39n78doFEpS3xFKkWGx2x2hLWfVJLq9KpuDOtamCOxOMd+l0us9Bq5887qNkgtf
         +gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lvxTydcJevvZImmvtiNDvHx9+ODAD7OdhHkJ/TimnPk=;
        b=Z3DSWx1W/8tnM6fQ6al1lFDSlCP6ddHyjfXVtfBD3hNbyGVwNb1GrakKAzROjOQSQD
         BKu3+YAiDE5L1Ixci7GcP+6Vuf3m0ZR7IvtYl/8RcRPrY5Kq2Ddig9pROC7WpS5F6Pe8
         VVue5J99a6CqBmdztDLxohUb6BL1NE0N6RrClTDism+riZFiOJigiOPiZiyyzIHSzZg+
         aL5Xj2/5QKo/NhmiDpJnbE5i4wuoQS8PixNXSN2koIoR+YnQ477jrLQa9XfAKeCsXfpH
         KefCZyMxoYt9dpIymdJwdR7qF70wCExH93Mg/mMaWwZRx12K1LPOqtOcawqqzH3iJgCk
         XnjQ==
X-Gm-Message-State: AOAM530g/xfvRG42r7kPXdll3jdpZfoqHtts4o06Pme6wr0EYngBuMhl
        MQdBqxH5wGbxAhinTalNoLQ1HG64puqnNTb4
X-Google-Smtp-Source: ABdhPJzOgw2H0pK9GGs7UNY6o6I3qJIbXoAp141g0Sn134K0BF1qLx84EAnUs7JAXYyBT313QEXNyA==
X-Received: by 2002:adf:aa4a:: with SMTP id q10mr11828436wrd.276.1607212887579;
        Sat, 05 Dec 2020 16:01:27 -0800 (PST)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id e4sm9155674wrr.32.2020.12.05.16.01.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 16:01:26 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
Date:   Sun, 6 Dec 2020 00:01:24 +0000
Cc:     Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
 <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
 <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx>
 <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
To:     Rich Felker <dalias@libc.org>, Andy Lutomirski <luto@kernel.org>,
        linux-x86_64@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Nov 2020, at 00:55, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>=20
> On 1 Nov 2020, at 21:01, Rich Felker <dalias@libc.org> wrote:
>>=20
>> On Sun, Nov 01, 2020 at 06:27:10PM +0000, Jessica Clarke wrote:
>>> On 1 Nov 2020, at 18:15, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>>>>=20
>>>> On 1 Nov 2020, at 18:07, Andy Lutomirski <luto@kernel.org> wrote:
>>>>>=20
>>>>> On Sat, Oct 31, 2020 at 6:50 PM Rich Felker <dalias@libc.org> =
wrote:
>>>>>>=20
>>>>>> On Sun, Nov 01, 2020 at 01:27:35AM +0000, Jessica Clarke wrote:
>>>>>>> On 1 Nov 2020, at 01:22, Rich Felker <dalias@libc.org> wrote:
>>>>>>>> On Sat, Oct 31, 2020 at 04:30:44PM -0700, Andy Lutomirski =
wrote:
>>>>>>>>> cc: some libc folks
>>>>>>>>>=20
>>>>>>>>> On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke =
<jrtc27@jrtc27.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>> POSIX specifies that the first field of the supplied msgp, =
namely mtype,
>>>>>>>>>> is a long, not a __kernel_long_t, and it's a user-defined =
struct due to
>>>>>>>>>> the variable-length mtext field so we can't even bend the =
spec and make
>>>>>>>>>> it a __kernel_long_t even if we wanted to. Thus we must use =
the compat
>>>>>>>>>> syscalls on x32 to avoid buffer overreads and overflows in =
msgsnd and
>>>>>>>>>> msgrcv respectively.
>>>>>>>>>=20
>>>>>>>>> This is a mess.
>>>>>>>>>=20
>>>>>>>>> include/uapi/linux/msg.h has:
>>>>>>>>>=20
>>>>>>>>> /* message buffer for msgsnd and msgrcv calls */
>>>>>>>>> struct msgbuf {
>>>>>>>>>    __kernel_long_t mtype;          /* type of message */
>>>>>>>>>    char mtext[1];                  /* message text */
>>>>>>>>> };
>>>>>>>>>=20
>>>>>>>>> Your test has:
>>>>>>>>>=20
>>>>>>>>> struct msg_long {
>>>>>>>>> long mtype;
>>>>>>>>> char mtext[8];
>>>>>>>>> };
>>>>>>>>>=20
>>>>>>>>> struct msg_long_ext {
>>>>>>>>> struct msg_long msg_long;
>>>>>>>>> char mext[4];
>>>>>>>>> };
>>>>>>>>>=20
>>>>>>>>> and I'm unclear as to exactly what you're trying to do there =
with the
>>>>>>>>> "mext" part.
>>>>>>>>>=20
>>>>>>>>> POSIX says:
>>>>>>>>>=20
>>>>>>>>>   The application shall ensure that the argument msgp points =
to  a  user-
>>>>>>>>>   defined  buffer that contains first a field of type long =
specifying the
>>>>>>>>>   type of the message, and then a data portion that holds the =
data  bytes
>>>>>>>>>   of the message. The structure below is an example of what =
this user-de=E2=80=90
>>>>>>>>>   fined buffer might look like:
>>>>>>>>>=20
>>>>>>>>>       struct mymsg {
>>>>>>>>>           long   mtype;       /* Message type. */
>>>>>>>>>           char   mtext[1];    /* Message text. */
>>>>>>>>>       }
>>>>>>>>>=20
>>>>>>>>> NTP has this delightful piece of code:
>>>>>>>>>=20
>>>>>>>>> 44 typedef union {
>>>>>>>>> 45   struct msgbuf msgp;
>>>>>>>>> 46   struct {
>>>>>>>>> 47     long mtype;
>>>>>>>>> 48     int code;
>>>>>>>>> 49     struct timeval tv;
>>>>>>>>> 50   } msgb;
>>>>>>>>> 51 } MsgBuf;
>>>>>>>>>=20
>>>>>>>>> bluefish has:
>>>>>>>>>=20
>>>>>>>>> struct small_msgbuf {
>>>>>>>>> long mtype;
>>>>>>>>> char mtext[MSQ_QUEUE_SMALL_SIZE];
>>>>>>>>> } small_msgp;
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> My laptop has nothing at all in /dev/mqueue.
>>>>>>>>>=20
>>>>>>>>> So I don't really know what the right thing to do is.  =
Certainly if
>>>>>>>>> we're going to apply this patch, we should also fix the =
header.  I
>>>>>>>>> almost think we should *delete* struct msgbuf from the =
headers, since
>>>>>>>>> it's all kinds of busted, but that will break the NTP build.  =
Ideally
>>>>>>>>> we would go back in time and remove it from the headers.
>>>>>>>>>=20
>>>>>>>>> Libc people, any insight?  We can probably fix the bug without
>>>>>>>>> annoying anyone given how lightly x32 is used and how lightly =
POSIX
>>>>>>>>> message queues are used.
>>>>>>>>=20
>>>>>>>> If it's that outright wrong and always has been, I feel like =
the old
>>>>>>>> syscall numbers should just be deprecated and new ones =
assigned.
>>>>>>>> Otherwise, there's no way for userspace to be safe against data
>>>>>>>> corruption when run on older kernels. If there's a new syscall =
number,
>>>>>>>> libc can just use the new one unconditionally (giving ENOSYS on
>>>>>>>> kernels where it would be broken) or have a x32-specific
>>>>>>>> implementation that makes the old syscall and performs =
translation if
>>>>>>>> the new one fails with ENOSYS.
>>>>>>>=20
>>>>>>> That doesn't really help broken code continue to work reliably, =
as
>>>>>>> upgrading libc will just pull in the new syscall for a binary =
that's
>>>>>>> expecting the broken behaviour, unless you do symbol versioning, =
but
>>>>>>> then it'll just break when you next recompile the code, and =
there's no
>>>>>>> way for that to be diagnosed given the *application* has to =
define the
>>>>>>> type. But given it's application-defined I really struggle to =
see how
>>>>>>> any code out there is actually expecting the current x32 =
behaviour as
>>>>>>> you'd have to go really out of your way to find out that x32 is =
broken
>>>>>>> and needs __kernel_long_t. I don't think there's any way around =
just
>>>>>>> technically breaking ABI whilst likely really fixing ABI in =
99.999% of
>>>>>>> cases (maybe 100%).
>>>>>>=20
>>>>>> I'm not opposed to "breaking ABI" here because the current =
syscall
>>>>>> doesn't work unless someone wrote bogus x32-specific code to work
>>>>>> around it being wrong. I don't particularly want to preserve any =
of
>>>>>> the current behavior.
>>>>>>=20
>>>>>> What I am somewhat opposed to is making a situation where an =
updated
>>>>>> libc can't be safe against getting run on a kernel with a broken
>>>>>> version of the syscall and silently corrupting data. I'm flexible
>>>>>> about how avoiding tha tis achieved.
>>>>>=20
>>>>> If we're sufficiently confident that we won't regress anything by
>>>>> fixing the bug, I propose we do the following.  First, we commit a =
fix
>>>>> that's Jessica's patch plus a fix to struct msghdr, and we mark =
that
>>>>> for -stable.  Then we commit another patch that removes 'struct
>>>>> msghdr' from uapi entirely, but we don't mark that for -stable.  =
If
>>>>> people complain about the latter, we revert it.
>>>>=20
>>>> Thinking about this more, MIPS n32 is also affected by that header. =
In
>>>> fact the n32 syscalls currently do the right thing and use the =
compat
>>>> implementations, so the header is currently out-of-sync with the =
kernel
>>>> there*. This should be noted when committing the change to msg.h.
>>>=20
>>> Never mind, it seems MIPS n32 is weird and leaves __kernel_long_t as =
a
>>> normal long despite being an ILP32-on-64-bit ABI, I guess because =
it's
>>> inherited from IRIX rather than being invented by the GNU world.
>>=20
>> Yes, the whole __kernel_long_t invention is largely x32-only (maybe
>> theoretically on aarch64-ilp32 too? if that even really exists?) and
>> is pretty much entirely a mistake from lacking the proper
>> infrastructure to do time64 when x32 was introduced (note that n32 =
has
>> 32-bit old-time_t). I hope effort will be made to keep the same
>> mistake from creeping into future ilp32-on-64 ABIs if there are any.
>=20
> Ping? Does anyone have further thoughts/are people happy for this to
> land?

Ping?

Jess

