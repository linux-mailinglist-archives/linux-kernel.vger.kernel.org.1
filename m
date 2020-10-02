Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0351280B99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgJBAYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:24:32 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:23440 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgJBAYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:24:32 -0400
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 20:24:31 EDT
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09203MoN007074;
        Fri, 2 Oct 2020 00:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=xBHef/nXukWQRZgHd6/isgeQhlsgNf9brfhVD/4UjtI=;
 b=jAn+NGG7I1I+Xp/4iYKcMgJJVAmIRJFiCAdbOObs8kb3QQEsaza+G0GP/oBhzcO8oSuD
 gkm2zsGe0p//xUz58PU2diJxfkraF5SMsPhlP639XUILYQu34ei4IN+Tha8nVsLqHXMk
 toLLtXbiOph9WIzJUSwcw+7VD29jMWP6wr5JSLovPqBAjh87snO3QjF/E+StEwud5YOA
 bMBqFZq9fJwUD1L+nZttNjYWXqykA5HuUrKY0iyVmgAXwWeHx8Z0i0cyrbmBuaAJIN0o
 EcJWiGnWSxxWIdu5RcNuZ9UCCl4a7d2G5p0ZW4V1kJpkoPLPORJ5KmTl5VxMGN16fUxQ gQ== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 33wjxx2u5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:06:35 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 2F15984;
        Fri,  2 Oct 2020 00:06:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 1AD0239;
        Fri,  2 Oct 2020 00:06:33 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 13/13] x86/platform/uv: Update Copyrights to conform to HPE standards
Date:   Thu,  1 Oct 2020 19:05:38 -0500
Message-Id: <20201002000538.94424-14-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201002000538.94424-1-mike.travis@hpe.com>
References: <20201002000538.94424-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=626
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Copyrights to those files that have been updated for UV5 changes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/include/asm/uv/bios.h      | 1 +
 arch/x86/include/asm/uv/uv_hub.h    | 1 +
 arch/x86/include/asm/uv/uv_mmrs.h   | 1 +
 arch/x86/kernel/apic/x2apic_uv_x.c  | 1 +
 arch/x86/platform/uv/bios_uv.c      | 1 +
 arch/x86/platform/uv/uv_nmi.c       | 1 +
 arch/x86/platform/uv/uv_time.c      | 1 +
 drivers/misc/sgi-gru/grufile.c      | 1 +
 drivers/misc/sgi-xp/xp.h            | 1 +
 drivers/misc/sgi-xp/xp_main.c       | 1 +
 drivers/misc/sgi-xp/xp_uv.c         | 1 +
 drivers/misc/sgi-xp/xpc_main.c      | 1 +
 drivers/misc/sgi-xp/xpc_partition.c | 1 +
 drivers/misc/sgi-xp/xpnet.c         | 1 +
 14 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 97ac595ebc6a..08b3d810dfba 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -5,6 +5,7 @@
 /*
  * UV BIOS layer definitions.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  * Copyright (c) Russ Anderson <rja@sgi.com>
  */
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 610bda21a8d9..5002f52be332 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -5,6 +5,7 @@
  *
  * SGI UV architectural definitions
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
 
diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 06ea2d1aaa3e..57fa67373262 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -5,6 +5,7 @@
  *
  * HPE UV MMR definitions
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2016 Silicon Graphics, Inc. All rights reserved.
  */
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 0c97315bf864..7c895991389c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -5,6 +5,7 @@
  *
  * SGI UV APIC functions (note: not an Intel compatible APIC)
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
 #include <linux/crash_dump.h>
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index b148b4c8c2ec..54511eaccf4d 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -2,6 +2,7 @@
 /*
  * BIOS run time interface routines.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  * Copyright (c) Russ Anderson <rja@sgi.com>
  */
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eac26feb0461..0f5cbcf0da63 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -2,6 +2,7 @@
 /*
  * SGI NMI support routines
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  * Copyright (c) Mike Travis
  */
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index e94436ba3022..a39e0f394c0e 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -2,6 +2,7 @@
 /*
  * SGI RTC clock/timer routines.
  *
+ *  (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  *  Copyright (c) 2009-2013 Silicon Graphics, Inc.  All Rights Reserved.
  *  Copyright (c) Dimitri Sivanich
  */
diff --git a/drivers/misc/sgi-gru/grufile.c b/drivers/misc/sgi-gru/grufile.c
index 18aa8c877bf8..7ffcfc0bb587 100644
--- a/drivers/misc/sgi-gru/grufile.c
+++ b/drivers/misc/sgi-gru/grufile.c
@@ -7,6 +7,7 @@
  * This file supports the user system call for file open, close, mmap, etc.
  * This also incudes the driver initialization code.
  *
+ *  (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  *  Copyright (c) 2008-2014 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
index 0af267baf031..7d839d844847 100644
--- a/drivers/misc/sgi-xp/xp.h
+++ b/drivers/misc/sgi-xp/xp.h
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2004-2008 Silicon Graphics, Inc. All rights reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 33558555820d..049c9aef0559 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2004-2008 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xp_uv.c b/drivers/misc/sgi-xp/xp_uv.c
index 118aef64518d..d28ffb1c7ade 100644
--- a/drivers/misc/sgi-xp/xp_uv.c
+++ b/drivers/misc/sgi-xp/xp_uv.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index f533ded72941..5a8097e717ae 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2004-2009 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index c21d48fd65cd..615aa731053b 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2004-2008 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index fc5cd83f21f2..d19d2ab848cf 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 1999-2009 Silicon Graphics, Inc. All rights reserved.
  */
 
-- 
2.21.0

