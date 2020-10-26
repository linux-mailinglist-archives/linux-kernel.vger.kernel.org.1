Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815AC298F48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781487AbgJZOaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:30:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1781103AbgJZOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:30:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QEBcTq079427;
        Mon, 26 Oct 2020 10:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=2ml38pNjrKoInsF4gZ7lFKR7yyrY8IylOvmBAmZmUQw=;
 b=A6e9pyfp8LVfFpPyp/wlkzcun/hYuBWiB/EVyO3bA/biljasGqSMftGFqHCmlmoKE04q
 RogtPUgqyNhgFTk+Rc97LrBzMbKOms8/0AMx1582vNH3eX8W/iOAPqT585lQUPzeYQuF
 IjaPeKdlh3/RDwdroF6dt2PGiHXI4GDjxru90m8VnxPMDUGeShbCEe0FlRhRxZ4HeUcK
 Onag/di2lUAcGf/18RNqWMs/Zro0kKDZvqMQQtrjyijtPGejn5idBXd6SbAs306GRymL
 hbn6g9pty8ySPkL7hRlmGI94HNSAPzicPfS4LgXkjLYQVEW/ed1XWi8RuKeajcRx9taG cQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34dp1qrh9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 10:30:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QERmbb017933;
        Mon, 26 Oct 2020 14:30:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34cbw7t9yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 14:30:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09QETw6J34996646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 14:29:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F78311C052;
        Mon, 26 Oct 2020 14:29:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD1311C04C;
        Mon, 26 Oct 2020 14:29:57 +0000 (GMT)
Received: from osiris (unknown [9.171.92.46])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Oct 2020 14:29:57 +0000 (GMT)
Date:   Mon, 26 Oct 2020 15:29:56 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 compile fix for 5.10-rc2
Message-ID: <20201026142956.GA9584@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_06:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a simple fix, so that s390 compiles again after Joe Perches' commit
33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
which went in just before 5.10-rc1.

Thanks,
Heiko

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-2

for you to fetch changes up to 8e90b4b1305a80b1d7712370a163eff269ac1ba2:

  s390: correct __bootdata / __bootdata_preserved macros (2020-10-26 14:18:01 +0100)

----------------------------------------------------------------
- Fix s390 compile breakage caused by commit 33def8498fdd
  ("treewide: Convert macro and uses of __section(foo) to __section("foo")")

----------------------------------------------------------------
Vasily Gorbik (1):
      s390: correct __bootdata / __bootdata_preserved macros

 arch/s390/include/asm/sections.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sections.h
index a996d3990a02..0c2151451ba5 100644
--- a/arch/s390/include/asm/sections.h
+++ b/arch/s390/include/asm/sections.h
@@ -26,14 +26,14 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
  * final .boot.data section, which should be identical in the decompressor and
  * the decompressed kernel (that is checked during the build).
  */
-#define __bootdata(var) __section(".boot.data.var") var
+#define __bootdata(var) __section(".boot.data." #var) var
 
 /*
  * .boot.preserved.data is similar to .boot.data, but it is not part of the
  * .init section and thus will be preserved for later use in the decompressed
  * kernel.
  */
-#define __bootdata_preserved(var) __section(".boot.preserved.data.var") var
+#define __bootdata_preserved(var) __section(".boot.preserved.data." #var) var
 
 extern unsigned long __sdma, __edma;
 extern unsigned long __stext_dma, __etext_dma;
