Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015C2C9E45
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbgLAJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:42:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:34669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391061AbgLAJmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:42:24 -0500
IronPort-SDR: FW0kHvT2sumcc70MphRJSkua/dOEWtIcgU7VqcA10fetmfsd0sqbQUkS4DnMisJZx+sLes8Y4+
 mVaosgSsE5xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="236925581"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="236925581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:41:43 -0800
IronPort-SDR: 0D61z/2HnaODzMGuhM/Zbsdle1ROHZVdEcpyjM4q+CQIWQu/cmGYfsYrZfxWr4icujIfd3gO23
 CiVQ9HaCOOXQ==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="537420240"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:41:40 -0800
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
Subject: [PATCH v6 18/18] sample/acrn: Introduce a sample of HSM ioctl interface usage
Date:   Tue,  1 Dec 2020 17:38:53 +0800
Message-Id: <20201201093853.12070-19-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201093853.12070-1-shuo.a.liu@intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

Launch a simple guest (with several instructions as payload) on ACRN
with demonstration ioctl usage.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
---
 samples/acrn/Makefile    |  12 ++++
 samples/acrn/guest.ld    |   9 +++
 samples/acrn/payload.ld  |   9 +++
 samples/acrn/vm-sample.c | 136 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 samples/acrn/Makefile
 create mode 100644 samples/acrn/guest.ld
 create mode 100644 samples/acrn/payload.ld
 create mode 100644 samples/acrn/vm-sample.c

