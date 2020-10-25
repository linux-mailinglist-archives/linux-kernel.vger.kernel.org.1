Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A253298195
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415622AbgJYMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:08:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:35821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415610AbgJYMIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603627669;
        bh=kr4lAkfZK+JhsGbXUMfhJcfAO4ZwYjRZcd2ae5vRSKI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=diTSK3Pv1tagA0oSje1EDLjb+ssqjBNqgGQhCUuvdMG2ZsedJpMoBcWjUfj/M1Yej
         ZunEojH1nj7sM2S0xwMxUFxlCz9L9nQssUZKUgFkEFzrfSWH0iSqYxIXmvmIYCnSV2
         bjsx27PP6dsrTnxTKDrHvcOsZmZ4oCOiaohyzovw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.190.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1jvx9D1I9i-00gWVd; Sun, 25
 Oct 2020 13:07:49 +0100
Date:   Sun, 25 Oct 2020 13:07:47 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.10-rc1
Message-ID: <20201025120747.GA6138@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:JQYu7Gw8bu7D4sLXEJdA163Ie4JB4iKBg/2yOQVec1edvWc6qzE
 DsbjUu+CXHbGRpgI6rSDCoiNsEKh2DQfbYo5wCRUxWHr3S2X5JOPNsU89ArltBnP8LXj4lI
 39K7wIob13yphOCaj+1lPE353KrN8Fjlb6vYpX3H0NxvEeQIlnCgcLqfDdRPcq9jdrk8s9t
 KuWQMpS47I+ED5Ct6Hfug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:doGlenfDa8A=:JfBIctl0C1WqxHGzc/Jxaz
 1ZGvgH/2Af9SC25CKBoU7SlEruN1kxYdzMwp+arOq6g2SPHcBSX4SFaELH5JpaRnmGthXbv16
 fU1IY7xYjUVeQikVOZ87R10GOKXKV1Jzw3VdPYmfEMV/OKu246eB7fJQbTPuxWOFmEt0QWaFr
 OZfrPHkEuor+KXctioKxQ0Zmu7MpuzAWvwUGWw/IUlr0KuseK9n+xRBvod85Ak2/mlzCKjbbH
 1UIaQQJH7ReXTabLavAE9MBD5TQTLgW97lo3Ar/B185CdxIZ9iv94i/C+Om05RZAIBB5xXI8j
 vV2gZz10mSS4Ww1jNi3wf86Ed7eQxsyeZzCwGUVQfTvc4hIFgCEoL+0+2M4I+flTSqXAyfIzn
 AlUQ0l3cPVe/Ah5ZBvIefFlkWBn945UdQuS1IdBa4UOeFpvWOW5v+ECarXNsnwiSTy/zvT6zN
 Ea9ohCR6i/FX6OHBw5xV5p+/WknomZ8uq9SzZuuCV0ZYBij2X1nzHAKBcK0gYenZ2mDW4/6v5
 9a3nKX9VFyYJ4BDyxw8glZAFlF5jjegpL5VX+nIUDSiRcXiUtQ/JnVhbo0jjrgqn5xzbo/dtl
 jIujHBV3tVstI0AscHIWh1pEg02JYDuyPTkkxltcei5Bj/cKlZ1gjT0Wb/NFP7hHhiHb+4RAE
 qUZAGYZ0ecTBnA4OX1v8mwbCMMOKBc1AhC+D5ZULdyN+gFCesvhtzNf97g1FBL4zIqDL+k+8M
 fpe9OkhFa9/ze7zEyi20+ytaWR4DmXoL7qbV4jxqBodAGYv+Wg+AqQ9++UMYhipTxP4qnXkTA
 /8+kz7xgzGWkTyQHoyvYE/Gf6bWZkbAVbR7k7x4PQtR9OImJSm7oFVIaGcO0g7ZXOsQjjlufD
 N9QBk+PJoP6V1UXh7JsA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few last fixes and updates for the parisc architecture for kernel 5.10-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.10-2

This patchset includes:

* During this merge window O_NONBLOCK was changed to become 000200000, but we
  missed that the syscalls timerfd_create(), signalfd4(), eventfd2(), pipe2(),
  inotify_init1() and userfaultfd() do a strict bit-wise check of the flags
  parameter. To provide backward compatibility with existing userspace we introduce
  parisc specific wrappers for those syscalls which filter out the old O_NONBLOCK
  value and replaces it with the new one.

* Prevent HIL bus driver to get stuck when keyboard or mouse isn't attached

* Improve error return codes when setting rtc time

* Minor documentation fix in pata_ns87415.c

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit f9893351acaecf0a414baf9942b48d5bb5c688c6:

  Merge tag 'kconfig-v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2020-10-22 13:20:39 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.10-2

for you to fetch changes up to 2e34ae02a9b49d1f459d811ae77d72d300584a69:

  ata: pata_ns87415.c: Document support on parisc with superio chip (2020-10-23 20:23:47 +0200)

----------------------------------------------------------------
Helge Deller (4):
      parisc: Improve error return codes when setting rtc time
      hil/parisc: Disable HIL driver when it gets stuck
      parisc: Add wrapper syscalls to fix O_NONBLOCK flag usage
      ata: pata_ns87415.c: Document support on parisc with superio chip

 arch/parisc/kernel/sys_parisc.c         | 73 ++++++++++++++++++++++++++++++++-
 arch/parisc/kernel/syscalls/syscall.tbl | 12 +++---
 arch/parisc/kernel/time.c               | 11 ++++-
 drivers/ata/pata_ns87415.c              |  3 +-
 drivers/input/serio/hil_mlc.c           | 21 ++++++++--
 drivers/input/serio/hp_sdc_mlc.c        |  8 ++--
 include/linux/hil_mlc.h                 |  2 +-
 7 files changed, 111 insertions(+), 19 deletions(-)
