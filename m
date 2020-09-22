Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A479627412E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIVLrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:47:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:24263 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgIVLpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:45:35 -0400
IronPort-SDR: P8GeV2O9A2djUvxH57x7NUeBwY0tlj9lIVnXAAxnfubR7VvPfTbinqRqOQUsLSvO90WYZwu4mu
 YaSmlCy3MGzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="245423697"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="245423697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:45:29 -0700
IronPort-SDR: WzcswtkjLIMSDfQETjF3P5QHqIYeq9N6aHhyWv+R9PQlz2/nVsw42zI0PGaZaS5p/IhKve90MX
 UFCl4S5IndOg==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="485922857"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:45:19 -0700
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
Subject: [PATCH v4 16/17] virt: acrn: Introduce irqfd
Date:   Tue, 22 Sep 2020 19:43:10 +0800
Message-Id: <20200922114311.38804-17-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114311.38804-1-shuo.a.liu@intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

irqfd is a mechanism to inject a specific interrupt to a User VM using a
decoupled eventfd mechanism.

Vhost is a kernel-level virtio server which uses eventfd for interrupt
injection. To support vhost on ACRN, irqfd is introduced in HSM.

HSM provides ioctls to associate a virtual Message Signaled Interrupt
(MSI) with an eventfd. The corresponding virtual MSI will be injected
into a User VM once the eventfd got signal.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/Makefile   |   2 +-
 drivers/virt/acrn/acrn_drv.h |  10 ++
 drivers/virt/acrn/hsm.c      |   7 ++
 drivers/virt/acrn/irqfd.c    | 235 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c       |   3 +
 include/uapi/linux/acrn.h    |  15 +++
 6 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/acrn/irqfd.c

diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index 755b583b32ca..08ce641dcfa1 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o vm.o mm.o ioreq.o ioeventfd.o
+acrn-y := hsm.o vm.o mm.o ioreq.o ioeventfd.o irqfd.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index c66c620b9f10..8354d0d5881c 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -161,6 +161,9 @@ extern rwlock_t acrn_vm_list_lock;
  * @ioeventfds_lock:		Lock to protect ioeventfds list
  * @ioeventfds:			List to link all hsm_ioeventfd
  * @ioeventfd_client:		I/O client for ioeventfds of the VM
