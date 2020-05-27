Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92611E3DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgE0Jug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 05:50:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgE0Juf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:50:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R9X4RO186946;
        Wed, 27 May 2020 05:50:25 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316ytum6p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 05:50:25 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R9a0s0012244;
        Wed, 27 May 2020 09:50:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 316uf8k35v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 09:50:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R9oLYA56819920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 09:50:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943CF4C044;
        Wed, 27 May 2020 09:50:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53F004C052;
        Wed, 27 May 2020 09:50:19 +0000 (GMT)
Received: from localhost.localdomain.localdomain (unknown [9.85.74.206])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 May 2020 09:50:19 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        maddy@linux.vnet.ibm.com, acme@kernel.org, anju@linux.vnet.ibm.com,
        jolsa@kernel.org, mpe@ellerman.id.au, atrajeev@linux.vnet.ibm.com
Subject: [PATCH V4 0/2] powerpc/perf: Add support for perf extended regs in powerpc
Date:   Wed, 27 May 2020 05:50:16 -0400
Message-Id: <1590573018-5201-1-git-send-email-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 cotscore=-2147483648
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set to add support for perf extended register capability in
powerpc. The capability flag PERF_PMU_CAP_EXTENDED_REGS, is used to
indicate the PMU which support extended registers. The generic code
define the mask of extended registers as 0 for non supported architectures.

patch 1/2 defines this PERF_PMU_CAP_EXTENDED_REGS mask to output the
values of mmcr0,mmcr1,mmcr2 for POWER9. Defines `PERF_REG_EXTENDED_MASK`
at runtime which contains mask value of the supported registers under
extended regs.

Patch 2/2 adds extended regs to sample_reg_mask in the tool side to use
with `-I?` option.

Anju T Sudhakar (2):
  powerpc/perf: Add support for outputting extended regs in perf
    intr_regs
  tools/perf: Add perf tools support for extended register capability in
    powerpc

---
Changes from v3 -> v4
- Addressed the comments for new line/tab issue
  and added "Reviewed-by" from Madhavan Srinivasn.

Changes from v2 -> v3
- Split kernel and tools side patches as suggested by Arnaldo
- Addressed review comment from Madhavan Srinivasn

Changes from v1 -> v2

- PERF_REG_EXTENDED_MASK` is defined at runtime in the kernel
based on platform. This will give flexibility in using extended
regs for all processor versions where the supported registers may differ.
- removed PERF_REG_EXTENDED_MASK from the perf tools side. Based on the
processor version(from PVR value), tool side will return the appropriate
extended mask
- Since tool changes can handle without a "PERF_REG_EXTENDED_MASK" macro,
dropped patch to set NO_AUXTRACE.
- Addressed review comments from Ravi Bangoria for V1

---

 arch/powerpc/include/asm/perf_event_server.h    |  8 ++++
 arch/powerpc/include/uapi/asm/perf_regs.h       | 14 ++++++-
 arch/powerpc/perf/core-book3s.c                 |  1 +
 arch/powerpc/perf/perf_regs.c                   | 34 +++++++++++++--
 arch/powerpc/perf/power9-pmu.c                  |  6 +++
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 14 ++++++-
 tools/perf/arch/powerpc/include/perf_regs.h     |  5 ++-
 tools/perf/arch/powerpc/util/perf_regs.c        | 55 +++++++++++++++++++++++++
 8 files changed, 131 insertions(+), 6 deletions(-)

-- 
1.8.3.1

