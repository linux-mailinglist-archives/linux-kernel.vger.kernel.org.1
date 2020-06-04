Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8F1EE94F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgFDRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgFDRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:19:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:19:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so8257788lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOUSWUGEazxQJ3JSjEEwtkoyhFt8vz7eHf2enbpW67A=;
        b=U2noY57kNh3hjtz9BxkBoIGKTgi4yPg5ibNuK9xQpxQ6tzamQfJk+nqbVCNZP+4+o/
         VXXoZRzj3D+kWIGD4/ngq3HCzDxh6D2JbHYAF9yr/u69w2haHYCpUxspXcj23UF5tddE
         God/9ySXPXRDFaophWLE0YGSON+TI3bErIXWlsZOsG48eXC4LeG6QPG5mfy/F9aFmrb8
         3UdvC8ePsY847d5hlvcw3cfRqN6WsoirASG5k0bSX2Lpk/+6C+h+QyaD3nt9FXvzPO/5
         xmV380j51RuWK+ZLlTvjTit+oCI1GxLf7rRyTtHfF6DftWMQ9VXVEPkN58nYAEzseM5e
         8hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOUSWUGEazxQJ3JSjEEwtkoyhFt8vz7eHf2enbpW67A=;
        b=JWjcffYMbhwKhuo4ygN3O14eXdIPc2ZAuvpBqrztV52ItGPFdx2qHsh9GzMmAHSrih
         t9fstwHi4mQnC3q61cJQr2bUFIVxbsImV0qTXUDELDPpBY1GYxeT2c7PIQ/A2kuNpBRC
         T0BjF13Y04/0czdwk82pueuMWwmjjgHwHW0RBJcMmTxbuueFXEKKlzQXRmtneP6BFDff
         huuMC0+gah/yNF/O1p+nc9XCksXx0nPgRtD7OE4Dk2/QQZ/3uOViplP7mR6NdUOMGlKp
         Fu/DcjBURx7AwRO6TnqnRF4+Ulg5bhlzCkTlzykyzwVY7IRcWGkayFqAoCwy1OKXtWWa
         G1Fw==
X-Gm-Message-State: AOAM533k7NpYZVoEdiB2KwU70kg23EmnSlJfRHfl2xdH/TTh/IOzaU3F
        jGrpjPKXKxe3fBX4xV8r0UJ3z9NyDZVY8NucSwcEsw==
X-Google-Smtp-Source: ABdhPJwL1gypiTKcwcoUo78fnWm4nQKRjHMGrDSQpDZDbjDKQ9rPEuTZCF0ZppT2Fx+kshP4tf++y91hW5IQ3rQXnc0=
X-Received: by 2002:a2e:9009:: with SMTP id h9mr2606965ljg.266.1591291176512;
 Thu, 04 Jun 2020 10:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
In-Reply-To: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 4 Jun 2020 22:49:24 +0530
Message-ID: <CA+G9fYuUvjDeLXVm2ax_5UF=OJeH7fog0U7GG2vEUXg-HXWRqg@mail.gmail.com>
Subject: Re: LTP: syscalls: regression on mainline - ioctl_loop01 mknod07 setns01
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     chrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        maco@android.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Jan Stancek <jstancek@redhat.com>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-block@vger.kernel.org

