Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCA2DF05B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLSQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 11:00:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgLSQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 11:00:46 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kqeeJ-0008U6-5l; Sat, 19 Dec 2020 16:00:04 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] close_range fix v5.11
Date:   Sat, 19 Dec 2020 16:58:21 +0100
Message-Id: <20201219155821.891607-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
syzbot reported a bug when asking close_range() to unshare the file
descriptor table and making all fds close-on-exec.
If CLOSE_RANGE_UNSHARE the caller will receive a private file descriptor
table in case their file descriptor table is currently shared before
operating on the requested file descriptor range.
For the case where the caller has requested all file descriptors to be
actually closed via e.g. close_range(3, ~0U, CLOSE_RANGE_UNSHARE) the
kernel knows that the caller does not need any of the file descriptors
anymore and will optimize the close operation by only copying all files in
the range from 0 to 3 and no others.
However, if the caller requested CLOSE_RANGE_CLOEXEC together with
CLOSE_RANGE_UNSHARE the caller wants to still make use of the file
descriptors so the kernel needs to copy all of them and can't optimize.

The original patch didn't account for this and thus could cause oopses as
evidenced by the syzbot report because it assumed that all fds had been
copied. Fix this by handling the CLOSE_RANGE_CLOEXEC case and copying all
fds if the two flags are specified together.

This should've been caught in the selftests but the original patch didn't
cover this case and I didn't catch it during review. So in addition to the
bugfix I'm also adding selftests. They will reliably reproduce the bug on a
non-fixed kernel and allows us to catch regressions and verify correct
behavior.
Note, the kernel selftest tree contained a bunch of changes that made the
original selftest fail to compile so there are small fixups in this pr to
make them compile without warnings.

The following changes since commit accefff5b547a9a1d959c7e76ad539bf2480e78b:

  Merge tag 'arm-soc-omap-genpd-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2020-12-16 16:53:54 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-cloexec-unshare-v5.11

for you to fetch changes up to 6abc20f8f879d891930f37186b19c9dc3ecc34dd:

  selftests/core: add regression test for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC (2020-12-19 16:23:19 +0100)

/* Testing */
No build failures or warnings were observed. All old and new tests are
passing.
The selftests manage to reliably reproduce the bug on a non-fixed kernel
and pass on a fixed kernel. Syzbot reported the bug gone with the fix in
this pr.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported when
test-pulling the tag into current mainline at
3644e2d2dda7 ("mm/filemap: fix infinite loop in generic_file_buffered_read()").

Please consider pulling these changes from the signed close-range-cloexec-unshare-v5.11 tag.

Thanks!
Christian

----------------------------------------------------------------
close-range-cloexec-unshare-v5.11

----------------------------------------------------------------
Christian Brauner (4):
      close_range: unshare all fds for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
      selftests/core: handle missing syscall number for close_range
      selftests/core: add test for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
      selftests/core: add regression test for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC

Tobias Klauser (1):
      selftests/core: fix close_range_test build after XFAIL removal

 fs/file.c                                       |   4 +-
 tools/testing/selftests/core/close_range_test.c | 281 +++++++++++++++++++++++-
 2 files changed, 278 insertions(+), 7 deletions(-)
