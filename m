Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EFA2A3C92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgKCGHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCGHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:07:07 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF0322277;
        Tue,  3 Nov 2020 06:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604383626;
        bh=6OhSsd1kywZnS/Iy6jdJh0vaPIO+ESjNMKEjsJjycB0=;
        h=From:To:Cc:Subject:Date:From;
        b=uYdLr8ycS7dx9p1UpEBPgd0Lk8K89a3YPlrd/PyEoglsPxl/oD4FTJqpT/kyOn0M2
         qppBlaPBYMM/qlDlw0hYVEpGasyuxfqZtiePCDt3O8ZHmY/bO/GH9U0XGL/mFNaMkb
         Us73zB0eP5sDwaa7kclJQbkaMpmwTvTB9pEFjHZw=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 0/4] Enable support of GAUDI NIC QMANs
Date:   Tue,  3 Nov 2020 08:06:57 +0200
Message-Id: <20201103060701.25852-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set initializes the GAUDI compute queues which are connected
to the NIC ports. It also configures the security properties of those
queues.

This is the pretty much the same code as the one that configures the
rest of the queues in GAUDI.

I want to emphasize that there is no networking/ethernet/RDMA code in
this patch-set. Those features will be supported in later patch-sets
according to the feedback that was received from the community.

This patch-set is pre-requisite for those later patch-sets and also for
additional features we want to upstream to the driver, such as collective
wait mechanism.

Thanks,
Oded

Oded Gabbay (4):
  habanalabs/gaudi: add NIC QMAN H/W and registers definitions
  habanalabs/gaudi: add NIC firmware-related definitions
  habanalabs/gaudi: add NIC security configuration
  habanalabs/gaudi: add support for NIC QMANs

 drivers/misc/habanalabs/common/habanalabs.h   |    3 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  741 ++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   32 +
 .../misc/habanalabs/gaudi/gaudi_security.c    | 3973 +++++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h |   34 +-
 .../include/gaudi/asic_reg/gaudi_regs.h       |   14 +-
 .../include/gaudi/asic_reg/nic0_qm0_masks.h   |  800 ++++
 .../include/gaudi/asic_reg/nic0_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic0_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm1_regs.h    |  834 ++++
 .../habanalabs/include/gaudi/gaudi_fw_if.h    |   24 +
 .../habanalabs/include/gaudi/gaudi_masks.h    |   15 +
 19 files changed, 13926 insertions(+), 50 deletions(-)
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

--
2.17.1

