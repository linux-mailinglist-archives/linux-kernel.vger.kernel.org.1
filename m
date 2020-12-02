Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C074A2CB433
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLBFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:06:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgLBFGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:06:11 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B252jOR015396;
        Wed, 2 Dec 2020 00:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DjO5Dnb0HGXeor5d72WSM9dsPFGumb/JQJ+bDIBfs0k=;
 b=Wuh9DfojPWpEwEvY+DRlD13L1CD2B1EyU5qEtz0PIQyomDfyFH7s99BLAECPTl10BdZi
 9AXjNO9z8BuK1OuoDMWxu9QVeoGoiySDsP+/AckKBf+tTIKltSMhn51+KBANiTc0+xub
 JfEV3Imubsrosby5/oFWmsh2oE0lZzhTiX9KvGVJt9mas5uWokZIxMLM1ckXIunDzjnv
 5w8D7yUm3TsThofn0IsnaJBpf1WtdlzTf641tJNkwZGMZvo2FgpU2OynrYUcksvncs0h
 1NVQhmOeq+xRoupxZC0n72CID5DDw07CqJ8xlAo4flyU4nvZGHOYdsVIti9YQkUMMbF5 Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjhd7wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:05:07 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B252roD015704;
        Wed, 2 Dec 2020 00:05:06 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjhd7vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:05:06 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2547vN015612;
        Wed, 2 Dec 2020 05:05:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 353dtha045-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:05:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2551M260359024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 05:05:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D2194C040;
        Wed,  2 Dec 2020 05:05:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94D04C058;
        Wed,  2 Dec 2020 05:04:58 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.85.125.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 05:04:58 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: [PATCH v2 0/4] Powerpc: Better preemption for shared processor
Date:   Wed,  2 Dec 2020 10:34:52 +0530
Message-Id: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=854
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vcpu_is_preempted will return the yield_count for
shared_processor. On a PowerVM LPAR, Phyp schedules at SMT8 core boundary
i.e all CPUs belonging to a core are either group scheduled in or group
scheduled out. This can be used to better predict non-preempted CPUs on
PowerVM shared LPARs.

perf stat -r 5 -a perf bench sched pipe -l 10000000 (lesser time is better)

powerpc/next
     35,107,951.20 msec cpu-clock                 #  255.898 CPUs utilized            ( +-  0.31% )
        23,655,348      context-switches          #    0.674 K/sec                    ( +-  3.72% )
            14,465      cpu-migrations            #    0.000 K/sec                    ( +-  5.37% )
            82,463      page-faults               #    0.002 K/sec                    ( +-  8.40% )
 1,127,182,328,206      cycles                    #    0.032 GHz                      ( +-  1.60% )  (66.67%)
    78,587,300,622      stalled-cycles-frontend   #    6.97% frontend cycles idle     ( +-  0.08% )  (50.01%)
   654,124,218,432      stalled-cycles-backend    #   58.03% backend cycles idle      ( +-  1.74% )  (50.01%)
   834,013,059,242      instructions              #    0.74  insn per cycle
                                                  #    0.78  stalled cycles per insn  ( +-  0.73% )  (66.67%)
   132,911,454,387      branches                  #    3.786 M/sec                    ( +-  0.59% )  (50.00%)
     2,890,882,143      branch-misses             #    2.18% of all branches          ( +-  0.46% )  (50.00%)

           137.195 +- 0.419 seconds time elapsed  ( +-  0.31% )

powerpc/next + patchset
     29,981,702.64 msec cpu-clock                 #  255.881 CPUs utilized            ( +-  1.30% )
        40,162,456      context-switches          #    0.001 M/sec                    ( +-  0.01% )
             1,110      cpu-migrations            #    0.000 K/sec                    ( +-  5.20% )
            62,616      page-faults               #    0.002 K/sec                    ( +-  3.93% )
 1,430,030,626,037      cycles                    #    0.048 GHz                      ( +-  1.41% )  (66.67%)
    83,202,707,288      stalled-cycles-frontend   #    5.82% frontend cycles idle     ( +-  0.75% )  (50.01%)
   744,556,088,520      stalled-cycles-backend    #   52.07% backend cycles idle      ( +-  1.39% )  (50.01%)
   940,138,418,674      instructions              #    0.66  insn per cycle
                                                  #    0.79  stalled cycles per insn  ( +-  0.51% )  (66.67%)
   146,452,852,283      branches                  #    4.885 M/sec                    ( +-  0.80% )  (50.00%)
     3,237,743,996      branch-misses             #    2.21% of all branches          ( +-  1.18% )  (50.01%)

            117.17 +- 1.52 seconds time elapsed  ( +-  1.30% )

This is around 14.6% improvement in performance.

Changelog:
v1->v2:
v1: https://lore.kernel.org/linuxppc-dev/20201028123512.871051-1-srikar@linux.vnet.ibm.com/t/#u
 - Rebased to 27th Nov linuxppc/merge tree.
 - Moved a hunk to fix a no previous prototype warning reported by: lkp@intel.com
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/C6PTRPHWMC7VV4OTYN3ISYKDHTDQS6YI/

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Phil Auld <pauld@redhat.com>

Srikar Dronamraju (4):
  powerpc: Refactor is_kvm_guest declaration to new header
  powerpc: Rename is_kvm_guest to check_kvm_guest
  powerpc: Reintroduce is_kvm_guest
  powerpc/paravirt: Use is_kvm_guest in vcpu_is_preempted

 arch/powerpc/include/asm/firmware.h  |  6 ------
 arch/powerpc/include/asm/kvm_guest.h | 25 +++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_para.h  |  2 +-
 arch/powerpc/include/asm/paravirt.h  | 18 ++++++++++++++++++
 arch/powerpc/kernel/firmware.c       |  5 ++++-
 arch/powerpc/platforms/pseries/smp.c |  3 ++-
 6 files changed, 50 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_guest.h

-- 
2.18.4

