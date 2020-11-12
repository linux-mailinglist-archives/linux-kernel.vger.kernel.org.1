Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2E82B1260
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKLXD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:03:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725929AbgKLXD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:03:56 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACN1mvR148597;
        Thu, 12 Nov 2020 18:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fnHRhadYMNBieRjFdpkgcexF0C54pntt644UCAtopA0=;
 b=gKSw9Sv0cphiUFkzlUncdYaCUMI577OPwVxN4ze5RJ4BGCLcBrWiBeGVEq4npR6laHdg
 LwfN7eRpb2QGTEbOnu5pU59+yF6qMqZYJikcgWR0BK8zN1E2F1KD/5w9XnTtSr+abnqq
 t1xrYdJhdkFPeeW1m2LVmH7lqSBofsVrM1t0CtLeRV9OMTjj5LxXt8zpSszij3/07ssT
 xxfVgNx5vDs8lEY+wf2kq5zEM9S8LGfRlZ6YeNFzTCzFYON8B+Q2WGCGwUdi6I9aRP6g
 /IphmOWOkxy9t6mVzys9IAYtSOSEffrIea50m33rR8jM04fBSLMj0yyXCWH865+aCWdi KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34s9vkyj8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:03:26 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACN2TGX151606;
        Thu, 12 Nov 2020 18:03:26 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34s9vkyj7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:03:26 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMqU4h031544;
        Thu, 12 Nov 2020 23:03:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 34nk78p4tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 23:03:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACN3M6d65798432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 23:03:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 315B74C04A;
        Thu, 12 Nov 2020 23:03:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9659B4C044;
        Thu, 12 Nov 2020 23:03:21 +0000 (GMT)
Received: from localhost (unknown [9.171.90.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Nov 2020 23:03:21 +0000 (GMT)
Date:   Fri, 13 Nov 2020 00:03:20 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] x86/tools: Use tools headers for instruction decoder
 selftests
Message-ID: <patch-1.thread-1e2854.git-d01a5698dc9b.your-ad-here.call-01605220128-ext-6070@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=1
 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86 instruction decoder is used from:
- the kernel itself,
- from tools like objtool and perf,
- within x86 tools, i.e. instruction decoder selftests.

The first two cases are similar, because tools headers try to mimic
kernel headers.

Instruction decoder selftests include some of the kernel headers
directly, including uapi headers. This works until headers dependencies
are kept to minimum and tools are not cross-compiled. Since the goal of
the x86 instruction decoder selftests is not to verify uapi headers move
it to using tools headers, like this is already done for vdso2c tool,
mkpiggy and other tools in arch/x86/boot/.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/tools/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 55b1ab378974..bddfc9a46645 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -29,14 +29,14 @@ posttest: $(obj)/insn_decoder_test vmlinux $(obj)/insn_sanity
 hostprogs += insn_decoder_test insn_sanity
 
 # -I needed for generated C source and C source which in the kernel tree.
-HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/uapi/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/uapi/
+HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(srctree)/tools/arch/x86/lib/ -I$(srctree)/tools/arch/x86/include/ -I$(objtree)/arch/x86/lib/
 
-HOSTCFLAGS_insn_sanity.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
+HOSTCFLAGS_insn_sanity.o := -Wall -I$(srctree)/tools/arch/x86/lib/ -I$(srctree)/tools/arch/x86/include/ -I$(objtree)/arch/x86/lib/
 
 # Dependencies are also needed.
-$(obj)/insn_decoder_test.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
+$(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
-$(obj)/insn_sanity.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
+$(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 hostprogs	+= relocs
-- 
2.25.4

