Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954572D09BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgLGEca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 23:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgLGEc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:32:29 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF30C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 20:31:43 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id s21so8522040pfu.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 20:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4gxEaB36cnYBuLLFzSYchCEp0p3wHq7jkMXvHid0lLw=;
        b=YwT8AHRGUPK+rct8HVEiT0QdSgAjegA+UfbRCjiFk4LYfDNyUqDRCnkx8Y3ZVWBFLv
         1O+Pc/0itPntpbvU3E7Ihuw1O6k8RCAbH+IiC3JVnazkV6DZf+IgLnhS3pUenlZs65ut
         wtDJkpaKdSD41c0oSWS92cXAExbKju8hBTu94pK74FmSDX9DW1cTz4fbpn6fyBGdaoFe
         oNANaYB7F5+JrIUkBK5zTcOJ0AUkkhRqtN9Ue8ms4PhumZfuC0KC0EuuxZr1e9/M9L3L
         59IslqHwc5e1A0LcgoYYXtLa3vHh5ZA1P+TAAfUISnQ9C+98yl3/Mla/aFZNw0km0/SG
         4D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4gxEaB36cnYBuLLFzSYchCEp0p3wHq7jkMXvHid0lLw=;
        b=IH9N2MqfTCzXaXLkejTfvdBqbHomtskO+KCDaenNlv2xgiSY6HkqQ4HYBhCNIgV+Qs
         tT4qP0Rf20TVFPOy8cjEnXRLZwHW6U7OOg+/uEhj7Wlq6wzv4D+eR38MFPLCAfjWf3nf
         FkkQo1Uki2MGkJDQOif196NfUmSCK/JVWMqf/sHW9HyYCZ9uGgxD20q7xYzakHG3P4CW
         oLo8KZjdPP4CX2dEhJ42QNO74fcP1WOYRgO14br/7AINrE1CQBVVfBrWHlQ4ykV7Qfym
         UuWUM0xaSZb/stkd+oJjg8j5fyQZhh0QnW0kf5/IH+jN8JAI2Jb3XOhSPVuwXeoXnAxz
         WDeA==
X-Gm-Message-State: AOAM532D28P50cyh/jA3eV5lZ+lIqcp8QB4tQYV3rB8ILjzpI+YcrgrU
        3r4j5SujF7Nk4lb4ej04dnE=
X-Google-Smtp-Source: ABdhPJylstN4ygiesT5Z14Y04e4p+JqnYDFElGEENqYrnrzK40waf+eyOucVpBA78CNAk2CEBoBAXw==
X-Received: by 2002:a17:902:8f83:b029:d7:ec99:d2fd with SMTP id z3-20020a1709028f83b02900d7ec99d2fdmr14458410plo.17.1607315501978;
        Sun, 06 Dec 2020 20:31:41 -0800 (PST)
Received: from ?IPv6:2601:647:4700:9b2:fc04:46d2:982e:6f95? ([2601:647:4700:9b2:fc04:46d2:982e:6f95])
        by smtp.gmail.com with ESMTPSA id q35sm8950649pjh.38.2020.12.06.20.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 20:31:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20201206093703.GY123287@linux.ibm.com>
Date:   Sun, 6 Dec 2020 20:31:39 -0800
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5921BA80-F263-4F8D-B7E6-316CEB602B51@gmail.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <31DA12CC-E9CC-497D-A2EE-B83549D95CE8@gmail.com>
 <20201206093703.GY123287@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the detailed answer, Mike. Things are clearer in regard to =
your
intention.

> On Dec 6, 2020, at 1:37 AM, Mike Rapoport <rppt@linux.ibm.com> wrote:
>=20
> The uffd monotor should *know* what is the state of child's memory and
> without this patch it could only guess.

I see - so mmap_changing is not just about graceful handling of =
copy-ioctl=E2=80=99s
(which I think monitors could handle before mmap_changing was =
introduced)
but to allow the monitor to know which pages are mapped in each process.
Makes sense, but I have strong doubts it really works (see below).

>> 2. How is memory ordering supposed to work here? IIUC, mmap_changing =
is not
>> protected by any lock and there are no memory barriers that are =
associated
>> with the assignment. Indeed, the code calls WRITE_ONCE()/READ_ONCE(), =
but
>> AFAIK this does not guarantee ordering with non-volatile =
reads/writes.
>=20
> There is also mmap_lock involved, so I don't see how copy can start in
> parallel with fork processing. Fork sets mmap_chaning to true while
> holding mmap_lock, so copy cannot start in parallel. When mmap_lock is
> realeased, mmap_chaning remains true until fork event is pushed to
> userspace and when this is done there is no issue with
> userfaultfd_copy.

Whenever I run into a non-standard and non-trivial synchronization =
algorithm
in the kernel (and elsewhere), I become very confused and concerned. I
raised my question since I wanted to modify the code and could not =
figure
out how to properly do so. Based on your input that the monitor is =
expected
to know the child mappings according to userfaultfd events, I now think =
that
the kernel does not provide this ability and the locking scheme is =
broken.

Here are some scenarios that I think are broken - please correct me if I =
am
wrong:

* Scenario 1: MADV_DONTNEED racing with userfaultfd page-faults

userfaultfd_remove() only holds the mmap_lock for read, so these events
cannot be ordered with userfaultfd page-faults.

* Scenario 2: MADV_DONTNEED racing with fork()

As userfaultfd_remove() releases mmap_lock after the user notification =
and
before the actual unmapping, concurrent fork() might happen before or =
after
the actual unmapping in MADV_DONTNEED and the user therefore has no way =
of
knowing whether the actual unmapping took place before or after the =
fork().

* Scenario 3: Concurrent MADV_DONTNEED can cause userfaultfd_remove() to
clear mmap_changing cleared before all the notifications are completed.

As mmap_lock is only taken for read, the first thread the completed
userfaultfd_remove() would clear the indication that was set by the =
other
one.

* Scenario 4: Fork starts and ends between copying of two pages.

As mmap_lock might be released during ioctl_copy() (inside
__mcopy_atomic()), some pages might be mapped in the child and others =
not:


CPU0				CPU1
----				----
ioctl_copy():
 __mcopy_atomic()
  mmap_read_lock()
  !mmap_changing [ok]
  mfill_atomic_pte() =3D=3D 0 [page0 copied]
  mfill_atomic_pte() =3D=3D -ENOENT [page1 will be retried]
  mmap_read_unlock()
  goto retry

				fork():
				 dup_userfaultfd()
				 -> mmap_changing=3Dtrue
				 userfaultfd_event_wait_completion()
				 -> mmap_changing=3Dfalse

  mmap_read_lock()
  !mmap_changing [ok]
  mfill_atomic_pte() =3D=3D 0 [page1 copied]
  mmap_read_unlock()
=20
 return: 2 pages were mapped, while the first is present in the child =
and
 the second one is non-present.

Bottom-line: it seems to me that mmap_changing should be a counter (not
boolean) that is protected by mmap_lock. This counter should be kept
elevated throughout the entire operation (in regard to MADV_DONTNEED).
Perhaps mmap_lock does not have to be taken to decrease the counter, but
then an smp_wmb() would be needed before the counter is decreased.

Let me know whether I am completely off or missing something.

Thanks,
Nadav

