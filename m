Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB664301F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbhAXXVu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 Jan 2021 18:21:50 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:46922 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbhAXXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:21:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 62F111809AD3C;
        Mon, 25 Jan 2021 00:21:00 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id En2gXzSTGuNe; Mon, 25 Jan 2021 00:20:59 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ft1g1MTWLLqg; Mon, 25 Jan 2021 00:20:59 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/8] MUSE: Userspace backed MTD v3
Date:   Mon, 25 Jan 2021 00:19:59 +0100
Message-Id: <20210124232007.21639-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to announce the first non-RFC version of this patch set.
Over the xmas holidays I found some time to experiment with various userspace
implementations of MTDs and gave the kernel side more fine-tuning.

Rationale:
----------

When working with flash devices a common task is emulating them to run various
tests or inspect dumps from real hardware. To achieve that we have plenty of
emulators in the MTD subsystem: mtdram, block2mtd, nandsim.

Each of them implements an ad-hoc MTD and have various drawbacks.
Over the last years some developers tried to extend them but these attempts
often got rejected because they added just more adhoc feature instead of
addressing overall problems.

MUSE is a novel approach to address the need of advanced MTD emulators.
Advanced means in this context supporting different (vendor specific) image
formats, different ways for fault injection (fuzzing) and recoding/replaying
IOs to emulate power cuts.

The core goal of MUSE is having the complexity on the userspace side and
only a small MTD driver in kernelspace.
While playing with different approaches I realized that FUSE offers everything
we need. So MUSE is a little like CUSE except that it does not implement a
bare character device but an MTD.

Notes:
------

- OOB support is currently limited. Currently MUSE has no support for processing
  in- and out-band in the same MTD operation. It is good enough to make JFFS2
  happy. This limitation is because FUSE has no support more than one variable
  length buffer in a FUSE request.
  At least I didn’t find a good way to pass more than one buffer to a request.
  Maybe FUSE folks can correct me. :-)

- Every MTD read/write operation maps 1:1 to a MUSE_READ/WRITE opcode.
  Since FUSE requests are not cheap, the amount of read/written bytes in a MTD
  operation as a huge impact on the performance. Especially when NOR style MTDs
  are implemented in userspace a large writebufsize should be requested to gain
  good write performance.
  On the other hand, MTD operations with lengths larger than writesize are *not*
  split up into multiple MUSE_READ/WRITE requests. This means that userspace
  has to split them manually when doing power-cut emulation.

- MUSE is not super fast. On my i5 workstation nandsim is almost twice as fast
  as a NAND flash in userspace. But MUSE is still magnitudes faster than any
  real world MTD out there. So it is good enough for the use cases I have in
  mind.

Changelog:
----------

Changes since v2 (RFC):
- OOB support
- MUSE_READ/WRITE opcodes are no longer a min IO MTD unit
- MTD partitions support via mtdparts string
- More code cleanup
- Code rebased to 5.11-rc4

Changes since v1 (RFC):
- Rewrote IO path, fuse_direct_io() is no longer used.
  Instead of cheating fuse_direct_io() use custom ops to implement
  reading and writing. That way MUSE no longer needs a dummy file object
  nor a fuse file object.
  In MTD all IO is synchronous and operations on kernel buffers, this
  makes IO processing simple for MUSE.
- Support for bad blocks.
- No more (ab)use of FUSE ops such as FUSE_FSYNC.
- Major code cleanup.

This series can also be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git muse_v3

Richard Weinberger (8):
  fuse: Export fuse_simple_request
  fuse: Export IO helpers
  fuse: Make cuse_parse_one a common helper
  mtd: Add MTD_MUSE flag
  mtd: Allow passing a custom cmdline to cmdline line parser
  fuse: Add MUSE specific defines FUSE interface
  fuse: Implement MUSE - MTD in userspace
  MAINTAINERS: Add entry for MUSE

 Documentation/ABI/testing/sysfs-class-mtd |    8 +
 MAINTAINERS                               |    7 +
 drivers/mtd/parsers/cmdlinepart.c         |   73 +-
 fs/fuse/Kconfig                           |   15 +
 fs/fuse/Makefile                          |    2 +
 fs/fuse/cuse.c                            |   58 +-
 fs/fuse/dev.c                             |    1 +
 fs/fuse/file.c                            |   16 +-
 fs/fuse/fuse_i.h                          |   18 +
 fs/fuse/helper.c                          |   70 ++
 fs/fuse/muse.c                            | 1086 +++++++++++++++++++++
 include/linux/mtd/partitions.h            |    2 +
 include/uapi/linux/fuse.h                 |   76 ++
 include/uapi/mtd/mtd-abi.h                |    1 +
 14 files changed, 1346 insertions(+), 87 deletions(-)
 create mode 100644 fs/fuse/helper.c
 create mode 100644 fs/fuse/muse.c

-- 
2.26.2

