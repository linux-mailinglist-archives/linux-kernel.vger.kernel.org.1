Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED12A1B9A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 02:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKAB1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 21:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgKAB1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 21:27:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD2C061A04
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 18:27:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a9so10488416wrg.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 18:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gZX1qo4aXS6qDWeCXzLwzvOSN4ZLOYxAu31fiJN4GpE=;
        b=cJrTa71qsyNyTEBirrpC8ZKp0eQ6kYgvXkHUSr7/LbyPInM0AYm5VmvJIOIRSkasu9
         UIGpzEwA4NWNoFDqVqdYlzwzyjV0A6Tu/N0wgloDbfnRHBSE//8Hia8eGarbjlWjrf3c
         uqEBPKqL1QItzwglmw+ERPYHVKEPkwmh+BWgyLFMNLgC3lZW4F7GY3LZCrIJrTg/AwY/
         9cqQP3J6LnTwUKJFBtnqqYMCtFVhCA4bs/GrT3/yD473JTnepPsqf9zFvRGmcVME+KeL
         PCyaVuXuEKyQYH4KKeT30jyFymNyUln+zsP2gDqjAoteY55OigitDjbZkm8Yq0xpim7N
         bqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gZX1qo4aXS6qDWeCXzLwzvOSN4ZLOYxAu31fiJN4GpE=;
        b=TPwtSv5b6ef9PyxDevC3RH9m/keXhhdgi+CYvSrxUREYyM2PZUo7L1HpGiwGbd6wLX
         NOXIq8yJw07AftXk/fJ05omwWwgKxuTOqNGu7zN+9FMkmSqFW3W1gojgxQbfaynKX5Xz
         TipmMZoqYmm1m8L9Lfa7tNbQICgNZRQt8kwwPNtKSb8YVWuVttTVE+z3my5oVgBmiJnO
         tOTsN2v09wCjAUG0y1aHqJmsPTPGyGnrqNL36D409yUU/ESXDi67BUzEB8dmC0qAjjlM
         E9Z0JD17VYoGKXpfaBDGZbIFMn5k9Mn44jKJscCJLPt3U4gd47SbmVyaO4KYGLCF/O63
         TIrw==
X-Gm-Message-State: AOAM533ymkl/AontAOFJ4TG+ySk0My7EcwFhzQi35j6jLrCT1Gu50HuG
        GCDqm3sFfDrHWQmW1GOpWdo0cw==
X-Google-Smtp-Source: ABdhPJzAJNACYmFhqmb/Dd7FEIPq+E2uXFc9bBirA/UCswt2LQaja2UHjcewHUtx5EHFIOjoj/lF4Q==
X-Received: by 2002:adf:a501:: with SMTP id i1mr11686644wrb.162.1604194057722;
        Sat, 31 Oct 2020 18:27:37 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id b63sm10544093wme.9.2020.10.31.18.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Oct 2020 18:27:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20201101012202.GM534@brightrain.aerifal.cx>
Date:   Sun, 1 Nov 2020 01:27:35 +0000
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-x86_64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
To:     Rich Felker <dalias@libc.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2020, at 01:22, Rich Felker <dalias@libc.org> wrote:
> On Sat, Oct 31, 2020 at 04:30:44PM -0700, Andy Lutomirski wrote:
>> cc: some libc folks
>>=20
>> On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>>=20
>>> POSIX specifies that the first field of the supplied msgp, namely =
mtype,
>>> is a long, not a __kernel_long_t, and it's a user-defined struct due =
to
>>> the variable-length mtext field so we can't even bend the spec and =
make
>>> it a __kernel_long_t even if we wanted to. Thus we must use the =
compat
>>> syscalls on x32 to avoid buffer overreads and overflows in msgsnd =
and
>>> msgrcv respectively.
>>=20
>> This is a mess.
>>=20
>> include/uapi/linux/msg.h has:
>>=20
>> /* message buffer for msgsnd and msgrcv calls */
>> struct msgbuf {
>>        __kernel_long_t mtype;          /* type of message */
>>        char mtext[1];                  /* message text */
>> };
>>=20
>> Your test has:
>>=20
>> struct msg_long {
>>    long mtype;
>>    char mtext[8];
>> };
>>=20
>> struct msg_long_ext {
>>    struct msg_long msg_long;
>>    char mext[4];
>> };
>>=20
>> and I'm unclear as to exactly what you're trying to do there with the
>> "mext" part.
>>=20
>> POSIX says:
>>=20
>>       The application shall ensure that the argument msgp points to  =
a  user-
>>       defined  buffer that contains first a field of type long =
specifying the
>>       type of the message, and then a data portion that holds the =
data  bytes
>>       of the message. The structure below is an example of what this =
user-de=E2=80=90
>>       fined buffer might look like:
>>=20
>>           struct mymsg {
>>               long   mtype;       /* Message type. */
>>               char   mtext[1];    /* Message text. */
>>           }
>>=20
>> NTP has this delightful piece of code:
>>=20
>>   44 typedef union {
>>   45   struct msgbuf msgp;
>>   46   struct {
>>   47     long mtype;
>>   48     int code;
>>   49     struct timeval tv;
>>   50   } msgb;
>>   51 } MsgBuf;
>>=20
>> bluefish has:
>>=20
>> struct small_msgbuf {
>> long mtype;
>> char mtext[MSQ_QUEUE_SMALL_SIZE];
>> } small_msgp;
>>=20
>>=20
>> My laptop has nothing at all in /dev/mqueue.
>>=20
>> So I don't really know what the right thing to do is.  Certainly if
>> we're going to apply this patch, we should also fix the header.  I
>> almost think we should *delete* struct msgbuf from the headers, since
>> it's all kinds of busted, but that will break the NTP build.  Ideally
>> we would go back in time and remove it from the headers.
>>=20
>> Libc people, any insight?  We can probably fix the bug without
>> annoying anyone given how lightly x32 is used and how lightly POSIX
>> message queues are used.
>=20
> If it's that outright wrong and always has been, I feel like the old
> syscall numbers should just be deprecated and new ones assigned.
> Otherwise, there's no way for userspace to be safe against data
> corruption when run on older kernels. If there's a new syscall number,
> libc can just use the new one unconditionally (giving ENOSYS on
> kernels where it would be broken) or have a x32-specific
> implementation that makes the old syscall and performs translation if
> the new one fails with ENOSYS.

That doesn't really help broken code continue to work reliably, as
upgrading libc will just pull in the new syscall for a binary that's
expecting the broken behaviour, unless you do symbol versioning, but
then it'll just break when you next recompile the code, and there's no
way for that to be diagnosed given the *application* has to define the
type. But given it's application-defined I really struggle to see how
any code out there is actually expecting the current x32 behaviour as
you'd have to go really out of your way to find out that x32 is broken
and needs __kernel_long_t. I don't think there's any way around just
technically breaking ABI whilst likely really fixing ABI in 99.999% of
cases (maybe 100%).

Jess

