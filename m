Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4951D629D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEPQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 12:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 12:25:33 -0400
Received: from vkoul-mobl.Dlink (unknown [49.207.59.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07FD206D8;
        Sat, 16 May 2020 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589646332;
        bh=ZpBrhlrmpHDM4bnj6HA0bzd92Cf5AYkp3l1+/w9OLyM=;
        h=From:To:Cc:Subject:Date:From;
        b=syIDhw3pWp4adqZ+txEOmMB8Ae5eQ8QQcQIu7SNRLtIalGVJ2a/jHecpwKVokwVi1
         T/3DPmPJVXbI0GHsdUSFU8IOzXZOdMQiWdpv2hZIGtdIbJznhXHHzEGtc5Y485N5T1
         tgWlF2k3vG1h+1VU3Ui2gwyoNsMjpjnJn6w11Ysw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] usb: renesas-xhci: include correct header for  get_unaligned_le16()
Date:   Sat, 16 May 2020 21:55:16 +0530
Message-Id: <20200516162516.385149-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_unaligned_le16() is defined in linux/unaligned/access_ok.h header
but it uses symbols which may not be available, leading to build
failures on ia64. Using asm/unaligned.h seem to be the right thing
and used in other drivers.

This fixes below error reported by kbuild test robot

In file included from drivers/usb/host/xhci-pci-renesas.c:9:
>> include/linux/unaligned/access_ok.h:8:28: error: redefinition of 'get_unaligned_le16'
8 | static __always_inline u16 get_unaligned_le16(const void *p)
|                            ^~~~~~~~~~~~~~~~~~
In file included from arch/ia64/include/asm/unaligned.h:5,
from arch/ia64/include/asm/io.h:23,
from arch/ia64/include/asm/smp.h:21,
from include/linux/smp.h:67,
from include/linux/percpu.h:7,
from include/linux/arch_topology.h:9,
from include/linux/topology.h:30,
from include/linux/gfp.h:9,
from include/linux/xarray.h:14,
from include/linux/radix-tree.h:18,
from include/linux/idr.h:15,
from include/linux/kernfs.h:13,
from include/linux/sysfs.h:16,
from include/linux/kobject.h:20,
from include/linux/of.h:17,
from include/linux/irqdomain.h:35,
from include/linux/acpi.h:13,
from drivers/usb/host/xhci-pci-renesas.c:4:
include/linux/unaligned/le_struct.h:7:19: note: previous definition of 'get_unaligned_le16' was here
7 | static inline u16 get_unaligned_le16(const void *p)
|                   ^~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/xhci-pci-renesas.c:9:
include/linux/unaligned/access_ok.h:13:28: error: redefinition of 'get_unaligned_le32'
13 | static __always_inline u32 get_unaligned_le32(const void *p)
|                            ^~~~~~~~~~~~~~~~~~
In file included from arch/ia64/include/asm/unaligned.h:5,
from arch/ia64/include/asm/io.h:23,
from arch/ia64/include/asm/smp.h:21,
from include/linux/smp.h:67,
from include/linux/percpu.h:7,
from include/linux/arch_topology.h:9,
from include/linux/topology.h:30,
from include/linux/gfp.h:9,
from include/linux/xarray.h:14,
from include/linux/radix-tree.h:18,
from include/linux/idr.h:15,
from include/linux/kernfs.h:13,
from include/linux/sysfs.h:16,
from include/linux/kobject.h:20,
from include/linux/of.h:17,
from include/linux/irqdomain.h:35,
from include/linux/acpi.h:13,
from drivers/usb/host/xhci-pci-renesas.c:4:
include/linux/unaligned/le_struct.h:12:19: note: previous definition of 'get_unaligned_le32' was here

Fixes: 8bd5741e3145 ("usb: renesas-xhci: Add the renesas xhci driver")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/usb/host/xhci-pci-renesas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index fa32ec352dc8..f7a4d2dea439 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
-- 
2.25.4