+ * @irqfds_lock:		Lock to protect irqfds list
+ * @irqfds:			List to link all hsm_irqfd
+ * @irqfd_wq:			Workqueue for irqfd async shutdown
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -180,6 +183,9 @@ struct acrn_vm {
 	struct mutex			ioeventfds_lock;
 	struct list_head		ioeventfds;
 	struct acrn_ioreq_client	*ioeventfd_client;
+	struct mutex			irqfds_lock;
+	struct list_head		irqfds;
+	struct workqueue_struct		*irqfd_wq;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -216,4 +222,8 @@ int acrn_ioeventfd_init(struct acrn_vm *vm);
 int acrn_ioeventfd_config(struct acrn_vm *vm, struct acrn_ioeventfd *args);
 void acrn_ioeventfd_deinit(struct acrn_vm *vm);
 
+int acrn_irqfd_init(struct acrn_vm *vm);
+int acrn_irqfd_config(struct acrn_vm *vm, struct acrn_irqfd *args);
+void acrn_irqfd_deinit(struct acrn_vm *vm);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 40ec16a21308..aaf4e76d27b4 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -115,6 +115,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vm_memmap memmap;
 	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
+	struct acrn_irqfd irqfd;
 	struct page *page;
 	u64 cstate_cmd;
 	int ret = 0;
@@ -317,6 +318,12 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
 		ret = acrn_ioeventfd_config(vm, &ioeventfd);
 		break;
+	case ACRN_IOCTL_IRQFD:
+		if (copy_from_user(&irqfd, (void __user *)ioctl_param,
+				   sizeof(irqfd)))
+			return -EFAULT;
+		ret = acrn_irqfd_config(vm, &irqfd);
+		break;
 	default:
 		dev_warn(acrn_dev.this_device, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
new file mode 100644
index 000000000000..a8766d528e29
--- /dev/null
+++ b/drivers/virt/acrn/irqfd.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN HSM irqfd: use eventfd objects to inject virtual interrupts
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Shuo Liu <shuo.a.liu@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+static LIST_HEAD(acrn_irqfd_clients);
+static DEFINE_MUTEX(acrn_irqfds_mutex);
+
+/**
+ * struct hsm_irqfd - Properties of HSM irqfd
+ * @vm:		Associated VM pointer
+ * @wait:	Entry of wait-queue
+ * @shutdown:	Async shutdown work
+ * @eventfd:	Associated eventfd
+ * @list:	Entry within &acrn_vm.irqfds of irqfds of a VM
+ * @pt:		Structure for select/poll on the associated eventfd
+ * @msi:	MSI data
+ */
+struct hsm_irqfd {
+	struct acrn_vm		*vm;
+	wait_queue_entry_t	wait;
+	struct work_struct	shutdown;
+	struct eventfd_ctx	*eventfd;
+	struct list_head	list;
+	poll_table		pt;
+	struct acrn_msi_entry	msi;
+};
+
+static void acrn_irqfd_inject(struct hsm_irqfd *irqfd)
+{
+	struct acrn_vm *vm = irqfd->vm;
+
+	acrn_msi_inject(vm, irqfd->msi.msi_addr,
+			irqfd->msi.msi_data);
+}
+
+static void hsm_irqfd_shutdown(struct hsm_irqfd *irqfd)
+{
+	u64 cnt;
+
+	lockdep_assert_held(&irqfd->vm->irqfds_lock);
+
+	/* remove from wait queue */
+	list_del_init(&irqfd->list);
+	eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+static void hsm_irqfd_shutdown_work(struct work_struct *work)
+{
+	struct hsm_irqfd *irqfd;
+	struct acrn_vm *vm;
+
+	irqfd = container_of(work, struct hsm_irqfd, shutdown);
+	vm = irqfd->vm;
+	mutex_lock(&vm->irqfds_lock);
+	if (!list_empty(&irqfd->list))
+		hsm_irqfd_shutdown(irqfd);
+	mutex_unlock(&vm->irqfds_lock);
+}
+
+/* Called with wqh->lock held and interrupts disabled */
+static int hsm_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+			    int sync, void *key)
+{
+	unsigned long poll_bits = (unsigned long)key;
+	struct hsm_irqfd *irqfd;
+	struct acrn_vm *vm;
+
+	irqfd = container_of(wait, struct hsm_irqfd, wait);
+	vm = irqfd->vm;
+	if (poll_bits & POLLIN)
+		/* An event has been signaled, inject an interrupt */
+		acrn_irqfd_inject(irqfd);
+
+	if (poll_bits & POLLHUP)
+		/* Do shutdown work in thread to hold wqh->lock */
+		queue_work(vm->irqfd_wq, &irqfd->shutdown);
+
+	return 0;
+}
+
+static void hsm_irqfd_poll_func(struct file *file, wait_queue_head_t *wqh,
+				poll_table *pt)
+{
+	struct hsm_irqfd *irqfd;
+
+	irqfd = container_of(pt, struct hsm_irqfd, pt);
+	add_wait_queue(wqh, &irqfd->wait);
+}
+
+/*
+ * Assign an eventfd to a VM and create a HSM irqfd associated with the
+ * eventfd. The properties of the HSM irqfd are built from a &struct
+ * acrn_irqfd.
+ */
+static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
+{
+	struct eventfd_ctx *eventfd = NULL;
+	struct hsm_irqfd *irqfd, *tmp;
+	unsigned int events;
+	struct fd f;
+	int ret = 0;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->vm = vm;
+	memcpy(&irqfd->msi, &args->msi, sizeof(args->msi));
+	INIT_LIST_HEAD(&irqfd->list);
+	INIT_WORK(&irqfd->shutdown, hsm_irqfd_shutdown_work);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	/*
+	 * Install custom wake-up handling to be notified whenever underlying
+	 * eventfd is signaled.
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, hsm_irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, hsm_irqfd_poll_func);
+
+	mutex_lock(&vm->irqfds_lock);
+	list_for_each_entry(tmp, &vm->irqfds, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		ret = -EBUSY;
+		mutex_unlock(&vm->irqfds_lock);
+		goto fail;
+	}
+	list_add_tail(&irqfd->list, &vm->irqfds);
+	mutex_unlock(&vm->irqfds_lock);
+
+	/* Check the pending event in this stage */
+	events = f.file->f_op->poll(f.file, &irqfd->pt);
+
+	if (events & POLLIN)
+		acrn_irqfd_inject(irqfd);
+
+	fdput(f);
+	return 0;
+fail:
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+static int acrn_irqfd_deassign(struct acrn_vm *vm,
+			       struct acrn_irqfd *args)
+{
+	struct hsm_irqfd *irqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	mutex_lock(&vm->irqfds_lock);
+	list_for_each_entry_safe(irqfd, tmp, &vm->irqfds, list) {
+		if (irqfd->eventfd == eventfd) {
+			hsm_irqfd_shutdown(irqfd);
+			break;
+		}
+	}
+	mutex_unlock(&vm->irqfds_lock);
+	eventfd_ctx_put(eventfd);
+
+	return 0;
+}
+
+int acrn_irqfd_config(struct acrn_vm *vm, struct acrn_irqfd *args)
+{
+	int ret;
+
+	if (args->flags & ACRN_IRQFD_FLAG_DEASSIGN)
+		ret = acrn_irqfd_deassign(vm, args);
+	else
+		ret = acrn_irqfd_assign(vm, args);
+
+	return ret;
+}
+
+int acrn_irqfd_init(struct acrn_vm *vm)
+{
+	INIT_LIST_HEAD(&vm->irqfds);
+	mutex_init(&vm->irqfds_lock);
+	vm->irqfd_wq = alloc_workqueue("acrn_irqfd-%u", 0, 0, vm->vmid);
+	if (!vm->irqfd_wq)
+		return -ENOMEM;
+
+	dev_dbg(acrn_dev.this_device, "VM %u irqfd init.\n", vm->vmid);
+	return 0;
+}
+
+void acrn_irqfd_deinit(struct acrn_vm *vm)
+{
+	struct hsm_irqfd *irqfd, *next;
+
+	dev_dbg(acrn_dev.this_device, "VM %u irqfd deinit.\n", vm->vmid);
+	destroy_workqueue(vm->irqfd_wq);
+	mutex_lock(&vm->irqfds_lock);
+	list_for_each_entry_safe(irqfd, next, &vm->irqfds, list)
+		hsm_irqfd_shutdown(irqfd);
+	mutex_unlock(&vm->irqfds_lock);
+}
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 3c671b03b273..7f152a74b591 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -51,6 +51,7 @@ struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
 	write_unlock_bh(&acrn_vm_list_lock);
 
 	acrn_ioeventfd_init(vm);
+	acrn_irqfd_init(vm);
 	dev_dbg(acrn_dev.this_device, "VM %u created.\n", vm->vmid);
 	return vm;
 }
@@ -69,7 +70,9 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	write_unlock_bh(&acrn_vm_list_lock);
 
 	acrn_ioeventfd_deinit(vm);
+	acrn_irqfd_deinit(vm);
 	acrn_ioreq_deinit(vm);
+
 	if (vm->monitor_page) {
 		put_page(vm->monitor_page);
 		vm->monitor_page = NULL;
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 7a99124c7d4d..75a687838a43 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -411,6 +411,19 @@ struct acrn_ioeventfd {
 	__u64	data;
 };
 
+#define ACRN_IRQFD_FLAG_DEASSIGN	0x01
+/**
+ * struct acrn_irqfd - Data to operate a &struct hsm_irqfd
+ * @fd:		The fd of eventfd associated with a hsm_irqfd
+ * @flags:	Logical-OR of ACRN_IRQFD_FLAG_*
+ * @msi:	Info of MSI associated with the irqfd
+ */
+struct acrn_irqfd {
+	__s32			fd;
+	__u32			flags;
+	struct acrn_msi_entry	msi;
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -467,5 +480,7 @@ struct acrn_ioeventfd {
 
 #define ACRN_IOCTL_IOEVENTFD		\
 	_IOW(ACRN_IOCTL_TYPE, 0x70, struct acrn_ioeventfd)
+#define ACRN_IOCTL_IRQFD		\
+	_IOW(ACRN_IOCTL_TYPE, 0x71, struct acrn_irqfd)
 
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

