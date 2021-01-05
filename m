Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5C2EA5A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbhAEG6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:58:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbhAEG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:58:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1056VZuR059254;
        Tue, 5 Jan 2021 01:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0cosHvdnKQO8bVKCgMXmAUIth9vZNlqT4Gaj28E42HA=;
 b=DBF6FvqKYOFCYOWX7Vsij2rlG4wFGiMPRQwtLNDKW6llHAuclk9ZTTp6QnEwFTkQ9d1k
 m13O/QhpykP3CbEf4s+/5klET7GdLvqBdBjKhlRQIGzw/vIiQH+lDZrDsEZFH5yZimPu
 diLFzyTkyGoc4/XlGF9AEv/QUn4qcdtRK0+V57okoEZl+PXLzW34MRuenBNmX8bFkWI2
 N/obp6CevY2hAQ9D+Ltr8BfjXfN7pQJ34ed7lGI3lO2o8Ky0U3Vq7sKHYon3qWF1KSJB
 /bUmVcJubiMK0M34K/Oy5earuk3Guc208DHPebCGUw8v6BWmm+Yk8u5sj2figCKTA8L6 Lg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35vjnrrr5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 01:57:45 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1056rAvU009097;
        Tue, 5 Jan 2021 06:57:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 35va37g6cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 06:57:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1056vcjF16646500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 06:57:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92C585204F;
        Tue,  5 Jan 2021 06:57:41 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.82.253])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AF46952051;
        Tue,  5 Jan 2021 06:57:38 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/ftrace: Disable multiple_kprobes test on powerpc
Date:   Tue,  5 Jan 2021 12:27:30 +0530
Message-Id: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-04,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=833 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all symbols are blacklisted on powerpc. Disable multiple_kprobes
test until that is sorted, so that rest of ftrace and kprobe selftests
can be run.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 312d237800969e..41503c32f53eed 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -7,7 +7,7 @@
 # Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
 case `uname -m` in
   x86_64|i[3456]86) OFFS=5;;
-  ppc64le) OFFS=8;;
+  ppc*) exit_unsupported;;
   *) OFFS=0;;
 esac
 

base-commit: 36bbbd0e234d817938bdc52121a0f5473b3e58f5
-- 
2.25.4

