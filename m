Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDB1A71A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 05:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404574AbgDNDSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 23:18:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404527AbgDNDSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:18:16 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E34HQK052445
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:18:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b9huxcnb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:18:15 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Apr 2020 04:17:55 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 04:17:51 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E3I6QC37880098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 03:18:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C21585204F;
        Tue, 14 Apr 2020 03:18:06 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3FE655204E;
        Tue, 14 Apr 2020 03:17:48 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v3 02/16] powerpc/watchpoint: Add SPRN macros for second DAWR
Date:   Tue, 14 Apr 2020 08:46:45 +0530
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041403-0012-0000-0000-000003A410B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041403-0013-0000-0000-000021E14589
Message-Id: <20200414031659.58875-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=759 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future Power architecture is introducing second DAWR. Add SPRN_ macros
for the same.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/reg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 156ee89fa9be..062e74cf41fd 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -284,6 +284,7 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DAWR0	0xB4
+#define SPRN_DAWR1	0xB5
 #define SPRN_RPR	0xBA	/* Relative Priority Register */
 #define SPRN_CIABR	0xBB
 #define   CIABR_PRIV		0x3
@@ -291,6 +292,7 @@
 #define   CIABR_PRIV_SUPER	2
 #define   CIABR_PRIV_HYPER	3
 #define SPRN_DAWRX0	0xBC
+#define SPRN_DAWRX1	0xBD
 #define   DAWRX_USER	__MASK(0)
 #define   DAWRX_KERNEL	__MASK(1)
 #define   DAWRX_HYP	__MASK(2)
-- 
2.21.1

