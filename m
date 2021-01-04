Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682992EA08B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbhADXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbhADXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:12:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C0BC061798
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:12:02 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i7so20050179pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qRuTB68VdASyyfYOcwRJv9bZzj+8O/NQLazmqFG6Ng8=;
        b=LHA2cfDbMW2VfP3ixq+UaGJnbAG07fveHJCzSjkosIDoKKlwnBQfisT6WaSzkE1Wi1
         uJGEKjJzEZymrTal9crf5IP0CcLsuZtu0QuaRBy2eqC7AmCqHCrQkRCMf0OwpXY1094V
         5jRTQkMgDAe228cKh8O1HutyE3MPAHxgK78cf1XRsrHAk8kV8sPgPEIvv4ZLa5ItCRW6
         G8TnBtgMbPXYaEMmSVa9d70RiD4oOr30ussOVWn6c9i6EDHWxanb44Mjwcm9VPwUEEeI
         60QS6p2IFHrU2IPW4Dvr7xZWRF5kSPk0WfezKV/w7AXl5SMBLyKokp7fEN1MTF96iOyK
         Hndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qRuTB68VdASyyfYOcwRJv9bZzj+8O/NQLazmqFG6Ng8=;
        b=n+w/k5PvvE5qAtpA1e2tX09EiTeg1hgqGumbBComDgVMowxqLGzgZxMCWU+dljnqt8
         ffWxf2CM+NwPOjb95KBmUfLM9GY8I5FcpkxpogWmjjk3YvlVT6STvhhfZzpqXNPuIbbk
         Jjv7RlljDgKqk+k2nReKYY7Jo+62DqatO5uNzC7I3euoUGM1WJZzWzBvjWm0frrWWBWN
         KNYcz1oiHQ6PsPPYerOKC3yk2MOC3y5mTUgZf47fj843dGwJjhOWOnGAQVAlic9zQ0E5
         8pFZKcMvrUbqPVHQAGRNU1FO3fSIH2dgworBfALYVjX414HbkSUWLGf3tKBv0hkOLRkH
         MEkw==
X-Gm-Message-State: AOAM533LW1gpAVSh06SwcsC117MHDoG2jWop1rw28YBLXgh3Vn1H0FWD
        Y0hxol/AHBqAyoyBOs4UffZ5+fB2luUTCA==
X-Google-Smtp-Source: ABdhPJxq1nKULhFu/EIOtCrDLF5LtwhMTD/yD0b0lXYcLzL3Jo8VhI4qjrBz795s3H90brRRjHQE2Q==
X-Received: by 2002:a62:ac09:0:b029:1a9:dd65:2f46 with SMTP id v9-20020a62ac090000b02901a9dd652f46mr50050225pfe.15.1609801443938;
        Mon, 04 Jan 2021 15:04:03 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:5dc7:72fe:2549:4bff? ([2601:646:c200:1ef2:5dc7:72fe:2549:4bff])
        by smtp.gmail.com with ESMTPSA id x5sm383473pjr.38.2021.01.04.15.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 15:04:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: in_compat_syscall() on x86
Date:   Mon, 4 Jan 2021 15:04:01 -0800
Message-Id: <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        X86 ML <x86@kernel.org>
In-Reply-To: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 4, 2021, at 2:36 PM, David Laight <David.Laight@aculab.com> wrote:
>=20
> =EF=BB=BFFrom: Eric W. Biederman
>> Sent: 04 January 2021 20:41
>>=20
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>>=20
>>> On Mon, Jan 04, 2021 at 12:16:56PM +0000, David Laight wrote:
>>>> On x86 in_compat_syscall() is defined as:
>>>>    in_ia32_syscall() || in_x32_syscall()
>>>>=20
>>>> Now in_ia32_syscall() is a simple check of the TS_COMPAT flag.
>>>> However in_x32_syscall() is a horrid beast that has to indirect
>>>> through to the original %eax value (ie the syscall number) and
>>>> check for a bit there.
>>>>=20
>>>> So on a kernel with x32 support (probably most distro kernels)
>>>> the in_compat_syscall() check is rather more expensive than
>>>> one might expect.
>>=20
>> I suggest you check the distro kernels.  I suspect they don't compile in
>> support for x32.  As far as I can tell x32 is an undead beast of a
>> subarchitecture that just enough people use that it can't be removed,
>> but few enough people use it likely has a few lurking scary bugs.
>=20
> It is defined in the Ubuntu kernel configs I've got lurking:
> Both 3.8.0-19_generic (Ubuntu 13.04) and 5.4.0-56_generic (probably 20.04)=
.
> Which is probably why it is in my test builds (I've just cut out
> a lot of modules).
>=20
>>>> It would be muck better if both checks could be done together.
>>>> I think this would require the syscall entry code to set a
>>>> value in both the 64bit and x32 entry paths.
>>>> (Can a process make both 64bit and x32 system calls?)
>>>=20
>>> Yes, it bloody well can.
>>>=20
>>> And I see no benefit in pushing that logics into syscall entry,
>>> since anything that calls in_compat_syscall() more than once
>>> per syscall execution is doing the wrong thing.  Moreover,
>>> in quite a few cases we don't call the sucker at all, and for
>>> all of those pushing that crap into syscall entry logics is
>>> pure loss.
>>=20
>> The x32 system calls have their own system call table and it would be
>> trivial to set a flag like TS_COMPAT when looking up a system call from
>> that table.  I expect such a change would be purely in the noise.
>=20
> Certainly a write of 0/1/2 into a dirtied cache line of 'current'
> could easily cost absolutely nothing.
> Especially if current has already been read.
>=20
> I also wondered about resetting it to zero when an x32 system call
> exits (rather than entry to a 64bit one).
>=20
> For ia32 the flag is set (with |=3D) on every syscall entry.
> Even though I'm pretty sure it can only change during exec.

It can change for every syscall. I have tests that do this.

>=20
>>> What's the point, really?
>>=20
>> Before we came up with the current games with __copy_siginfo_to_user
>> and x32_copy_siginfo_to_user I was wondering if we should make such
>> a change.  The delivery of compat signal frames and core dumps which
>> do not go through the system call entry path could almost benefit from
>> a flag that could be set/tested when on those paths.
>=20
> For signal delivery it should (probably) depend on the system call
> that setup the signal handler.

I think it has worked this way for some time now.

> Although I'm sure I remember one kernel where some of it was done
> in libc (with a single entrypoint for all hadlers).
>=20
>> The fact that only SIGCHLD (which can not trigger a coredump) is
>> different saves the coredump code from needing such a test.
>>=20
>> The fact that the signal frame code is simple enough it can directly
>> call x32_copy_siginfo_to_user or __copy_siginfo_to_user saves us there.
>>=20
>> So I don't think we have any cases where we actually need a flag that
>> is independent of the system call but we have come very close.
>=20
> If a program can do both 64bit and x32 system calls you probably
> need to generate a 64bit core dump if it has ever made a 64bit
> system call??

I think core dump should (and does) depend on the execution mode at the time=
 of the crash.

It=E2=80=99s worth noting that GCC=E2=80=99s understanding of mixed bitness i=
s horrible.
