Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00EA1C60B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgEETFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:05:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgEETFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588705499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=C87013T7miUBeS+mUtqzih667NdnaLshNDFWgAVS/zE=;
        b=Dlcrk0FbeCiMn4oJZeodD1iWf8NzYxcqQ3dUEde+XoUWJ+WOm0Zvrqv+KhgRMkRBIKwsMv
        GO/KJN5WbbogJZp1zKPzfRXcrrfEfxag4XH9CMTZQIpBigTKN3iPjBHNW6pDZn6KWt2nm7
        t6eY0i1/kCTXVv0Kgg82wODO5yPNoWw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-51FZo3F2MzqSdk7dZmy5Gg-1; Tue, 05 May 2020 15:04:57 -0400
X-MC-Unique: 51FZo3F2MzqSdk7dZmy5Gg-1
Received: by mail-pl1-f198.google.com with SMTP id g9so2217231plm.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 12:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C87013T7miUBeS+mUtqzih667NdnaLshNDFWgAVS/zE=;
        b=T2reVSw8pM/s5y56cBdITdMg7q/z38kzCbM42wk38Q9a9Lb2/Tl4A9+uZ1+S119SKY
         Gc6bIZa01MDjkq0cdIqxLzoblM1Q3CElrxFhjP/JZ9mWPBmps5nEBVg/XzITJD+0KKvP
         1jYu1B7DX49q7ChOoq2OXEiZAGWylE5v1CjRa+52pqBD3VcwGaH0JTf2Z+v6trwYOBA2
         gCzSjsKhCWRuUcUry/qD0kx+H+mU0jXXgBg2+bbFa+qEjuWhPNo1181HrcPRtfARrM+I
         BCvaXvt2Fk1Lp1/eOgZ4MxTbFS0mM+e5ED852axPpzRsLCStq0nRX32kJXYC4tpl8M6n
         DN1A==
X-Gm-Message-State: AGi0PuZzFCIezt2jMX4rd4sKTdXp/lAWun6Ho1/oV4wETDU3CniHO2nC
        lZyNw/b2Frz5FFgKEvxMZay5IJSUYy8kvTMLV1+H0vjKiCJIsS9aGDoLU7CWlVJmocgO7JSzORf
        WhpMNRBq+ljDuk1RkaQQ0Mmcl
X-Received: by 2002:a17:90a:df88:: with SMTP id p8mr4983058pjv.119.1588705496155;
        Tue, 05 May 2020 12:04:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwXIzFhMOEAmtg5EmEQVlz9X54oc4x7EGYUYTrtCU3knTF3F6bb9GuvSBLVF9k0mBLGbO7fQ==
X-Received: by 2002:a17:90a:df88:: with SMTP id p8mr4983026pjv.119.1588705495869;
        Tue, 05 May 2020 12:04:55 -0700 (PDT)
Received: from localhost ([122.177.124.216])
        by smtp.gmail.com with ESMTPSA id h26sm2654823pfk.35.2020.05.05.12.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 12:04:55 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        manishc@marvell.com, davem@davemloft.net
Subject: [PATCH 1/2] net: qed*: Reduce RX and TX default ring count when running inside kdump kernel
Date:   Wed,  6 May 2020 00:34:40 +0530
Message-Id: <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally kdump kernel(s) run under severe memory constraint with the
basic idea being to save the crashdump vmcore reliably when the primary
kernel panics/hangs.

Currently the qed* ethernet driver ends up consuming a lot of memory in
the kdump kernel, leading to kdump kernel panic when one tries to save
the vmcore via ssh/nfs (thus utilizing the services of the underlying
qed* network interfaces).

An example OOM message log seen in the kdump kernel can be seen here
[1], with crashkernel size reservation of 512M.

Using tools like memstrack (see [2]), we can track the modules taking up
the bulk of memory in the kdump kernel and organize the memory usage
output as per 'highest allocator first'. An example log for the OOM case
indicates that the qed* modules end up allocating approximately 216M
memory, which is a large part of the total crashkernel size:

 dracut-pre-pivot[676]: ======== Report format module_summary: ========
 dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)
 dracut-pre-pivot[676]: Module qede using 65.3MB (1045 pages), peak allocation 65.3MB (1045 pages)

