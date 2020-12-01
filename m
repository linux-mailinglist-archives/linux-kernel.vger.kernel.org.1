Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC832C9E33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbgLAJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:41:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:62080 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388433AbgLAJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:41:34 -0500
IronPort-SDR: yJLDU1p7mADdOdVhSA1m5HSFhMO7RcjGY7jPRCI1TmignCz6zyA/hELNE683W287fKtt8eUXF+
 mOtvj/08msJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="169297156"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="169297156"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:53 -0800
IronPort-SDR: TFRv9wF/fdy/muGqVYRqC812HvwpT9OKrh2QJQ7o24opACHy8mSKhSsiS7gBJcr5mE/EDPSbC4
 gLNhPI09dlBg==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="315605236"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:50 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH v6 10/18] virt: acrn: Introduce PCI configuration space PIO accesses combiner
Date:   Tue,  1 Dec 2020 17:38:45 +0800
Message-Id: <20201201093853.12070-11-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201093853.12070-1-shuo.a.liu@intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

A User VM can access its virtual PCI configuration spaces via port IO
approach, which has two following steps:
 1) writes address into port 0xCF8
 2) put/get data in/from port 0xCFC

To distribute a complete PCI configuration space access one time, HSM
need to combine such two accesses together.

Combine two paired PIO I/O requests into one PCI I/O request and
continue the I/O request distribution.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/acrn_drv.h |  2 +
 drivers/virt/acrn/ioreq.c    | 76 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h    | 15 +++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 7e89e4944d0f..97a7f31cd681 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -154,6 +154,7 @@ extern rwlock_t acrn_vm_list_lock;
  * @default_client:		The default I/O request client
  * @ioreq_buf:			I/O request shared buffer
  * @ioreq_page:			The page of the I/O request shared buffer
+ * @pci_conf_addr:		Address of a PCI configuration access emulation
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -168,6 +169,7 @@ struct acrn_vm {
 	struct acrn_ioreq_client	*default_client;
 	struct acrn_io_request_buffer	*ioreq_buf;
 	struct page			*ioreq_page;
+	u32				pci_conf_addr;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index ed22b1c4775d..b469f273e20c 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -220,6 +220,80 @@ int acrn_ioreq_client_wait(struct acrn_ioreq_client *client)
 	return 0;
 }
 