On Thu, 4 Jun 2020 at 22:47, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following three test cases reported as regression on Linux mainline kernel
> on x86_64, arm64, arm and i386
>
>   ltp-syscalls-tests:
>     * ioctl_loop01
>     * mknod07
>     * setns01
>
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git branch: master
> GOOD:
>   git commit: b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69
>   git describe: v5.7-1230-gb23c4771ff62
> BAD:
>   git commit: 1ee08de1e234d95b5b4f866878b72fceb5372904
>   git describe: v5.7-3523-g1ee08de1e234
>
> kernel-config: https://builds.tuxbuild.com/U3bU0dMA62OVHb4DvZIVuw/kernel.config
>
> We are investigating these failures.
>
> tst_test.c:906: CONF: btrfs driver not available
> tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
> tst_device.c:88: INFO: Found free device 1 '/dev/loop1'
> ioctl_loop01.c:49: PASS: /sys/block/loop1/loop/partscan = 0
> [ 1073.639677] loop_set_status: loop1 () has still dirty pages (nrpages=1)
> ioctl_loop01.c:50: PASS: /sys/block/loop1/loop/autoclear = 0
> ioctl_loop01.c:51: PASS: /sys/block/loop1/loop/backing_file =
> '/scratch/ltp-mnIdulzriQ/9cPtLQ/test.img'
> ioctl_loop01.c:63: FAIL: expect 12 but got 17
> ioctl_loop01.c:67: FAIL: /sys/block/loop1/loop/partscan != 1 got 0
> ioctl_loop01.c:68: FAIL: /sys/block/loop1/loop/autoclear != 1 got 0
> ioctl_loop01.c:79: FAIL: access /dev/loop1p1 fails
> [ 1073.679678] loop_set_status: loop1 () has still dirty pages (nrpages=1)
> ioctl_loop01.c:85: FAIL: access /sys/block/loop1/loop1p1 fails
>
> HINT: You _MAY_ be missing kernel fixes, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10c70d95c0f2
>
> mke2fs 1.43.8 (1-Jan-2018)
> [ 1264.711379] EXT4-fs (loop0): mounting ext2 file system using the
> ext4 subsystem
> [ 1264.716642] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> mknod07     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
> mknod07     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mknod07     1  TPASS  :  mknod failed as expected:
> TEST_ERRNO=EACCES(13): Permission denied
> mknod07     2  TPASS  :  mknod failed as expected:
> TEST_ERRNO=EACCES(13): Permission denied
> mknod07     3  TFAIL  :  mknod07.c:155: mknod succeeded unexpectedly
> mknod07     4  TPASS  :  mknod failed as expected:
> TEST_ERRNO=EPERM(1): Operation not permitted
> mknod07     5  TPASS  :  mknod failed as expected:
> TEST_ERRNO=EROFS(30): Read-only file system
> mknod07     6  TPASS  :  mknod failed as expected:
> TEST_ERRNO=ELOOP(40): Too many levels of symbolic links
>
>
> setns01     0  TINFO  :  ns_name=ipc, ns_fds[0]=6, ns_types[0]=0x8000000
> setns01     0  TINFO  :  ns_name=mnt, ns_fds[1]=7, ns_types[1]=0x20000
> setns01     0  TINFO  :  ns_name=net, ns_fds[2]=8, ns_types[2]=0x40000000
> setns01     0  TINFO  :  ns_name=pid, ns_fds[3]=9, ns_types[3]=0x20000000
> setns01     0  TINFO  :  ns_name=uts, ns_fds[4]=10, ns_types[4]=0x4000000
> setns01     0  TINFO  :  setns(-1, 0x8000000)
> setns01     1  TPASS  :  invalid fd exp_errno=9
> setns01     0  TINFO  :  setns(-1, 0x20000)
> setns01     2  TPASS  :  invalid fd exp_errno=9
> setns01     0  TINFO  :  setns(-1, 0x40000000)
> setns01     3  TPASS  :  invalid fd exp_errno=9
> setns01     0  TINFO  :  setns(-1, 0x20000000)
> setns01     4  TPASS  :  invalid fd exp_errno=9
> setns01     0  TINFO  :  setns(-1, 0x4000000)
> setns01     5  TPASS  :  invalid fd exp_errno=9
> setns01     0  TINFO  :  setns(11, 0x8000000)
> setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(11, 0x20000)
> setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(11, 0x40000000)
> setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(11, 0x20000000)
> setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(11, 0x4000000)
> setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> errno=EBADF(9): Bad file descriptor
>
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/1467931#L8047
>
> test results comparison shows this test case started failing from June-2-2020
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/ioctl_loop01/history/
>
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/setns01/history/
>
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/mknod07/history/
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
