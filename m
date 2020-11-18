Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54D2B823B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgKRQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:48:33 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:17267 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbgKRQsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:48:31 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGl638012904;
        Wed, 18 Nov 2020 16:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=RYdHdbxJgpSC+EDUO3rGG9C+dpg42FB+WNdi+TFBkN8=;
 b=KaEAP4VTjHJjASAgl9AxcINQeBFLULPzULPRdNmHuqexln8n1Xxyf2Ci/tXd6QQmiM+p
 mR59gVt8K6n8y627iXvZZUMaL03TgtR9y2w072AEUETdx/cfnTt6UMpCZwBN6Y3Nw7Yz
 Vl11HkRNCXoS+srZR2n9owZ7lnkV12QMtNBdf37vnJxwn5MC7VMNhsRZldb6B5sEw0MT
 cw+b0RH1VM+6VaRQhQWZrwR+EBpkJvvmYnyvOiiALdgIzTNH9TUmU1TA3ZHz+lJO1fh/
 RXnjE/aP7Y1ud+ogNixPJ8XPDN4KaidSQoz7m/6ZFInpzkH4Pgd2IgTD2GKln59kYBHl kg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vgcbb7f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:48:01 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id A86119C;
        Wed, 18 Nov 2020 16:48:00 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 6504944;
        Wed, 18 Nov 2020 16:48:00 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 1F7CB3003D756; Wed, 18 Nov 2020 10:48:00 -0600 (CST)
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
Subject: [PATCH v2 1/5] x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
Date:   Wed, 18 Nov 2020 10:47:43 -0600
Message-Id: <20201118164747.236259-2-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201118164747.236259-1-justin.ernst@hpe.com>
References: <20201118164747.236259-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_06:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove existing interface at /sys/firmware/sgi_uv/, created by
arch/x86/platform/uv/uv_sysfs.c

This interface includes:
/sys/firmware/sgi_uv/coherence_id
/sys/firmware/sgi_uv/partition_id

Both coherence_id and partition_id will be re-introduced via a
new uv_sysfs driver.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/Makefile   |  2 +-
 arch/x86/platform/uv/uv_sysfs.c | 63 ---------------------------------
 2 files changed, 1 insertion(+), 64 deletions(-)
 delete mode 100644 arch/x86/platform/uv/uv_sysfs.c

diff --git a/arch/x86/platform/uv/Makefile b/arch/x86/platform/uv/Makefile
index 224ff0504890..1441dda8edf7 100644
--- a/arch/x86/platform/uv/Makefile
+++ b/arch/x86/platform/uv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_X86_UV)		+= bios_uv.o uv_irq.o uv_sysfs.o uv_time.o uv_nmi.o
+obj-$(CONFIG_X86_UV)		+= bios_uv.o uv_irq.o uv_time.o uv_nmi.o
diff --git a/arch/x86/platform/uv/uv_sysfs.c b/arch/x86/platform/uv/uv_sysfs.c
deleted file mode 100644
index 266773e2fb37..000000000000
--- a/arch/x86/platform/uv/uv_sysfs.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * This file supports the /sys/firmware/sgi_uv interfaces for SGI UV.
- *
- *  Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson
- */
-
-#include <linux/device.h>
-#include <asm/uv/bios.h>
-#include <asm/uv/uv.h>
-
-struct kobject *sgi_uv_kobj;
-
-static ssize_t partition_id_show(struct kobject *kobj,
-			struct kobj_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_partition_id);
-}
-
-static ssize_t coherence_id_show(struct kobject *kobj,
-			struct kobj_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_coherency_id);
-}
-
-static struct kobj_attribute partition_id_attr =
-	__ATTR(partition_id, S_IRUGO, partition_id_show, NULL);
-
-static struct kobj_attribute coherence_id_attr =
-	__ATTR(coherence_id, S_IRUGO, coherence_id_show, NULL);
-
-
-static int __init sgi_uv_sysfs_init(void)
-{
-	unsigned long ret;
-
-	if (!is_uv_system())
-		return -ENODEV;
-
-	if (!sgi_uv_kobj)
-		sgi_uv_kobj = kobject_create_and_add("sgi_uv", firmware_kobj);
-	if (!sgi_uv_kobj) {
-		printk(KERN_WARNING "kobject_create_and_add sgi_uv failed\n");
-		return -EINVAL;
-	}
-
-	ret = sysfs_create_file(sgi_uv_kobj, &partition_id_attr.attr);
-	if (ret) {
-		printk(KERN_WARNING "sysfs_create_file partition_id failed\n");
-		return ret;
-	}
-
-	ret = sysfs_create_file(sgi_uv_kobj, &coherence_id_attr.attr);
-	if (ret) {
-		printk(KERN_WARNING "sysfs_create_file coherence_id failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-device_initcall(sgi_uv_sysfs_init);
-- 
2.26.2

