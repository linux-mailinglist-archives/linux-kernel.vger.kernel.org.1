Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC62C6EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 04:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgK1Dsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 22:48:52 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:13710 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731486AbgK1Dnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 22:43:50 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS3cGPL009688;
        Sat, 28 Nov 2020 03:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=+goaEceT8gHIrp4fdfliMHkFZeekO0OtEE+BxP3MIA4=;
 b=VLEHYa8fEgo9F1YHURg0YOwkuet9DlJuwX2XiRZ2mSQeqv8AzRTX1zaT/xoCofs8OGeb
 ZH4ae6xabxm9YNNoxPL+3l8wK8/FbRWmRluqRciqBplucA8Kdl7D9jGehpuB5GDfaR3p
 e7gfKPoWgUo/HIE9WQ1qQ5B4+GIRzPu4fIO4zkAf3XBSdQmb+lHp+Tm+bTn6P3U2ioE4
 D+3qmwpdGhIbMHvgH4LxPJKSFDAGs4nzcoris3WpR7+70QkZMwYBXxbnxmLY8DNdhoLn
 rQBNgAN9QlnCnb19fCNKUvnGMRu8AJzQ+1/Kji9McJqNeq8h8lgqnuCVovx8aS4FI35D yw== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 3532m2m0df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 03:42:56 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 0B57E9D;
        Sat, 28 Nov 2020 03:42:56 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0F5EF48;
        Sat, 28 Nov 2020 03:42:55 +0000 (UTC)
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
Subject: [PATCH v2 3/5] x86/platform/uv: Add sysfs hubless leaves
Date:   Fri, 27 Nov 2020 21:42:25 -0600
Message-Id: <20201128034227.120869-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201128034227.120869-1-mike.travis@hpe.com>
References: <20201128034227.120869-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280025
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
index 115754cdcd89..913559797ba4 100644
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
@@ -747,6 +749,12 @@ static ssize_t uv_hub_type_show(struct kobject *kobj,
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
 static struct kobj_attribute coherence_id_attr =
@@ -757,6 +765,8 @@ static struct kobj_attribute uv_archtype_attr =
 	__ATTR(archtype, 0444, uv_archtype_show, NULL);
 static struct kobj_attribute uv_hub_type_attr =
 	__ATTR(hub_type, 0444, uv_hub_type_show, NULL);
+static struct kobj_attribute uv_hubless_attr =
+	__ATTR(hubless, 0444, uv_hubless_show, NULL);
 
 static struct attribute *base_attrs[] = {
 	&partition_id_attr.attr,
@@ -804,11 +814,36 @@ static int initial_bios_setup(void)
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
@@ -819,6 +854,10 @@ static int __init uv_sysfs_init(void)
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
@@ -856,10 +895,19 @@ static int __init uv_sysfs_init(void)
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

