Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30328F8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbgJOS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391214AbgJOS4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:56:45 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E097321527;
        Thu, 15 Oct 2020 18:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602788204;
        bh=W9IxqASsxTzhXqon7o4Cl4Xbv5Ps7FhZXepxFDjEGSY=;
        h=Date:From:To:cc:Subject:From;
        b=cojHZvQ0VLzkO/VkSCzpTacxGy25I+qa/i20PyqUEoxUQw11RjFEQKGko5ln6LHug
         BlUn5lXMICX9fdusDJncMN318UIcs6XuI1ERK0p03BykBuKgUjFmFXwf667Jtz+RG7
         KBi5S+CJ5FJUSCBBY3XKzzHzdD5wLdODyZBC4O0A=
Date:   Thu, 15 Oct 2020 20:56:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] trivial for 5.10
Message-ID: <nycvar.YFH.7.76.2010152055050.18859@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

to receive the latest advances in computer science from trivial queue for 
5.10. Thanks.

----------------------------------------------------------------
Anatoly Pugachev (1):
      selftests: vm: add fragment CONFIG_GUP_BENCHMARK

Chris Packham (1):
      HID: logitech-dj: Fix spelling in comment

Chucheng Luo (1):
      fs: Fix missing 'bit' in comment

Fam Zheng (1):
      perf: Fix opt help text for --no-bpf-event

Geert Uytterhoeven (1):
      scif: Fix spelling of EACCES

Jiri Kosina (1):
      Merge branch 'master' into for-next

Joe Perches (1):
      spelling.txt: Remove some duplicate entries

Lukas Bulwahn (1):
      MAINTAINERS: rectify MMP SUPPORT after moving cputype.h

Pavel Machek (1):
      mtd: rawnand: oxnas: cleanup/simplify code

Randy Dunlap (3):
      lib/bitmap.c: fix spello
      printk: fix global comment
      xtensa: fix Kconfig typo

Shaokun Zhang (1):
      bootconfig: Fix kernel message mentioning CONFIG_BOOT_CONFIG

 MAINTAINERS                       | 2 +-
 arch/xtensa/Kconfig               | 2 +-
 drivers/hid/hid-logitech-dj.c     | 2 +-
 drivers/mtd/nand/raw/oxnas_nand.c | 3 +--
 fs/vboxsf/dir.c                   | 2 +-
 include/linux/scif.h              | 8 ++++----
 init/main.c                       | 2 +-
 kernel/printk/printk_safe.c       | 2 +-
 lib/bitmap.c                      | 2 +-
 scripts/spelling.txt              | 4 ----
 tools/testing/selftests/vm/config | 1 +
 11 files changed, 13 insertions(+), 17 deletions(-)

-- 
Jiri Kosina
SUSE Labs

