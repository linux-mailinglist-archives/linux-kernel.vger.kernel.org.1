Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84552D26B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLHI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgLHI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:58:13 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F88C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:57:33 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b26so13293218pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gtLb/BFxaZEtUCQGZNUXZW2j+UMC0CoivbHLowPJfAI=;
        b=hJ60Glvn+CmUXHYPQBC/b47Mub8Qtjb9XxPeVkVLwgtgjKxRJdpu1CymYyZQWCaB3x
         97vp7zu7D5FDHJOm/ooRrVgXNMDyh0KhGHj6gnGpMn89i9W060X6hAvGlOqXkbvm0fEY
         6sEx1UzxHxruJCQUXVi48Fos9Lur4v6RRPVhmzZWYDdCskNEUv+sC/sC+YUkbxD4Sqfb
         cOF1+mDLg8BoaTGe9886CiMpwCfMXu4I9GTbxb/jGpZR/lF/r7DULDCetztcD5Tu0YAS
         4O8UM89EDWVCZM2sjGheqH78mvJZ7wIX7KY7nrH3wHOrq5g2aDclDjsLk4gLULW0/i4E
         ehqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gtLb/BFxaZEtUCQGZNUXZW2j+UMC0CoivbHLowPJfAI=;
        b=ICu16yS1+9kov/j74JtjJg17Yh6V8sVtaEzKv7+DK8VKcHvwVNFmEyrURwA2XrLSfR
         pP1osD6orXcy//K45qlIwDWNOP+D2WyANaylpnIgUzRa6kCKBRBAsgp+E0kR3t1DukGH
         3l5lvcHPuA/GQk4T2vaaFOfwiv9b2/IjL0DpVowBNqplBg7EhCwTYUNmnD71ROjCY0Tk
         ia+rKMDMPS4out9iLlXyq48DO483/xa6lDezM2MW2OfOdlWNYzTg79eQ/x85erjs+1Xn
         C4rhat8unq/DL5nwPUKt6p5M6GjtT85gCjCULa9ET4hIvmegq0PJ0iEawoDVJsJiigNm
         ur/g==
X-Gm-Message-State: AOAM530/zTECR7gMrO/iCFQA0lknpeAhq42AMl1f8xnD+tO3B4oxKdyQ
        I/2nJDxMSAd//4HCAUixPz4=
X-Google-Smtp-Source: ABdhPJyzh7Uemlt+vdwUtjLJLeCSsJuNHKl9rVRmHdzZGos30W8A7PLEXDV4YLoaQymFDiOYMQKl+g==
X-Received: by 2002:a62:1716:0:b029:19d:b78b:ef02 with SMTP id 22-20020a6217160000b029019db78bef02mr19798332pfx.11.1607417852838;
        Tue, 08 Dec 2020 00:57:32 -0800 (PST)
Received: from ?IPv6:2601:647:4700:9b2:5c98:e5b3:1ddc:54ce? ([2601:647:4700:9b2:5c98:e5b3:1ddc:54ce])
        by smtp.gmail.com with ESMTPSA id k16sm7410225pfi.131.2020.12.08.00.57.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 00:57:32 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20201208083434.GA1164013@linux.ibm.com>
Date:   Tue, 8 Dec 2020 00:57:30 -0800
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83A6D439-F732-4112-BD1F-00195EBFCE4C@gmail.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <31DA12CC-E9CC-497D-A2EE-B83549D95CE8@gmail.com>
 <20201206093703.GY123287@linux.ibm.com>
 <5921BA80-F263-4F8D-B7E6-316CEB602B51@gmail.com>
 <20201208083434.GA1164013@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 8, 2020, at 12:34 AM, Mike Rapoport <rppt@linux.ibm.com> wrote:
>=20
> On Sun, Dec 06, 2020 at 08:31:39PM -0800, Nadav Amit wrote:
>> Whenever I run into a non-standard and non-trivial synchronization =
algorithm
>> in the kernel (and elsewhere), I become very confused and concerned. =
I
>> raised my question since I wanted to modify the code and could not =
figure
>> out how to properly do so. Based on your input that the monitor is =
expected
>> to know the child mappings according to userfaultfd events, I now =
think that
>> the kernel does not provide this ability and the locking scheme is =
broken.
>>=20
>> Here are some scenarios that I think are broken - please correct me =
if I am
>> wrong:
>>=20
>> * Scenario 1: MADV_DONTNEED racing with userfaultfd page-faults
>>=20
>> userfaultfd_remove() only holds the mmap_lock for read, so these =
events
>> cannot be ordered with userfaultfd page-faults.
>>=20
>> * Scenario 2: MADV_DONTNEED racing with fork()
>>=20
>> As userfaultfd_remove() releases mmap_lock after the user =
notification and
>> before the actual unmapping, concurrent fork() might happen before or =
after
>> the actual unmapping in MADV_DONTNEED and the user therefore has no =
way of
>> knowing whether the actual unmapping took place before or after the =
fork().
>>=20
>> * Scenario 3: Concurrent MADV_DONTNEED can cause userfaultfd_remove() =
to
>> clear mmap_changing cleared before all the notifications are =
completed.
>>=20
>> As mmap_lock is only taken for read, the first thread the completed
>> userfaultfd_remove() would clear the indication that was set by the =
other
>> one.
>>=20
>> * Scenario 4: Fork starts and ends between copying of two pages.
>>=20
>> As mmap_lock might be released during ioctl_copy() (inside
>> __mcopy_atomic()), some pages might be mapped in the child and others =
not:
>>=20
>>=20
>> CPU0				CPU1
>> ----				----
>> ioctl_copy():
>> __mcopy_atomic()
>>  mmap_read_lock()
>>  !mmap_changing [ok]
>>  mfill_atomic_pte() =3D=3D 0 [page0 copied]
>>  mfill_atomic_pte() =3D=3D -ENOENT [page1 will be retried]
>>  mmap_read_unlock()
>>  goto retry
>>=20
>> 				fork():
>> 				 dup_userfaultfd()
>> 				 -> mmap_changing=3Dtrue
>> 				 userfaultfd_event_wait_completion()
>> 				 -> mmap_changing=3Dfalse
>>=20
>>  mmap_read_lock()
>>  !mmap_changing [ok]
>>  mfill_atomic_pte() =3D=3D 0 [page1 copied]
>>  mmap_read_unlock()
>>=20
>> return: 2 pages were mapped, while the first is present in the child =
and
>> the second one is non-present.
>>=20
>> Bottom-line: it seems to me that mmap_changing should be a counter =
(not
>> boolean) that is protected by mmap_lock. This counter should be kept
>> elevated throughout the entire operation (in regard to =
MADV_DONTNEED).
>> Perhaps mmap_lock does not have to be taken to decrease the counter, =
but
>> then an smp_wmb() would be needed before the counter is decreased.
>>=20
>> Let me know whether I am completely off or missing something.
>=20
> I tried to remember what's going on there and wrap my head around your
> examples. I'm not sure if userspace cannot workaround some of those, =
but
> I can't say I can propose it right now.
>=20
> There is for sure userspace is helpless in Scenario 4, but I think it =
is
> very unlikely that fork() will be fast enough to grab and release
> mmap_lock while uffd_copy() waits for CPU to retry.
>=20
> I agree that a making mmap_changing a counter would be more robust
> anyway.

Thanks for confirming my suspicion.

On a second thought, I think that a sequence lock would be required. I =
will
work on a patch to resolve it in the next RFC of the related patch =
series I
am working on.

As for the race window size, as there are lock optimizations to prevent
writers' starvation, I do not think the last scenario is completely
far-fetched.

Thanks again,
Nadav=
