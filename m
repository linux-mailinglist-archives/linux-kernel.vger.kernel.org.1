Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134A12DA18C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503313AbgLNU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503222AbgLNU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:29:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6EC0613D3;
        Mon, 14 Dec 2020 12:28:44 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B3A32C1;
        Mon, 14 Dec 2020 20:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B3A32C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607977724; bh=ieJvaqrG7h80O/UEWlZGAg2uGrm87Ckk1N9AqoObOiM=;
        h=Date:From:To:Cc:Subject:From;
        b=QlRoDcRsMQ9XHxYvojboaA9lX86sbwx7laa7D6VoFvMsYYxuilRyr2lLYSD+hTJXF
         Sz0seBJdCSiA5+6WU269tpiQi4hK41v76RsSgy8KZYrFemH5aA0hayXZYXu2hedRGP
         l1/EOhLSK1uq2Wl2lBdfdrvh1XZdcOycx3zD6vPFh+DSgKefPN1dTtHMJxLeKDw+0P
         EdFLV2MdoALrNHd6knVTPcfdTH4eE/WNrcxMRVGGc7ZHjpavdfOWEpsGum9YbYQDAj
         DIseUOVOADymh5lRIRuItOlp3eD0kyda081T75r42kLVDP3kOmf4XrMX1vAk2QqwSz
         KHSe2n8ZkuyZg==
Date:   Mon, 14 Dec 2020 13:28:43 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.11
Message-ID: <20201214132843.5dd09ec3@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.11

for you to fetch changes up to 47e44ed01434e51e2e42b188482d837c01e5d16e:

  docs: fix broken cross reference in translations/zh_CN (2020-12-14 13:14:22 -0700)

----------------------------------------------------------------
A much quieter cycle for documentation (happily), with, one hopes, the bulk
of the churn behind us.  Significant stuff in this pull includes:

 - A set of new Chinese translations
 - Italian translation updates
 - A mechanism from Mauro to automatically format Documentation/features
   for the built docs
 - Automatic cross references without explicit :ref: markup
 - A new reset-controller document
 - An extensive new document on reporting problems from Thorsten

That last patch also adds the CC-BY-4.0 license to LICENSES/dual; there was
some discussion on this, but we seem to have consensus and an ack from Greg
for that addition.

----------------------------------------------------------------
Aditya Srivastava (1):
      Documentation: include sign off for reverts

Andrew Klychkov (5):
      Documentation: fix typos in dev-tools/kasan.rst
      Documentation: fix typos in process/kernel-docs.rst
      Documentation: fix typos found in process, dev-tools, and doc-guide subdirectories
      Documentation: fix typos found in admin-guide subdirectory
      Documentation: fix multiple typos found in the admin-guide subdirectory

Andy Shevchenko (1):
      scripts: kernel-doc: Restore anonymous enum parsing

Artem Bityutskiy (1):
      docs: trace: fix event state structure name

Bailu Lin (2):
      Documentation: Chinese translation of Documentation/arm64/perf.rst
      Documentation: Chinese translation of Documentation/arm64/elf_hwcaps.rst

Barry Song (1):
      Documentation/admin-guide: mark memmap parameter is supported by a few architectures

Ben Widawsky (1):
      kernel-doc: Fix example in Nested structs/unions

Casey Schaufler (1):
      docs: ABI: ABI documentation for procfs attribute files used by multiple LSMs

Federico Vaga (1):
      doc:it_IT: align Italian documentation

Geert Uytterhoeven (2):
      docs: core-api/printk-formats.rst: Clarify formatting {cpu,node}mask
      docs: ABI: Drop trailing whitespace

JaeSang Yoo (1):
      docs: update requirements to install six module

Jonathan Corbet (2):
      docs: Note that sphinx 1.7 will be required soon
      docs: fix broken cross reference in translations/zh_CN

Jonathan Neuschäfer (3):
      docs: driver-api: mtd: intel-spi: Improve formatting of shell commands
      docs: filesystems: link ubifs-authentication.rst without .rst extension
      docs: mtd: spi-nor: Fix formatting of text vs. diagrams

