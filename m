Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6727E67D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgI3KXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58040 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgI3KXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:23:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UA34eX132050;
        Wed, 30 Sep 2020 06:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YKyQ5xIGCX9cBGV7qWvKGTfjYt2RfE/ZUqLP41WpN9Y=;
 b=OPQeB8/TXPU21NApO7Y8QRgvuvIU+4/Y2UVS6Z+jtk6vOr0lpUE9wiViWs791dgkEjQ0
 6M8uYI89+YiYJCD5sl8FkCGDQBytsUIsjC2+kWNhIXv9POSy/y6jNBmR5f8YlmHxK+5C
 aE6fu8a/dBwTQR/FadpucrcCLqUmy+ks9tB4lBCVKamE6IFHGFJliVjl4vWTAKXDtSb9
 iBKNDnioMGHTrYGLgaUjSdlIp08Zdfy1LDaVekq81KRhw3UooEobm72CXyMlSHcyxl7/
 7+lQugajvDkI2yJ/6eiZVuWFGxpQqMO/kGekxIm76WQnyxQ4Y/zWIw0bPeGK6ilZgoOZ pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqa6spju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 06:23:46 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UA3X99132864;
        Wed, 30 Sep 2020 06:23:46 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqa6sphq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 06:23:44 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UAMufJ019373;
        Wed, 30 Sep 2020 10:23:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 33sw98a8kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 10:23:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UANe1c30081390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 10:23:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2409A4203F;
        Wed, 30 Sep 2020 10:23:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9DE242042;
        Wed, 30 Sep 2020 10:23:38 +0000 (GMT)
Received: from oc8242746057.ibm.com.com (unknown [9.171.39.113])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Sep 2020 10:23:38 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        lijiang@redhat.com
Cc:     ebiederm@xmission.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, keescook@chromium.org,
        christian.brauner@ubuntu.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH v3 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
Date:   Wed, 30 Sep 2020 12:23:28 +0200
Message-Id: <20200930102328.396488-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset of the field 'init_uts_ns.name' has changed
since commit 9a56493f6942 ("uts: Use generic ns_common::count").

Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain

Make the offset of the field 'uts_namespace.name' available
in VMCOREINFO because tools like 'crash-utility' and
'makedumpfile' must be able to read it from crash dumps.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---

v2 -> v3:
 * Added documentation to vmcoreinfo.rst
 * Use the short form of the commit reference

v1 -> v2:
 * Improved commit message
 * Added link to the discussion of the uts namespace changes

 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 kernel/crash_core.c                            | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index e44a6c01f336..3861a25faae1 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -39,6 +39,12 @@ call.
 User-space tools can get the kernel name, host name, kernel release
 number, kernel version, architecture name and OS type from it.
 
+(uts_namespace, name)
+---------------------
+
+Offset of the name's member. Crash Utility and Makedumpfile get
+the start address of the init_uts_ns.name from this.
+
 node_online_map
 ---------------
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..173fdc261882 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
+	VMCOREINFO_OFFSET(uts_namespace, name);
 	VMCOREINFO_SYMBOL(node_online_map);
 #ifdef CONFIG_MMU
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
-- 
2.26.2

