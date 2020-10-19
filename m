Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09D292EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgJSTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:53:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgJSTxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:53:55 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfL0-1k4ZnA1FA2-00ijwH; Mon, 19 Oct 2020 21:53:26 +0200
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
Subject: [PATCH v4 0/3] time namespace aware system boot time
Date:   Mon, 19 Oct 2020 21:52:54 +0200
Message-Id: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QCan7DQtsekxnb1J8UY+1zof+10m43qpEiCqOYi3EUIykufj9Ul
 uyD8wrcMOLtR0vrEc6Ktekxe57VwNxIAF/wHCdSGTuH5bTK4cJtYHp+TdJhDTzahe98C0v4
 4QmoLEO4QlvTg0FOPyl2llZdjxeUu+c64xqC7WgtIfO1UHZjJdf5nUY+C97BnhPv8xEJ5vL
 GXq9x0gVqJfAjUUfOK9cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h1UGJNEDNQo=:D7olIAoGy6A4xFB67xl8mI
 fK17RU8IwQhz43Hi/dH0WchEk1oLayR5JR7q661C6+b7pQV7lKtEQwgDJK3MB6Vay2q9ZaesR
 N+kPt4SWAi1V9Jcw7WxFqfz9nyjbexiVZR2dIxFZEtGBnB6wvfbqFtsr70z4DEdSURhtcdWyG
 YDBavQP2Y8fxuGDckW/MCN+E4d8CcsATPOG5Iq88T0keY+mQX4wFvYZ8TagslNx+Hz/tSjSp2
 6zZNl8XI05WP++v3abbh+eaGJ8MFyiPGJwVupCzTBWo4KEHRqhKWP7+kgf6pkBxIJEo1fiC7p
 eCvxBQkMPciYsZ4M013JkrvH8jJDTyZZwxa5bZyUuEPgFR7Dbs67paJRanEPfV3Lh0WdFgXNH
 UxYf65BFLzbLMe5xzWmtijnaOsfu4TJrbLXj2yAM9XFNsji3HlZB2unzlyRveQ2gqVP6OILqe
 hM4uEWFk+A==
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

