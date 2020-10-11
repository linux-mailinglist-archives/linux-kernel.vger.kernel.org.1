Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB728A7E4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgJKPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:00:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbgJKPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:00:27 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6KpF-1kPMaM0m0v-016hQd; Sun, 11 Oct 2020 16:59:51 +0200
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
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 0/3] time namespace aware system boot time
Date:   Sun, 11 Oct 2020 16:59:21 +0200
Message-Id: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pEDnMFOB3+lv+I3vYSBKIPFqDU6h+rojAZELkzbCRzWlu9RPsKJ
 oj0x5fmHUACu8XSXmWnYAU9FzmgP96ZHvjM/Vf4B6oWlLaRdfiCW6GZP6RH01DEPt0/AZrc
 mHbz/SQv2BJP6RcVtINAy+9TIuDydBENxEItAMiTStnZrtk8XR6D/ruPQQrDenFMpXXdAlv
 K0M6FGaKQqb3xd1UDLMxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:huZfNW+b68E=:JTwlBWKPsLMUeD1aCzLqtJ
 Dbty10N6QCaBbJ+KirMRetVjL+wt2TiwB7OlI+ymrCVNASycoyV026QnWGknnBjuyGoHrcIGt
 iYZRCDhQyo4A/SnMtGpNSWt4km0HgDTY/Ap5/Onjxyanv5Q0eP5rHr60QYBuCZvALIACyCpIu
 nHYZ5yFsr5bZuPC14z6Ie5FUEs+JQn2gMB1uga8KGiXnBiNyfRGHu/yjccVzPcgCl/7LVRH02
 0DvfzTzxtVB+kQ9xJKplvR/yIrU4fuC10EKEfQF8lTJNJaI3gZNHzzIkLvZ+DorPiQC8QEoDQ
 MttyQJvG5Dd6BjcniyiIdxKU+Ad8DbirvyXS64vkvlbNaNs4Z0/CA8/2w9fneF8ICY+MA8wKU
 +6Vd6G7yNqfxfHwifqMVMyrXj2UrHW2iQXKkizZdpQHLIUmJi7zDzte0NCuSpeXG1qhUjVVUc
 dHEusR/9zIKNZpJJVbLFS+a2MqC/PxdeORUe7BnIIP+wMSBUt8HXmoMhmIOmKtcSCcmiuoLSr
 CoYNEOymxmsFZZjcBNTcBt6+h0K4uOqrm3H8x2Hpk3kRmWqBZ1y7Aa9PNvc4MwKqVXrOt2nLp
 CC278dP/9sI2ZX02fS0yIqwhCk/5ldSVXM6ZxQR7y7eDOi8Fp68PF+Db3yfSap7fwF/E7fFAq
 PdKqH2RcRUbaDziHEwEogZK6LTqXIk8Zx/XTQ8rrVwN3QXsc48Z46f94FJOwdzugqQlLSz/HB
 JPRPbC7oZqDoodhcXwMaNCZwCmtCk2rG9zLkvj2R0miNCbeh+Vm5vWmYH9WqNeHXdoXdYMuFb
 m7ZqUG5HhC7mYtMlwpoB6Qah1bmxsOm1+3i4TFcl4OYjmBlOuzWGGKypvhOyZP6AsX9671X2e
 E5bhs6pj0A/+ZeF4tv5Q==
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
start_bootime provided by the task_struct.

v3 Changes:
leave getboottime64() unchanged and shift the boot timestamp in
'fs/proc/stat.c' as result of the discussion with Andrei and Thomas.

v2 Changes:
Fixed compile errors with TIME_NS not set in config
Reported-by: kernel test robot <lkp@intel.com>

Michael Weiß (3):
  timens: additional helper function to add boottime in nsec
  fs/proc: apply the time namespace offset to /proc/stat btime
  selftests/timens: added selftest for /proc/stat btime

 fs/proc/array.c                         |  6 ++-
 fs/proc/stat.c                          | 17 +++++++-
 include/linux/time_namespace.h          | 13 ++++++
 tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 4 deletions(-)

-- 
2.20.1

