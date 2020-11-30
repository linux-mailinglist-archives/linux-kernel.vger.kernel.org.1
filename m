Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E412C80B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgK3JNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgK3JNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:13:50 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C112074A;
        Mon, 30 Nov 2020 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606727588;
        bh=5k8vMnz4qLBXieP9HBcz5OAw8I0dzouFVUvW/MCn9FQ=;
        h=Date:From:To:Cc:Subject:From;
        b=chT/gzCW7ZGYqI53zxV58auKl3syQqfFni3WhMwFv70PaRR+VtI5gAV/YL31xIg9H
         dDKPjX9e/7KZIME4+DQlNwtdXHDwsvqOhFeMV+TBQbFXhbKi81/B7vnKQtTovkGHv5
         zr7rYsjd9HeeXGlAGQie1kNKhRjR03YVLcK4CIAQ=
Date:   Mon, 30 Nov 2020 11:13:04 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.11-rc1
Message-ID: <20201130091304.GA17912@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs pull request for the merge window of kernel 5.11.
It contains many changes, new features, support for new firmware.
Details are in the tag.

Thanks,
Oded

The following changes since commit 3473065927a877e0a15c4d4b64f245ccaba24e3f:

  Merge 5.10-rc6 into char-misc-next (2020-11-30 08:33:06 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2020-11-30

for you to fetch changes up to f44afb5b5a5d04448da843b2fe872e01669bc317:

  habanalabs: Add CB IOCTL opcode to retrieve CB information (2020-11-30 10:47:38 +0200)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.11-rc1:

- Add support for ability to perform collective stream sync. This is basically
  a synchronization between compute and network streams.

- Add initialization of NIC QMANs and security configuration. This is a
  pre-requisite for upstreaming the NIC ETH and RDMA code.

- Add option to scrub all internal memory (SRAM and DRAM) when the user
  closes the file-descriptor

- Support new firmware that provide enhanced device security. This includes
  many changes that basically amounts to moving certain configurations to
  the firmware and stop reading registers directly and instead receiving the
  information from the firmware. For example:
  - Retrieve HBM ECC error information
  - Retrieve PLL configuration
  - Configure of internal credits, rate-limitation

- Support new firmware that performs the GAUDI device reset instead of the
  driver. The driver now asks the firmware to do it.

- Some changes were done as Pre-requisite for future ASICs support:
  - Add option to put the device's PCI MMU page tables on the host memory.
  - Support loading multiple types of firmware.
  - Adding option to user to inquire about usage counter of Command buffer.

- Support taking timestamp of Command Submission when it completes and
  providing it to the user.

- Change aggregate cs counters to atomic and fix the cs counters structure
  to support addition of new counters in the future

- Update email address nad git repo of the driver in MAINTAINERS

- Many small bug fixes and improvements, such as:
  - Refactoring in MMU code to move code from ASIC-dependant files to
    common code
  - Minimize driver prints when no errors occur
  - Using enums, defines instead of hard-coded values
  - Refactoring of Command Submission flow to make it more readable now that
    we have multiple types of Command Submissions.

----------------------------------------------------------------
Alon Mizrahi (3):
      habanalabs: firmware returns 64bit argument
      habanalabs: fetch pll frequency from firmware
      habanalabs: add ull to PLL masks

Guy Nisan (1):
      habanalabs: add boot errors prints

Igor Grinberg (1):
      habanalabs/gaudi: remove pcie_en strap toggle

Moti Haimovski (4):
      habanalabs: fix MMU print message
      habanalabs: refactor MMU to support dual residency MMU
      habanalabs: share a single ctx-mutex between all MMUs
      habanalabs: fix MMU debugfs operations

Oded Gabbay (25):
      MAINTAINERS: update email, git repo of habanalabs driver
      habanalabs: change aggregate cs counters to atomic
      habanalabs: we need CPU queues for hwmon
      habanalabs: support multiple types of firmwares
      habanalabs: minimize prints when everything is fine
      habanalabs: don't init vm module if no MMU
      habanalabs: remove duplicate check
      habanalabs/gaudi: add NIC QMAN H/W and registers definitions
      habanalabs/gaudi: add NIC firmware-related definitions
      habanalabs/gaudi: add NIC security configuration
      habanalabs/gaudi: add support for NIC QMANs
      habanalabs/gaudi: monitor device memory usage
      habanalabs: make sure cs type is valid in cs_ioctl_signal_wait
      habanalabs: initialize variable before use
      habanalabs/gaudi: increase MAX CS to 16K
      habanalabs: remove duplicate print
      habanalabs: restore vm_pgoff after mmap
      habanalabs: move asic property to correct structure
      habanalabs: print message with correct device
      habanalabs: print CS type when it is stuck
      habanalabs: update firmware files
      habanalabs/gaudi: print ECC type field
      habanalabs: add missing counter update
      habanalabs/gaudi: handle reset when f/w is in preboot
      habanalabs: change messages to debug level

Ofir Bitton (26):
      habanalabs/gaudi: move mmu_prepare to context init
      habanalabs: sync stream structures refactor
      habanalabs: add support for multiple SOBs per monitor
      habanalabs: sync stream refactor functions
      habanalabs: sync stream collective infrastructure
      habanalabs/gaudi: Set DMA5 QMAN internal
      habanalabs: sync stream collective support
      habanalabs/gaudi: remove unreachable code
      habanalabs: advanced FW loading
      habanalabs: fetch security indication from FW
      habanalabs/gaudi: add support for FW security
      habanalabs/gaudi: fetch PLL info from FW
      habanalabs: release signal if collective wait was dropped
      habanalabs: add 'needs reset' state in driver
      habanalabs: move HW dirty check to a proper location
      habanalabs: refactor mmu va_range db structure
      habanalabs: improve hard reset procedure
      habanalabs: use host va range for internal pools
      habanalabs: fetch hard reset capability from FW
      habanalabs/gaudi: fetch HBM ecc info from FW
      habanalabs: support reserving aligned va block
      habanalabs/gaudi: align to new FW reset scheme
      habanalabs: mmu map wrapper for sizes larger than a page
      habanalabs: indicate to user that a cs is gone
      habanalabs: add support for cs with timestamp
      habanalabs: free host huge va_range if not used

Omer Shpigelman (1):
      habanalabs: fix hard reset print and comment

Tal Cohen (1):
      habanalabs: use enum for CB allocation options

Tomer Tayar (9):
      habanalabs: Small refactoring of CS IOCTL handling
      habanalabs: Small refactoring of cs_do_release()
      habanalabs: Skip updating CI of internal queues if not in use
      habanalabs: Move repeatedly included headers to habanalabs.h
      habanalabs: Separate CS job completion from its deallocation
      habanalabs: Rename hw_queues_mirror to cs_mirror
      habanalabs: Add mask for CS type bits in CS flags
      habanalabs: Modify the cs_cnt of a CB to be atomic
      habanalabs: Add CB IOCTL opcode to retrieve CB information

farah kassabri (3):
      habanalabs: fix cs counters structure
      habanalabs/gaudi: scrub all memory upon closing FD
      habanalabs: reset device upon fw read failure

kernel test robot (2):
      habanalabs: goya_reset_sob_group() can be static
      habanalabs: gaudi_ctx_fini() can be static

 MAINTAINERS                                        |    4 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   55 +-
 .../misc/habanalabs/common/command_submission.c    | 1016 +++--
 drivers/misc/habanalabs/common/context.c           |    4 +
 drivers/misc/habanalabs/common/debugfs.c           |  310 +-
 drivers/misc/habanalabs/common/device.c            |  182 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  167 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  458 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   34 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   77 +-
 drivers/misc/habanalabs/common/hw_queue.c          |  273 +-
 drivers/misc/habanalabs/common/hwmon.c             |   31 +-
 drivers/misc/habanalabs/common/memory.c            |  333 +-
 drivers/misc/habanalabs/common/mmu.c               |  273 +-
 drivers/misc/habanalabs/common/mmu_v1.c            |  139 +-
 drivers/misc/habanalabs/common/pci.c               |   16 +-
 drivers/misc/habanalabs/common/sysfs.c             |   18 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 2384 ++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   87 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    2 -
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        |    8 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 4056 +++++++++++++++++++-
 drivers/misc/habanalabs/goya/goya.c                |  166 +-
 drivers/misc/habanalabs/goya/goyaP.h               |    3 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    2 -
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |   28 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  136 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  103 +
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |   26 +-
 .../include/gaudi/asic_reg/nic0_qm0_masks.h        |  800 ++++
 .../include/gaudi/asic_reg/nic0_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic0_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/psoc_hbm_pll_regs.h     |  114 -
 .../include/gaudi/asic_reg/psoc_pci_pll_regs.h     |  114 -
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   27 +-
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   15 +
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |    2 +
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |    3 +-
 .../misc/habanalabs/include/goya/goya_reg_map.h    |    2 +
 include/uapi/misc/habanalabs.h                     |  126 +-
 48 files changed, 18021 insertions(+), 1913 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h