This patch reduces the default RX and TX ring count from 1024 to 64
when running inside kdump kernel, which leads to a significant memory
saving.

An example log with the patch applied shows the reduced memory
allocation in the kdump kernel:
 dracut-pre-pivot[674]: ======== Report format module_summary: ========
 dracut-pre-pivot[674]: Module qed using 141.8MB (2268 pages), peak allocation 141.8MB (2268 pages)
 <..snip..>
[dracut-pre-pivot[674]: Module qede using 4.8MB (76 pages), peak allocation 4.9MB (78 pages)

Tested crashdump vmcore save via ssh/nfs protocol using underlying qed*
network interface after applying this patch.

[1] OOM log:
------------

 kworker/0:6: page allocation failure: order:6,
 mode:0x60c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
 kworker/0:6 cpuset=/ mems_allowed=0
 CPU: 0 PID: 145 Comm: kworker/0:6 Not tainted 4.18.0-109.el8.aarch64 #1
 Hardware name: To be filled by O.E.M. Saber/Saber, BIOS 0ACKL025
 01/18/2019
 Workqueue: events work_for_cpu_fn
 Call trace:
  dump_backtrace+0x0/0x188
  show_stack+0x24/0x30
  dump_stack+0x90/0xb4
  warn_alloc+0xf4/0x178
  __alloc_pages_nodemask+0xcac/0xd58
  alloc_pages_current+0x8c/0xf8
  kmalloc_order_trace+0x38/0x108
  qed_iov_alloc+0x40/0x248 [qed]
  qed_resc_alloc+0x224/0x518 [qed]
  qed_slowpath_start+0x254/0x928 [qed]
   __qede_probe+0xf8/0x5e0 [qede]
  qede_probe+0x68/0xd8 [qede]
  local_pci_probe+0x44/0xa8
  work_for_cpu_fn+0x20/0x30
  process_one_work+0x1ac/0x3e8
  worker_thread+0x44/0x448
  kthread+0x130/0x138
  ret_from_fork+0x10/0x18
  Cannot start slowpath
  qede: probe of 0000:05:00.1 failed with error -12

[2]. Memstrack tool: https://github.com/ryncsn/memstrack

Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Cc: Manish Chopra <manishc@marvell.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index 234c6f30effb..b55ab32ef0b3 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -32,6 +32,7 @@
 #ifndef _QEDE_H_
 #define _QEDE_H_
 #include <linux/compiler.h>
+#include <linux/crash_dump.h>
 #include <linux/version.h>
 #include <linux/workqueue.h>
 #include <linux/netdevice.h>
@@ -574,13 +575,13 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 #define RX_RING_SIZE		((u16)BIT(RX_RING_SIZE_POW))
 #define NUM_RX_BDS_MAX		(RX_RING_SIZE - 1)
 #define NUM_RX_BDS_MIN		128
-#define NUM_RX_BDS_DEF		((u16)BIT(10) - 1)
+#define NUM_RX_BDS_DEF		((is_kdump_kernel()) ? ((u16)BIT(6) - 1) : ((u16)BIT(10) - 1))
 
 #define TX_RING_SIZE_POW	13
 #define TX_RING_SIZE		((u16)BIT(TX_RING_SIZE_POW))
 #define NUM_TX_BDS_MAX		(TX_RING_SIZE - 1)
 #define NUM_TX_BDS_MIN		128
-#define NUM_TX_BDS_DEF		NUM_TX_BDS_MAX
+#define NUM_TX_BDS_DEF		((is_kdump_kernel()) ? ((u16)BIT(6) - 1) : NUM_TX_BDS_MAX)
 
 #define QEDE_MIN_PKT_LEN		64
 #define QEDE_RX_HDR_SIZE		256
-- 
2.7.4

