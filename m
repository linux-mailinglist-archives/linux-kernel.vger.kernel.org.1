Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8775E297431
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465678AbgJWQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35682246AA;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=6KumAqKJzCIKS9xMxAoZ4Qv+ZzcImY+Z7m/NE14YuUc=;
        h=From:To:Cc:Subject:Date:From;
        b=BqMwxeln0LGbWGj+qRV5mByAI4fDDP6G3SMy6OP3zgf09avSxL9eTaMsk3hN5sSoW
         587DkKlHY5QdLn7PnECYh7M3UTgIhPyVXB5NhcuqVBmQ702qU9UEIhkxmPVfWAVyTf
         SJHnjAlzqITA14IsALG1istFp+SWvwbnqlO3bpk0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002AvM-Jn; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Antti Palosaari <crope@iki.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Borislav Petkov <bp@alien8.de>,
        Chris Leech <cleech@redhat.com>,
        Colin Cross <ccross@android.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lee Duncan <lduncan@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Matt Porter <mporter@kernel.crashing.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org
Subject: [PATCH v3 00/56] Fix several bad kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:47 +0200
Message-Id: <cover.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc has always be limited to a probably bad documented
rule:

The kernel-doc markups should appear *imediatelly before* the
function or data structure that it documents.

On other words, if a C file would contain something like this:

	/**
	 * foo - function foo
	 * @args: foo args
	 */
	static inline void bar(int args);

	/**
	 * bar - function bar
	 * @args: foo args
	 */
	static inline void foo(void *args);


The output (in ReST format) will be:

	.. c:function:: void bar (int args)

	   function foo

	**Parameters**

	``int args``
	  foo args


	.. c:function:: void foo (void *args)

	   function bar

	**Parameters**

	``void *args``
	  foo args

Which is clearly a wrong result.  Before this changeset, 
not even a warning is produced on such cases.

As placing such markups just before the documented
data is a common practice, on most cases this is fine.

However, as patches touch things, identifiers may be
renamed, and people may forget to update the kernel-doc
markups to follow such changes.

This has been happening for quite a while, as there are
lots of files with kernel-doc problems.

This series address those issues and add a file at the
end that will enforce that the identifier will match the
kernel-doc markup, avoiding this problem from
keep happening as time goes by.

This series is based on current upstream tree.

@maintainers: feel free to pick the patches and
apply them directly on your trees, as all patches on 
this series are independent from the other ones.

Jon,

The first patch contains a trivial bug fix that I got
at kernel-doc script while writing this series. Feel
free to pick it anytime.

The last one should likely be applied only after we
have everything else in place, as otherwise it will 
produce hundreds of warnings, and the broken
markups will be ignored.

