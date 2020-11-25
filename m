Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5292C4713
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgKYRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:55:16 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:19422 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730749AbgKYRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:55:16 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHsfn0032308;
        Wed, 25 Nov 2020 17:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=RYdHdbxJgpSC+EDUO3rGG9C+dpg42FB+WNdi+TFBkN8=;
 b=YhmEQ8uEl9ES1jboU0KbI4CcSPWWBqOlZ1k72JW6RiK68sP+WHqLLm3S5VcffDIqVVVb
 ELuo62GMdO38cFAjeDdGiSqXfcYhz6xliYPjMzg2Lzuv17Nr3ZF1P4CmzfqzRQ32wMRF
 6XeTjvw/KdirV/unE7RUn3B708nL45zxFtU7Ei/9+yCWSonbiVW9/bvv+4g1Atjlc1xZ
 TG0BmthQ6/FRlmq1Cnzx9zHEIH7ephMr2gikmWYvEsdQfjeJmGUQICtdMKIxGqr2iuL8
 N69hXy88uoIWxx9II3+v/ZNldJVMPLEl6HnQJ77CREc3vfP4xYvOri2PxdZn26uBn7CE 5g== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 351r3kt8p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:54:54 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 096F76A;
        Wed, 25 Nov 2020 17:54:53 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A398F49;
        Wed, 25 Nov 2020 17:54:52 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 5D628302F4806; Wed, 25 Nov 2020 11:54:52 -0600 (CST)
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
        Mike Travis <mike.travis@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH v3 1/5] x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
Date:   Wed, 25 Nov 2020 11:54:40 -0600
Message-Id: <20201125175444.279074-2-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201125175444.279074-1-justin.ernst@hpe.com>
References: <20201125175444.279074-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_11:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250111
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

