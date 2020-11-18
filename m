Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000112B8240
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKRQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:48:40 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:53248 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbgKRQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:48:39 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGkZ5u005808;
        Wed, 18 Nov 2020 16:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ZsWZ/d+WoIZNYJfi1E8I4QrPg0VgiLNkzEpI5UcCubs=;
 b=k1spNJevJkmhksxo+9i+TNFFqbLyXZYUQAWnvc7zEPNJtsVmbGggLA4djZosTnuXpZse
 Mlt/TbxKpq0ilclXz7hfQsPBKo5PRy+PKkpsxKVHFtIGpvxf+glXXN4f7mJruoOIv+oE
 Iq2LdENs3K/F30UTnZ3MaVfdfv6pAyqpLyjk0TvF8sonPYnj+GNcgQ0VHxa7hItEsu/3
 v/wf9T7Bw5Yjr1PLBqZAidGxCnWlad4oyq6Nitre4RKK7psvRzH/peZ4Tm50yjZ4J58g
 mZ6psCMhueLBGQ7OIiYGRs+YKbysQs8rhqo2QsVPqYmFfsdbMey29MigjOXnbKLq7xp1 zg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vpyq7cqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:48:03 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 98EE693;
        Wed, 18 Nov 2020 16:48:02 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 60B9737;
        Wed, 18 Nov 2020 16:48:02 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 1B6533003D756; Wed, 18 Nov 2020 10:48:02 -0600 (CST)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH v2 3/5] x86/platform/uv: Add new uv_sysfs platform driver
Date:   Wed, 18 Nov 2020 10:47:45 -0600
Message-Id: <20201118164747.236259-4-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201118164747.236259-1-justin.ernst@hpe.com>
References: <20201118164747.236259-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_06:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the uv_sysfs driver to construct a read-only sysfs interface at
/sys/firmware/sgi_uv/ to expose information gathered from UV BIOS.
This information includes:
	UV Hub descriptions, including physical location
	Cabling layout between hubs on the fabric
	PCI topology, including physical location of PCI cards

Together, the information provides a robust physical description of a
UV system, useful for correlating to performance data or performing
remote support.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/platform/x86/Kconfig    |  11 +
 drivers/platform/x86/Makefile   |   3 +
 drivers/platform/x86/uv_sysfs.c | 862 ++++++++++++++++++++++++++++++++
 3 files changed, 876 insertions(+)
 create mode 100644 drivers/platform/x86/uv_sysfs.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0d91d136bc3b..ba34153571b8 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -78,6 +78,17 @@ config HUAWEI_WMI
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
 
+config UV_SYSFS
+	tristate "Sysfs structure for UV systems"
+	depends on X86_UV
+	depends on SYSFS
+	help
+	  This driver supports a sysfs tree describing information about
+	  UV systems at /sys/firmware/sgi_uv/.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called uv_sysfs.
+
 config INTEL_WMI_SBL_FW_UPDATE
 	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5f823f7eff45..a34875d833dd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -62,6 +62,9 @@ obj-$(CONFIG_HP_WIRELESS)	+= hp-wireless.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
 
+# Hewlett Packard Enterprise
+obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
+
 # IBM Thinkpad and Lenovo
 obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
 obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