Mathieu Chouquet-Stringer (1):
      docs: Update documentation to reflect what TAINT_CPU_OUT_OF_SPEC means

Mauro Carvalho Chehab (11):
      scripts: get_feat.pl: add a script to handle Documentation/features
      scripts: get_feat.pl: improve matrix output
      scripts: get_feat.pl: use its implementation for list-arch.sh
      sphinx: kernel_feat.py: add a script to parse feature files
      docs: admin-guide: add a features list
      docs: archis: add a per-architecture features list
      scripts: kernel-doc: fix parsing function-like typedefs
      scripts: get_feat.pl: make complete table more coincise
      scripts: get_feat.pl: change the group by order
      scripts: get_feat.pl: reduce table width for all features output
      docs: nios2: add missing ReST file

Nícolas F. R. A. Prado (2):
      docs: automarkup.py: Allow automatic cross-reference inside C namespace
      docs: dt: Use full path to enable cross-reference

Philipp Zabel (1):
      docs: add a reset controller chapter to the driver API docs

Randy Dunlap (1):
      Documentation: mount_api: change kernel log wording

Stephen Kitt (1):
      docs: clean up sysctl/kernel: titles, version

Sumera Priyadarsini (1):
      Documentation: Coccinelle: Improve command example for debugging patches

Szabolcs Nagy (1):
      Documentation: document /proc api for arm64 MTE vm flags

Thorsten Leemhuis (4):
      LICENSES: Add the CC-BY-4.0 license
      docs: Add a new text describing how to report bugs
      docs: make reporting-bugs.rst obsolete
      docs: reporting-issues: move 'outdated, need help' note to proper place

Tiezhu Yang (1):
      Documentation: kgdb: Fix a typo

Wang Qing (2):
      doc: zh_CN: add translatation for tmpfs
      doc: zh_CN: add tmpfs to index tree

Wei Li (1):
      Documentation/features: Update feature lists for 5.10

