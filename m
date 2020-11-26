Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52952C5BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404802AbgKZSJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:09:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34860 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404684AbgKZSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:09:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQI2V3x060446;
        Thu, 26 Nov 2020 13:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=agNMQSwcWAtOgAzmyTFS+GDXbWjIfS7PKsTyOpUgFUw=;
 b=q3j7970mUxti4Vw937nV6D+2Py2JCT2h/1cWYLoIpgG4jI/h0DIXuIru/AOeT17rWro0
 XvmBBY30ofuCWW96oWDRCGBBbB+vP015XsPZqK1xe9R/iM5fZL3fZ0zcXUn8CXY4qlmb
 iwV7He08v+z4wcBDHIqhFqC3kELWMD6Wr1m+7RotbBfuOijErm0CD/AG1pWr3g5doDgJ
 62a8598pi8Zx5wKwLL5Yyz76oD7oRX6XUcHQwEqawsUY0F/8fPqMs/1i93kHM3KobZnB
 ocQB/FIMdECATAVig9z8ROXkdAGFckXamDZH4D8kACwz4TzqtDhaumCm02dbemisafPh oA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352h4frbnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 13:09:21 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQI8jNM016127;
        Thu, 26 Nov 2020 18:09:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 34yy8r3b4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 18:09:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQI9Hw649152454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 18:09:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EFB6A4054;
        Thu, 26 Nov 2020 18:09:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94910A405C;
        Thu, 26 Nov 2020 18:09:14 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.81.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 18:09:14 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC PATCH 01/14] ftrace: Fix updating FTRACE_FL_TRAMP
Date:   Thu, 26 Nov 2020 23:38:38 +0530
Message-Id: <56c113aa9c3e10c19144a36d9684c7882bf09af5.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_08:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc, kprobe-direct.tc triggered FTRACE_WARN_ON() in
ftrace_get_addr_new() followed by the below message:
  Bad trampoline accounting at: 000000004222522f (wake_up_process+0xc/0x20) (f0000001)

The set of steps leading to this involved:
- modprobe ftrace-direct-too
- enable_probe
- modprobe ftrace-direct
- rmmod ftrace-direct <-- trigger

The problem turned out to be that we were not updating flags in the
ftrace record properly. From the above message about the trampoline
accounting being bad, it can be seen that the ftrace record still has
FTRACE_FL_TRAMP set though ftrace-direct module is going away. This
happens because we are checking if any ftrace_ops has the
FTRACE_FL_TRAMP flag set _before_ updating the filter hash.

The fix for this is to look for any _other_ ftrace_ops that also needs
FTRACE_FL_TRAMP.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/ftrace.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8185f7240095f4..9c1bba8cc51b03 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1629,6 +1629,8 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
 static struct ftrace_ops *
 ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
 static struct ftrace_ops *
+ftrace_find_tramp_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude);
+static struct ftrace_ops *
 ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
 
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
@@ -1778,7 +1780,7 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			 * to it.
 			 */
 			if (ftrace_rec_count(rec) == 1 &&
-			    ftrace_find_tramp_ops_any(rec))
+			    ftrace_find_tramp_ops_any_other(rec, ops))
 				rec->flags |= FTRACE_FL_TRAMP;
 			else
 				rec->flags &= ~FTRACE_FL_TRAMP;
@@ -2244,6 +2246,24 @@ ftrace_find_tramp_ops_any(struct dyn_ftrace *rec)
 	return NULL;
 }
 
+static struct ftrace_ops *
+ftrace_find_tramp_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude)
+{
+	struct ftrace_ops *op;
+	unsigned long ip = rec->ip;
+
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+
+		if (op == op_exclude || !op->trampoline)
+			continue;
+
+		if (hash_contains_ip(ip, op->func_hash))
+			return op;
+	} while_for_each_ftrace_op(op);
+
+	return NULL;
+}
+
 static struct ftrace_ops *
 ftrace_find_tramp_ops_next(struct dyn_ftrace *rec,
 			   struct ftrace_ops *op)
-- 
2.25.4

