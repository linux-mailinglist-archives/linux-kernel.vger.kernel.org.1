Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355F22DC705
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbgLPTYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:24:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:39993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgLPTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608146560;
        bh=KECqyXX4KBM3ulRcxRMiqAHgnq2/rmUWEOb7bcxwksk=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=P+/bvfvHNXsmZJHMHauRCkD5i033AzeQge2DyrJq+EqzAw5i3Y8embRtQb9tE7U/p
         feuk49R0XPmMB+cLFYqb9+tUJDdwwfYVG7LD6Z2KuxU/hoy8SFeZfUPulOlyUHoigb
         aWMHCj8zlQOdn5ZcYgZ29O6zKa0XKnNsAoBTvxV4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.188.26]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1kdSjj3whw-00W1CJ; Wed, 16
 Dec 2020 20:22:40 +0100
Date:   Wed, 16 Dec 2020 20:22:35 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.11-rc1
Message-ID: <20201216192235.GA27343@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:EaXLt0pAz4OTpPxhUCs2zX69fAoKSXwU46CIP6tow5KgNMxuClw
 dFe6U237d+JPiEmTYocurJo2aEK4i2I1Bc3L8ZFhhuWkaSDDqbXQcbKejLiP8ahHEQiTgaZ
 9Xl/1xL9oOkJV4igdL5bRCJY01fvukkxT/z9q1TqSXASDOZll2Vdv7c70mq7aNYQePLALMl
 66xxqjE8qQDyYffSxURpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PaK9AW1lOYs=:Nt4rMdSDRVEawq8q3k+JI8
 JRjNRpkzUYK2gse3ZUlQZc1amzPLAylBNdX0Gxb3vkpHczXyZ1TLbvA1KlPK16Qo8CQ3aVlMH
 6wHB/ZX20s55p3jA8SYjIwB8xkS10bRe/M7qmVLGbZQ9e6suTcDTrqChVbkf1zqsQWw6F6KAz
 kyoE7jcwfjpLxJdOos3Lv4l2YpNG+bb2irwD4wY9G9BsbjCZcz/Ds9igwn4x/JqnEef/O9lVs
 wZrepy9grYN9oC2Avk38GTFVBV4PtxROBp82PA+S9M9F2fZZSqfAT1sGT17cW8BG7ZiEdhLvQ
 ov17EJfGgnO3qWB+OFh7UCLNqlNqswO2Z+js/ZmTJRhoT0n/955d4JFM6L08UlaIAQVeeJb/b
 4if+YQ/u1lNhQyT4GFg7qBqInD0atH4qBNISQVSC4WeTJGiwEhYOq8YxdVqveIzIbxVByAqlI
 RJxMiy3U/zMUkc6zBI2Mf029F7VWbh3FZmk7TSHtdDgNE5aTT9hO2fgVc7slSMY3KJO3p6FV7
 +pcRiwdW9yIpAXfYqcTg3y1U8wOz8ZdbOlnVDxlgu3AgoP8hoXi+UqMuV7ZzvBHr8smRYRn7k
 62Bt51qXHW3G+/97TXsWT2mDOE80vSOH+jQOxmsizMyg56vnUrmrU5hayrmlM4T8DMdB6cn92
 8L+zQPr/dyimJA6Vyq16SVC/ctu23/1Iz/eVwb6x/zWADwTENovb0PNRMWzYGiwFoqSmcK/0C
 BRbDNSnE+I38ADSf/l5/hkBhCXZc+6nq/i6rFR4yh0WPttUF18O+Ikv4losVZVb1WU9XpWGDL
 1tQiJ90NQL7g/49BUu0O5xUjk0ckUwoMFMx29jNi/tcM+l/P5EAcKZGklIa//NBzJTdFHG9qT
 xmfwu2AoVHmp8UbZg3aQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull the updates for the parisc architecture for kernel 5.11-rc1 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-1

This patchset includes:

A change to increase the default maximum stack size on parisc to 100 MB
and the ability to further increase the stack hard limit size at runtime
with ulimit for newly started processes.

The other patches fix compile warnings, utilizes the Kbuild logic and
cleanups the parisc arch code.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-1

for you to fetch changes up to 39b1e779b6e2d4ca7967b49b26f1e4358f20c90c:

  parisc: pci-dma: fix warning unused-function (2020-12-15 05:41:11 +0100)

----------------------------------------------------------------
Anders Roxell (1):
      parisc: pci-dma: fix warning unused-function

Geert Uytterhoeven (1):
      parisc/uapi: Use Kbuild logic to provide <asm/types.h>

Helge Deller (3):
      parisc: Drop loops_per_jiffy from per_cpu struct
      parisc: Use _TIF_USER_WORK_MASK in entry.S
      parisc: Make user stack size configurable

 arch/parisc/include/asm/processor.h  |  8 ++------
 arch/parisc/include/uapi/asm/types.h |  7 -------
 arch/parisc/kernel/entry.S           |  4 ++--
 arch/parisc/kernel/pci-dma.c         |  2 +-
 arch/parisc/kernel/processor.c       |  5 ++---
 arch/parisc/kernel/sys_parisc.c      | 23 +++++++++++++++++++++--
 fs/exec.c                            |  4 ++--
 mm/Kconfig                           | 12 +++++-------
 8 files changed, 35 insertions(+), 30 deletions(-)
 delete mode 100644 arch/parisc/include/uapi/asm/types.h