Wilken Gottwalt (1):
      documentation: arm: sunxi: add Allwinner H616 documents

 Documentation/ABI/testing/configfs-usb-gadget-ecm  |    2 +-
 Documentation/ABI/testing/procfs-attr-current      |   20 +
 Documentation/ABI/testing/procfs-attr-exec         |   20 +
 Documentation/ABI/testing/procfs-attr-prev         |   19 +
 Documentation/ABI/testing/sysfs-devices-memory     |    2 +-
 Documentation/ABI/testing/sysfs-fs-ext4            |    2 +-
 Documentation/ABI/testing/sysfs-module             |    2 +-
 .../ABI/testing/sysfs-platform-renesas_usb3        |    2 +-
 Documentation/admin-guide/README.rst               |    4 +-
 Documentation/admin-guide/acpi/cppc_sysfs.rst      |    4 +-
 Documentation/admin-guide/binderfs.rst             |    2 +-
 Documentation/admin-guide/blockdev/paride.rst      |    2 +-
 Documentation/admin-guide/blockdev/zram.rst        |    2 +-
 Documentation/admin-guide/bug-bisect.rst           |    2 +-
 Documentation/admin-guide/bug-hunting.rst          |    2 +-
 Documentation/admin-guide/cifs/introduction.rst    |    2 +-
 Documentation/admin-guide/cifs/usage.rst           |    6 +-
 .../admin-guide/device-mapper/dm-crypt.rst         |    4 +-
 .../admin-guide/device-mapper/dm-integrity.rst     |    4 +-
 .../admin-guide/device-mapper/dm-raid.rst          |    2 +-
 .../admin-guide/device-mapper/dm-zoned.rst         |    6 +-
 Documentation/admin-guide/device-mapper/verity.rst |    2 +-
 .../admin-guide/device-mapper/writecache.rst       |    4 +-
 Documentation/admin-guide/features.rst             |    3 +
 .../admin-guide/hw-vuln/tsx_async_abort.rst        |    2 +-
 Documentation/admin-guide/index.rst                |    4 +-
 Documentation/admin-guide/kernel-parameters.rst    |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/admin-guide/md.rst                   |    2 +-
 Documentation/admin-guide/media/bttv.rst           |    2 +-
 Documentation/admin-guide/media/dvb_references.rst |    2 +-
 .../admin-guide/media/frontend-cardlist.rst        |    4 +-
 Documentation/admin-guide/media/gspca-cardlist.rst |    2 +-
 Documentation/admin-guide/media/ipu3.rst           |    6 +-
 .../admin-guide/media/remote-controller.rst        |    2 +-
 Documentation/admin-guide/mm/index.rst             |    4 +-
 Documentation/admin-guide/mm/numaperf.rst          |    2 +-
 Documentation/admin-guide/mm/userfaultfd.rst       |    2 +-
 Documentation/admin-guide/module-signing.rst       |    2 +-
 Documentation/admin-guide/perf/imx-ddr.rst         |    2 +-
 .../admin-guide/pm/intel-speed-select.rst          |    4 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |    6 +-
 Documentation/admin-guide/ramoops.rst              |    2 +-
 Documentation/admin-guide/reporting-bugs.rst       |    5 +
 Documentation/admin-guide/reporting-issues.rst     | 1631 ++++++++++++++++++++
 Documentation/admin-guide/security-bugs.rst        |    2 +-
 Documentation/admin-guide/sysctl/abi.rst           |    2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |   18 +-
 Documentation/admin-guide/sysctl/vm.rst            |    2 +-
 Documentation/admin-guide/tainted-kernels.rst      |   23 +-
 Documentation/arm/features.rst                     |    3 +
 Documentation/arm/index.rst                        |    2 +
 Documentation/arm/sunxi.rst                        |   10 +
 Documentation/arm64/elf_hwcaps.rst                 |    2 +
 Documentation/arm64/features.rst                   |    3 +
 Documentation/arm64/index.rst                      |    2 +
 Documentation/arm64/perf.rst                       |    2 +
 Documentation/conf.py                              |    5 +-
 Documentation/core-api/printk-formats.rst          |    4 +-
 Documentation/dev-tools/coccinelle.rst             |    9 +-
 Documentation/dev-tools/kasan.rst                  |    4 +-
 Documentation/dev-tools/kcov.rst                   |    2 +-
 Documentation/dev-tools/kgdb.rst                   |    7 +-
 .../devicetree/bindings/submitting-patches.rst     |    3 +-
 Documentation/doc-guide/kernel-doc.rst             |    6 +-
 Documentation/doc-guide/sphinx.rst                 |    2 +-
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/mtd/intel-spi.rst         |    4 +-
 Documentation/driver-api/mtd/spi-nor.rst           |    6 +-
 Documentation/driver-api/reset.rst                 |  221 +++
 Documentation/features/list-arch.sh                |   17 +-
 .../locking/queued-rwlocks/arch-support.txt        |    2 +-
 .../locking/queued-spinlocks/arch-support.txt      |    2 +-
 .../seccomp/seccomp-filter/arch-support.txt        |    4 +-
 .../time/context-tracking/arch-support.txt         |    2 +-
 .../features/time/virt-cpuacct/arch-support.txt    |    2 +-
 Documentation/filesystems/index.rst                |    2 +-
 Documentation/filesystems/mount_api.rst            |    4 +-
 Documentation/filesystems/proc.rst                 |    1 +
 Documentation/ia64/features.rst                    |    3 +
 Documentation/ia64/index.rst                       |    2 +
 Documentation/index.rst                            |    2 +-
 Documentation/m68k/features.rst                    |    3 +
 Documentation/m68k/index.rst                       |    2 +
 Documentation/mips/features.rst                    |    3 +
 Documentation/mips/index.rst                       |    2 +
 .../device_drivers/ethernet/3com/vortex.rst        |    4 +-
 Documentation/nios2/features.rst                   |    3 +
 Documentation/nios2/index.rst                      |   12 +
 Documentation/openrisc/features.rst                |    3 +
 Documentation/openrisc/index.rst                   |    2 +
 Documentation/parisc/features.rst                  |    3 +
 Documentation/parisc/index.rst                     |    2 +
 Documentation/powerpc/features.rst                 |    3 +
 Documentation/powerpc/index.rst                    |    2 +
 Documentation/process/clang-format.rst             |    2 +-
 .../process/embargoed-hardware-issues.rst          |    2 +-
 Documentation/process/howto.rst                    |    9 +-
 Documentation/process/kernel-docs.rst              |    4 +-
 Documentation/process/submitting-patches.rst       |    2 +
 Documentation/riscv/features.rst                   |    3 +
 Documentation/riscv/index.rst                      |    2 +
 Documentation/s390/features.rst                    |    3 +
 Documentation/s390/index.rst                       |    2 +
 Documentation/sh/features.rst                      |    3 +
 Documentation/sh/index.rst                         |    2 +
 Documentation/sparc/features.rst                   |    3 +
 Documentation/sparc/index.rst                      |    2 +
 Documentation/sphinx/automarkup.py                 |  122 +-
 Documentation/sphinx/kernel_feat.py                |  169 ++
 Documentation/sphinx/requirements.txt              |    1 +
 Documentation/trace/events.rst                     |   10 +-
 .../translations/it_IT/doc-guide/kernel-doc.rst    |   30 +-
 .../translations/it_IT/doc-guide/sphinx.rst        |   20 +
 .../translations/it_IT/process/2.Process.rst       |    4 +-
 .../translations/it_IT/process/changes.rst         |   22 +-
 .../translations/it_IT/process/coding-style.rst    |   26 +-
 .../translations/it_IT/process/deprecated.rst      |  147 +-
 .../translations/it_IT/process/email-clients.rst   |    5 +
 .../it_IT/process/programming-language.rst         |    8 +-
 .../it_IT/process/submitting-patches.rst           |  297 +---
 .../translations/zh_CN/arm64/elf_hwcaps.rst        |  240 +++
 Documentation/translations/zh_CN/arm64/index.rst   |    2 +
 Documentation/translations/zh_CN/arm64/perf.rst    |   86 ++
 .../translations/zh_CN/filesystems/index.rst       |    1 +
 .../translations/zh_CN/filesystems/tmpfs.rst       |  146 ++
 Documentation/x86/features.rst                     |    3 +
 Documentation/x86/index.rst                        |    1 +
 Documentation/xtensa/features.rst                  |    3 +
 Documentation/xtensa/index.rst                     |    2 +
 LICENSES/dual/CC-BY-4.0                            |  410 +++++
 MAINTAINERS                                        |    1 +
 scripts/get_feat.pl                                |  630 ++++++++
 scripts/kernel-doc                                 |    4 +-
 tools/debugging/kernel-chktaint                    |    2 +-
 135 files changed, 4228 insertions(+), 444 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-current
 create mode 100644 Documentation/ABI/testing/procfs-attr-exec
 create mode 100644 Documentation/ABI/testing/procfs-attr-prev
 create mode 100644 Documentation/admin-guide/features.rst
 create mode 100644 Documentation/admin-guide/reporting-issues.rst
 create mode 100644 Documentation/arm/features.rst
 create mode 100644 Documentation/arm64/features.rst
 create mode 100644 Documentation/driver-api/reset.rst
 create mode 100644 Documentation/ia64/features.rst
 create mode 100644 Documentation/m68k/features.rst
 create mode 100644 Documentation/mips/features.rst
 create mode 100644 Documentation/nios2/features.rst
 create mode 100644 Documentation/nios2/index.rst
 create mode 100644 Documentation/openrisc/features.rst
 create mode 100644 Documentation/parisc/features.rst
 create mode 100644 Documentation/powerpc/features.rst
 create mode 100644 Documentation/riscv/features.rst
 create mode 100644 Documentation/s390/features.rst
 create mode 100644 Documentation/sh/features.rst
 create mode 100644 Documentation/sparc/features.rst
 create mode 100644 Documentation/sphinx/kernel_feat.py
 create mode 100644 Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
 create mode 100644 Documentation/translations/zh_CN/arm64/perf.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/tmpfs.rst
 create mode 100644 Documentation/x86/features.rst
 create mode 100644 Documentation/xtensa/features.rst
 create mode 100644 LICENSES/dual/CC-BY-4.0
 create mode 100755 scripts/get_feat.pl
