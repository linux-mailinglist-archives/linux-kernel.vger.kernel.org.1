Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15C1EEAEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgFDTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 15:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgFDTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:11:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F521C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 12:11:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so4262419lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FMqkfjIzwNR6V/h4b+1kbLwk6T8zG2nwZG76PzOWl4=;
        b=cXpxTi9aJOIFGl5LioIreu8DwLrUp75TGTOrjBAbZgoHbzVDWaa2Fg64R+qFqYTuvM
         La9Z4BSCupWR1ydnCo0uIcuT98kuC2BfLlhkFZFNSmm2bdHXnwtSS8+l4s+/r3CLe9LP
         3PnE71x8dqTsQRTtbp4pCB9lpPBmMPRnJXv2j0ev+PMo1WFA+mNcppSMvcEPJP0Exk7b
         FDjrd5nhhaN0s/fhofbxMBxhbNX0PFkZu6RFAoOYmuNyjrZKbJfr+8FHOT+xiuOcobGK
         BCJ7GBAacvHk+GYdyQgivMEvQabisHpfnm+voD+Abp98+8B3Vdd7doSwd8sSOJS2pMUf
         lcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FMqkfjIzwNR6V/h4b+1kbLwk6T8zG2nwZG76PzOWl4=;
        b=AsI9blSoro9lXnPfeNVO1RFtkTFnjd0RRzB0z1+X74ELCDN1dDcM+7PAONjkoHto/F
         bJJ1+/mQFsymFfk9Tj1rgsOZJd7Z3dpElZpYZtiz0/Vr1ETAFHwF2b9fxhtozP9h0Wao
         QA/9yGP7fAH9+FPBT3TV4M1VIOscR+aG+IdQ4g+yVFTFHUKL55XkxAioOycdskz9kWIK
         Df73WH4PZjdPsNAwoJyiqbUMBLMDKusJTiTc6cqwcbWs3EyIxoTQzbaFgBX5ThqeQ5Zt
         YhsfjoyvfglMxER12zqcK6Ymi/S2qsqUGNpDYj8cy9DKo8O6GpaikoFrY3XTE5+oRv8j
         LbAA==
X-Gm-Message-State: AOAM533ai/stwQ93X4cOCXB7CYi3hxm6Mkmflz/LUvOTC1NjPqJUmzvn
        zI1jKyWRpHyqireW4wem2Mp8w+zOLAKfI6t4sNVweQ==
X-Google-Smtp-Source: ABdhPJxeLtglAPY9jAlFosaebNncQzEHL+mG4AYno5yvXTZLpNvD4TxLpuXCdJER539LNMQtPSMdxbycOmPl2Ug4QHc=
X-Received: by 2002:a19:c04:: with SMTP id 4mr3273082lfm.17.1591297864552;
 Thu, 04 Jun 2020 12:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
 <CA+G9fYuUvjDeLXVm2ax_5UF=OJeH7fog0U7GG2vEUXg-HXWRqg@mail.gmail.com>
In-Reply-To: <CA+G9fYuUvjDeLXVm2ax_5UF=OJeH7fog0U7GG2vEUXg-HXWRqg@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 4 Jun 2020 21:10:53 +0200
Message-ID: <CAB0TPYGo5ePYrah3Wgv_M1fx91+niRe12YaBBXGfs5b87Fjtrg@mail.gmail.com>
Subject: Re: LTP: syscalls: regression on mainline - ioctl_loop01 mknod07 setns01
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        chrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
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

Hi Naresh,

