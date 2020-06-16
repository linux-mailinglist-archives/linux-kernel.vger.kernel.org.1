Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CBA1FA7E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 06:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgFPEqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 00:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgFPEqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:46:36 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30832206DB;
        Tue, 16 Jun 2020 04:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592282795;
        bh=5gDFn5P6wSFQJ52Xxmdb7V5k+gomrQfYAQ0eF53nfTY=;
        h=Date:From:To:Cc:Subject:From;
        b=j2EUkj+5fc5oNgZty0JRoIvCT4uUByj46uBNiu3fYdU4Mj5hWCWIi61uE7Vx1JMEF
         Bo4AjH3jovQ5+l3YW2chKZ2amQK929DDzb+SjgpuoO50RX9DxZv6s4W0iwBphGVcMO
         XYoi9sl/MY7ITxeAv3+7XzX6MpFhEEIuhmRAgNB0=
Date:   Mon, 15 Jun 2020 23:51:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL v2] flexible-array member conversion patches for 5.8-rc2
Message-ID: <20200616045155.GA2728@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

v2 of today's pull request. I considerably reduced the size of the changelog
text for all the patches, while at the same time, pointing people to where
they can read further details about the changes, in case they want/need to.

I also reduced the size and modified the commit message for the pull request.
It no longer contains the part about the one-element arrays.

Thanks
--
Gustavo

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-conversions-5.8-rc2

for you to fetch changes up to 76fafbfffb447d2a5a95d5a9486b0217c00f9785:

  w1: Replace zero-length array with flexible-array (2020-06-15 23:08:32 -0500)

----------------------------------------------------------------
flexible-array member conversion patches for 5.8-rc2

Hi Linus,

Please, pull the following patches that replace zero-length arrays with
flexible-array members.

Notice that all of these patches have been baking in linux-next for
two development cycles now.

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code should
always use “flexible array members”[1] for these cases. The older style of
one-element or zero-length arrays should no longer be used[2].

C99 introduced “flexible array members”, which lacks a numeric size for the
array declaration entirely:

struct something {
        size_t count;
        struct foo items[];
};

This is the way the kernel expects dynamically sized trailing elements to be
declared. It allows the compiler to generate errors when the flexible array
does not occur last in the structure, which helps to prevent some kind of
undefined behavior[3] bugs from being inadvertently introduced to the codebase.
It also allows the compiler to correctly analyze array sizes (via sizeof(),
CONFIG_FORTIFY_SOURCE, and CONFIG_UBSAN_BOUNDS). For instance, there is no
mechanism that warns us that the following application of the sizeof() operator
to a zero-length array always results in zero:

struct something {
        size_t count;
        struct foo items[0];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
instance->count = count;

size = sizeof(instance->items) * instance->count;
memcpy(instance->items, source, size);

At the last line of code above, size turns out to be zero, when one might have
thought it represents the total size in bytes of the dynamic memory recently
allocated for the trailing array items. Here are a couple examples of this
issue[4][5]. Instead, flexible array members have incomplete type, and so the
sizeof() operator may not be applied[6], so any misuse of such operators will
be immediately noticed at build time.

The cleanest and least error-prone way to implement this is through the use of
a flexible array member:

struct something {
        size_t count;
        struct foo items[];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
instance->count = count;

size = sizeof(instance->items[0]) * instance->count;
memcpy(instance->items, source, size);

Thanks
--
Gustavo

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://github.com/KSPP/linux/issues/21
[3] https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf
[4] https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539
[5] https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf
[6] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html

----------------------------------------------------------------
Gustavo A. R. Silva (41):
      firmware: dmi-sysfs: Replace zero-length array with flexible-array member
      firmware: google: memconsole: Replace zero-length array with flexible-array member
      firmware: google: vpd: Replace zero-length array with flexible-array member
      aio: Replace zero-length array with flexible-array
      ARM: tegra: Replace zero-length array with flexible-array
      dmaengine: Replace zero-length array with flexible-array
      can: peak_canfd: Replace zero-length array with flexible-array
      can: Replace zero-length array with flexible-array
      crypto: Replace zero-length array with flexible-array
      drbd: Replace zero-length array with flexible-array
      drm/edid: Replace zero-length array with flexible-array
      cb710: Replace zero-length array with flexible-array
      firewire: ohci: Replace zero-length array with flexible-array
      FS-Cache: Replace zero-length array with flexible-array
      ia64: kernel: unwind_i.h: Replace zero-length array with flexible-array
      samples: mei: Replace zero-length array with flexible-array
      ibft: Replace zero-length array with flexible-array
      jffs2: Replace zero-length array with flexible-array
      KVM: Replace zero-length array with flexible-array
      kexec: Replace zero-length array with flexible-array
      keys: encrypted-type: Replace zero-length array with flexible-array
      kprobes: Replace zero-length array with flexible-array
      libata: Replace zero-length array with flexible-array
      tools/testing/nvdimm: Replace zero-length array with flexible-array
      block: Replace zero-length array with flexible-array
      oprofile: Replace zero-length array with flexible-array
      firmware: pcdp: Replace zero-length array with flexible-array
      media: pwc: Replace zero-length array with flexible-array
      rapidio: Replace zero-length array with flexible-array
      RxRPC: Replace zero-length array with flexible-array
      phy: samsung: Replace zero-length array with flexible-array
      sctp: Replace zero-length array with flexible-array
      ima: Replace zero-length array with flexible-array
      ASoC: SOF: Replace zero-length array with flexible-array
      Squashfs: Replace zero-length array with flexible-array
      stm class: Replace zero-length array with flexible-array
      dmaengine: tegra-apb: Replace zero-length array with flexible-array
      tifm: Replace zero-length array with flexible-array
      soc: ti: Replace zero-length array with flexible-array
      tracing/probe: Replace zero-length array with flexible-array
      w1: Replace zero-length array with flexible-array

