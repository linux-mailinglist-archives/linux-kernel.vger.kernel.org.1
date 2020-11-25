Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FB92C46CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgKYRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:30:02 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:36130 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732832AbgKYRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:30:00 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHLgT3001069;
        Wed, 25 Nov 2020 17:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=YDMIc2mncs6us1j3vnKNHhgPgS8ZlJskp/BO1GYcJ/U=;
 b=e7jUW5o9q86G5qtrZfgfBsw4LQioyMBmH3QnP5VQA9rJ8lrIOKh35KRM54whgtNfGz0b
 4gSLFvN96ZMkB7QOUPIj9hUXC9/xiDZkQuQueKbBihp8i1Ebh4xsplK4zPOzWnIDLUxW
 8/ufLmJciFVlj5I58rBXvxAVViPsEVZaVyC+NcUsjisC+Lb9AXMTMCSXuJJ9jMYd/rFJ
 I616J+Rl/hyu1Wy6X2fHbc6plHkqaEiHqhWjjiNTfDXWx7U18W6ZTovijG4ci3NQp8uO
 r3TSNxBzqGEHLsboEUGUN9HN3wPKS77Gbx8zfcU9Q1xIPOETzmDuuedf1ZNw3xD2o/Me Kg== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 3515vs2461-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:29:40 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 040DAA3;
        Wed, 25 Nov 2020 17:29:40 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 161C437;
        Wed, 25 Nov 2020 17:29:39 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/5] x86/platform/uv: Add sysfs hubless leaves
Date:   Wed, 25 Nov 2020 11:29:05 -0600
Message-Id: <20201125172907.240996-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125172907.240996-1-mike.travis@hpe.com>
References: <20201125172907.240996-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uv_sysfs hubless leaves for UV hubless systems.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/platform/x86/uv_sysfs.c | 52 +++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 6729ea8b63d2..5aa1addf3598 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -44,6 +44,8 @@ static const char *uv_type_string(void)
 		return "5.0";
 	else if (is_uv2_hub())
 		return "3.0";
+	else if (uv_get_hubless_system())
+		return "0.1";
 	else
 		return "unknown";
 }
@@ -741,6 +743,12 @@ static ssize_t uv_hub_type_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_hub_type());
 }
 
+static ssize_t uv_hubless_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_get_hubless_system());
+}
+
 static struct kobj_attribute partition_id_attr =
 	__ATTR(partition_id, 0444, partition_id_show, NULL);
 static struct kobj_attribute uv_type_attr =
@@ -749,6 +757,8 @@ static struct kobj_attribute uv_archtype_attr =
 	__ATTR(archtype, 0444, uv_archtype_show, NULL);
 static struct kobj_attribute uv_hub_type_attr =
 	__ATTR(hub_type, 0444, uv_hub_type_show, NULL);
+static struct kobj_attribute uv_hubless_attr =
+	__ATTR(hubless, 0444, uv_hubless_show, NULL);
 
 static struct attribute *base_attrs[] = {
 	&partition_id_attr.attr,
@@ -795,11 +805,36 @@ static int initial_bios_setup(void)
 	return 0;
 }
 
+static struct attribute *hubless_base_attrs[] = {
+	&partition_id_attr.attr,
+	&uv_type_attr.attr,
+	&uv_archtype_attr.attr,
+	&uv_hubless_attr.attr,
+	NULL,
+};
+
+static struct attribute_group hubless_base_attr_group = {
+	.attrs = hubless_base_attrs
+};
+
+
+static int __init uv_sysfs_hubless_init(void)
+{
+	int ret;
+
+	ret = sysfs_create_group(sgi_uv_kobj, &hubless_base_attr_group);
+	if (ret) {
+		pr_warn("sysfs_create_group hubless_base_attr_group failed\n");
+		kobject_put(sgi_uv_kobj);
+	}
+	return ret;
+}
+
 static int __init uv_sysfs_init(void)
 {
 	int ret = 0;
 
-	if (!is_uv_system())
+	if (!is_uv_system() && !uv_get_hubless_system())
 		return -ENODEV;
 
 	num_cnodes = uv_num_possible_blades();
@@ -810,6 +845,10 @@ static int __init uv_sysfs_init(void)
 		pr_warn("kobject_create_and_add sgi_uv failed\n");
 		return -EINVAL;
 	}
+
+	if (uv_get_hubless_system())
+		return uv_sysfs_hubless_init();
+
 	ret = sysfs_create_group(sgi_uv_kobj, &base_attr_group);
 	if (ret) {
 		pr_warn("sysfs_create_group base_attr_group failed\n");
@@ -847,10 +886,19 @@ static int __init uv_sysfs_init(void)
 	return ret;
 }
 
+static void __exit uv_sysfs_hubless_exit(void)
+{
+	sysfs_remove_group(sgi_uv_kobj, &hubless_base_attr_group);
+	kobject_put(sgi_uv_kobj);
+}
+
 static void __exit uv_sysfs_exit(void)
 {
-	if (!is_uv_system())
+	if (!is_uv_system()) {
+		if (uv_get_hubless_system())
+			uv_sysfs_hubless_exit();
 		return;
+	}
 
 	pci_topology_exit();
 	uv_ports_exit();
-- 
2.21.0

