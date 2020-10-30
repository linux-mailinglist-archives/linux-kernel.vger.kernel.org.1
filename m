Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E592A1175
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJ3XOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgJ3XOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:14:18 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A0420825;
        Fri, 30 Oct 2020 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604099657;
        bh=1hqChdUKXVD3YuY81cq4wvV4czcVIDxraUTMZdAupSw=;
        h=Date:From:To:Cc:Subject:From;
        b=txCsPYzjFNlNYjyU0+7KRMwEA8x9z45Nr6lzQz2wVC8+0qX6vnntSSiaR0FZzst/S
         VR2M4esQaWkMuFFT8xtGVKQwfY5VJqglsrWoZpRXbK4TjTB8Om/+nC9d6el7G5v03v
         j9Bn8YyvhX6jDBJYGXdV8OYQuuGWVs57y07Scbbs=
Date:   Fri, 30 Oct 2020 17:13:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] flexible array conversions for 5.10-rc2
Message-ID: <20201030221342.GA6183@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-conversions-5.10-rc2

for you to fetch changes up to a38283da05d321fa1fce38ea3cf41c9f1dbd1f21:

  printk: ringbuffer: Replace zero-length array with flexible-array member (2020-10-30 16:57:42 -0500)

----------------------------------------------------------------
flexible-array member conversion patches for 5.10-rc2

Hi Linus,

Please, pull the following patches that replace zero-length arrays with
flexible-array members.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (17):
      dmaengine: ti-cppi5: Replace zero-length array with flexible-array member
      mailbox: zynqmp-ipi-message: Replace zero-length array with flexible-array member
      platform/chrome: cros_ec_commands: Replace zero-length array with flexible-array member
      platform/chrome: cros_ec_proto: Replace zero-length array with flexible-array member
      tracepoint: Replace zero-length array with flexible-array member
      params: Replace zero-length array with flexible-array member
      Bluetooth: Replace zero-length array with flexible-array member
      fs: Replace zero-length array with flexible-array member
      enetc: Replace zero-length array with flexible-array member
      ima: Replace zero-length array with flexible-array member
      scsi: target: tcmu: Replace zero-length array with flexible-array member
      Bluetooth: btintel: Replace zero-length array with flexible-array member
      gve: Replace zero-length array with flexible-array member
      mei: hw: Replace zero-length array with flexible-array member
      net/mlx5: Replace zero-length array with flexible-array member
      net/smc: Replace zero-length array with flexible-array member
      printk: ringbuffer: Replace zero-length array with flexible-array member

 drivers/bluetooth/btintel.h                      |  2 +-
 drivers/misc/mei/hw.h                            |  6 +++---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c |  2 +-
 drivers/net/ethernet/google/gve/gve_adminq.h     |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c       |  5 ++---
 drivers/target/target_core_user.c                |  2 +-
 fs/binfmt_elf.c                                  |  2 +-
 fs/hfs/btree.h                                   |  2 +-
 fs/hfsplus/hfsplus_fs.h                          |  2 +-
 fs/isofs/rock.h                                  |  8 ++++----
 fs/select.c                                      |  4 ++--
 include/linux/dma/ti-cppi5.h                     |  4 ++--
 include/linux/fs.h                               |  2 +-
 include/linux/mailbox/zynqmp-ipi-message.h       |  2 +-
 include/linux/mlx5/mlx5_ifc.h                    |  4 ++--
 include/linux/platform_data/cros_ec_commands.h   | 14 +++++++-------
 include/linux/platform_data/cros_ec_proto.h      |  2 +-
 kernel/params.c                                  |  2 +-
 kernel/printk/printk_ringbuffer.c                |  2 +-
 kernel/tracepoint.c                              |  2 +-
 net/bluetooth/msft.c                             |  3 ++-
 net/smc/smc_clc.h                                |  4 ++--
 security/integrity/ima/ima.h                     |  2 +-
 23 files changed, 40 insertions(+), 40 deletions(-)
