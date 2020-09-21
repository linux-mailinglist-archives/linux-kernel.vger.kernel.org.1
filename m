Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE9272581
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgIUN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:27:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgIUN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:27:33 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M6ltQ-1kODD23TeI-008IHo; Mon, 21 Sep 2020 15:27:31 +0200
Received: by mail-qk1-f177.google.com with SMTP id q5so14959798qkc.2;
        Mon, 21 Sep 2020 06:27:30 -0700 (PDT)
X-Gm-Message-State: AOAM530tYn12Q7iH40nvMZ40ErDKAtgebOUiI4ITpyJ0EvECdwqUdAfV
        TwfwMUhTrZOyQUSNoUGPtgpPmtO1PrCFhL0LCvE=
X-Google-Smtp-Source: ABdhPJw3W/Ieljc7e0oA/u77MIRuqr3TE/XBiDVGGgq19pLPt2WILDmtKHBHjbkWI+jPLTjuDrJcAihYlG1zN/lSkUA=
X-Received: by 2002:a37:5d8:: with SMTP id 207mr46387678qkf.352.1600694849499;
 Mon, 21 Sep 2020 06:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124624.1469673-4-arnd@arndb.de> <20200921125454.150CA21789@mail.kernel.org>
In-Reply-To: <20200921125454.150CA21789@mail.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Sep 2020 15:27:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1pzsyYCq8pa7uVYAg9a_-tg3biWReesnxAmxhySzfeew@mail.gmail.com>
Message-ID: <CAK8P3a1pzsyYCq8pa7uVYAg9a_-tg3biWReesnxAmxhySzfeew@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] ARM: oabi-compat: add epoll_pwait handler
To:     Sasha Levin <sashal@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pL5Kky/O6zrDI92K3Z6BMx6/xt7C3jmUfQvQ23QYwmvIoxoL0fR
 y8256E/HOnTe1NaKlQK4bA8cqOYtTODpRQ3qXONNJOQpt/rJkaZfrgEJZo6CYwC+x9NgdMH
 WPTbDvjTHPsEJTkwp4tr2gjmUkFen9PMV0GaQZUOXgaxe4vy/Q5jYJP5kgZuO3EzhPVVq6v
 qk69IeShlTWXWNRt6ulgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7RezZ1yr56c=:pyLD8PAO3etmg8bf7xIvkS
 SipeRU34rCidsm86/WUpDA3AM9d5X4AFgMo8vzP9micit7ylRv9GgtgbbxP/c1nIb5+xRY8zZ
 eggPG8U9Ps0NbH14EzWSKNYQ+8B6fvOzFQoCfoBNHac5Jh0PW6ItTa5kO2iYpN+gxNhfvVh4v
 R0F5r8WEXWRVEaLk9H+Olvg2ybEA/2QFjrtPrdhxvS84uZTlMvvOvMaz0RlizHc8y6yrcpvx8
 c9OyjLMwRMOa/x1UjpJRsZs68tiPTtcmrdBQAlogS6ceoXSYz0sj2gIGw0Mrm8LUc2yAXoSvT
 l96PATZ9YO+tHKsz9kmThdkzn0s08FBwDcBKd6JNWvzD/xiK+iCcA7fGIyDvZethqU+/rEpSi
 axSXR3hNoPhsXI9XvmB9DaHU5dGla3H4JA/KK+/KzQRqX5zUwlptplhOOpoqj7NQt2FKyIkMl
 yGDrthRizAB4SJ5fc8wBZ9Q0QMZcsAgHLRXcACMRPLB2veqnhZx8ljKCVLV4Q0Zm0N3Qfnz/j
 Ho51WYYWvPW7NZWIJDUzUGT8w6+LTADKGy2/R4Vt7XYjCASM/BEmZmfpzLwzLk7iOz/g6xJ44
 RRLmtj9HbQkXZyKwOIyKWjGXICt6TpChPqKIZAW2q9RqRWb+Qsdx8mTKhHJ0fcE6JqGRq+YfK
 ZP996lI3OKJA78IBIJajH7iMkTcPqJ0uPQr1K5vt2J2+MEr51drzxQ4Xt8g+S/8iSNb0BbPT2
 OmvaA5vBld8m23eeqSp6gNbhmJaHI614+y2XJG8McYK99bGZr/FEHVfPSTdeR/tJ2J1l4l2c7
 bTgzfRQdmg3cKgmz2/7KpmQISvcenmHFI5JPvwsnDyPiOeYTYgf6G/ZNonHg7Ftt4JzD4Mp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 2:54 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag
> fixing commit: 369842658a36 ("ARM: 5677/1: ARM support for TIF_RESTORE_SIGMASK/pselect6/ppoll/epoll_pwait").
>
> The bot has tested the following trees: v5.8.10, v5.4.66, v4.19.146, v4.14.198, v4.9.236, v4.4.236.
>
> v5.8.10: Build OK!
> v5.4.66: Build OK!
> v4.19.146: Build OK!
> v4.14.198: Build OK!
> v4.9.236: Failed to apply! Possible dependencies:
>     00bf25d693e7 ("y2038: use time32 syscall names on 32-bit")
>     17435e5f8cf3 ("time: Introduce CONFIG_COMPAT_32BIT_TIME")
>     338035edc9b9 ("arm: Wire up restartable sequences system call")
>     4e2648db9c5f ("ARM: remove indirection of asm/mach-types.h")
>     73aeb2cbcdc9 ("ARM: 8787/1: wire up io_pgetevents syscall")
>     78594b95998f ("ARM: add migrate_pages() system call")
>     96a8fae0fe09 ("ARM: convert to generated system call tables")
>     a1016e94cce9 ("ARM: wire up statx syscall")
>     c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
>     d4703ddafd1e ("time: Introduce CONFIG_64BIT_TIME in architectures")
>
> v4.4.236: Failed to apply! Possible dependencies:
>     00bf25d693e7 ("y2038: use time32 syscall names on 32-bit")
>     03590cb56d5d ("ARM: wire up copy_file_range() syscall")
>     0d4a619b64ba ("dma-mapping: make the generic coherent dma mmap implementation optional")
>     17435e5f8cf3 ("time: Introduce CONFIG_COMPAT_32BIT_TIME")
>     4e2648db9c5f ("ARM: remove indirection of asm/mach-types.h")
>     96a8fae0fe09 ("ARM: convert to generated system call tables")
>     c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
>     d4703ddafd1e ("time: Introduce CONFIG_64BIT_TIME in architectures")
>     f2335a2a0a59 ("ARM: wire up preadv2 and pwritev2 syscalls")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?

I wouldn't worry too much about the failed backport in this case, as I
don't think there are any actual users of this code on older stable
kernels, and even if there are they are unlikely to start using
epoll_pwait.

      Arnd
