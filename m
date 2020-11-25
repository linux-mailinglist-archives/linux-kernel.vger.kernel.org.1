Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475DD2C46D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbgKYRbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:31:01 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:48008 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731849AbgKYRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:31:01 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHL2no018327;
        Wed, 25 Nov 2020 17:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=OSA5e/LlFWVc8lUczZgPyRj+T5sDYm4kuwRL68CKvAU=;
 b=ErbHRqmjQ8PHmwhL9f0LrA/wOR6zWs73pOjLWrr6JlNQCClPYgo9vlDl6MZrXjAs4Xu4
 J7OxpJbiP3JmOpP/BlyOeavUdgfhNAP4mtv/oYd+DNkzLYON4+3KywQKSv6BCM5iO7UL
 uPlGotDv5eX65H07mYyanHtb+gnujSdrn+uiCMmvKyA95D+mnvvxO4Q1mq+w4rJcGQWH
 9y5fsxz8Ar93BFLVWAp31cx4UFSwxdkby4WX0ZBhSBhWR7giiIzuu5fYRDk7FGpyhgR7
 DEieJB6WXsGwKBEyplNa9yOtm/+EerASl5wrUcPdHdDNjyhbMTCG8srusaushqX72czV AA== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 351mb6uyt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:29:39 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 2FEFE6D;
        Wed, 25 Nov 2020 17:29:39 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 17C6F39;
        Wed, 25 Nov 2020 17:29:38 +0000 (UTC)
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
Subject: [PATCH 2/5] x86/platform/uv: Add sysfs leaves to replace those in procfs
Date:   Wed, 25 Nov 2020 11:29:04 -0600
Message-Id: <20201125172907.240996-3-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125172907.240996-1-mike.travis@hpe.com>
References: <20201125172907.240996-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=920 malwarescore=0 bulkscore=0 clxscore=1015
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uv_sysfs leaves to display the info.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/platform/x86/uv_sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 6de360370f0e..6729ea8b63d2 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -729,14 +729,32 @@ static ssize_t uv_type_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "%s\n", uv_type_string());
 }
 
+static ssize_t uv_archtype_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return uv_get_archtype(buf, PAGE_SIZE);
+}
+
+static ssize_t uv_hub_type_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_hub_type());
+}
+
 static struct kobj_attribute partition_id_attr =
 	__ATTR(partition_id, 0444, partition_id_show, NULL);
 static struct kobj_attribute uv_type_attr =
 	__ATTR(uv_type, 0444, uv_type_show, NULL);
+static struct kobj_attribute uv_archtype_attr =
+	__ATTR(archtype, 0444, uv_archtype_show, NULL);
+static struct kobj_attribute uv_hub_type_attr =
+	__ATTR(hub_type, 0444, uv_hub_type_show, NULL);
 
 static struct attribute *base_attrs[] = {
 	&partition_id_attr.attr,
 	&uv_type_attr.attr,
+	&uv_archtype_attr.attr,
+	&uv_hub_type_attr.attr,
 	NULL,
 };
 
-- 
2.21.0

