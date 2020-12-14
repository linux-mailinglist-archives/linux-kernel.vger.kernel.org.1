Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438122D99EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407468AbgLNO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440152AbgLNOXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:23:01 -0500
Date:   Mon, 14 Dec 2020 08:22:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607955741;
        bh=OW1ezYqM9kcEmxofilnAS3iGMDuyI8QhL2vTf1Mndak=;
        h=From:To:Cc:Subject:From;
        b=jiWsXS5XoFVSoq9opSwCW4YMO/fxMp2T5K9p1zZmAU61E16mqf7j2GrOFojeVg4XW
         ARFfz8uIWIug6GsPC0CN5hn2W1gkzx7MQApwmpn9cP6R/rr6eZot6V9ObQ8uhQYXjm
         qsS8BvfOPDw0TQRPpJuDEXyP3yJhv4A9wWsvNqb4yYy8QMYrNRsFT4ncXBI4lZc+1y
         sf3k1lh9F1t7DnvUNVVSA7oV9gbHLY/c/SxSN8Jj7Pz9RrTB9n9Pmvdedg8wtkbSl1
         /cqyL8Nlwvkx9NH6QvJOvFgFZLniNSYYrSrGFW7zvi3YnZAGxNB1cDcKe9RglnqssR
         J/A72tbt1K8dw==
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.11-rc1
Message-ID: <20201214142200.GA1062@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.11-rc1

for you to fetch changes up to 36f9ff9e03de89691274a6aec45aa079bd3ae405:

  lib: Fix fall-through warnings for Clang (2020-11-19 07:23:47 -0600)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.11-rc1

Hi Linus,

Please, pull the following patches that fix many fall-through warnings
when building with Clang 12.0.0 and this[1] change reverted. Notice
that in order to enable -Wimplicit-fallthrough for Clang, such change[1]
is meant to be reverted at some point. So, these patches help to move
in that direction.

- powerpc: boot: include compiler_attributes.h (Nick Desaulniers)
- Revert "lib: Revert use of fallthrough pseudo-keyword in lib/" (Nick Desaulniers)
- powerpc: fix -Wimplicit-fallthrough (Nick Desaulniers)
- lib: Fix fall-through warnings for Clang (Gustavo A. R. Silva)

Thanks!

[1] commit e2079e93f562c ("kbuild: Do not enable -Wimplicit-fallthrough for clang for now")

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      lib: Fix fall-through warnings for Clang

Nick Desaulniers (3):
      powerpc: boot: include compiler_attributes.h
      Revert "lib: Revert use of fallthrough pseudo-keyword in lib/"
      powerpc: fix -Wimplicit-fallthrough

 arch/powerpc/boot/Makefile      |  1 +
 arch/powerpc/boot/decompress.c  |  1 -
 arch/powerpc/kernel/prom_init.c |  1 +
 arch/powerpc/kernel/uprobes.c   |  1 +
 arch/powerpc/perf/imc-pmu.c     |  1 +
 lib/asn1_decoder.c              |  4 ++--
 lib/assoc_array.c               |  2 +-
 lib/bootconfig.c                |  4 ++--
 lib/cmdline.c                   | 11 ++++++-----
 lib/dim/net_dim.c               |  2 +-
 lib/dim/rdma_dim.c              |  4 ++--
 lib/glob.c                      |  2 +-
 lib/kstrtox.c                   |  1 +
 lib/nlattr.c                    |  2 +-
 lib/siphash.c                   | 36 ++++++++++++++++++------------------
 lib/ts_fsm.c                    |  2 +-
 lib/vsprintf.c                  | 15 ++++++++-------
 lib/xz/xz_dec_lzma2.c           |  4 ++--
 lib/xz/xz_dec_stream.c          | 16 ++++++++--------
 lib/zlib_inflate/inflate.c      | 24 ++++++++++++------------
 lib/zstd/bitstream.h            | 11 ++++++-----
 lib/zstd/compress.c             |  2 +-
 lib/zstd/decompress.c           | 12 ++++++------
 lib/zstd/huf_compress.c         |  5 +++--
 24 files changed, 86 insertions(+), 78 deletions(-)
