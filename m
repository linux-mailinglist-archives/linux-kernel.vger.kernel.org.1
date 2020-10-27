Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E129CA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373130AbgJ0Unw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:43:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44033 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505096AbgJ0Unv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:43:51 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjjKf-1k5dy61yRv-00lEzH; Tue, 27 Oct 2020 21:43:21 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v5 0/3] time namespace aware system boot time
Date:   Tue, 27 Oct 2020 21:42:55 +0100
Message-Id: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bHKV46k7NjYBrZvTjk2bb2c7IWh3tgSsU+12Nyo5sfzjqKLFQEM
 zU+CBwHwQCxoyomZnJ1DswSRDXeyo0uDUFuqm6dsnzFz3oXO4SI+aTT8rOLXCSMFUs8CfbH
 L0VWyYJ3IxLziMkiZieOXCkBjA1VxMHKaFmEdT0Uk97y3BBTjYCF87JErHuuSJ7NZYi9Y8r
 AY5DQ5vHc2D6kljPBSHQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GmT63YoxH1w=:FLj56L0iwgAW0ZFb1sjQDl
 6gyShO8SUWC3o9XW2JzjYvyRLp+KLJPqm0oVwS3rxQLMY7SwFD4EhZJLQ36evVhvIVbhs7ENg
 jKDpLzZuM0wGobr9w9dRkMVob8WSMc2fwPaiBX5Izbn2SV4U9+8OwIPhLna7KTjeOIhmeKZmy
 LCKuibQfpRcGZEUfs+FkwgxxQvXFvnFTR8VG92kUNUP2MR9bAScF7mxM4ghF2B64W+72oYFDR
 uZTmSWKdFqnuiUOIEUmyj3ELVPVkK7x9XM/ZmWEjxK1PLkWngA9OKGKWU8HUc253RCKdjyVeU
 tRJ+JaSxoU8wCmYKp/iYwC2BqSAJtBbilE1BSpvzWle2IpJ27xq2uOgzFg+0T8aGLDNqqh3r7
 xVxqoIIlW2gM86qUUbAlBZiDR6fsk2KHDmEj23yB2GPkC2l8nMbKKtWWrdJneKriwb7dpc4vh
 g+jZ8ars3Bk6DDRCEPzIBMqN02k37d0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time namespaces make it possible to virtualize time inside of
containers, e.g., it is feasible to reset the uptime of a container
to zero by setting the time namespace offset for boottime to the
negated current value of the CLOCK_BOOTTIME.

However, the boot time stamp provided by getboottime64() does not
take care of time namespaces. The resulting boot time stamp 'btime'
provided by /proc/stat does not show a plausible time stamp inside
the time namespace of a container.

We address this by shifting the value returned by getboottime64()
by subtracting the boottime offset of the time namespace.
(A selftest to check the expected /proc/stat 'btime' inside the
namespace is provided.)

Further, to avoid to show processes as time travelers inside of the
time namespace the boottime offset then needs to be added to the
start_boottime provided by the task_struct.

v5 Changes:
Added tags, Thanks Andrei and Thomas for reviews and comments.
Updated commit message of [2/3] as indicated by Thomas.

v4 Changes:
Avoid type conversions back and forth between timespec64 and ktime_t
in 'proc/stat.c' as suggested by Andrei.
Introduced timens_sub_boottime() in 'time_namespace.h' to provide
better coder readability/consistency.

v3 Changes:
leave getboottime64() unchanged and shift the boot timestamp in
'fs/proc/stat.c' as result of the discussion with Andrei and Thomas.

v2 Changes:
Fixed compile errors with TIME_NS not set in config

Michael Weiß (3):
  timens: additional helper functions for boottime offset handling
  fs/proc: apply the time namespace offset to /proc/stat btime
  selftests/timens: added selftest for /proc/stat btime

 fs/proc/array.c                         |  6 ++-
 fs/proc/stat.c                          |  3 ++
 include/linux/time_namespace.h          | 22 ++++++++++
 tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++-
 4 files changed, 86 insertions(+), 3 deletions(-)

-- 
2.20.1

