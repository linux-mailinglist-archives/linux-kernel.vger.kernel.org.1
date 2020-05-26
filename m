Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8F1CCFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 05:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEKC77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 22:59:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgEKC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:59:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04B22fxo060627;
        Sun, 10 May 2020 22:59:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2dwacw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 22:59:25 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04B2CIE6108961;
        Sun, 10 May 2020 22:59:25 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2dwacc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 22:59:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04B2t9Mm029912;
        Mon, 11 May 2020 02:59:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55bfpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 02:59:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04B2xKBC57212948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 02:59:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC71AE055;
        Mon, 11 May 2020 02:59:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FEBCAE04D;
        Mon, 11 May 2020 02:59:16 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.53.64])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 May 2020 02:59:16 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v5 00/16] powerpc/watchpoint: Preparation for more than one watchpoint
Date:   Mon, 11 May 2020 08:28:55 +0530
Message-Id: <20200511025911.212827-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_11:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=638 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, powerpc Book3S code has been written with an assumption of
only one watchpoint. But Power10[1] is introducing second watchpoint
register (DAWR). Even though this patchset does not enable 2nd DAWR,
it makes the infrastructure ready so that enabling 2nd DAWR should
just be a matter of changing count.

Existing functionality works fine with the patchset. I've tested it
with perf, ptrace(gdb), xmon. All hw-breakpoint selftests are passing
as well. And I've build tested for 8xx and 'AMCC 44x, 46x or 47x'.

Note: kvm or PowerVM guest is not enabled yet.

v4: https://lore.kernel.org/linuxppc-dev/20200430043417.30948-1-ravi.bangoria@linux.ibm.com

v4->v5:
 - s/future power architecture/Power10/
 - s/dawr/DAWR/ in commit descriptions

[1]: https://www-355.ibm.com/systems/power/openpower/

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
  powerpc/watchpoint/xmon: Support 2nd DAWR

 arch/powerpc/include/asm/cputable.h       |   6 +-
 arch/powerpc/include/asm/debug.h          |   2 +-
 arch/powerpc/include/asm/hw_breakpoint.h  |  32 +-
 arch/powerpc/include/asm/processor.h      |   6 +-
 arch/powerpc/include/asm/reg.h            |   6 +-
 arch/powerpc/include/asm/sstep.h          |   2 +
 arch/powerpc/kernel/dawr.c                |  23 +-
 arch/powerpc/kernel/hw_breakpoint.c       | 645 ++++++++++++++++++----
 arch/powerpc/kernel/process.c             |  85 +--
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  72 ++-
 arch/powerpc/kernel/ptrace/ptrace32.c     |   4 +-
 arch/powerpc/kernel/signal.c              |  13 +-
 arch/powerpc/kvm/book3s_hv.c              |  12 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  18 +-
 arch/powerpc/xmon/xmon.c                  |  99 +++-
 kernel/events/hw_breakpoint.c             |  16 +
 16 files changed, 814 insertions(+), 227 deletions(-)

-- 
2.21.1

