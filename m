Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9FA28C17F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbgJLTao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:30:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:51974 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387595AbgJLTao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:30:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E13372CA;
        Mon, 12 Oct 2020 19:30:43 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:30:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.10
Message-ID: <20201012133042.688ee6a6@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
92001bc0365a144783f8f3108be94e74baf61011:

  Documentation: laptops: thinkpad-acpi: fix underline length build warning (2020-08-24 17:19:07 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.10

for you to fetch changes up to 4fb220da0dd03d3699776220d86ac84b38941c0c:

  gpiolib: Update indentation in driver.rst for code excerpts (2020-10-12 13:15:34 -0600)

----------------------------------------------------------------
As hoped, things calmed down for docs this cycle; fewer changes and almost
no conflicts at all.  This pull includes:

 - A reworked and expanded user-mode Linux document
 - Some simplifications and improvements for submitting-patches.rst
 - An emergency fix for (some) problems with Sphinx 3.x
 - Some welcome automarkup improvements to automatically generate
   cross-references to struct definitions and other documents
 - The usual collection of translation updates, typo fixes, etc.

NOTE that there will be a largish  late-window pull request coming,
probably directly from Mauro.  Sphinx 3.x has broken a bunch of things,
which is obnoxious, though the end result is better; fixing the problems
requires a number of cross-tree documentation tweaks.  These are best done
toward the end to avoid creating unnecessary conflicts with other trees.
---------------------------------------------------------------- 

Andrew Cooper (1): docs/ia64: Drop obsolete Xen documentation

Andy Shevchenko (1):
      gpiolib: Update indentation in driver.rst for code excerpts

Anton Ivanov (1):
      docs: replace the old User Mode Linux HowTo with a new one

Bailu Lin (2):
      doc: zh_CN: index files in arm64 subdirectory
      Documentation: Chinese translation of Documentation/arm64/amu.rst

Barry Song (1):
      Documentation: core-api/cpu_hotplug: fix a typo

Bhaskar Chowdhury (4):
      docs: fb: Remove framebuffer scrollback boot option
      docs: fb: Remove matroxfb scrollback boot option
      docs: fb: Remove sstfb scrollback boot option
      docs: fb: Remove vesafb scrollback boot option

Coly Li (2):
      docs: trusted-encrypted.rst: update parameters for command examples
      bcache: doc: update Documentation/admin-guide/bcache.rst

Connor Kuehl (1):
      docs: kvm: fix referenced ioctl symbol

Dave Hansen (1):
      Documentation: clarify driver licensing rules

Denis Efremov (2):
      Documentation: remove current_security() reference
      docs: filesystems: replace to_dev() with kobj_to_dev()

Drew DeVault (4):
      submitting-patches.rst: remove heading numbering
      Documentation/process: expand plain-text advice
      Documentation/maintainer: rehome sign-off process
      submitting-patches.rst: presume git will be used

Gustavo A. R. Silva (1):
      docs: deprecated.rst: Update zero-length/one-element arrays section

Javier Garcia (1):
      Documentation: process: step 2: Link to email list fixed.

Joe Perches (1):
      deprecated.rst: Remove now removed uninitialized_var

John Hubbard (1):
      Documentation: better locations for sysfs-pci, sysfs-tagging

Jonathan Cameron (1):
      kernel-doc: add support for ____cacheline_aligned attribute

Jonathan Corbet (1):
      Make the docs build "work" with Sphinx 3.x

Jonathan Neuschäfer (2):
      MAINTAINERS: Add ubifs-authentication.rst to UBIFS
      docs: ubifs-authentication: Add a top-level heading

Krzysztof Kozlowski (1):
      docs: process: Add cross-link to security-bugs

Lars Poeschel (1):
      Documentation: iio: fix a typo

Li Qiang (1):
      Documentation: kvm: fix a typo

Mark Starovoytov (1):
      mailmap: add entry for <mstarovoitov@marvell.com>

Mauro Carvalho Chehab (14):
      .gitignore: docs: ignore sphinx_*/ directories
      kernel-doc: include line numbers for function prototypes
      docs: scheduler: fix the directory name on two files
      docs: trace: fix the location of kprobes.rst
      MAINTAINERS: fix location of qlogic/LICENSE.qla3xxx
      scripts: device_attr_show.cocci: update location of sysfs doc
      docs: add some new files to their respective index.rst files
      docs: watch_queue: fix some warnings
      docs: kvm: api.rst: add missing spaces
      docs: soundwire: fix some identation at stream.rst
      docs: dma-buf: fix some warnings
      docs: submitting-patches: use :doc: for references
      iio: iio.h: fix a warning at the kernel-doc markup
      docs: trace: ring-buffer-design.rst: use the new SPDX tag

Naoki Hayama (1):
      Documentation/admin-guide: tainted-kernels: Fix typo occured

NeilBrown (1):
      doc: seq_file: clarify role of *pos in ->next()

Nick Desaulniers (2):
      Documentation: add minimum clang/llvm version
      docs: programming-languages: refresh blurb on clang support

Nícolas F. R. A. Prado (5):
      docs: Add automatic cross-reference for C types
      kernel-doc: Update "cross-referencing from rST" section to use automarkup
      docs: Allow multiple automarkup functions
      docs: Add automatic cross-reference for documentation pages
      docs: Document cross-referencing between documentation pages

Ralph Campbell (2):
      mm/doc: editorial pass on page migration
      mm/doc: add usage description for migrate_vma_*()

Randy Dunlap (10):
      Documentation: submit-checklist: add clean builds for new Documentation
      Documentation: filesystems: mount_api: fix headings
      Documentation: kernel-parameters: fix formatting of MIPS "machtype"
      Documentation/admin-guide: kernel-parameters: fix "disable_ddw" wording
      Documentation/admin-guide: kernel-parameters: fix "io7" parameter description
      Documentation: admin-guide: kernel-parameters: reformat "lapic=" boot option
      Documentation/admin-guide: kernel-parameters: capitalize Korina
      Documentation/admin-guide: README & svga: remove use of "rdev"
      Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"
      Documentation: kernel-parameters: clarify "module." parameters

Satheesh Rajendran (1):
      Doc: admin-guide: Add entry for kvm_cma_resv_ratio kernel param

SeongJae Park (5):
      Documentation/kokr: bring process docs up to date
      Documentation/kokr/howto: Wordsmith
      docs/memory-barriers.txt: Fix references for DMA*.txt files
      docs/memory-barriers.txt/kokr: Remove remaining references to mmiowb()
      docs/memory-barriers.txt/kokr: Allow architecture to override the flush barrier

Stephen Boyd (1):
      docs: stable-ABI: Document /sys/kernel/notes

Stephen Kitt (3):
      docs: rewrite admin-guide/sysctl/abi.rst
      docs: rewrite admin-guide/sysctl/abi.rst
      Fix references to nommu-mmap.rst

Tian Tao (2):
      Documentation: arm64 also supports disable hugeiomap
      Documentation: Remove CMA's dependency on architecture

Wilken Gottwalt (1):
      documentation: arm: sunxi: Allwinner H2+/H3 update

lijiang (1):
      docs: admin-guide: update kdump documentation due to change of crash URL

 .gitignore                                         |    3 +
 .mailmap                                           |    1 +
 Documentation/ABI/stable/sysfs-kernel-notes        |    5 +
 Documentation/PCI/index.rst                        |    1 +
 Documentation/{filesystems => PCI}/sysfs-pci.rst   |    0
 Documentation/admin-guide/README.rst               |    6 +-
 Documentation/admin-guide/bcache.rst               |   31 +-
 Documentation/admin-guide/blockdev/ramdisk.rst     |   66 +-
 Documentation/admin-guide/cgroup-v1/cpusets.rst    |    2 +
 Documentation/admin-guide/kdump/kdump.rst          |    7 +-
 Documentation/admin-guide/kernel-parameters.txt    |   38 +-
 Documentation/admin-guide/svga.rst                 |    7 +-
 Documentation/admin-guide/sysctl/abi.rst           |   73 +-
 Documentation/admin-guide/tainted-kernels.rst      |    2 +-
 Documentation/arm/sunxi.rst                        |    2 +-
 Documentation/arm64/amu.rst                        |    2 +
 Documentation/arm64/index.rst                      |    2 +
 Documentation/conf.py                              |   15 +-
 Documentation/core-api/cpu_hotplug.rst             |    2 +-
 Documentation/doc-guide/kernel-doc.rst             |   33 +-
 Documentation/doc-guide/sphinx.rst                 |   17 +
 Documentation/driver-api/dma-buf.rst               |    2 +-
 Documentation/driver-api/gpio/driver.rst           |   12 +-
 Documentation/driver-api/nvdimm/index.rst          |    1 +
 Documentation/driver-api/soundwire/stream.rst      |    8 +-
 Documentation/fb/fbcon.rst                         |   21 +-
 Documentation/fb/matroxfb.rst                      |    2 -
 Documentation/fb/sstfb.rst                         |    3 -
 Documentation/fb/vesafb.rst                        |    2 -
 Documentation/filesystems/index.rst                |    2 -
 Documentation/filesystems/mount_api.rst            |    7 +-
 Documentation/filesystems/seq_file.rst             |   20 +-
 Documentation/filesystems/sysfs.rst                |    3 +-
 Documentation/filesystems/ubifs-authentication.rst |    6 +-
 Documentation/firmware-guide/acpi/index.rst        |    1 +
 Documentation/hwmon/index.rst                      |    1 +
 Documentation/ia64/index.rst                       |    1 -
 Documentation/ia64/xen.rst                         |  206 -
 Documentation/iio/iio_configfs.rst                 |    2 +-
 Documentation/kbuild/llvm.rst                      |    4 +
 Documentation/maintainer/index.rst                 |    1 +
 Documentation/maintainer/modifying-patches.rst     |   50 +
 Documentation/memory-barriers.txt                  |    8 +-
 Documentation/networking/index.rst                 |    1 +
 .../{filesystems => networking}/sysfs-tagging.rst  |    0
 Documentation/process/2.Process.rst                |    2 +-
 Documentation/process/changes.rst                  |   15 +
 Documentation/process/deprecated.rst               |   24 +-
 Documentation/process/email-clients.rst            |    5 +
 Documentation/process/programming-language.rst     |    9 +-
 Documentation/process/submit-checklist.rst         |    4 +
 Documentation/process/submitting-drivers.rst       |    9 +-
 Documentation/process/submitting-patches.rst       |  280 +-
 Documentation/scheduler/sched-capacity.rst         |    2 +-
 Documentation/scheduler/sched-energy.rst           |    2 +-
 Documentation/security/credentials.rst             |    1 -
 Documentation/security/keys/trusted-encrypted.rst  |    5 +-
 Documentation/sphinx/automarkup.py                 |  137 +-
 Documentation/trace/kprobetrace.rst                |    2 +-
 Documentation/trace/ring-buffer-design.rst         |   26 +-
 Documentation/translations/ko_KR/howto.rst         |    9 +-
 .../translations/ko_KR/memory-barriers.txt         |   32 +-
 Documentation/translations/zh_CN/arm64/amu.rst     |  100 +
 Documentation/translations/zh_CN/arm64/index.rst   |   16 +
 .../translations/zh_CN/filesystems/sysfs.txt       |    3 +-
 Documentation/translations/zh_CN/index.rst         |    1 +
 Documentation/virt/index.rst                       |    2 +-
 Documentation/virt/kvm/amd-memory-encryption.rst   |    6 +-
 Documentation/virt/kvm/api.rst                     |    4 +-
 Documentation/virt/kvm/cpuid.rst                   |    2 +-
 Documentation/virt/uml/user_mode_linux.rst         | 4403 --------------------
 .../virt/uml/user_mode_linux_howto_v2.rst          | 1208 ++++++
 Documentation/vm/hmm.rst                           |  139 +-
 Documentation/vm/index.rst                         |    1 +
 Documentation/vm/page_migration.rst                |  164 +-
 Documentation/watch_queue.rst                      |   14 +-
 MAINTAINERS                                        |    3 +-
 include/linux/iio/iio.h                            |    2 +-
 init/Kconfig                                       |    2 +-
 mm/Kconfig                                         |    2 +-
 mm/nommu.c                                         |    2 +-
 samples/kprobes/kprobe_example.c                   |    2 +-
 samples/kprobes/kretprobe_example.c                |    2 +-
 scripts/coccinelle/api/device_attr_show.cocci      |    2 +-
 scripts/kernel-doc                                 |    5 +-
 85 files changed, 2072 insertions(+), 5256 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-kernel-notes
 rename Documentation/{filesystems => PCI}/sysfs-pci.rst (100%)
 delete mode 100644 Documentation/ia64/xen.rst
 create mode 100644 Documentation/maintainer/modifying-patches.rst
 rename Documentation/{filesystems => networking}/sysfs-tagging.rst (100%)
 create mode 100644 Documentation/translations/zh_CN/arm64/amu.rst
 create mode 100644 Documentation/translations/zh_CN/arm64/index.rst
 delete mode 100644 Documentation/virt/uml/user_mode_linux.rst
 create mode 100644 Documentation/virt/uml/user_mode_linux_howto_v2.rst
