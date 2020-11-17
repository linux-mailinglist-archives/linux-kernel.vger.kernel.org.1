Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3B2B6D31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgKQSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:22:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26686 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgKQSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:22:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHI1nWE109898;
        Tue, 17 Nov 2020 13:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=Z8lJ3TisK6FbavOo1/3RPhA4BmEZkgzFWG/ASPxXlR8=;
 b=VsVa2BZHx8YyGTVC0sOLYGVIM5agOxxjIO3LwS8b2Ud8nvLoJMhWfqKeDtgDIcSkj36M
 UPR1tnial81QBpKXFTRQkyBJ9PF2i2AryPt9QDj28VGqVHRZ4NUIv2sB7RhHX/cRwdo8
 hrBW9Wms52phREqewmrcmLZEFzpNeHDm+fl3S+eVkoJj95lHQ11DkJzSkkv5/e9Tf7Rk
 dE9RGtyyPSG+asGOYlHKt+6KfcyAe/k2TapOBCQF2bMEUC/JDqQcu3wwGbkh0vwQrQiI
 PMMx9URjyccwCJ6U2zuLtDdIszFskR0NcGMn/CNEG19QUVoGWroM/EtcZSyTB+auHwxx EA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vbvr0jbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 13:22:04 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AHI8RBV002476;
        Tue, 17 Nov 2020 18:22:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 34t6gh9r6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 18:22:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AHILxhH9372186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:21:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD110AE053;
        Tue, 17 Nov 2020 18:21:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB11AE04D;
        Tue, 17 Nov 2020 18:21:59 +0000 (GMT)
Received: from osiris (unknown [9.171.25.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Nov 2020 18:21:59 +0000 (GMT)
Date:   Tue, 17 Nov 2020 19:21:58 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.10-rc5
Message-ID: <20201117182158.GA4746@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=2 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small s390 updates for 5.10-rc5.

Thanks,
Heiko

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-4

for you to fetch changes up to 78d732e1f326f74f240d416af9484928303d9951:

  s390/cpum_sf.c: fix file permission for cpum_sfb_size (2020-11-12 12:10:36 +0100)

----------------------------------------------------------------
- fix system call exit path; avoid return to user space with
  any TIF/CIF/PIF set

- fix file permission for cpum_sfb_size parameter

- another small defconfig update

----------------------------------------------------------------
Heiko Carstens (2):
      s390: fix system call exit path
      s390: update defconfigs

Thomas Richter (1):
      s390/cpum_sf.c: fix file permission for cpum_sfb_size

 arch/s390/configs/debug_defconfig | 1 +
 arch/s390/kernel/entry.S          | 2 ++
 arch/s390/kernel/perf_cpum_sf.c   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index a4d3c578fbd8..fe6f529ac82c 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -1,3 +1,4 @@
+CONFIG_UAPI_HEADER_TEST=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_WATCH_QUEUE=y
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 86235919c2d1..5346545b9860 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -422,6 +422,7 @@ ENTRY(system_call)
 #endif
 	LOCKDEP_SYS_EXIT
 .Lsysc_tif:
+	DISABLE_INTS
 	TSTMSK	__PT_FLAGS(%r11),_PIF_WORK
 	jnz	.Lsysc_work
 	TSTMSK	__TI_flags(%r12),_TIF_WORK
@@ -444,6 +445,7 @@ ENTRY(system_call)
 # One of the work bits is on. Find out which one.
 #
 .Lsysc_work:
+	ENABLE_INTS
 	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lsysc_reschedule
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 4f9e4626df55..f100c9209743 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -2228,4 +2228,4 @@ static int __init init_cpum_sampling_pmu(void)
 }
 
 arch_initcall(init_cpum_sampling_pmu);
-core_param(cpum_sfb_size, CPUM_SF_MAX_SDB, sfb_size, 0640);
+core_param(cpum_sfb_size, CPUM_SF_MAX_SDB, sfb_size, 0644);
