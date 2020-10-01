Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9227F92B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJAF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAF4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:56:38 -0400
Received: from localhost (unknown [122.167.37.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB9821D80;
        Thu,  1 Oct 2020 05:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601531797;
        bh=LfDAticihhVf1qC7wEBp14UNi5/S+4ZD+yJN+ha0bqE=;
        h=Date:From:To:Cc:Subject:From;
        b=hrMWxcrunf2EdODMOaKcOn57tFlMm63J1t0bvNouD/95/NdyhHFepmXBmgRDiogty
         ExyEinr67AE7MXF6gOkGYc6EbZEH1PX/BfEQHkAdzeyfWs0CiHkEWnrwR4pNxj3rKp
         EzLsX6zJ2eSv6UC9nAsNRTI/fXylm1e8qRXBX7WU=
Date:   Thu, 1 Oct 2020 11:26:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.10-rc1
Message-ID: <20201001055632.GQ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please pull to receive updates for soundwire subsystem.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.10-rc1

for you to fetch changes up to 0173f525b2c1b02a51784e2119d434593235aed1:

  soundwire: sysfs: add slave status and device number before probe (2020-0=
9-28 11:17:43 +0530)

----------------------------------------------------------------
soundwire updates for 5.10-rc1

This round of update includes:
 - Generic bandwidth allocation algorithm from Intel folks
 - PM support for Intel chipsets
 - Updates to Intel drivers which makes sdw usable on latest laptops
 - Support for MMIO SDW controllers found in QC chipsets
 - Update to subsystem to use helpers in bitfield.h to manage register
   bits

----------------------------------------------------------------
Bard Liao (4):
      soundwire: master: enable pm runtime
      soundwire: intel: reinitialize IP+DSP in .prepare(), but only when re=
suming
      soundwire: intel: fix intel_suspend/resume defined but not used warni=
ng
      soundwire: Add generic bandwidth allocation algorithm

Dan Carpenter (1):
      soundwire: remove an unnecessary NULL check

Jonathan Marek (5):
      soundwire: qcom: fix abh/ahb typo
      soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
      soundwire: qcom: add support for mmio soundwire master devices
      soundwire: qcom: add v1.5.1 compatible
      soundwire: qcom: fix SLIBMUS/SLIMBUS typo

Pierre-Louis Bossart (39):
      soundwire: intel: Add basic power management support
      soundwire: intel: add pm_runtime support
      soundwire: intel: reset pm_runtime status during system resume
      soundwire: intel: fix race condition on system resume
      soundwire: intel: call helper to reset Slave states on resume
      soundwire: intel: pm_runtime idle scheduling
      soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
      soundwire: intel: add CLK_STOP_NOT_ALLOWED support
      soundwire: intel_init: handle power rail dependencies for clock stop =
mode
      soundwire: intel: support clock_stop mode without quirks
      ASoC: codecs: soundwire: remove port_ready[] usage from codecs.
      soundwire: add definition for maximum number of ports
      soundwire: fix port_ready[] dynamic allocation in mipi_disco
      soundwire: intel: disable shim wake on suspend
      soundwire: intel: ignore software command retries
      soundwire: intel: add multi-link support
      soundwire: intel: add missing support for all clock stop modes
      soundwire: bus: update multi-link definition with hw sync details
      soundwire: intel: add multi-link hw_synchronization information
      soundwire: stream: enable hw_sync as needed by hardware
      soundwire: intel: add error log for clock-stop invalid configs
      soundwire: intel: pass link_mask information to each master
      soundwire: intel: don't manage link power individually
      soundwire: stream: fix NULL/IS_ERR confusion
      soundwire: intel: fix NULL/ERR_PTR confusion
      soundwire: intel: remove .trigger operation
      soundwire: intel: remove stream handling from .prepare and .hw_free
      soundwire: cadence: fix race condition between suspend and Slave devi=
ce alerts
      ASoC/soundwire: bus: use property to set interrupt masks
      soundwire: bus: filter-out unwanted interrupt reports
      soundwire: slave: add first_interrupt_done status
      soundwire: bus: use quirk to filter out invalid parity errors
      ASoC: codecs: realtek-soundwire: ignore initial PARITY errors
      soundwire: bus: export broadcast read/write capability for tests
      soundwire: cadence: add parity error injection through debugfs
      soundwire: enable Data Port test modes
      soundwire: intel: enable test modes
      soundwire: cadence: add data port test fail interrupt
      soundwire: sysfs: add slave status and device number before probe

Rander Wang (2):
      soundwire: intel: add CLK_STOP_BUS_RESET support
      soundwire: intel: refine runtime pm for SDW_INTEL_CLK_STOP_BUS_RESET

Srinivas Kandagatla (4):
      soundwire: qcom: clear BIT FIELDs before value set.
      soundwire: qcom: add support to block packing mode
      soundwire: qcom: get max rows and cols info from compatible
      soundwire: bus: add enumerated Slave device to device list

Vinod Koul (11):
      soundwire: define and use addr bit masks
      soundwire: bus: use FIELD_GET()
      soundwire: slave: use SDW_DISCO_LINK_ID()
      soundwire: stream: use FIELD_{GET|PREP}
      soundwire: qcom : use FIELD_{GET|PREP}
      soundwire: cadence: use FIELD_{GET|PREP}
      soundwire: intel: use FIELD_{GET|PREP}
      soundwire: intel_init: use FIELD_{GET|PREP}
      soundwire: remove SDW_REG_SHIFT()
      soundwire: cadence: use u32p_replace_bits
      soundwire: intel: use {u32|u16}p_replace_bits

 .../ABI/testing/sysfs-bus-soundwire-slave          |  18 +
 .../devicetree/bindings/soundwire/qcom,sdw.txt     |   1 +
 drivers/soundwire/Kconfig                          |   7 +-
 drivers/soundwire/Makefile                         |   3 +
 drivers/soundwire/bus.c                            | 120 ++-
 drivers/soundwire/bus.h                            |  52 +-
 drivers/soundwire/bus_type.c                       |   9 +
 drivers/soundwire/cadence_master.c                 | 199 ++++-
 drivers/soundwire/cadence_master.h                 |   5 +
 drivers/soundwire/generic_bandwidth_allocation.c   | 425 +++++++++++
 drivers/soundwire/intel.c                          | 803 +++++++++++++++++=
+---
 drivers/soundwire/intel.h                          |   4 +
 drivers/soundwire/intel_init.c                     |  22 +-
 drivers/soundwire/master.c                         |   2 +
 drivers/soundwire/mipi_disco.c                     |  18 +-
 drivers/soundwire/qcom.c                           | 118 ++-
 drivers/soundwire/slave.c                          |  13 +-
 drivers/soundwire/stream.c                         |  45 +-
 drivers/soundwire/sysfs_local.h                    |   4 +
 drivers/soundwire/sysfs_slave.c                    |  58 +-
 include/linux/soundwire/sdw.h                      |  48 +-
 include/linux/soundwire/sdw_registers.h            |   7 -
 sound/soc/codecs/max98373-sdw.c                    |  18 +-
 sound/soc/codecs/rt1308-sdw.c                      |  17 +-
 sound/soc/codecs/rt5682-sdw.c                      |  20 +-
 sound/soc/codecs/rt700-sdw.c                       |  20 +-
 sound/soc/codecs/rt711-sdw.c                       |  20 +-
 sound/soc/codecs/rt715-sdw.c                       |  38 +-
 sound/soc/codecs/wsa881x.c                         |   1 +
 29 files changed, 1763 insertions(+), 352 deletions(-)
 create mode 100644 drivers/soundwire/generic_bandwidth_allocation.c

Thanks
--=20
~Vinod

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl91b5AACgkQfBQHDyUj
g0crjA//ZBmJBlan9jJkx/LDJ6vOdvhJZ2+q88JSRr+xvUPSFx+n1k+6ve/4F6zP
ZWJwUVm3S30+1JSKF5NHudAVzvo3/CJjs6KrN+z+OYxi0KHdWo6kILPzb+h3jGXz
jaE4VE5m1Zsw52ZIw0CKvHX2yNejEKVSXs9+CLtbUeVAwIBo7PXi0WTaYrzIeDnE
No0gvdUeN5nO8wbDzsTux2PjYz2SRMDzPeUzPMcE7qEmiIALh2WbbAmIdZdy3VZ7
Uz2v5bGh0OoZ5sAU6gqTtKRNuMOWF8SvYqPcNGwN2yAVnh8L08nQNiNi2F/fyIMq
Kyj0ZxL3sW6Z8nf5nmGADgj0YKZ75+oN2NVhyr7BA8FL4HRD6MqFbsXaPaAqG9is
jSmon4BYwdOHznU3ubK2ZNPgNJ4dftvZUAwVfQ+Niw1DsrCmHFxeCkV8KHvuwUTw
Eicp/JA3zGGDy6fHZkSx22dndg1w/Hx/tHWhEHX0lblN1NxnGAzD8t+uzs/+ljRa
KNFMMh1o23u644Tp3vQfnhR3HrrdVXQwT4HtsAqAzddJ+MXotUo6FNxJXir9fYHG
QSPb2r0dhx6QVdKZ4k87gCwD2zMaEVxXalxtRIS3WZmzRj54C5J5Cpzdl8unETFr
KPSgPtNgXIAbzTCBARx2hTR/thwBxOhJGos5rFz4WfO3yOqkQC8=
=GaGq
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
