Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DD2921EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 06:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgJSE1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 00:27:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbgJSE1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 00:27:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09J42con060747;
        Mon, 19 Oct 2020 00:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tcWDIXacr+AR5okwAEeGfsqusWRz2oIQrT0H2Psi9yk=;
 b=A4uH/3UC3yN2V9I432ysCixH2S8ff+8iZsZ2RUilkQUTJRiOOr9ffFmahTufy414qHQ6
 pr5y703IXCyWB7yUR6hS5AhGcwRUOsO3FIvSH+1vVFoD5dJmrt1kIHwt0+phodFZ6HFT
 l5UF+N2VHKIhEO+e9yRAwAIOGoKbMhBvYoZPhmA/kvlI74TOwwzpTXCU3VRMD9FQcsaZ
 mdTtbDGTUAY5wBTV+qvPkyWR85ovfPw7JNS9rah+/EoDqF0+dGitPo2I2//VLBzr5Rik
 vQPbRHDHWLbvrvAbbh/4doVFjLJwLBdRBoOljolKfCzG38H2OMp6/YXVnsv+WtGYBpCf cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3492puhd2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 00:27:30 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09J4LPrI105865;
        Mon, 19 Oct 2020 00:27:29 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3492puhd20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 00:27:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09J4I9Zb019688;
        Mon, 19 Oct 2020 04:27:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 347r880uvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 04:27:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09J4RPki27328966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 04:27:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C17FA4057;
        Mon, 19 Oct 2020 04:27:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DE88A4040;
        Mon, 19 Oct 2020 04:27:21 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.79.221.103])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Oct 2020 04:27:21 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>
Subject: [PATCH v2 0/2] Fixes for coregroup
Date:   Mon, 19 Oct 2020 09:57:14 +0530
Message-Id: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-18_13:2020-10-16,2020-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=723 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fixes problems introduced by the coregroup patches.
The first patch we remove a redundant variable.
Second patch allows to boot with CONFIG_CPUMASK_OFFSTACK enabled.

Changelog v1->v2:
https://lore.kernel.org/linuxppc-dev/20201008034240.34059-1-srikar@linux.vnet.ibm.com/t/#u
1. 1st patch was not part of previous posting.
2. Updated 2nd patch based on comments from Michael Ellerman

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Qian Cai <cai@redhat.com>

Srikar Dronamraju (2):
  powerpc/smp: Remove unnecessary variable
  powerpc/smp: Use GFP_ATOMIC while allocating tmp mask

 arch/powerpc/kernel/smp.c | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

-- 
2.18.2

