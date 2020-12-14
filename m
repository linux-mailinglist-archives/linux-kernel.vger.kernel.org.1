Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C92D97C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407705AbgLNL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:58:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbgLNL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:58:34 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1komUB-0002C6-NA; Mon, 14 Dec 2020 11:57:51 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] time namespace fixes for v5.11
Date:   Mon, 14 Dec 2020 12:57:44 +0100
Message-Id: <20201214115744.3306832-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are some time namespace fixes for v5.11.

/* Summary */
When time namespaces were introduced we missed to virtualize the "btime" field
in /proc/stat. This confuses tasks which are in another time namespace with a
virtualized boottime which is common in some container workloads. This pr
contains Michael's series to fix "btime" which Thomas asked me to take through
my tree.
To fix "btime" virtualization we simply subtract the offset of the time
namespace's boottime from btime before printing the stats. Note that since
start_boottime of processes are seconds since boottime and the boottime stamp
is now shifted according to the time namespace's offset, the offset of the time
namespace also needs to be applied before the process stats are given to
userspace. This avoids that processes shown by tools such as "ps" appear as
time travelers in the corresponding time namespace. Selftests are included to
verify that btime virtualization in /proc/stat works as expected.

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/time-namespace-v5.11

for you to fetch changes up to 5c62634fc65101d350cbd47722fb76f02693059d:

  namespace: make timens_on_fork() return nothing (2020-11-18 11:06:47 +0100)

/* Testing */
All patches are based on v5.10-rc2. All old and new tests are passing.
Please note that I missed to merge these fixes into my for-next branch and so
linux-next has not contained the commits in this pr.
I'm still sending this pr because these are fairly trivial bugfixes and have
seen vetting from multiple people. I have also now merged this tag into my
for-next branch so these commits will show up in linux-next soon. If you feel
more comfortable with this sitting in linux-next for a while please just ignore
this pr and I'll resend after rc1 has been released.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge 2c85ebc57b3e ("Linux 5.10").

Please consider pulling these changes from the signed time-namespace-v5.11 tag.

Thanks!
Christian

----------------------------------------------------------------
time-namespace-v5.11

----------------------------------------------------------------
Hui Su (1):
      namespace: make timens_on_fork() return nothing

Michael Weiß (3):
      timens: additional helper functions for boottime offset handling
      fs/proc: apply the time namespace offset to /proc/stat btime
      selftests/timens: added selftest for /proc/stat btime

 fs/proc/array.c                         |  6 ++--
 fs/proc/stat.c                          |  3 ++
 include/linux/time_namespace.h          | 28 ++++++++++++++--
 kernel/nsproxy.c                        |  7 +---
 kernel/time/namespace.c                 |  6 ++--
 tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++++++++++-
 6 files changed, 92 insertions(+), 16 deletions(-)