I suspect the loop failures are due to
faf1d25440d6ad06d509dada4b6fe62fea844370 ("loop: Clean up
LOOP_SET_STATUS lo_flags handling"), I will investigate and get back
to you.

Thanks,
Martijn

On Thu, Jun 4, 2020 at 7:19 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> + linux-block@vger.kernel.org
>
> On Thu, 4 Jun 2020 at 22:47, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Following three test cases reported as regression on Linux mainline kernel
> > on x86_64, arm64, arm and i386
> >
> >   ltp-syscalls-tests:
> >     * ioctl_loop01
> >     * mknod07
> >     * setns01
> >
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > git branch: master
> > GOOD:
> >   git commit: b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69
> >   git describe: v5.7-1230-gb23c4771ff62
> > BAD:
> >   git commit: 1ee08de1e234d95b5b4f866878b72fceb5372904
> >   git describe: v5.7-3523-g1ee08de1e234
> >
> > kernel-config: https://builds.tuxbuild.com/U3bU0dMA62OVHb4DvZIVuw/kernel.config
> >
> > We are investigating these failures.
> >
> > tst_test.c:906: CONF: btrfs driver not available
> > tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
> > tst_device.c:88: INFO: Found free device 1 '/dev/loop1'
> > ioctl_loop01.c:49: PASS: /sys/block/loop1/loop/partscan = 0
> > [ 1073.639677] loop_set_status: loop1 () has still dirty pages (nrpages=1)
> > ioctl_loop01.c:50: PASS: /sys/block/loop1/loop/autoclear = 0
> > ioctl_loop01.c:51: PASS: /sys/block/loop1/loop/backing_file =
> > '/scratch/ltp-mnIdulzriQ/9cPtLQ/test.img'
> > ioctl_loop01.c:63: FAIL: expect 12 but got 17
> > ioctl_loop01.c:67: FAIL: /sys/block/loop1/loop/partscan != 1 got 0
> > ioctl_loop01.c:68: FAIL: /sys/block/loop1/loop/autoclear != 1 got 0
> > ioctl_loop01.c:79: FAIL: access /dev/loop1p1 fails
> > [ 1073.679678] loop_set_status: loop1 () has still dirty pages (nrpages=1)
> > ioctl_loop01.c:85: FAIL: access /sys/block/loop1/loop1p1 fails
> >
> > HINT: You _MAY_ be missing kernel fixes, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10c70d95c0f2
> >
> > mke2fs 1.43.8 (1-Jan-2018)
> > [ 1264.711379] EXT4-fs (loop0): mounting ext2 file system using the
> > ext4 subsystem
> > [ 1264.716642] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> > mknod07     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
> > mknod07     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > mknod07     1  TPASS  :  mknod failed as expected:
> > TEST_ERRNO=EACCES(13): Permission denied
> > mknod07     2  TPASS  :  mknod failed as expected:
> > TEST_ERRNO=EACCES(13): Permission denied
> > mknod07     3  TFAIL  :  mknod07.c:155: mknod succeeded unexpectedly
> > mknod07     4  TPASS  :  mknod failed as expected:
> > TEST_ERRNO=EPERM(1): Operation not permitted
> > mknod07     5  TPASS  :  mknod failed as expected:
> > TEST_ERRNO=EROFS(30): Read-only file system
> > mknod07     6  TPASS  :  mknod failed as expected:
> > TEST_ERRNO=ELOOP(40): Too many levels of symbolic links
> >
> >
> > setns01     0  TINFO  :  ns_name=ipc, ns_fds[0]=6, ns_types[0]=0x8000000
> > setns01     0  TINFO  :  ns_name=mnt, ns_fds[1]=7, ns_types[1]=0x20000
> > setns01     0  TINFO  :  ns_name=net, ns_fds[2]=8, ns_types[2]=0x40000000
> > setns01     0  TINFO  :  ns_name=pid, ns_fds[3]=9, ns_types[3]=0x20000000
> > setns01     0  TINFO  :  ns_name=uts, ns_fds[4]=10, ns_types[4]=0x4000000
> > setns01     0  TINFO  :  setns(-1, 0x8000000)
> > setns01     1  TPASS  :  invalid fd exp_errno=9
> > setns01     0  TINFO  :  setns(-1, 0x20000)
> > setns01     2  TPASS  :  invalid fd exp_errno=9
> > setns01     0  TINFO  :  setns(-1, 0x40000000)
> > setns01     3  TPASS  :  invalid fd exp_errno=9
> > setns01     0  TINFO  :  setns(-1, 0x20000000)
> > setns01     4  TPASS  :  invalid fd exp_errno=9
> > setns01     0  TINFO  :  setns(-1, 0x4000000)
> > setns01     5  TPASS  :  invalid fd exp_errno=9
> > setns01     0  TINFO  :  setns(11, 0x8000000)
> > setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(11, 0x20000)
> > setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(11, 0x40000000)
> > setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(11, 0x20000000)
> > setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(11, 0x4000000)
> > setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> >
> > Full test log link,
> > https://lkft.validation.linaro.org/scheduler/job/1467931#L8047
> >
> > test results comparison shows this test case started failing from June-2-2020
> > https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/ioctl_loop01/history/
> >
> > https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/setns01/history/
> >
> > https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/mknod07/history/
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
