Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A252A5F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgKDIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:30:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9352 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728144AbgKDIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:30:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A48DuDP189797;
        Wed, 4 Nov 2020 03:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=bNa83xruY+M2D+JwoQ6tkFvCe3F5OE4bmBteOfGZYVk=;
 b=Rr9T6qwk4f3eZJeWCDFHYmOyx1Wnz8kCmPN3EOuBUiCqTiKqM/vstgKEq/YPTFElkrHk
 Ll/pm8UmRC1o4t8UiKKPt5mKiBxgVXJORsN42Hh7nzwZLchiitS6ouQqmPrs7wDGcggA
 ssfizOQ+PTmrANxdnc7LqY21bwxs6ElWs56/iUYJc+zpAyGmKjSt3bgZXxoBSTDVlARy
 SqhizP1kwb0307OqyTSAE2QUDhUPhl1M7lPAPA57PpcLZrjTMFiF7CxilQzLv4BqzwZO
 JZDOuQC3TwZxyWy4Y6+u4iyc0V6Sqhl0ImilZWr6XILflG0gUCvHopN6GAK1zz2HQLAr PQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34krkq8frv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 03:30:08 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A48RI2r014676;
        Wed, 4 Nov 2020 08:30:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 34h01uby3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 08:30:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A48U4QP58458370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 08:30:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B8B52059;
        Wed,  4 Nov 2020 08:30:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CD3E85206C;
        Wed,  4 Nov 2020 08:30:02 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Omit test 68 for s390.
Date:   Wed,  4 Nov 2020 09:29:54 +0100
Message-Id: <20201104082954.57338-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_06:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
adds a WINDOWS EXE file named tests/pe-file.exe, which is
examined by the test case 'PE file support'.

This test reads the buildid from the file tests/pe-file.exe,
which is a Portable Executable (PE) binary file used by the
Windows operating system.

Since s390 does not support PE files, omit this test.

Output before:
[root@t35lp46 perf]# ./perf test -F 68
68: PE file support                               : Failed!
[root@t35lp46 perf]#

Output after:
[root@t35lp46 perf]# ./perf test -F 68
68: PE file support                               : Skip
[root@t35lp46 perf]#


Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/pe-file-parsing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 58b90c42eb38..4e45178c50f6 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -18,7 +18,7 @@
 
 #include "tests.h"
 
-#ifdef HAVE_LIBBFD_SUPPORT
+#if defined(HAVE_LIBBFD_SUPPORT) && !defined(__s390x__)
 
 static int run_dir(const char *d)
 {
-- 
2.26.2

