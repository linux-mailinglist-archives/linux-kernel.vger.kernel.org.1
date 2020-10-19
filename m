Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF9292273
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgJSGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:19:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:10275 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgJSGT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:19:58 -0400
IronPort-SDR: VhgUOOAGAw27+lqIOgMQyq0AVocUe9ibS2Ev/PmOof3NIGLMNr0OyGb8vN7WA/GjEdrwLBeExC
 /XNxYRGuESCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="166194688"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="166194688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:19:58 -0700
IronPort-SDR: Q9KBMoRqReiXe3o/FJnW8oEllwWA/TY6UCjupfSL7XY/HALb0+dQ+iKxN9u0oPQCSORIGhZwGH
 XD3jlhk1yIVw==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="358050020"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:19:54 -0700
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
Subject: [PATCH v5 14/17] virt: acrn: Introduce I/O ranges operation interfaces
Date:   Mon, 19 Oct 2020 14:18:00 +0800
Message-Id: <20201019061803.13298-15-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019061803.13298-1-shuo.a.liu@intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
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
index b2dbac205078..aa21c8ccc63a 100644
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