 arch/ia64/kernel/unwind_i.h                   |  2 +-
 block/partitions/ldm.h                        |  2 +-
 drivers/amba/tegra-ahb.c                      |  2 +-
 drivers/block/drbd/drbd_int.h                 |  2 +-
 drivers/block/drbd/drbd_protocol.h            |  8 +++---
 drivers/crypto/chelsio/chcr_crypto.h          |  8 +++---
 drivers/dma/milbeaut-hdmac.c                  |  2 +-
 drivers/dma/milbeaut-xdmac.c                  |  2 +-
 drivers/dma/moxart-dma.c                      |  2 +-
 drivers/dma/tegra20-apb-dma.c                 |  2 +-
 drivers/dma/ti/edma.c                         |  2 +-
 drivers/dma/ti/k3-udma.c                      |  2 +-
 drivers/dma/timb_dma.c                        |  2 +-
 drivers/firewire/core-cdev.c                  |  2 +-
 drivers/firewire/core-transaction.c           |  2 +-
 drivers/firewire/core.h                       |  2 +-
 drivers/firewire/nosy.c                       |  2 +-
 drivers/firewire/ohci.c                       |  2 +-
 drivers/firmware/dmi-sysfs.c                  |  2 +-
 drivers/firmware/google/memconsole-coreboot.c |  2 +-
 drivers/firmware/google/vpd.c                 |  2 +-
 drivers/firmware/iscsi_ibft.c                 |  2 +-
 drivers/firmware/pcdp.h                       |  2 +-
 drivers/hwtracing/stm/policy.c                |  2 +-
 drivers/hwtracing/stm/stm.h                   |  4 +--
 drivers/media/usb/pwc/pwc.h                   |  2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  4 +--
 drivers/oprofile/cpu_buffer.h                 |  2 +-
 drivers/phy/samsung/phy-samsung-usb2.h        |  2 +-
 drivers/rapidio/rio-scan.c                    |  2 +-
 drivers/soc/ti/knav_qmss.h                    |  2 +-
 drivers/w1/w1_netlink.h                       |  4 +--
 fs/aio.c                                      |  2 +-
 fs/jffs2/nodelist.h                           |  2 +-
 fs/jffs2/summary.h                            |  4 +--
 fs/squashfs/squashfs_fs.h                     | 16 ++++++------
 include/drm/drm_displayid.h                   |  2 +-
 include/keys/encrypted-type.h                 |  2 +-
 include/keys/rxrpc-type.h                     |  4 +--
 include/linux/can/skb.h                       |  2 +-
 include/linux/cb710.h                         |  2 +-
 include/linux/dmaengine.h                     |  4 +--
 include/linux/fscache-cache.h                 |  2 +-
 include/linux/kexec.h                         |  2 +-
 include/linux/kprobes.h                       |  2 +-
 include/linux/kvm_host.h                      |  2 +-
 include/linux/libata.h                        |  2 +-
 include/linux/sctp.h                          | 36 +++++++++++++--------------
 include/linux/tifm.h                          |  2 +-
 kernel/trace/trace_probe.h                    |  2 +-
 samples/mei/mei-amt-version.c                 |  2 +-
 security/integrity/integrity.h                |  4 +--
 sound/soc/sof/probe.h                         |  8 +++---
 tools/testing/nvdimm/test/nfit_test.h         |  6 ++---
 54 files changed, 96 insertions(+), 96 deletions(-)
