Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C32DEDA5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 08:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgLSHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 02:07:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49002 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgLSHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:07:20 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C05081F46488;
        Sat, 19 Dec 2020 07:06:37 +0000 (GMT)
Date:   Sat, 19 Dec 2020 08:06:32 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexandre Belloni <abelloni@kernel.org>
Subject: [GIT PULL] i3c: Changes for 5.11
Message-ID: <20201219080632.686b92bc@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here the I3C PR for 5.11. This should be my last PR (I resigned from
my maintainer position). Alexandre Belloni (maintainer of the RTC
subsystem) kindly proposed to take over, so he should send the I3C PRs
from now on.

Regards,

Boris 

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.11

for you to fetch changes up to 95393f3e07ab53855b91881692a4a5b52dcdc03c:

  i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning (2020-12-17 10:31:30 +0100)

----------------------------------------------------------------
* Add the HCI driver
* Add a missing destroy_workqueue() in an error path
* Flag Alexandre Belloni as the new maintainer

----------------------------------------------------------------
Boris Brezillon (1):
      i3c: Resign from my maintainer role

Colin Ian King (1):
      i3c/master: Fix uninitialized variable next_addr

Nicolas Pitre (3):
      dt-bindings: i3c: MIPI I3C Host Controller Interface
      i3c/master: introduce the mipi-i3c-hci driver
      i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning

Qinglang Miao (1):
      i3c master: fix missing destroy_workqueue() on error in i3c_master_register

 Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml |   47 +++
 MAINTAINERS                                             |    2 +-
 drivers/i3c/master.c                                    |    5 +-
 drivers/i3c/master/Kconfig                              |   13 +
 drivers/i3c/master/Makefile                             |    1 +
 drivers/i3c/master/mipi-i3c-hci/Makefile                |    6 +
 drivers/i3c/master/mipi-i3c-hci/cmd.h                   |   67 ++++
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                |  378 +++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                |  316 ++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/core.c                  |  798 ++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/dat.h                   |   32 ++
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c                |  184 ++++++++++
 drivers/i3c/master/mipi-i3c-hci/dct.h                   |   16 +
 drivers/i3c/master/mipi-i3c-hci/dct_v1.c                |   36 ++
 drivers/i3c/master/mipi-i3c-hci/dma.c                   |  784 +++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c              |  308 ++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/ext_caps.h              |   19 +
 drivers/i3c/master/mipi-i3c-hci/hci.h                   |  144 ++++++++
 drivers/i3c/master/mipi-i3c-hci/ibi.h                   |   42 +++
 drivers/i3c/master/mipi-i3c-hci/pio.c                   | 1041 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/xfer_mode_rate.h        |   79 ++++
 21 files changed, 4316 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/Makefile
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/cmd.h
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/core.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/dat.h
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/dat_v1.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/dct.h
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/dct_v1.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/dma.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/ext_caps.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/ext_caps.h
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci.h
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/ibi.h
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/pio.c
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/xfer_mode_rate.h
