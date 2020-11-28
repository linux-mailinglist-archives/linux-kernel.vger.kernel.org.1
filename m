Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0E2C6EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 05:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgK1EEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 23:04:35 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:51911 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731107AbgK1Dnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 22:43:50 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS3d2P1011982;
        Sat, 28 Nov 2020 03:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ec1ud86y8iyIGHtravApZVjgzjgBfBbVjx+9jw6dsmY=;
 b=ftr8qI9bXSmIiVLBIstm67lvm2WipXRB082XuyzVZiVl4tPWjEX41gyrPlk0mONZchAL
 pTdtr6XwWiGK8Cft/nyttOPZhFG/5hl7A/SMSnsBK/zzdtiNyQzo6QOKF8aRWr5kU3zq
 5MZW0ZbEWG6tNTT1uGJSiFvG3VBZ3H/yXqtFnb0ZlSIO4k1Gly1D84Ocz4COOL3G948z
 cOSYatRsaW+YOE2Djx7r0Yryfkdj9+/T5G0k40UyBVbibmzDlhOP6ouasDHKn8AKlxrW
 JGZ4ApwZGXREkfQWcYf6afCUFGl30F2gogNJjtYFaBu7Ws/Rw15Se6dJqF5JMLv57r7e Cw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 3532m2m0dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 03:42:55 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F30B651;
        Sat, 28 Nov 2020 03:42:54 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 03D204A;
        Sat, 28 Nov 2020 03:42:53 +0000 (UTC)
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
Subject: [PATCH v2 2/5] x86/platform/uv: Add sysfs leaves to replace those in procfs
Date:   Fri, 27 Nov 2020 21:42:24 -0600
Message-Id: <20201128034227.120869-3-mike.travis@hpe.com>
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

Add uv_sysfs leaves to display the info.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/platform/x86/uv_sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 54c342579f1c..115754cdcd89 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -735,17 +735,35 @@ static ssize_t uv_type_show(struct kobject *kobj,
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
 static struct kobj_attribute coherence_id_attr =
 	__ATTR(coherence_id, 0444, coherence_id_show, NULL);
 static struct kobj_attribute uv_type_attr =
 	__ATTR(uv_type, 0444, uv_type_show, NULL);
+static struct kobj_attribute uv_archtype_attr =
+	__ATTR(archtype, 0444, uv_archtype_show, NULL);
+static struct kobj_attribute uv_hub_type_attr =
+	__ATTR(hub_type, 0444, uv_hub_type_show, NULL);
 
 static struct attribute *base_attrs[] = {
 	&partition_id_attr.attr,
 	&coherence_id_attr.attr,
 	&uv_type_attr.attr,
+	&uv_archtype_attr.attr,
+	&uv_hub_type_attr.attr,
 	NULL,
 };
 
-- 
2.21.0