diff --git a/samples/acrn/Makefile b/samples/acrn/Makefile
new file mode 100644
index 000000000000..c8e3ed9785e9
--- /dev/null
+++ b/samples/acrn/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.PHONY: vm-sample
+
+vm-sample: vm-sample.o payload.o
+	$(CC) $^ -o $@
+
+payload.o: payload.ld guest16.o
+	$(LD) -T $< -o $@
+
+clean:
+	rm *.o vm-sample
diff --git a/samples/acrn/guest.ld b/samples/acrn/guest.ld
new file mode 100644
index 000000000000..5127c682bd22
--- /dev/null
+++ b/samples/acrn/guest.ld
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+OUTPUT_FORMAT(binary)
+SECTIONS
+{
+        .start : { *(.start) }
+        .text : { *(.text*) }
+        .rodata : { *(.rodata) }
+        .data : { *(.data) }
+}
diff --git a/samples/acrn/payload.ld b/samples/acrn/payload.ld
new file mode 100644
index 000000000000..e8d9a498ad62
--- /dev/null
+++ b/samples/acrn/payload.ld
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+SECTIONS
+{
+        .payload16 0 : {
+                guest16 = .;
+                guest16.o(.text)
+                guest16_end = .;
+        }
+}
diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
new file mode 100644
index 000000000000..b2dad47a77a0
--- /dev/null
+++ b/samples/acrn/vm-sample.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A sample program to run a User VM on the ACRN hypervisor
+ *
+ * This sample runs in a Service VM, which is a privileged VM of ACRN.
+ * CONFIG_ACRN_HSM need to be enabled in the Service VM.
+ *
+ * Guest VM code in guest16.s will be executed after the VM launched.
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ */
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <malloc.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <linux/acrn.h>
+
+#define GUEST_MEMORY_SIZE	(1024*1024)
+void *guest_memory;
+
+extern const unsigned char guest16[], guest16_end[];
+static char io_request_page[4096] __attribute__((aligned(4096)));
+static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request_page;
+
+__u16 vcpu_num;
+__u16 vmid;
+/* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
+guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
+
+int hsm_fd;
+int is_running = 1;
+
+void vm_exit(int sig)
+{
+	sig = sig;
+
+	is_running = 0;
+	ioctl(hsm_fd, ACRN_IOCTL_PAUSE_VM, vmid);
+	ioctl(hsm_fd, ACRN_IOCTL_DESTROY_IOREQ_CLIENT, 0);
+}
+
+int main(int argc, char **argv)
+{
+	int vcpu_id, ret;
+	struct acrn_vm_creation create_vm = {0};
+	struct acrn_vm_memmap ram_map = {0};
+	struct acrn_vcpu_regs regs;
+	struct acrn_io_request *io_req;
+	struct acrn_ioreq_notify __attribute__((aligned(8))) notify;
+
+	argc = argc;
+	argv = argv;
+
+	guest_memory = memalign(4096, GUEST_MEMORY_SIZE);
+	if (!guest_memory) {
+		printf("No enough memory!\n");
+		return -1;
+	}
+	hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
+
+	memcpy(&create_vm.uuid, &vm_uuid, 16);
+	create_vm.ioreq_buf = (__u64)io_req_buf;
+	ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
+	printf("Created VM! [%d]\n", ret);
+	vcpu_num = create_vm.vcpu_num;
+	vmid = create_vm.vmid;
+
+	/* setup guest memory */
+	ram_map.type = ACRN_MEMMAP_RAM;
+	ram_map.vma_base = (__u64)guest_memory;
+	ram_map.len = GUEST_MEMORY_SIZE;
+	ram_map.user_vm_pa = 0;
+	ram_map.attr = ACRN_MEM_ACCESS_RWX;
+	ret = ioctl(hsm_fd, ACRN_IOCTL_SET_MEMSEG, &ram_map);
+	printf("Set up VM memory! [%d]\n", ret);
+
+	memcpy(guest_memory, guest16, guest16_end-guest16);
+
+	/* setup vcpu registers */
+	memset(&regs, 0, sizeof(regs));
+	regs.vcpu_id = 0;
+	regs.vcpu_regs.rip = 0;
+
+	/* CR0_ET | CR0_NE */
+	regs.vcpu_regs.cr0 = 0x30U;
+	regs.vcpu_regs.cs_ar = 0x009FU;
+	regs.vcpu_regs.cs_sel = 0xF000U;
+	regs.vcpu_regs.cs_limit = 0xFFFFU;
+	regs.vcpu_regs.cs_base = 0 & 0xFFFF0000UL;
+	regs.vcpu_regs.rip = 0 & 0xFFFFUL;
+
+	ret = ioctl(hsm_fd, ACRN_IOCTL_SET_VCPU_REGS, &regs);
+	printf("Set up VM BSP registers! [%d]\n", ret);
+
+	/* create an ioreq client for this VM */
+	ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_IOREQ_CLIENT, 0);
+	printf("Created IO request client! [%d]\n", ret);
+
+	/* run vm */
+	ret = ioctl(hsm_fd, ACRN_IOCTL_START_VM, vmid);
+	printf("Start VM! [%d]\n", ret);
+
+	signal(SIGINT, vm_exit);
+	while (is_running) {
+		ret = ioctl(hsm_fd, ACRN_IOCTL_ATTACH_IOREQ_CLIENT, 0);
+
+		for (vcpu_id = 0; vcpu_id < vcpu_num; vcpu_id++) {
+			io_req = &io_req_buf[vcpu_id];
+			if ((__sync_add_and_fetch(&io_req->processed, 0) == ACRN_IOREQ_STATE_PROCESSING)
+					&& (!io_req->kernel_handled))
+				if (io_req->type == ACRN_IOREQ_TYPE_PORTIO) {
+					int bytes, port, in;
+
+					port = io_req->reqs.pio_request.address;
+					bytes = io_req->reqs.pio_request.size;
+					in = (io_req->reqs.pio_request.direction == ACRN_IOREQ_DIR_READ);
+					printf("Guest VM %s PIO[%x] with size[%x]\n", in ? "read" : "write", port, bytes);
+
+					notify.vmid = vmid;
+					notify.vcpu = vcpu_id;
+					ioctl(hsm_fd, ACRN_IOCTL_NOTIFY_REQUEST_FINISH, &notify);
+				}
+		}
+	}
+
+	ret = ioctl(hsm_fd, ACRN_IOCTL_DESTROY_VM, NULL);
+	printf("Destroy VM! [%d]\n", ret);
+	close(hsm_fd);
+	free(guest_memory);
+	return 0;
+}
-- 
2.28.0

