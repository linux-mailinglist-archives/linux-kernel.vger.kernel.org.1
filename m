Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9B292276
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgJSGUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:20:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:40284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgJSGUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:20:23 -0400
IronPort-SDR: RjuSa1CNE4qYm90ylCfPTgVjH4OvgldsW2M0b2prbdeP9f3tTLohDZyP0o5RLdkacjj66wnYgV
 yKMcGioivxqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="231167715"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="231167715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:20:21 -0700
IronPort-SDR: cBHapaXe6PgmMvqa10V2B2nvmk9mjUa+CCCsgK5bdzhXyx7KbUua0Kn6u+4zuaq8SKf67YBGhn
 HM64irF0PpPg==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="331794950"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:20:16 -0700
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
Subject: [PATCH v5 17/17] virt: acrn: Introduce an interface for Service VM to control vCPU
Date:   Mon, 19 Oct 2020 14:18:03 +0800
Message-Id: <20201019061803.13298-18-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019061803.13298-1-shuo.a.liu@intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

ACRN supports partition mode to achieve real-time requirements. In
partition mode, a CPU core can be dedicated to a vCPU of User VM. The
local APIC of the dedicated CPU core can be passthrough to the User VM.
The Service VM controls the assignment of the CPU cores.

Introduce an interface for the Service VM to remove the control of CPU
core from hypervisor perspective so that the CPU core can be a dedicated
CPU core of User VM.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/hsm.c       | 48 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 14 ++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index c7290e177b1e..8c3799cc0313 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -9,6 +9,7 @@
  *	Yakui Zhao <yakui.zhao@intel.com>
  */
 
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -341,6 +342,52 @@ static int acrn_dev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static ssize_t remove_cpu_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u64 cpu, lapicid;
+	int ret;
+
+	if (kstrtoull(buf, 0, &cpu) < 0)
+		return -EINVAL;
+
+	if (cpu >= num_possible_cpus() || cpu == 0 || !cpu_is_hotpluggable(cpu))
+		return -EINVAL;
+
+	if (cpu_online(cpu))
+		remove_cpu(cpu);
+
+	lapicid = cpu_data(cpu).apicid;
+	dev_dbg(dev, "Try to remove cpu %lld with lapicid %lld\n", cpu, lapicid);
+	ret = hcall_sos_remove_cpu(lapicid);
+	if (ret < 0) {
+		dev_err(dev, "Failed to remove cpu %lld!\n", cpu);
+		goto fail_remove;
+	}
+
+	return count;
+
+fail_remove:
+	add_cpu(cpu);
+	return ret;
+}
+static DEVICE_ATTR_WO(remove_cpu);
+
+static struct attribute *acrn_attrs[] = {
+	&dev_attr_remove_cpu.attr,
+	NULL
+};
+
+static struct attribute_group acrn_attr_group = {
+	.attrs = acrn_attrs,
+};
+
+static const struct attribute_group *acrn_attr_groups[] = {
+	&acrn_attr_group,
+	NULL
+};
+
 static const struct file_operations acrn_fops = {
 	.owner		= THIS_MODULE,
 	.open		= acrn_dev_open,
@@ -352,6 +399,7 @@ struct miscdevice acrn_dev = {
 	.minor	= MISC_DYNAMIC_MINOR,
 	.name	= "acrn_hsm",
 	.fops	= &acrn_fops,
+	.groups	= acrn_attr_groups,
 };
 
 static int __init hsm_init(void)
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index e640632366f0..0cfad05bd1a9 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -13,6 +13,9 @@
 
 #define HC_ID 0x80UL
 
+#define HC_ID_GEN_BASE			0x0UL
+#define HC_SOS_REMOVE_CPU		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x01)
+
 #define HC_ID_VM_BASE			0x10UL
 #define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
 #define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
@@ -42,6 +45,17 @@
 #define HC_ID_PM_BASE			0x80UL
 #define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
 
+/**
+ * hcall_sos_remove_cpu() - Remove a vCPU of Service VM
+ * @cpu: The vCPU to be removed
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_sos_remove_cpu(u64 cpu)
+{
+	return acrn_hypercall1(HC_SOS_REMOVE_CPU, cpu);
+}
+
 /**
  * hcall_create_vm() - Create a User VM
  * @vminfo:	Service VM GPA of info of User VM creation
-- 
2.28.0

