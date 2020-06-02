Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE821EB40B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBEBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 00:01:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgFBEBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:01:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0523WjYS086445;
        Tue, 2 Jun 2020 00:01:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bjss9e6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:19 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0523wR4L153686;
        Tue, 2 Jun 2020 00:01:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bjss9e52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052404tq030717;
        Tue, 2 Jun 2020 04:01:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47w8d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 04:01:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05241DLM66584892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 04:01:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E66F452050;
        Tue,  2 Jun 2020 04:01:12 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.55.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 790CA52051;
        Tue,  2 Jun 2020 04:01:09 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] powerpc/watchpoint: Enable 2nd DAWR on baremetal and powervm
Date:   Tue,  2 Jun 2020 09:30:59 +0530
Message-Id: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_03:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=507 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last series[1] was to add basic infrastructure support for more than
one watchpoint on Book3S powerpc. This series actually enables the 2nd
DAWR for baremetal and powervm. Kvm guest is still not supported. This
series depends on Alistair's "Base support for POWER10"[2] series.

[1]: https://lore.kernel.org/linuxppc-dev/20200514111741.97993-1-ravi.bangoria@linux.ibm.com/
[2]: https://lore.kernel.org/linuxppc-dev/20200521014341.29095-1-alistair@popple.id.au

Ravi Bangoria (7):
  powerpc/watchpoint: Enable watchpoint functionality on power10 guest
  powerpc/dt_cpu_ftrs: Add feature for 2nd DAWR
  powerpc/watchpoint: Set CPU_FTR_DAWR1 based on pa-features bit
  powerpc/watchpoint: Rename current H_SET_MODE DAWR macro
  powerpc/watchpoint: Guest support for 2nd DAWR hcall
  powerpc/watchpoint: Return available watchpoints dynamically
  powerpc/watchpoint: Remove 512 byte boundary

 arch/powerpc/include/asm/cputable.h       | 13 +++++++++----
 arch/powerpc/include/asm/hvcall.h         |  3 ++-
 arch/powerpc/include/asm/hw_breakpoint.h  |  5 +++--
 arch/powerpc/include/asm/machdep.h        |  2 +-
 arch/powerpc/include/asm/plpar_wrappers.h |  7 ++++++-
 arch/powerpc/kernel/dawr.c                |  2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  7 +++++++
 arch/powerpc/kernel/hw_breakpoint.c       |  5 +++--
 arch/powerpc/kernel/prom.c                |  2 ++
 arch/powerpc/kvm/book3s_hv.c              |  2 +-
 arch/powerpc/platforms/pseries/setup.c    |  7 +++++--
 11 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.26.2

