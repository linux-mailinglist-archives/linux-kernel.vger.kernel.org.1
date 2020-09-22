Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441C4274636
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:08:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC680C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:08:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3930418wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hkiycIgTIsBMOxXZar9zmMtd4RLKrrfIfW7nlrOS99c=;
        b=VOh3+idyRCxyJXafN87dNSNGIsWog31qzjnjGuVQVtvZILfIABEcEEJhTxC9vghfTN
         dSeiUWAv1itlQkd8eeHUF6+y9/EHDAIfph+jtLJmarclB0CRu8BQJ4wtcmojAwkczm1v
         foI93yIHMlgieitiSesCMsWu6lYzl2XfBq9dXwCxuVfFhaKvbJZNUuG4ddrG7AbRjBSO
         NhMwNVkDn3f2grzqetEhGmnFpIoQ9nIdCqYtgiT3VrdaOzxX2R24bjIK4PMFeYlgnoDz
         kyFNqDjgBrthDZQtdkKL6OkhABr2A4irmree1bA/Z/tq0t1LADblX5kHJ2sJd9D+CZT/
         554A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hkiycIgTIsBMOxXZar9zmMtd4RLKrrfIfW7nlrOS99c=;
        b=fvtWk3ed++WVvNMx7jRQ1Ja88kr1UtITO/lWlDg3WUVyRHDSbZOqYpeEXYdUE6tCyC
         6hNJaX5au1LKBlMtVHg8hFzsJM0Kb3AJGJLW92M8n9E+BhhHNZ9Z0k+9SU2svg7b64oB
         kFPUWcm1TO+CrmtyROBkBRISOSFNi1LHjPXJu2sH/QMbFqZ7wZwwd4FuRA6k2MOUmtkz
         IewzRhNKdGcohFMAN4puiZC8gTjIIwwrWB+OR+4c6myJCBThjQfy2zg+iQ2bnb237sHo
         XytVe8QR763XQBOjSsH5R1OfWfouQr7V30ShyJqbtqjQLC8wwmVG+YOe7znQOxH3SBTL
         wM/Q==
X-Gm-Message-State: AOAM533Q4ohqC0j86YWbtKX7wGx3kfpKCuDIMmRqCVw9xf1szn34guqo
        U6NlKGIh3A33BH7H4iS7pNarJvYrfiU=
X-Google-Smtp-Source: ABdhPJzEmHIrd32RCKeRMn12nes5n70gv7swSlj5sRP+z2lq0U1IJpgzv5K7lQV8/UNQeSWjJtQTSQ==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr1930811wmh.152.1600790920239;
        Tue, 22 Sep 2020 09:08:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id l18sm27104914wrp.84.2020.09.22.09.08.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Sep 2020 09:08:39 -0700 (PDT)
Date:   Tue, 22 Sep 2020 19:08:37 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.10-rc1
Message-ID: <20200922160837.GA6025@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs pull request for the merge window of kernel 5.10. It
contains many small improvements to common and GAUDI code. Details are in
the tag.

Thanks,
Oded