+static bool is_cfg_addr(struct acrn_io_request *req)
+{
+	return ((req->type == ACRN_IOREQ_TYPE_PORTIO) &&
+		(req->reqs.pio_request.address == 0xcf8));
+}
+
+static bool is_cfg_data(struct acrn_io_request *req)
+{
+	return ((req->type == ACRN_IOREQ_TYPE_PORTIO) &&
+		((req->reqs.pio_request.address >= 0xcfc) &&
+		 (req->reqs.pio_request.address < (0xcfc + 4))));
+}
+
+/* The low 8-bit of supported pci_reg addr.*/
+#define PCI_LOWREG_MASK  0xFC
+/* The high 4-bit of supported pci_reg addr */
+#define PCI_HIGHREG_MASK 0xF00
+/* Max number of supported functions */
+#define PCI_FUNCMAX	7
+/* Max number of supported slots */
+#define PCI_SLOTMAX	31
+/* Max number of supported buses */
+#define PCI_BUSMAX	255
+#define CONF1_ENABLE	0x80000000UL
+/*
+ * A PCI configuration space access via PIO 0xCF8 and 0xCFC normally has two
+ * following steps:
+ *   1) writes address into 0xCF8 port
+ *   2) accesses data in/from 0xCFC
+ * This function combines such paired PCI configuration space I/O requests into
+ * one ACRN_IOREQ_TYPE_PCICFG type I/O request and continues the processing.
+ */
+static bool handle_cf8cfc(struct acrn_vm *vm,
+			  struct acrn_io_request *req, u16 vcpu)
+{
+	int offset, pci_cfg_addr, pci_reg;
+	bool is_handled = false;
+
+	if (is_cfg_addr(req)) {
+		WARN_ON(req->reqs.pio_request.size != 4);
+		if (req->reqs.pio_request.direction == ACRN_IOREQ_DIR_WRITE)
+			vm->pci_conf_addr = req->reqs.pio_request.value;
+		else
+			req->reqs.pio_request.value = vm->pci_conf_addr;
+		is_handled = true;
+	} else if (is_cfg_data(req)) {
+		if (!(vm->pci_conf_addr & CONF1_ENABLE)) {
+			if (req->reqs.pio_request.direction ==
+					ACRN_IOREQ_DIR_READ)
+				req->reqs.pio_request.value = 0xffffffff;
+			is_handled = true;
+		} else {
+			offset = req->reqs.pio_request.address - 0xcfc;
+
+			req->type = ACRN_IOREQ_TYPE_PCICFG;
+			pci_cfg_addr = vm->pci_conf_addr;
+			req->reqs.pci_request.bus =
+					(pci_cfg_addr >> 16) & PCI_BUSMAX;
+			req->reqs.pci_request.dev =
+					(pci_cfg_addr >> 11) & PCI_SLOTMAX;
+			req->reqs.pci_request.func =
+					(pci_cfg_addr >> 8) & PCI_FUNCMAX;
+			pci_reg = (pci_cfg_addr & PCI_LOWREG_MASK) +
+				   ((pci_cfg_addr >> 16) & PCI_HIGHREG_MASK);
+			req->reqs.pci_request.reg = pci_reg + offset;
+		}
+	}
+
+	if (is_handled)
+		ioreq_complete_request(vm, vcpu, req);
+
+	return is_handled;
+}
+
 static bool in_range(struct acrn_ioreq_range *range,
 		     struct acrn_io_request *req)
 {
@@ -380,6 +454,8 @@ static int acrn_ioreq_dispatch(struct acrn_vm *vm)
 				ioreq_complete_request(vm, i, req);
 				continue;
 			}
+			if (handle_cf8cfc(vm, req, i))
+				continue;
 
 			spin_lock_bh(&vm->ioreq_clients_lock);
 			client = find_ioreq_client(vm, req);
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 96ebc879b8d0..66c43bd1e1b3 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -21,6 +21,7 @@
 
 #define ACRN_IOREQ_TYPE_PORTIO		0
 #define ACRN_IOREQ_TYPE_MMIO		1
+#define ACRN_IOREQ_TYPE_PCICFG		2
 
 #define ACRN_IOREQ_DIR_READ		0
 #define ACRN_IOREQ_DIR_WRITE		1
@@ -41,6 +42,18 @@ struct acrn_pio_request {
 	__u32	value;
 };
 
+/* Need keep same header fields with pio_request */
+struct acrn_pci_request {
+	__u32	direction;
+	__u32	reserved[3];
+	__u64	size;
+	__u32	value;
+	__u32	bus;
+	__u32	dev;
+	__u32	func;
+	__u32	reg;
+};
+
 /**
  * struct acrn_io_request - 256-byte ACRN I/O request
  * @type:		Type of this request (ACRN_IOREQ_TYPE_*).
@@ -49,6 +62,7 @@ struct acrn_pio_request {
  * @reserved0:		Reserved fields.
  * @reqs:		Union of different types of request. Byte offset: 64.
  * @reqs.pio_request:	PIO request data of the I/O request.
+ * @reqs.pci_request:	PCI configuration space request data of the I/O request.
  * @reqs.mmio_request:	MMIO request data of the I/O request.
  * @reqs.data:		Raw data of the I/O request.
  * @reserved1:		Reserved fields.
@@ -108,6 +122,7 @@ struct acrn_io_request {
 	__u32	reserved0[14];
 	union {
 		struct acrn_pio_request		pio_request;
+		struct acrn_pci_request		pci_request;
 		struct acrn_mmio_request	mmio_request;
 		__u64				data[8];
 	} reqs;
-- 
2.28.0

