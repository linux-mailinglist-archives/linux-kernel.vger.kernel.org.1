Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53C11CCFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 05:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEKC75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 22:59:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgEKC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:59:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04B2Wv86028120;
        Sun, 10 May 2020 22:59:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvrdjcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 22:59:34 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04B2Xglm029451;
        Sun, 10 May 2020 22:59:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvrdjcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 22:59:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04B2tJvS029931;
        Mon, 11 May 2020 02:59:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55bfq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 02:59:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04B2xSee57147530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 02:59:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A088AE051;
        Mon, 11 May 2020 02:59:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CE35AE045;
        Mon, 11 May 2020 02:59:24 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.53.64])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 May 2020 02:59:24 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v5 02/16] powerpc/watchpoint: Add SPRN macros for second DAWR
Date:   Mon, 11 May 2020 08:28:57 +0530
Message-Id: <20200511025911.212827-3-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511025911.212827-1-ravi.bangoria@linux.ibm.com>
References: <20200511025911.212827-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_11:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=892 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power10 is introducing second DAWR. Add SPRN_ macros for the same.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Michael Neuling <mikey@neuling.org>
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