Mauro Carvalho Chehab (56):
  scripts: kernel-doc: fix typedef parsing
  drm: amdgpu_dm: fix a typo
  amdgpu: fix a few kernel-doc markup issues
  drm: drm_print.h: fix kernel-doc markups
  s390: fix kernel-doc markups
  x86: mtrr: fix a kernel-doc markup
  block: blk-mq: fix a kernel-doc markup
  ata: fix some kernel-doc markups
  drivers: base: fix some kernel-doc markups
  EDAC: fix some kernel-doc markups
  drm/amdgpu: fix some kernel-doc markups
  drm: fix some kernel-doc markups
  HSI: fix a kernel-doc markup
  IB: fix kernel-doc markups
  media: fix kernel-doc markups
  mei: bus: fix a kernel-doc markup
  mtd: rawnand: fix a kernel-doc markup
  net: phy: fix kernel-doc markups
  net: datagram: fix some kernel-doc markups
  net: core: fix some kernel-doc markups
  mac80211: fix kernel-doc markups
  parport: fix a kernel-doc markup
  PCI: fix kernel-doc markups
  PNP: fix kernel-doc markups
  rapidio: fix kernel-doc a markup
  regulator: fix a kernel-doc markup
  scsi: fix some kernel-doc markups
  slimbus: fix a kernel-doc markup
  spi: fix a typo inside a kernel-doc markup
  uio: fix some kernel-doc markups
  usb: dwc3: fix kernel-doc markups
  video: fix some kernel-doc markups
  vme: fix two kernel-doc markups
  fs: fix kernel-doc markups
  jbd2: fix kernel-doc markups
  locks: fix a typo at a kernel-doc markup
  pstore/zone: fix a kernel-doc markup
  clk: fix a kernel-doc markup
  completion: fix kernel-doc markups
  firmware: stratix10-svc: fix kernel-doc markups
  connector: fix a kernel-doc markup
  lib/crc7: fix a kernel-doc markup
  hrtimer: fix kernel-doc markups
  genirq: fix kernel-doc markups
  iio: fix a kernel-doc markup
  list: fix a typo at the kernel-doc markup
  memblock: fix kernel-doc markups
  sound: fix kernel-doc markups
  refcount.h: fix a kernel-doc markup
  w1: fix a kernel-doc markup
  audit: fix a kernel-doc markup
  resource: fix kernel-doc markups
  shed: fix kernel-doc markup
  mm: fix kernel-doc markups
  selftests: kselftest_harness.h: partially fix kernel-doc markups
  scrpits: kernel-doc: validate kernel-doc markup with the actual names

 arch/s390/include/asm/ccwdev.h                |  2 +-
 arch/s390/include/asm/cio.h                   |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c               |  3 +-
 block/blk-mq.c                                |  2 +-
 drivers/ata/libata-core.c                     |  2 +-
 drivers/ata/libata-eh.c                       |  2 +-
 drivers/ata/libata-scsi.c                     |  2 +-
 drivers/base/class.c                          |  2 +-
 drivers/base/devres.c                         |  2 +-
 drivers/base/firmware_loader/fallback.c       |  2 +-
 drivers/edac/edac_device.h                    | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 +-
 drivers/gpu/drm/drm_atomic_state_helper.c     |  2 +-
 drivers/gpu/drm/drm_connector.c               |  3 +-
 drivers/gpu/drm/drm_dp_helper.c               |  2 +-
 drivers/gpu/drm/drm_framebuffer.c             |  2 +-
 drivers/gpu/drm/drm_gem.c                     |  4 +-
 drivers/gpu/drm/drm_gem_vram_helper.c         |  2 +-
 drivers/gpu/drm/drm_mode_object.c             |  2 +-
 drivers/gpu/drm/drm_modes.c                   |  4 +-
 drivers/gpu/drm/drm_scdc_helper.c             |  2 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |  2 +-
 drivers/gpu/drm/i915/i915_gem_evict.c         |  2 +-
 drivers/gpu/drm/i915/i915_perf.c              |  8 ++-
 drivers/gpu/drm/scheduler/sched_main.c        |  2 +-
 drivers/gpu/drm/v3d/v3d_sched.c               |  2 +-
 drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
 drivers/hsi/hsi_core.c                        |  2 +-
 drivers/infiniband/core/cm.c                  |  5 +-
 drivers/infiniband/core/cq.c                  |  4 +-
 drivers/infiniband/core/iwpm_util.h           |  2 +-
 drivers/infiniband/core/sa_query.c            |  3 +-
 drivers/infiniband/core/verbs.c               |  4 +-
 drivers/infiniband/sw/rdmavt/ah.c             |  2 +-
 drivers/infiniband/sw/rdmavt/mcast.c          | 12 ++--
 drivers/infiniband/sw/rdmavt/qp.c             |  8 +--
 drivers/infiniband/ulp/iser/iscsi_iser.c      |  2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_encap.h  |  2 +-
 .../ulp/opa_vnic/opa_vnic_vema_iface.c        |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h         |  2 +-
 drivers/media/dvb-frontends/ascot2e.h         |  2 +-
 drivers/media/dvb-frontends/cxd2820r.h        |  2 +-
 drivers/media/dvb-frontends/drxk.h            |  2 +-
 drivers/media/dvb-frontends/dvb-pll.h         |  2 +-
 drivers/media/dvb-frontends/helene.h          |  4 +-
 drivers/media/dvb-frontends/horus3a.h         |  2 +-
 drivers/media/dvb-frontends/ix2505v.h         |  4 +-
 drivers/media/dvb-frontends/m88ds3103.h       |  2 +-
 drivers/media/dvb-frontends/mb86a20s.h        |  2 +-
 drivers/media/dvb-frontends/stb6000.h         |  2 +-
 drivers/media/dvb-frontends/tda826x.h         |  2 +-
 drivers/media/dvb-frontends/zl10036.h         |  4 +-
 drivers/misc/mei/bus.c                        |  2 +-
 drivers/mtd/nand/raw/nand_bbt.c               |  2 +-
 drivers/net/phy/mdio_bus.c                    |  2 +-
 drivers/net/phy/phy-c45.c                     |  2 +-
 drivers/net/phy/phy.c                         |  2 +-
 drivers/net/phy/phy_device.c                  |  2 +-
 drivers/net/phy/phylink.c                     |  2 +-
 drivers/parport/share.c                       |  2 +-
 drivers/pci/p2pdma.c                          | 10 +--
 drivers/pci/pci-driver.c                      |  4 +-
 drivers/pci/pci.c                             |  2 +-
 drivers/pci/probe.c                           |  4 +-
 drivers/pci/slot.c                            |  5 +-
 drivers/pnp/core.c                            |  4 +-
 drivers/rapidio/rio.c                         |  2 +-
 drivers/regulator/core.c                      |  2 +-
 drivers/scsi/iscsi_tcp.c                      |  4 +-
 drivers/scsi/libiscsi.c                       |  2 +-
 drivers/scsi/scsi_devinfo.c                   |  3 +-
 drivers/scsi/scsi_lib.c                       |  6 +-
 drivers/scsi/scsi_transport_fc.c              |  2 +-
 drivers/slimbus/slimbus.h                     |  2 +-
 drivers/spi/spi.c                             |  6 +-
 .../staging/media/ipu3/include/intel-ipu3.h   |  8 +--
 drivers/uio/uio.c                             |  4 +-
 drivers/usb/dwc3/core.c                       |  2 +-
 drivers/usb/dwc3/core.h                       |  2 +-
 drivers/usb/gadget/composite.c                |  2 +-
 drivers/usb/typec/mux.c                       |  2 +-
 drivers/video/fbdev/core/fbcmap.c             |  2 +-
 drivers/video/hdmi.c                          |  3 +-
 drivers/vme/vme.c                             |  4 +-
 fs/dcache.c                                   | 72 +++++++++----------
 fs/inode.c                                    |  4 +-
 fs/jbd2/journal.c                             | 34 ++++-----
 fs/jbd2/transaction.c                         | 31 ++++----
 fs/locks.c                                    |  2 +-
 fs/pstore/zone.c                              |  2 +-
 fs/seq_file.c                                 |  5 +-
 fs/super.c                                    | 12 ++--
 include/drm/drm_atomic_helper.h               |  4 +-
 include/drm/drm_connector.h                   |  2 +-
 include/drm/drm_device.h                      |  2 +-
 include/drm/drm_dsc.h                         |  3 +-
 include/drm/drm_gem_vram_helper.h             |  8 +--
 include/drm/drm_print.h                       | 20 +++++-
 include/linux/clk.h                           |  2 +-
 include/linux/completion.h                    | 10 ++-
 include/linux/connector.h                     |  2 +-
 include/linux/device/class.h                  | 14 ++++
 include/linux/edac.h                          |  4 +-
 .../firmware/intel/stratix10-svc-client.h     | 10 +--
 include/linux/hrtimer.h                       |  6 +-
 include/linux/iio/trigger.h                   |  2 +-
 include/linux/jbd2.h                          |  2 +-
 include/linux/list.h                          |  2 +-
 include/linux/memblock.h                      |  4 +-
 include/linux/mtd/rawnand.h                   |  3 +-
 include/linux/netdevice.h                     | 11 ++-
 include/linux/parport.h                       | 31 ++++++++
 include/linux/refcount.h                      |  2 +-
 include/linux/uio_driver.h                    | 16 +++++
 include/linux/usb/composite.h                 |  2 +-
 include/linux/w1.h                            |  2 +-
 include/media/dvbdev.h                        |  2 +-
 include/media/v4l2-ctrls.h                    |  2 +-
 include/media/v4l2-dev.h                      |  4 +-
 include/media/v4l2-device.h                   |  2 +-
 include/media/v4l2-dv-timings.h               |  2 +-
 include/media/v4l2-fwnode.h                   |  2 +-
 include/media/v4l2-mediabus.h                 |  6 +-
 include/media/v4l2-subdev.h                   |  2 +-
 include/media/videobuf2-core.h                |  2 +-
 include/net/cfg80211.h                        |  9 +--
 include/net/mac80211.h                        |  7 +-
 include/rdma/ib_verbs.h                       | 11 +++
 include/sound/core.h                          |  3 +-
 include/sound/pcm.h                           |  4 +-
 include/uapi/drm/amdgpu_drm.h                 |  2 +-
 include/uapi/sound/compress_offload.h         |  2 +-
 kernel/audit.c                                |  2 +-
 kernel/irq/chip.c                             |  2 +-
 kernel/irq/generic-chip.c                     |  2 +-
 kernel/resource.c                             | 24 ++++---
 kernel/sched/core.c                           | 16 ++---
 kernel/sched/fair.c                           |  3 +-
 kernel/time/hrtimer.c                         |  2 +-
 lib/crc7.c                                    |  2 +-
 mm/gup.c                                      | 24 ++++---
 mm/page_alloc.c                               | 16 ++---
 mm/truncate.c                                 | 10 ++-
 net/core/datagram.c                           |  2 +-
 net/core/dev.c                                |  4 +-
 net/core/skbuff.c                             |  2 +-
 net/ethernet/eth.c                            |  6 +-
 net/mac80211/sta_info.h                       |  9 ++-
 net/sunrpc/rpc_pipe.c                         |  3 +-
 scripts/kernel-doc                            | 64 ++++++++++++-----
 sound/core/control.c                          |  4 +-
 sound/core/pcm_dmaengine.c                    |  3 +-
 sound/core/pcm_lib.c                          |  2 +-
 sound/core/pcm_native.c                       |  4 +-
 sound/soc/soc-core.c                          |  2 +-
 sound/soc/soc-dapm.c                          |  2 +-
 tools/testing/selftests/kselftest_harness.h   | 66 ++++++++---------
 161 files changed, 558 insertions(+), 382 deletions(-)

-- 
2.26.2