The following changes since commit 8fd0e2a6df262539eaa28b0a2364cca10d1dc662:

  uio: free uio id after uio file node is freed (2020-09-17 18:52:03 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-09-22

for you to fetch changes up to f279e5cd95058ddbb8f86e1c32f25d36502a115c:

  habanalabs: update scratchpad register map (2020-09-22 18:49:54 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.10-rc1:

- Stop using the DRM's dma-fence module and instead use kernel completions.
- Support PCIe AER
- Use dma_mmap_coherent for memory allocated using dma_alloc_coherent
- Use smallest possible alignment when allocating virtual addresses in our
  MMU driver.
- Refactor MMU driver code to be device-oriented
- Allow user to check CS status without any sleep
- Add an option to map a Command Buffer to the Device's MMU
- Expose sync manager resource allocation to user through INFO IOCTL
- Convert code to use standard BIT(), GENMASK() and FIELD_PREP()
- Many small fixes (casting, better error messages, remove unused
  defines, h/w configuration fixes, etc.)

----------------------------------------------------------------
Dotan Barak (1):
      habanalabs: print the queue id in case of an error

Hillf Danton (1):
      habanalabs: make use of dma_mmap_coherent

Moti Haimovski (4):
      habanalabs: rename mmu.c to mmu_v1.c
      habanalabs: refactor MMU as device-oriented
      habanalabs: add num_hops to hl_mmu_properties
      habanalabs: add debugfs support for MMU with 6 HOPs

Oded Gabbay (28):
      habanalabs: increase length of ASIC name
      habanalabs: change CB's ID to be 64 bits
      habanalabs: cast int to u32 before printing it with %u
      habanalabs: eliminate redundant else condition
      habanalabs: use standard BIT() and GENMASK()
      habanalabs: use FIELD_PREP() instead of <<
      habanalabs: remove redundant assignment to variable
      habanalabs: check TPC vector pipe is empty
      habanalabs: use 1U when shifting bits
      habanalabs: update GAUDI hardware specs
      habanalabs: replace armcp with the generic cpucp
      habanalabs: cast to u64 before shift > 31 bits
      habanalabs: restructure hl_mmap
      habanalabs: clear vm_pgoff before doing the mmap
      habanalabs: count dropped CS because max CS in-flight
      habanalabs: rename ArmCP to CPU-CP
      habanalabs: remove unused ASIC function pointer
      habanalabs: remove unused define
      habanalabs: increase PQ COMP_OFFSET by one nibble
      habanalabs: check flag before reset because of f/w event
      habanalabs/gaudi: increase timeout for boot fit load
      habanalabs: allow to wait on CS without sleep
      habanalabs: no need for DMA_SHARED_BUFFER
      habanalabs: update firmware interface file
      habanalabs/gaudi: remove axi drain support
      habanalabs/gaudi: fix DMA completions max outstanding to 15
      habanalabs: add indication of security-enabled F/W
      habanalabs: update scratchpad register map

Ofir Bitton (5):
      habanalabs: Replace dma-fence mechanism with completions
      habanalabs: add information about PCIe controller
      habanalabs: expose sync manager resources allocation in INFO IOCTL
      habanalabs: PCIe Advanced Error Reporting support
      habanalabs: Fix alignment issue in cpucp_info structure

Omer Shpigelman (1):
      habanalabs: use smallest possible alignment for virtual addresses

Tomer Tayar (3):
      habanalabs: Include linux/bitfield.h only in habanalabs.h
      habanalabs: Save context in a command buffer object
      habanalabs: Add an option to map CB to device MMU

farah kassabri (3):
      habanalabs: remove security from ARB_MST_QUIET register
      habanalabs: extend busy engines mask to 64 bits
      habanalabs: add support for getting device total energy

 Documentation/ABI/testing/sysfs-driver-habanalabs  |    18 +-
 drivers/misc/habanalabs/Kconfig                    |     1 -
 drivers/misc/habanalabs/common/Makefile            |     4 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   229 +-
 .../misc/habanalabs/common/command_submission.c    |   107 +-
 drivers/misc/habanalabs/common/context.c           |    25 +-
 drivers/misc/habanalabs/common/debugfs.c           |    92 +-
 drivers/misc/habanalabs/common/device.c            |    18 +-
 drivers/misc/habanalabs/common/firmware_if.c       |   229 +-
 drivers/misc/habanalabs/common/habanalabs.h        |   200 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |    76 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   105 +-
 drivers/misc/habanalabs/common/hw_queue.c          |    10 +-
 drivers/misc/habanalabs/common/hwmon.c             |    60 +-
 drivers/misc/habanalabs/common/irq.c               |     2 +-
 drivers/misc/habanalabs/common/memory.c            |    86 +-
 drivers/misc/habanalabs/common/mmu.c               |   812 +-
 drivers/misc/habanalabs/common/mmu_v1.c            |   863 ++
 drivers/misc/habanalabs/common/pci.c               |    17 +-
 drivers/misc/habanalabs/common/sysfs.c             |    60 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   192 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    52 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 12351 +++++++++----------
 drivers/misc/habanalabs/goya/goya.c                |    89 +-
 drivers/misc/habanalabs/goya/goyaP.h               |     2 +-
 .../include/common/{armcp_if.h => cpucp_if.h}      |   298 +-
 drivers/misc/habanalabs/include/common/qman_if.h   |     2 +-
 drivers/misc/habanalabs/include/gaudi/gaudi.h      |     2 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   273 +-
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |     1 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |     1 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |     2 +
 include/uapi/misc/habanalabs.h                     |    87 +-
 33 files changed, 8662 insertions(+), 7704 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/mmu_v1.c
 rename drivers/misc/habanalabs/include/common/{armcp_if.h => cpucp_if.h} (60%)
