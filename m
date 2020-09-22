Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA44227413A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgIVLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:47:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:59836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgIVLpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:45:35 -0400
IronPort-SDR: 5QpO3h5FKxJiX/FWoG3ZDGUdN8LPVxwicXeujVbN3SWFkxqOkWKT9/6o/wQDzpeBSGLkBISfUf
 nos8KvjL0Srw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222177027"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="222177027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:45:11 -0700
IronPort-SDR: 0kl/KAHpO8mJ1VbpDKs5ZIV4gT2zlBqesQQRjrkJat/oLUFgb/5VfBiqDVEQzNDjK6GliXg2zk
 sfIWjBvTDK3w==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="412633404"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:45:08 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v4 14/17] virt: acrn: Introduce I/O ranges operation interfaces
Date:   Tue, 22 Sep 2020 19:43:08 +0800
Message-Id: <20200922114311.38804-15-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114311.38804-1-shuo.a.liu@intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
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
index 701c83319115..5b824fa1ee57 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -199,6 +199,10 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 						   void *data, bool is_default,
 						   const char *name);
 void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end);
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end);
 
 int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data);
 
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index bf194f0fbd70..acf4edfb8c74 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -101,6 +101,66 @@ int acrn_ioreq_request_default_complete(struct acrn_vm *vm, u16 vcpu)
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

