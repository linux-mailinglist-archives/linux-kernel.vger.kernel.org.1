Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C229226F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgJSGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:19:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:2305 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgJSGTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:19:31 -0400
IronPort-SDR: ucp4IJBmGHBgt4nw54ZHzZZoJoBv/cl4hQcO9PZlRehOH3Id6r88uBkC3qM7m9VFmJ8x/t8mtn
 iaPsS2IYdwyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="251670163"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="251670163"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:19:30 -0700
IronPort-SDR: CavqKfSrc+IShfecN1AOjy6CdjwNrqvqLE8S18rDBBsYSoJp5Pe8n1etodB1GsioE8T5+tPTmA
 Lqu6OmofNBGg==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="315568707"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:19:27 -0700
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
Subject: [PATCH v5 10/17] virt: acrn: Introduce PCI configuration space PIO accesses combiner
Date:   Mon, 19 Oct 2020 14:17:56 +0800
Message-Id: <20201019061803.13298-11-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019061803.13298-1-shuo.a.liu@intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
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
index cf9143cf760d..97d2aab8b70a 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -156,6 +156,7 @@ extern rwlock_t acrn_vm_list_lock;
  * @default_client:		The default I/O request client
  * @ioreq_buf:			I/O request shared buffer
  * @ioreq_page:			The page of the I/O request shared buffer
+ * @pci_conf_addr:		Address of a PCI configuration access emulation
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -170,6 +171,7 @@ struct acrn_vm {
 	struct acrn_ioreq_client	*default_client;
 	struct acrn_io_request_buffer	*ioreq_buf;
 	struct page			*ioreq_page;
+	u32				pci_conf_addr;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 95df44049cca..b2dbac205078 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -221,6 +221,80 @@ int acrn_ioreq_client_wait(struct acrn_ioreq_client *client)
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
@@ -381,6 +455,8 @@ static int acrn_ioreq_dispatch(struct acrn_vm *vm)
 				ioreq_complete_request(vm, i, req);
 				continue;
 			}
+			if (handle_cf8cfc(vm, req, i))
+				continue;
 
 			spin_lock_bh(&vm->ioreq_clients_lock);
 			client = find_ioreq_client(vm, req);
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 8eb687f1482c..31cf0fd73bcc 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -20,6 +20,7 @@
 
 #define ACRN_IOREQ_TYPE_PORTIO		0
 #define ACRN_IOREQ_TYPE_MMIO		1
+#define ACRN_IOREQ_TYPE_PCICFG		2
 
 #define ACRN_IOREQ_DIR_READ		0
 #define ACRN_IOREQ_DIR_WRITE		1
@@ -40,6 +41,18 @@ struct acrn_pio_request {
 	__u32	value;
 } __attribute__((aligned(8)));
 
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
+} __attribute__((aligned(8)));
+
 /**
  * struct acrn_io_request - 256-byte ACRN I/O request
  * @type:		Type of this request (ACRN_IOREQ_TYPE_*).
@@ -48,6 +61,7 @@ struct acrn_pio_request {
  * @reserved0:		Reserved fields.
  * @reqs:		Union of different types of request. Byte offset: 64.
  * @reqs.pio_request:	PIO request data of the I/O request.
+ * @reqs.pci_request:	PCI configuration space request data of the I/O request.
  * @reqs.mmio_request:	MMIO request data of the I/O request.
  * @reqs.data:		Raw data of the I/O request.
  * @reserved1:		Reserved fields.
@@ -107,6 +121,7 @@ struct acrn_io_request {
 	__u32	reserved0[14];
 	union {
 		struct acrn_pio_request		pio_request;
+		struct acrn_pci_request		pci_request;
 		struct acrn_mmio_request	mmio_request;
 		__u64				data[8];
 	} reqs;
-- 
2.28.0

