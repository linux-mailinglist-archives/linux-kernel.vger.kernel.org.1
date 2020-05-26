Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7161A7198
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404507AbgDNDRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 23:17:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404489AbgDNDRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:17:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E34GRO069644
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:17:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30b7gw3uws-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:17:34 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Apr 2020 04:17:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 04:17:10 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E3HQIH60096710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 03:17:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7033D52054;
        Tue, 14 Apr 2020 03:17:26 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DE98652067;
        Tue, 14 Apr 2020 03:17:11 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v3 00/16] powerpc/watchpoint: Preparation for more than one watchpoint
Date:   Tue, 14 Apr 2020 08:46:43 +0530
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041403-0012-0000-0000-000003A410A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041403-0013-0000-0000-000021E1457A
Message-Id: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=643 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, powerpc Book3S code has been written with an assumption of only
one watchpoint. But future power architecture is introducing second
watchpoint register (DAWR). Even though this patchset does not enable
2nd DAWR, it make the infrastructure ready so that enabling 2nd DAWR
should just be a matter of changing count.

Existing functionality works fine with the patchset. I've tested it with
perf, ptrace(gdb), xmon. All hw-breakpoint selftests are passing as well.
And I've build tested for 8xx and 'AMCC 44x, 46x or 47x'.

Note: kvm or PowerVM guest is not enabled yet.

v2:
  https://lore.kernel.org/linuxppc-dev/20200401061309.92442-1-ravi.bangoria@linux.ibm.com

v2->v3:
 - Few minor improvements as suggested by Christophe
 - Rebased to powerpc/next

Ravi Bangoria (16):
  powerpc/watchpoint: Rename current DAWR macros
  powerpc/watchpoint: Add SPRN macros for second DAWR
  powerpc/watchpoint: Introduce function to get nr watchpoints
    dynamically
  powerpc/watchpoint/ptrace: Return actual num of available watchpoints
  powerpc/watchpoint: Provide DAWR number to set_dawr
  powerpc/watchpoint: Provide DAWR number to __set_breakpoint
  powerpc/watchpoint: Get watchpoint count dynamically while disabling
    them
  powerpc/watchpoint: Disable all available watchpoints when
    !dawr_force_enable
  powerpc/watchpoint: Convert thread_struct->hw_brk to an array
  powerpc/watchpoint: Use loop for thread_struct->ptrace_bps
  powerpc/watchpoint: Introduce is_ptrace_bp() function
  powerpc/watchpoint: Use builtin ALIGN*() macros
  powerpc/watchpoint: Prepare handler to handle more than one
    watcnhpoint
  powerpc/watchpoint: Don't allow concurrent perf and ptrace events
  powerpc/watchpoint/xmon: Don't allow breakpoint overwriting
  powerpc/watchpoint/xmon: Support 2nd dawr

 arch/powerpc/include/asm/cputable.h       |   6 +-
 arch/powerpc/include/asm/debug.h          |   2 +-
 arch/powerpc/include/asm/hw_breakpoint.h  |  32 +-
 arch/powerpc/include/asm/processor.h      |   6 +-
 arch/powerpc/include/asm/reg.h            |   6 +-
 arch/powerpc/include/asm/sstep.h          |   2 +
 arch/powerpc/kernel/dawr.c                |  23 +-
 arch/powerpc/kernel/hw_breakpoint.c       | 646 ++++++++++++++++++----
 arch/powerpc/kernel/process.c             |  85 +--
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  72 ++-
 arch/powerpc/kernel/ptrace/ptrace32.c     |   4 +-
 arch/powerpc/kernel/signal.c              |  12 +-
 arch/powerpc/kvm/book3s_hv.c              |  12 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  18 +-
 arch/powerpc/xmon/xmon.c                  |  99 +++-
 kernel/events/hw_breakpoint.c             |  16 +
 16 files changed, 814 insertions(+), 227 deletions(-)

-- 
2.21.1

