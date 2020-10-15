Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104C928FB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgJOWzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgJOWzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:55:10 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A0620714;
        Thu, 15 Oct 2020 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602802509;
        bh=MYaImY1TMO2dxt1Al7P3a4lN7JKH38iZlisNSRHpq+U=;
        h=Date:From:To:Cc:Subject:From;
        b=oSms8DnnezRvDafrFCtnckrgWqwccMI2pgNhqbH2blgHikOgu27ZPJ2nFoxjfgKkG
         ansJ3k2zV0JmirnaLhdvvU90FYFn1XTvC68Xr8HMt/LU3CH2J8TMb8+kHa0aJI5zca
         6s8G3NOZA+KeVOZjdPOSPRolGx8U+DQE91xacs/A=
Date:   Thu, 15 Oct 2020 15:55:08 -0700
From:   jaegeuk@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 5.10-rc1
Message-ID: <20201015225508.GA2465821@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 581cb3a26baf846ee9636214afaa5333919875b1:

  Merge tag 'f2fs-for-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2020-09-10 13:12:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.10-rc1

for you to fetch changes up to 788e96d1d39949fc91457a816f4bda0d374c257b:

  f2fs: code cleanup by removing unnecessary check (2020-10-14 13:23:41 -0700)

----------------------------------------------------------------
f2fs-for-5.10-rc1

In this round, we've added new features such as zone capacity for ZNS and
a new GC policy, ATGC, along with in-memory segment management. In addition,
we could improve the decompression speed significantly by changing virtual
mapping method. Even though we've fixed lots of small bugs in compression
support, I feel that it becomes more stable so that I could give it a try in
production.

Enhancement:
 - suport zone capacity in NVMe Zoned Namespace devices
 - introduce in-memory current segment management
 - add standart casefolding support
 - support age threshold based garbage collection
 - improve decompression speed by changing virtual mapping method

Bug fix:
 - fix condition checks in some ioctl() such as compression, move_range, etc
 - fix 32/64bits support in data structures
 - fix memory allocation in zstd decompress
 - add some boundary checks to avoid kernel panic on corrupted image
 - fix disallowing compression for non-empty file
 - fix slab leakage of compressed block writes

In addition, it includes code refactoring for better readability and minor
bug fixes for compression and zoned device support.

----------------------------------------------------------------
Aravind Ramesh (1):
      f2fs: support zone capacity less than zone size

Chao Yu (24):
      f2fs: compress: remove unneeded code
      f2fs: introduce inmem curseg
      f2fs: record average update time of segment
      f2fs: inherit mtime of original block during GC
      f2fs: support 64-bits key in f2fs rb-tree node entry
      f2fs: fix compile warning
      f2fs: compress: use more readable atomic_t type for {cic,dic}.ref
      f2fs: support age threshold based garbage collection
      f2fs: allocate proper size memory for zstd decompress
      f2fs: ignore compress mount option on image w/o compression feature
      f2fs: trace: fix typo
      f2fs: clean up kvfree
      f2fs: do sanity check on zoned block device path
      f2fs: relocate blkzoned feature check
      f2fs: remove unneeded parameter in find_in_block()
      f2fs: fix uninit-value in f2fs_lookup
      f2fs: fix to check segment boundary during SIT page readahead
      f2fs: fix to do sanity check on segment/section count
      f2fs: compress: introduce page array slab cache
      f2fs: compress: introduce cic/dic slab cache
      f2fs: compress: fix to disallow enabling compress on non-empty file
      f2fs: fix to set SBI_NEED_FSCK flag for inconsistent inode
      f2fs: don't issue flush in f2fs_flush_device_cache() for nobarrier case
      f2fs: introduce check_swap_activate_fast()

Chengguang Xu (1):
      f2fs: code cleanup by removing unnecessary check

Daeho Jeong (6):
      f2fs: add block address limit check to compressed file
      f2fs: change compr_blocks of superblock info to 64bit
      f2fs: change i_compr_blocks of inode to atomic value
      f2fs: change return value of f2fs_disable_compressed_file to bool
      f2fs: change virtual mapping way for compression pages
      f2fs: fix writecount false positive in releasing compress blocks

Dan Robertson (1):
      f2fs: check position in move range ioctl

Daniel Rosenberg (3):
      unicode: Add utf8_casefold_hash
      fs: Add standard casefolding support
      f2fs: Use generic casefolding support

Eric Biggers (1):
      f2fs: reject CASEFOLD inode flag without casefold feature

Jack Qiu (1):
      f2fs: correct statistic of APP_DIRECT_IO/APP_DIRECT_READ_IO

Jaegeuk Kim (4):
      f2fs: point man pages for some f2fs utils
      f2fs: fix slab leak of rpages pointer
      f2fs: fix memory alignment to support 32bit
      f2fs: handle errors of f2fs_get_meta_page_nofail

Jamie Iles (1):
      f2fs: wait for sysfs kobject removal before freeing f2fs_sb_info

Matthew Wilcox (Oracle) (1):
      f2fs: Simplify SEEK_DATA implementation

Randy Dunlap (1):
      f2fs: Documentation edits/fixes

Wang Xiaojun (3):
      f2fs: remove unused check on version_bitmap
      f2fs: remove duplicated code in sanity_check_area_boundary
      f2fs: fix wrong total_sections check and fsmeta check

Xiaojun Wang (2):
      f2fs: remove duplicated type casting
      f2fs: change return value of reserved_segments to unsigned int

Zhang Qilong (1):
      f2fs: add trace exit in exception path

 Documentation/ABI/testing/sysfs-fs-f2fs |   3 +-
 Documentation/filesystems/f2fs.rst      |  82 ++++-
 fs/f2fs/acl.c                           |   6 +-
 fs/f2fs/checkpoint.c                    |  17 +-
 fs/f2fs/compress.c                      | 242 +++++++++++----
 fs/f2fs/data.c                          | 119 +++++++-
 fs/f2fs/debug.c                         |  18 +-
 fs/f2fs/dir.c                           | 109 ++-----
 fs/f2fs/extent_cache.c                  |  37 ++-
 fs/f2fs/f2fs.h                          | 118 +++++---
 fs/f2fs/file.c                          |  88 +++---
 fs/f2fs/gc.c                            | 413 +++++++++++++++++++++++--
 fs/f2fs/gc.h                            |  69 ++++-
 fs/f2fs/inline.c                        |   4 +-
 fs/f2fs/inode.c                         |  21 +-
 fs/f2fs/namei.c                         |   2 +-
 fs/f2fs/node.c                          |   7 +-
 fs/f2fs/segment.c                       | 522 ++++++++++++++++++++++++++------
 fs/f2fs/segment.h                       |  71 +++--
 fs/f2fs/super.c                         | 168 +++++++---
 fs/f2fs/sysfs.c                         |  22 +-
 fs/f2fs/xattr.c                         |   8 +-
 fs/libfs.c                              |  87 ++++++
 fs/unicode/utf8-core.c                  |  23 +-
 include/linux/f2fs_fs.h                 |   3 -
 include/linux/fs.h                      |  16 +
 include/linux/unicode.h                 |   3 +
 include/trace/events/f2fs.h             |  10 +-
 28 files changed, 1795 insertions(+), 493 deletions(-)