new file mode 100644
index 000000000000..02206401f0ed
--- /dev/null
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -0,0 +1,862 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file supports the /sys/firmware/sgi_uv topology tree on HPE UV.
+ *
+ *  Copyright (c) 2020 Hewlett Packard Enterprise.  All Rights Reserved.
+ *  Copyright (c) Justin Ernst
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/kobject.h>
+#include <asm/uv/bios.h>
+#include <asm/uv/uv.h>
+#include <asm/uv/uv_hub.h>
+#include <asm/uv/uv_geo.h>
+
+#define INVALID_CNODE -1
+
+struct kobject *sgi_uv_kobj;
+struct kset *uv_pcibus_kset;
+struct kset *uv_hubs_kset;
+static struct uv_bios_hub_info *hub_buf;
+static struct uv_bios_port_info **port_buf;
+static struct uv_hub **uv_hubs;
+static struct uv_pci_top_obj **uv_pci_objs;
+static int num_pci_lines;
+static int num_cnodes;
+static int *prev_obj_to_cnode;
+static int uv_bios_obj_cnt;
+static signed short uv_master_nasid = -1;
+static void *uv_biosheap;
+
+static const char *uv_type_string(void)
+{
+	if (is_uv5_hub())
+		return "9.0";
+	else if (is_uv4a_hub())
+		return "7.1";
+	else if (is_uv4_hub())
+		return "7.0";
+	else if (is_uv3_hub())
+		return "5.0";
+	else if (is_uv2_hub())
+		return "3.0";
+	else
+		return "unknown";
+}
+
+static int ordinal_to_nasid(int ordinal)
+{
+	if (ordinal < num_cnodes && ordinal >= 0)
+		return UV_PNODE_TO_NASID(uv_blade_to_pnode(ordinal));
+	else
+		return -1;
+}
+
+static union geoid_u cnode_to_geoid(int cnode)
+{
+	union geoid_u geoid;
+
+	uv_bios_get_geoinfo(ordinal_to_nasid(cnode), (u64)sizeof(union geoid_u), (u64 *)&geoid);
+	return geoid;
+}
+
+static int location_to_bpos(char *location, int *rack, int *slot, int *blade)
+{
+	char type, r, b, h;
+	int idb, idh;
+
+	if (sscanf(location, "%c%03d%c%02d%c%2d%c%d",
+			 &r, rack, &type, slot, &b, &idb, &h, &idh) != 8)
+		return -1;
+	*blade = idb * 2 + idh;
+
+	return 0;
+}
+
+static int cache_obj_to_cnode(struct uv_bios_hub_info *obj)
+{
+	int cnode;
+	union geoid_u geoid;
+	int obj_rack, obj_slot, obj_blade;
+	int rack, slot, blade;
+
+	if (!obj->f.fields.this_part && !obj->f.fields.is_shared)
+		return 0;
+
+	if (location_to_bpos(obj->location, &obj_rack, &obj_slot, &obj_blade))
+		return -1;
+
+	for (cnode = 0; cnode < num_cnodes; cnode++) {
+		geoid = cnode_to_geoid(cnode);
+		rack = geo_rack(geoid);
+		slot = geo_slot(geoid);
+		blade = geo_blade(geoid);
+		if (obj_rack == rack && obj_slot == slot && obj_blade == blade)
+			prev_obj_to_cnode[obj->id] = cnode;
+	}
+
+	return 0;
+}
+
+static int get_obj_to_cnode(int obj_id)
+{
+	return prev_obj_to_cnode[obj_id];
+}
+
+struct uv_hub {
+	struct kobject kobj;
+	struct uv_bios_hub_info *hub_info;
+	struct uv_port **ports;
+};
+
+#define to_uv_hub(kobj_ptr) container_of(kobj_ptr, struct uv_hub, kobj)
+
+static ssize_t hub_name_show(struct uv_bios_hub_info *hub_info, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", hub_info->name);
+}
+
+static ssize_t hub_location_show(struct uv_bios_hub_info *hub_info, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", hub_info->location);
+}
+
+static ssize_t hub_partition_show(struct uv_bios_hub_info *hub_info, char *buf)
+{
+	return sprintf(buf, "%d\n", hub_info->f.fields.this_part);
+}
+
+static ssize_t hub_shared_show(struct uv_bios_hub_info *hub_info, char *buf)
+{
+	return sprintf(buf, "%d\n", hub_info->f.fields.is_shared);
+}
+static ssize_t hub_nasid_show(struct uv_bios_hub_info *hub_info, char *buf)
+{
+	int cnode = get_obj_to_cnode(hub_info->id);
+
+	return sprintf(buf, "%d\n", ordinal_to_nasid(cnode));
+}
+static ssize_t hub_cnode_show(struct uv_bios_hub_info *hub_info, char *buf)
+{
+	return sprintf(buf, "%d\n", get_obj_to_cnode(hub_info->id));
+}
+
+struct hub_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct uv_bios_hub_info *hub_info, char *buf);
+	ssize_t (*store)(struct uv_bios_hub_info *hub_info, const char *buf, size_t sz);
+};
+
+static struct hub_sysfs_entry name_attribute =
+	__ATTR(name, 0444, hub_name_show, NULL);
+static struct hub_sysfs_entry location_attribute =
+	__ATTR(location, 0444, hub_location_show, NULL);
+static struct hub_sysfs_entry partition_attribute =
+	__ATTR(this_partition, 0444, hub_partition_show, NULL);
+static struct hub_sysfs_entry shared_attribute =
+	__ATTR(shared, 0444, hub_shared_show, NULL);
+static struct hub_sysfs_entry nasid_attribute =
+	__ATTR(nasid, 0444, hub_nasid_show, NULL);
+static struct hub_sysfs_entry cnode_attribute =
+	__ATTR(cnode, 0444, hub_cnode_show, NULL);
+
+static struct attribute *uv_hub_attrs[] = {
+	&name_attribute.attr,
+	&location_attribute.attr,
+	&partition_attribute.attr,
+	&shared_attribute.attr,
+	&nasid_attribute.attr,
+	&cnode_attribute.attr,
+	NULL,
+};
+
+static void hub_release(struct kobject *kobj)
+{
+	struct uv_hub *hub = to_uv_hub(kobj);
+
+	kfree(hub);
+}
+
+static ssize_t hub_type_show(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	struct uv_hub *hub = to_uv_hub(kobj);
+	struct uv_bios_hub_info *bios_hub_info = hub->hub_info;
+	struct hub_sysfs_entry *entry;
+
+	entry = container_of(attr, struct hub_sysfs_entry, attr);
+
+	if (!entry->show)
+		return -EIO;
+
+	return entry->show(bios_hub_info, buf);
+}
+
+static const struct sysfs_ops hub_sysfs_ops = {
+	.show = hub_type_show,
+};
+
+static struct kobj_type hub_attr_type = {
+	.release	= hub_release,
+	.sysfs_ops	= &hub_sysfs_ops,
+	.default_attrs	= uv_hub_attrs,
+};
+
+static int uv_hubs_init(void)
+{
+	s64 biosr;
+	u64 sz;
+	int i, ret;
+
+	prev_obj_to_cnode = kmalloc_array(uv_bios_obj_cnt, sizeof(*prev_obj_to_cnode),
+					 GFP_KERNEL);
+	if (!prev_obj_to_cnode)
+		return -ENOMEM;
+
+	for (i = 0; i < uv_bios_obj_cnt; i++)
+		prev_obj_to_cnode[i] = INVALID_CNODE;
+
+	uv_hubs_kset = kset_create_and_add("hubs", NULL, sgi_uv_kobj);
+	if (!uv_hubs_kset) {
+		ret = -ENOMEM;
+		goto err_hubs_kset;
+	}
+	sz = uv_bios_obj_cnt * sizeof(*hub_buf);
+	hub_buf = kzalloc(sz, GFP_KERNEL);
+	if (!hub_buf) {
+		ret = -ENOMEM;
+		goto err_hub_buf;
+	}
+
+	biosr = uv_bios_enum_objs((u64)uv_master_nasid, sz, (u64 *)hub_buf);
+	if (biosr) {
+		ret = -EINVAL;
+		goto err_enum_objs;
+	}
+
+	uv_hubs = kcalloc(uv_bios_obj_cnt, sizeof(*uv_hubs), GFP_KERNEL);
+	if (!uv_hubs) {
+		ret = -ENOMEM;
+		goto err_enum_objs;
+	}
+
+	for (i = 0; i < uv_bios_obj_cnt; i++) {
+		uv_hubs[i] = kzalloc(sizeof(*uv_hubs[i]), GFP_KERNEL);
+		if (!uv_hubs[i]) {
+			i--;
+			goto err_hubs;
+		}
+
+		uv_hubs[i]->hub_info = &hub_buf[i];
+		cache_obj_to_cnode(uv_hubs[i]->hub_info);
+
+		uv_hubs[i]->kobj.kset = uv_hubs_kset;
+
+		ret = kobject_init_and_add(&uv_hubs[i]->kobj, &hub_attr_type,
+					  NULL, "hub_%u", hub_buf[i].id);
+		if (ret)
+			goto err_hubs;
+		kobject_uevent(&uv_hubs[i]->kobj, KOBJ_ADD);
+	}
+	return 0;
+
+err_hubs:
+	for (; i >= 0; i--)
+		kobject_put(&uv_hubs[i]->kobj);
+	kfree(uv_hubs);
+err_enum_objs:
+	kfree(hub_buf);
+err_hub_buf:
+	kset_unregister(uv_hubs_kset);
+err_hubs_kset:
+	kfree(prev_obj_to_cnode);
+	return ret;
+
+}
+
+static void uv_hubs_exit(void)
+{
+	int i;
+
+	for (i = 0; i < uv_bios_obj_cnt; i++)
+		kobject_put(&uv_hubs[i]->kobj);
+
+	kfree(uv_hubs);
+	kfree(hub_buf);
+	kset_unregister(uv_hubs_kset);
+	kfree(prev_obj_to_cnode);
+}
+
+struct uv_port {
+	struct kobject kobj;
+	struct uv_bios_port_info *port_info;
+};
+
+#define to_uv_port(kobj_ptr) container_of(kobj_ptr, struct uv_port, kobj)
+
+static ssize_t uv_port_conn_hub_show(struct uv_bios_port_info *port, char *buf)
+{
+	return sprintf(buf, "%d\n", port->conn_id);
+}
+
+static ssize_t uv_port_conn_port_show(struct uv_bios_port_info *port, char *buf)
+{
+	return sprintf(buf, "%d\n", port->conn_port);
+}
+
+struct uv_port_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct uv_bios_port_info *port_info, char *buf);
+	ssize_t (*store)(struct uv_bios_port_info *port_info, const char *buf, size_t size);
+};
+
+static struct uv_port_sysfs_entry uv_port_conn_hub_attribute =
+	__ATTR(conn_hub, 0444, uv_port_conn_hub_show, NULL);
+static struct uv_port_sysfs_entry uv_port_conn_port_attribute =
+	__ATTR(conn_port, 0444, uv_port_conn_port_show, NULL);
+
+static struct attribute *uv_port_attrs[] = {
+	&uv_port_conn_hub_attribute.attr,
+	&uv_port_conn_port_attribute.attr,
+	NULL,
+};
+
+static void uv_port_release(struct kobject *kobj)
+{
+	struct uv_port *port = to_uv_port(kobj);
+
+	kfree(port);
+}
+
+static ssize_t uv_port_type_show(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	struct uv_port *port = to_uv_port(kobj);
+	struct uv_bios_port_info *port_info = port->port_info;
+	struct uv_port_sysfs_entry *entry;
+
+	entry = container_of(attr, struct uv_port_sysfs_entry, attr);
+
+	if (!entry->show)
+		return -EIO;
+
+	return entry->show(port_info, buf);
+}
+
+static const struct sysfs_ops uv_port_sysfs_ops = {
+	.show = uv_port_type_show,
+};
+
+static struct kobj_type uv_port_attr_type = {
+	.release	= uv_port_release,
+	.sysfs_ops	= &uv_port_sysfs_ops,
+	.default_attrs	= uv_port_attrs,
+};
+
+static int uv_ports_init(void)
+{
+	s64 biosr;
+	int j = 0, k = 0, ret, sz;
+
+	port_buf = kcalloc(uv_bios_obj_cnt, sizeof(*port_buf), GFP_KERNEL);
+	if (!port_buf)
+		return -ENOMEM;
+
+	for (j = 0; j < uv_bios_obj_cnt; j++) {
+		sz = hub_buf[j].ports * sizeof(*port_buf[j]);
+		port_buf[j] = kzalloc(sz, GFP_KERNEL);
+		if (!port_buf[j]) {
+			ret = -ENOMEM;
+			j--;
+			goto err_port_info;
+		}
+		biosr = uv_bios_enum_ports((u64)uv_master_nasid, (u64)hub_buf[j].id, sz,
+					(u64 *)port_buf[j]);
+		if (biosr) {
+			ret = -EINVAL;
+			goto err_port_info;
+		}
+	}
+	for (j = 0; j < uv_bios_obj_cnt; j++) {
+		uv_hubs[j]->ports = kcalloc(hub_buf[j].ports,
+					   sizeof(*uv_hubs[j]->ports), GFP_KERNEL);
+		if (!uv_hubs[j]->ports) {
+			ret = -ENOMEM;
+			j--;
+			goto err_ports;
+		}
+	}
+	for (j = 0; j < uv_bios_obj_cnt; j++) {
+		for (k = 0; k < hub_buf[j].ports; k++) {
+			uv_hubs[j]->ports[k] = kzalloc(sizeof(*uv_hubs[j]->ports[k]), GFP_KERNEL);
+			if (!uv_hubs[j]->ports[k]) {
+				ret = -ENOMEM;
+				k--;
+				goto err_kobj_ports;
+			}
+			uv_hubs[j]->ports[k]->port_info = &port_buf[j][k];
+			ret = kobject_init_and_add(&uv_hubs[j]->ports[k]->kobj, &uv_port_attr_type,
+					&uv_hubs[j]->kobj, "port_%d", port_buf[j][k].port);
+			if (ret)
+				goto err_kobj_ports;
+			kobject_uevent(&uv_hubs[j]->ports[k]->kobj, KOBJ_ADD);
+		}
+	}
+	return 0;
+
+err_kobj_ports:
+	for (; j >= 0; j--) {
+		for (; k >= 0; k--)
+			kobject_put(&uv_hubs[j]->ports[k]->kobj);
+		if (j > 0)
+			k = hub_buf[j-1].ports - 1;
+	}
+	j = uv_bios_obj_cnt - 1;
+err_ports:
+	for (; j >= 0; j--)
+		kfree(uv_hubs[j]->ports);
+	j = uv_bios_obj_cnt - 1;
+err_port_info:
+	for (; j >= 0; j--)
+		kfree(port_buf[j]);
+	kfree(port_buf);
+	return ret;
+}
+
+static void uv_ports_exit(void)
+{
+	int j, k;
+
+	for (j = 0; j < uv_bios_obj_cnt; j++) {
+		for (k = hub_buf[j].ports; k >= 0; k--)
+			kobject_put(&uv_hubs[j]->ports[k]->kobj);
+	}
+	for (j = 0; j < uv_bios_obj_cnt; j++) {
+		kfree(uv_hubs[j]->ports);
+		kfree(port_buf[j]);
+	}
+	kfree(port_buf);
+}
+
+struct uv_pci_top_obj {
+	struct kobject kobj;
+	char *type;
+	char *location;
+	int iio_stack;
+	char *ppb_addr;
+	int slot;
+};
+
+#define to_uv_pci_top_obj(kobj_ptr) container_of(kobj_ptr, struct uv_pci_top_obj, kobj)
+
+static ssize_t uv_pci_type_show(struct uv_pci_top_obj *top_obj, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->type);
+}
+
+static ssize_t uv_pci_location_show(struct uv_pci_top_obj *top_obj, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->location);
+}
+
+static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)
+{
+	return sprintf(buf, "%d\n", top_obj->iio_stack);
+}
+
+static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->ppb_addr);
+}
+
+static ssize_t uv_pci_slot_show(struct uv_pci_top_obj *top_obj, char *buf)
+{
+	return sprintf(buf, "%d\n", top_obj->slot);
+}
+
+struct uv_pci_top_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct uv_pci_top_obj *top_obj, char *buf);
+	ssize_t (*store)(struct uv_pci_top_obj *top_obj, const char *buf, size_t size);
+};
+
+static struct uv_pci_top_sysfs_entry uv_pci_type_attribute =
+	__ATTR(type, 0444, uv_pci_type_show, NULL);
+static struct uv_pci_top_sysfs_entry uv_pci_location_attribute =
+	__ATTR(location, 0444, uv_pci_location_show, NULL);
+static struct uv_pci_top_sysfs_entry uv_pci_iio_stack_attribute =
+	__ATTR(iio_stack, 0444, uv_pci_iio_stack_show, NULL);
+static struct uv_pci_top_sysfs_entry uv_pci_ppb_addr_attribute =
+	__ATTR(ppb_addr, 0444, uv_pci_ppb_addr_show, NULL);
+static struct uv_pci_top_sysfs_entry uv_pci_slot_attribute =
+	__ATTR(slot, 0444, uv_pci_slot_show, NULL);
+
+static void uv_pci_top_release(struct kobject *kobj)
+{
+	struct uv_pci_top_obj *top_obj = to_uv_pci_top_obj(kobj);
+
+	kfree(top_obj->type);
+	kfree(top_obj->location);
+	kfree(top_obj->ppb_addr);
+	kfree(top_obj);
+}
+
+static ssize_t pci_top_type_show(struct kobject *kobj,
+			struct attribute *attr, char *buf)
+{
+	struct uv_pci_top_obj *top_obj = to_uv_pci_top_obj(kobj);
+	struct uv_pci_top_sysfs_entry *entry;
+
+	entry = container_of(attr, struct uv_pci_top_sysfs_entry, attr);
+
+	if (!entry->show)
+		return -EIO;
+
+	return entry->show(top_obj, buf);
+}
+
+static const struct sysfs_ops uv_pci_top_sysfs_ops = {
+	.show = pci_top_type_show,
+};
+
+static struct kobj_type uv_pci_top_attr_type = {
+	.release	= uv_pci_top_release,
+	.sysfs_ops	= &uv_pci_top_sysfs_ops,
+};
+
+static int init_pci_top_obj(struct uv_pci_top_obj *top_obj, char *line)
+{
+	char *start;
+	char type[11], location[14], ppb_addr[15];
+	int str_cnt, ret;
+	unsigned int tmp_match[2];
+
+	// Minimum line length
+	if (strlen(line) < 36)
+		return -EINVAL;
+
+	//Line must match format "pcibus %4x:%2x" to be valid
+	str_cnt = sscanf(line, "pcibus %4x:%2x", &tmp_match[0], &tmp_match[1]);
+	if (str_cnt < 2)
+		return -EINVAL;
+
+	/* Connect pcibus to segment:bus number with '_'
+	 * to concatenate name tokens.
+	 * pcibus 0000:00 ... -> pcibus_0000:00 ...
+	 */
+	line[6] = '_';
+
+	/* Null terminate after the concatencated name tokens
+	 * to produce kobj name string.
+	 */
+	line[14] = '\0';
+
+	// Use start to index after name tokens string for remainder of line info.
+	start = &line[15];
+
+	top_obj->iio_stack = -1;
+	top_obj->slot = -1;
+
+	/* r001i01b00h0 BASE IO (IIO Stack 0)
+	 * r001i01b00h1 PCIe IO (IIO Stack 1)
+	 * r001i01b03h1 PCIe SLOT
+	 * r001i01b00h0 NODE IO
+	 * r001i01b00h0 Riser
+	 * (IIO Stack #) may not be present.
+	 */
+	if (start[0] == 'r') {
+		str_cnt = sscanf(start, "%13s %10[^(] %*s %*s %d)",
+				location, type, &top_obj->iio_stack);
+		if (str_cnt < 2)
+			return -EINVAL;
+		top_obj->type = kstrdup(type, GFP_KERNEL);
+		if (!top_obj->type)
+			return -ENOMEM;
+		top_obj->location = kstrdup(location, GFP_KERNEL);
+		if (!top_obj->location) {
+			kfree(top_obj->type);
+			return -ENOMEM;
+		}
+	}
+	/* PPB at 0000:80:00.00 (slot 3)
+	 * (slot #) may not be present.
+	 */
+	else if (start[0] == 'P') {
+		str_cnt = sscanf(start, "%10s %*s %14s %*s %d)",
+				type, ppb_addr, &top_obj->slot);
+		if (str_cnt < 2)
+			return -EINVAL;
+		top_obj->type = kstrdup(type, GFP_KERNEL);
+		if (!top_obj->type)
+			return -ENOMEM;
+		top_obj->ppb_addr = kstrdup(ppb_addr, GFP_KERNEL);
+		if (!top_obj->ppb_addr) {
+			kfree(top_obj->type);
+			return -ENOMEM;
+		}
+	} else
+		return -EINVAL;
+
+	top_obj->kobj.kset = uv_pcibus_kset;
+
+	ret = kobject_init_and_add(&top_obj->kobj, &uv_pci_top_attr_type, NULL, "%s", line);
+	if (ret)
+		goto err_add_sysfs;
+
+	if (top_obj->type) {
+		ret = sysfs_create_file(&top_obj->kobj, &uv_pci_type_attribute.attr);
+		if (ret)
+			goto err_add_sysfs;
+	}
+	if (top_obj->location) {
+		ret = sysfs_create_file(&top_obj->kobj, &uv_pci_location_attribute.attr);
+		if (ret)
+			goto err_add_sysfs;
+	}
+	if (top_obj->iio_stack >= 0) {
+		ret = sysfs_create_file(&top_obj->kobj, &uv_pci_iio_stack_attribute.attr);
+		if (ret)
+			goto err_add_sysfs;
+	}
+	if (top_obj->ppb_addr) {
+		ret = sysfs_create_file(&top_obj->kobj, &uv_pci_ppb_addr_attribute.attr);
+		if (ret)
+			goto err_add_sysfs;
+	}
+	if (top_obj->slot >= 0) {
+		ret = sysfs_create_file(&top_obj->kobj, &uv_pci_slot_attribute.attr);
+		if (ret)
+			goto err_add_sysfs;
+	}
+
+	kobject_uevent(&top_obj->kobj, KOBJ_ADD);
+	return 0;
+
+err_add_sysfs:
+	kobject_put(&top_obj->kobj);
+	return ret;
+}
+
+static int pci_topology_init(void)
+{
+	char *pci_top_str, *start, *found, *count;
+	size_t sz;
+	s64 biosr;
+	int l = 0, k = 0;
+	int len, ret;
+
+	uv_pcibus_kset = kset_create_and_add("pcibuses", NULL, sgi_uv_kobj);
+	if (!uv_pcibus_kset)
+		return -ENOMEM;
+
+	for (sz = PAGE_SIZE; sz < 16 * PAGE_SIZE; sz += PAGE_SIZE) {
+		pci_top_str = kmalloc(sz, GFP_KERNEL);
+		if (!pci_top_str) {
+			ret = -ENOMEM;
+			goto err_pci_top_str;
+		}
+		biosr = uv_bios_get_pci_topology((u64)sz, (u64 *)pci_top_str);
+		if (biosr == BIOS_STATUS_SUCCESS) {
+			len = strnlen(pci_top_str, sz);
+			for (count = pci_top_str; count < pci_top_str + len; count++) {
+				if (*count == '\n')
+					l++;
+			}
+			num_pci_lines = l;
+
+			uv_pci_objs = kcalloc(num_pci_lines,
+					     sizeof(*uv_pci_objs), GFP_KERNEL);
+			if (!uv_pci_objs) {
+				kfree(pci_top_str);
+				ret = -ENOMEM;
+				goto err_pci_top_str;
+			}
+			start = pci_top_str;
+			while ((found = strsep(&start, "\n")) != NULL) {
+				uv_pci_objs[k] = kzalloc(sizeof(*uv_pci_objs[k]), GFP_KERNEL);
+				if (!uv_pci_objs[k]) {
+					ret = -ENOMEM;
+					goto err_pci_obj;
+				}
+				ret = init_pci_top_obj(uv_pci_objs[k], found);
+				if (ret)
+					goto err_pci_obj;
+				k++;
+				if (k == num_pci_lines)
+					break;
+			}
+		}
+		kfree(pci_top_str);
+		if (biosr == BIOS_STATUS_SUCCESS || biosr == BIOS_STATUS_UNIMPLEMENTED)
+			break;
+	}
+
+	return 0;
+err_pci_obj:
+	k--;
+	for (; k >= 0; k--)
+		kobject_put(&uv_pci_objs[k]->kobj);
+	kfree(uv_pci_objs);
+	kfree(pci_top_str);
+err_pci_top_str:
+	kset_unregister(uv_pcibus_kset);
+	return ret;
+}
+
+static void pci_topology_exit(void)
+{
+	int k;
+
+	for (k = 0; k < num_pci_lines; k++)
+		kobject_put(&uv_pci_objs[k]->kobj);
+	kset_unregister(uv_pcibus_kset);
+	kfree(uv_pci_objs);
+}
+
+static ssize_t partition_id_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%ld\n", sn_partition_id);
+}
+
+static ssize_t coherence_id_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%ld\n", sn_coherency_id);
+}
+
+static ssize_t uv_type_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", uv_type_string());
+}
+
+static struct kobj_attribute partition_id_attr =
+	__ATTR(partition_id, 0444, partition_id_show, NULL);
+static struct kobj_attribute coherence_id_attr =
+	__ATTR(coherence_id, 0444, coherence_id_show, NULL);
+static struct kobj_attribute uv_type_attr =
+	__ATTR(uv_type, 0444, uv_type_show, NULL);
+
+static struct attribute *base_attrs[] = {
+	&partition_id_attr.attr,
+	&coherence_id_attr.attr,
+	&uv_type_attr.attr,
+	NULL,
+};
+
+static struct attribute_group base_attr_group = {
+	.attrs = base_attrs
+};
+
+static int initial_bios_setup(void)
+{
+	u64 v;
+	s64 biosr;
+
+	biosr = uv_bios_get_master_nasid((u64)sizeof(uv_master_nasid), (u64 *)&uv_master_nasid);
+	if (biosr)
+		return -EINVAL;
+
+	biosr = uv_bios_get_heapsize((u64)uv_master_nasid, (u64)sizeof(u64), &v);
+	if (biosr)
+		return -EINVAL;
+
+	uv_biosheap = vmalloc(v);
+	if (!uv_biosheap)
+		return -ENOMEM;
+
+	biosr = uv_bios_install_heap((u64)uv_master_nasid, v, (u64 *)uv_biosheap);
+	if (biosr) {
+		vfree(uv_biosheap);
+		return -EINVAL;
+	}
+
+	biosr = uv_bios_obj_count((u64)uv_master_nasid, sizeof(u64), &v);
+	if (biosr) {
+		vfree(uv_biosheap);
+		return -EINVAL;
+	}
+	uv_bios_obj_cnt = (int)v;
+
+	return 0;
+}
+
+static int __init uv_sysfs_init(void)
+{
+	int ret = 0;
+
+	if (!is_uv_system())
+		return -ENODEV;
+
+	num_cnodes = uv_num_possible_blades();
+
+	if (!sgi_uv_kobj)
+		sgi_uv_kobj = kobject_create_and_add("sgi_uv", firmware_kobj);
+	if (!sgi_uv_kobj) {
+		pr_warn("kobject_create_and_add sgi_uv failed\n");
+		return -EINVAL;
+	}
+	ret = sysfs_create_group(sgi_uv_kobj, &base_attr_group);
+	if (ret) {
+		pr_warn("sysfs_create_group base_attr_group failed\n");
+		goto err_create_group;
+	}
+
+	ret = initial_bios_setup();
+	if (ret)
+		goto err_bios_setup;
+
+	ret = uv_hubs_init();
+	if (ret)
+		goto err_hubs_init;
+
+	ret = uv_ports_init();
+	if (ret)
+		goto err_ports_init;
+
+	ret = pci_topology_init();
+	if (ret)
+		goto err_pci_init;
+
+	return 0;
+
+err_pci_init:
+	uv_ports_exit();
+err_ports_init:
+	uv_hubs_exit();
+err_hubs_init:
+	vfree(uv_biosheap);
+err_bios_setup:
+	sysfs_remove_group(sgi_uv_kobj, &base_attr_group);
+err_create_group:
+	kobject_put(sgi_uv_kobj);
+	return ret;
+}
+
+static void __exit uv_sysfs_exit(void)
+{
+	if (!is_uv_system())
+		return;
+
+	pci_topology_exit();
+	uv_ports_exit();
+	uv_hubs_exit();
+	vfree(uv_biosheap);
+	sysfs_remove_group(sgi_uv_kobj, &base_attr_group);
+	kobject_put(sgi_uv_kobj);
+}
+
+#ifndef MODULE
+device_initcall(uv_sysfs_init);
+#else
+module_init(uv_sysfs_init);
+#endif
+module_exit(uv_sysfs_exit);
+
+MODULE_AUTHOR("Hewlett Packard Enterprise");
+MODULE_LICENSE("GPL");
-- 
2.26.2

