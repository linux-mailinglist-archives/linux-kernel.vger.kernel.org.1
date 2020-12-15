Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B8A2DB020
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgLOPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:32:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLOPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:32:31 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kpCIn-0001FF-Hu; Tue, 15 Dec 2020 15:31:49 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] close_range()/openat2() v5.11
Date:   Tue, 15 Dec 2020 16:31:25 +0100
Message-Id: <20201215153125.199021-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This contains a fix for openat2() to make RESOLVE_BENEATH and
RESOLVE_IN_ROOT mutually exclusive. It doesn't make sense to specify both
at the same time. The openat2() selftests have been extended to verify
that these two flags can't be specified together.

This also adds the CLOSE_RANGE_CLOEXEC flag to close_range() which allows
to mark a range of file descriptors as close-on-exec without actually
closing them. This is useful in general but the use-case that triggered the
patch is installing a seccomp profile in the calling task before exec. If
the seccomp profile wants to block the close_range() syscall it obviously
can't use it to close all fds before exec. If it calls close_range() before
installing the seccomp profile it needs to take care not to close fds that
it will still need before the exec meaning it would have to call
close_range() multiple times on different ranges and then still fall back
to closing fds one by one right before the exec. CLOSE_RANGE_CLOEXEC allows
to solve this problem relying on the exec codepath to get rid of the
unwanted fds. The close_range() tests have been expanded to verify that
CLOSE_RANGE_CLOEXEC works.

Note, I had picked up the openat2() and close_range() right after -rc6
since they were close to missing the merge window and I wanted to have them
in -next for a little bit.
I've coordinatd this with Al and made extra sure yesterday that he's fine
with me sending this. He's ack on the openat2() change (I couldn't add the
ack anymore since that would've meant rebasing). He hasn't commented on the
close_range() extension. In case you'd prefer to only pull the openat2()
fix you can pull from the

openat2-v5.11

tag instead of the close-range-openat2-v5.11 tag here.

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-openat2-v5.11

for you to fetch changes up to 23afeaeff3d985b07abf2c76fd12b8c548da8367:

  selftests: core: add tests for CLOSE_RANGE_CLOEXEC (2020-12-04 12:06:16 +0100)

/* Testing */
The patches are based on v5.10-rc6 since I had waited pretty late for them to
be picked up. No build failures or warnings were observed. All old and new
tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflict with 2c85ebc57b3e ("Linux 5.10") when
pulling the tag.

Please consider pulling these changes from the signed close-range-openat2-v5.11 tag.

Thanks!
Christian

----------------------------------------------------------------
close-range-openat2-v5.11

----------------------------------------------------------------
Aleksa Sarai (2):
      openat2: reject RESOLVE_BENEATH|RESOLVE_IN_ROOT
      selftests: openat2: add RESOLVE_ conflict test

Giuseppe Scrivano (2):
      fs, close_range: add flag CLOSE_RANGE_CLOEXEC
      selftests: core: add tests for CLOSE_RANGE_CLOEXEC

 fs/file.c                                       | 44 +++++++++++----
 fs/open.c                                       |  4 ++
 include/uapi/linux/close_range.h                |  3 +
 tools/testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++++++++
 tools/testing/selftests/openat2/openat2_test.c  |  8 ++-
 5 files changed, 122 insertions(+), 11 deletions(-)
