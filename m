Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65181300144
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbhAVLNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:13:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:24040 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbhAVLGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:06:03 -0500
IronPort-SDR: UjrMbvF9w4qg4g0udsD07vfzq9L38znHBUVEFL6H6/hZ36judgUNm6IADqsahzv9UI4y6WL0Y9
 CbuBjSnTN0yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243508425"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="243508425"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:03:03 -0800
IronPort-SDR: r/hRJn+WEBvNwpNqHXlhexY2gt+JG52XsZHwSwGJB2BX6sMCl4k0HucNjqU+r0dE+Wwwasr35a
 lP4ER9syJJQw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="351791298"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:03:00 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v8 14/18] virt: acrn: Introduce I/O ranges operation interfaces
Date:   Fri, 22 Jan 2021 19:01:18 +0800
Message-Id: <20210122110122.45800-15-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210122110122.45800-1-shuo.a.liu@intel.com>
References: <20210122110122.45800-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

An I/O request of a User VM, which is constructed by hypervisor, is
distributed by the ACRN Hypervisor Service Module to an I/O client
corresponding to the address range of the I/O request.

I/O client maintains a list of address ranges. Introduce
acrn_ioreq_range_{add,del}() to manage these address ranges.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/acrn_drv.h |  4 +++
 drivers/virt/acrn/ioreq.c    | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 068f0be769f6..8a7d7721f505 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -197,6 +197,10 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 						   void *data, bool is_default,
 						   const char *name);
 void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end);
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end);
 
 int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data);
 
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index d19c05582d38..80b2e3f0e276 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -103,6 +103,66 @@ int acrn_ioreq_request_default_complete(struct acrn_vm *vm, u16 vcpu)
 	return ret;
 }
 
+/**
+ * acrn_ioreq_range_add() - Add an iorange monitored by an ioreq client
+ * @client:	The ioreq client
+ * @type:	Type (ACRN_IOREQ_TYPE_MMIO or ACRN_IOREQ_TYPE_PORTIO)
+ * @start:	Start address of iorange
+ * @end:	End address of iorange
+ *
+ * Return: 0 on success, <0 on error
+ */
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end)
+{
+	struct acrn_ioreq_range *range;
+
+	if (end < start) {
+		dev_err(acrn_dev.this_device,
+			"Invalid IO range [0x%llx,0x%llx]\n", start, end);
+		return -EINVAL;
+	}
+
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	range->type = type;
+	range->start = start;
+	range->end = end;
+
+	write_lock_bh(&client->range_lock);
+	list_add(&range->list, &client->range_list);
+	write_unlock_bh(&client->range_lock);
+
+	return 0;
+}
+
+/**
+ * acrn_ioreq_range_del() - Del an iorange monitored by an ioreq client
+ * @client:	The ioreq client
+ * @type:	Type (ACRN_IOREQ_TYPE_MMIO or ACRN_IOREQ_TYPE_PORTIO)
+ * @start:	Start address of iorange
+ * @end:	End address of iorange
+ */
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end)
+{
+	struct acrn_ioreq_range *range;
+
+	write_lock_bh(&client->range_lock);
+	list_for_each_entry(range, &client->range_list, list) {
+		if (type == range->type &&
+		    start == range->start &&
+		    end == range->end) {
+			list_del(&range->list);
+			kfree(range);
+			break;
+		}
+	}
+	write_unlock_bh(&client->range_lock);
+}
+
 /*
  * ioreq_task() is the execution entity of handler thread of an I/O client.
  * The handler callback of the I/O client is called within the handler thread.
-- 
2.28.0

