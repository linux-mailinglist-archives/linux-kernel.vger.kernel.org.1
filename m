Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6D28DC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgJNI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:59:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgJNI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:59:56 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kScdV-00077O-FW; Wed, 14 Oct 2020 08:59:53 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread changes for v5.10
Date:   Wed, 14 Oct 2020 10:59:48 +0200
Message-Id: <20201014085948.172950-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the changes for v5.10:

/* Summary */
This introduces a new extension to the pidfd_open() syscall. Users can now
raise the new PIDFD_NONBLOCK flag to support non-blocking pidfd file
descriptors. This has been requested for uses in async process management
libraries such as async-pidfd in Rust.

Ever since the introduction of pidfds and more advanced async io various
programming languages such as Rust have grown support for async event
libraries. These libraries are created to help build epoll-based event loops
around file descriptors. A common pattern is to automatically make all file
descriptors they manage to O_NONBLOCK.

For such libraries the EAGAIN error code is treated specially. When a function
is called that returns EAGAIN the function isn't called again until the event
loop indicates the the file descriptor is ready. Supporting EAGAIN when waiting
on pidfds makes such libraries just work with little effort.

This introduces a new flag PIDFD_NONBLOCK that is equivalent to O_NONBLOCK.
This follows the same patterns we have for other (anon inode) file descriptors
such as EFD_NONBLOCK, IN_NONBLOCK, SFD_NONBLOCK, TFD_NONBLOCK and the same for
close-on-exec flags.

Passing a non-blocking pidfd to waitid() currently has no effect, i.e. is
not supported. There are users which would like to use waitid() on pidfds
that are O_NONBLOCK and mix it with pidfds that are blocking and both pass
them to waitid().
The expected behavior is to have waitid() return -EAGAIN for non-blocking
pidfds and to block for blocking pidfds without needing to perform any
additional checks for flags set on the pidfd before passing it to waitid().
Non-blocking pidfds will return EAGAIN from waitid() when no child process is
ready yet. Returning -EAGAIN for non-blocking pidfds makes it easier for event
loops that handle EAGAIN specially.

It also makes the API more consistent and uniform. In essence, waitid() is
treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
socket.
With the addition of support for non-blocking pidfds we support the same
functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
for pidfds waitid() supports WNOHANG. Both flags are per-call options. In
contrast non-blocking pidfds and non-blocking sockets are a setting on an open
file description affecting all threads in the calling process as well as other
processes that hold file descriptors referring to the same open file
description. Both behaviors, per call and per open file description, have
genuine use-cases.

The interaction with the WNOHANG flag is documented as follows:
- If a non-blocking pidfd is passed and WNOHANG is not raised we simply raise
  the WNOHANG flag internally. When do_wait() returns indicating that there are
  eligible child processes but none have exited yet we set EAGAIN. If no child
  process exists we continue returning ECHILD.
- If a non-blocking pidfd is passed and WNOHANG is raised waitid() will
  continue returning 0, i.e. it will not set EAGAIN. This ensure backwards
  compatibility with applications passing WNOHANG explicitly with pidfds.

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.10

for you to fetch changes up to 01361b665a26ef0c087e53f14cf310d1cfe0cf98:

  tests: remove O_NONBLOCK before waiting for WSTOPPED (2020-10-09 11:56:51 +0200)

/* Testing */
All patches are based on v5.9-rc2 and have been sitting in linux-next. The lkft
test framework reported hanging selftests a couple of weeks ago. This was due to
a logic error in the selftests which was fixed in 01361b665a26 ("tests: remove
O_NONBLOCK before waiting for WSTOPPED"). I've opted to let the fix be a
separate commit rather than amending the original selftests to not invalidate
the weeks of testing it had gotten in linux-next before. Otherwise, all old and
new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from linux-next and no merge
conflicts showed up doing a test-merge with current mainline 359287765c04 ("Merge branch
'from-miklos' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.

Please consider pulling these changes from the signed threads-v5.10 tag.

Thanks!
Christian

----------------------------------------------------------------
threads-v5.10

----------------------------------------------------------------
Christian Brauner (5):
      exit: support non-blocking pidfds
      pidfd: support PIDFD_NONBLOCK in pidfd_open()
      tests: port pidfd_wait to kselftest harness
      tests: add waitid() tests for non-blocking pidfds
      tests: remove O_NONBLOCK before waiting for WSTOPPED

 include/uapi/linux/pidfd.h                 |  12 ++
 kernel/exit.c                              |  15 +-
 kernel/pid.c                               |  12 +-
 tools/testing/selftests/pidfd/pidfd.h      |   4 +
 tools/testing/selftests/pidfd/pidfd_wait.c | 304 ++++++++++++-----------------
 5 files changed, 164 insertions(+), 183 deletions(-)
 create mode 100644 include/uapi/linux/pidfd.h
