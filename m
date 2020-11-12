Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64D2B125F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKLXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:03:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgKLXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:03:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACN2sto042518;
        Thu, 12 Nov 2020 18:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=FMOWnoGH4pRJTA4CZg+kIm+2FrFyGZ1RWFDcDb7biAk=;
 b=Gvsyg2jdxLPi6Tv/aBEWEuVgqIyXVC/URlq3VOhh9s6gVlejyy08M95/OHEtRduXRTb5
 e46yDq9+t1lfz8wLwi1bPMNdZX/JxXyyj+JaMLJRbbu1Wk0JwAVxdEbo0BiOtUq98K/s
 w7J7fOE2tfMR9q1xzD4dEPjORgB2EkWmWAtlCDX3yruxh0+19zUxi2sd31SZmT+iqnTx
 KLb0/foWhNtQkY0Egyvp7Nq+iLSJUbsRNfSqnrywsIsk8xSrqYMQ8FvWTCHZtI0Rfe48
 MZrsUfEMfVNlbyThMFO+sx6F/PBzoIV5wLA72owAAlAEqB//2TdMZ4W7gJedMXJy5Yhh 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sbjv4gxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:03:24 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACN31Hj043178;
        Thu, 12 Nov 2020 18:03:24 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sbjv4gw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:03:24 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMqDEx000681;
        Thu, 12 Nov 2020 23:03:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh64m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 23:03:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACN3JEH4981500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 23:03:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 345B84C04A;
        Thu, 12 Nov 2020 23:03:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97EF14C040;
        Thu, 12 Nov 2020 23:03:18 +0000 (GMT)
Received: from localhost (unknown [9.171.90.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Nov 2020 23:03:18 +0000 (GMT)
Date:   Fri, 13 Nov 2020 00:03:17 +0100
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
Subject: [PATCH v5 0/5] objtool and cross compilation
Message-ID: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series is resent with additional patch for the instruction
decoder selftest, since it has been dropped from the tip/objtool/core
due to instruction decoder selftest build failure.

Previous version can be found here:
https://lore.kernel.org/lkml/cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours/

rfc v4 - v5:
 - original patch 1 has been merged. It has been replaced with the patch
   which moves instruction decoder selftests to tools headers usage.
   This effectively fixes x86 kernel cross-compilation with
   CONFIG_X86_DECODER_SELFTEST=y. And posttests are run successfully at
   least on s390 (with entire patch series applied).
 - patch 2 has instruction decoder selftest fixup added.
 - also includes patch 5 for objtool header include paths rework.
 - patches 2-5 titles changed to those with which they were picked up
   into tip/objtool/core.

rfc v3 - rfc v4:
 - patch 4: objtool: fix x86 orc generation on big endian cross compiles
   - introduced "bswap_if_needed()" macro for multi-byte values
     conversion, which are read from / about to be written to a target
     native endianness ELF file.
 - patch 2: x86/insn: instruction decoder and big endian cross compiles
   - changed subject prefix from objtool to x86/insn
   - reformated leXX_to_cpu macro make it easier to read

rfc v2 - rfc v3:
 - reused __*_ENDIAN_BITFIELD and dropped unneeded byteswap if __KERNEL__
   is defined following David's suggestions,
 - re-splitted changes and made x86 instruction decoder a separate patch,
 - extra patch to add -Wno-nested-externs build flag to enable BUILD_BUG()
   usage,
 - added a safer and more readable leXX_to_cpu macro in x86 instruction
   decoder,
 - simplified includes. Switched to using leXX_to_cpu/cpu_to_leXX in
   the objtool and x86 instruction decoder since
   <linux/kernel.h> is included in the objtool already.

rfc v1 - rfc v2:
 - rebased onto tip/objtool/core
 - reformatted couple of lines

Currently objtool seems to be the only tool from all the build tools
needed for x86 build which breaks x86 cross compilation on big endian
systems.

But besides x86 cross compilation, endianness awareness is also needed
for big endian architectures objtool support in general.

We have working prototype of objtool support and orc unwinder for s390
made originally by Martin Schwidefsky. I'm trying to bring it in shape
again and refactor to share more code with "generic" part.

But first things first. This patch series points to endianness problems
which should be addressed. Recent "other architectures support" patches
currently moved only some problematic parts into x86 arch specific folder.
Besides that even though big endian stuff is only needed for the objtool
arch/x86/lib/insn.c and arch/x86/include/asm/insn.h are shared across
the kernel source and the tools, so changes are applied to both.

Martin Schwidefsky (2):
  x86/insn: Support big endian cross-compiles
  objtool: Fix reloc generation on big endian cross compiles

Vasily Gorbik (3):
  x86/tools: Use tools headers for instruction decoder selftests
  objtool: Fix x86 orc generation on big endian cross compiles
  objtool: Rework header include paths

 arch/x86/include/asm/insn.h                   |  33 ++++++
 arch/x86/include/asm/orc_types.h              |  10 ++
 arch/x86/lib/insn.c                           | 101 ++++++++----------
 arch/x86/tools/Makefile                       |   8 +-
 arch/x86/tools/insn_sanity.c                  |   4 -
 tools/arch/x86/include/asm/insn.h             |  33 ++++++
 tools/arch/x86/include/asm/orc_types.h        |  10 ++
 tools/arch/x86/lib/insn.c                     | 101 ++++++++----------
 tools/objtool/.gitignore                      |   2 +-
 tools/objtool/Makefile                        |   1 +
 tools/objtool/arch/x86/decode.c               |   8 +-
 .../arch/x86/include/{ => arch}/cfi_regs.h    |   0
 .../x86/include/{arch_elf.h => arch/elf.h}    |   0
 .../arch/x86/include/arch/endianness.h        |   9 ++
 .../{arch_special.h => arch/special.h}        |   0
 tools/objtool/arch/x86/special.c              |   4 +-
 tools/objtool/builtin-check.c                 |   4 +-
 tools/objtool/builtin-orc.c                   |   4 +-
 tools/objtool/check.c                         |  19 ++--
 tools/objtool/elf.c                           |  40 +++----
 tools/objtool/{ => include/objtool}/arch.h    |   4 +-
 tools/objtool/{ => include/objtool}/builtin.h |   0
 tools/objtool/{ => include/objtool}/cfi.h     |   2 +-
 tools/objtool/{ => include/objtool}/check.h   |   4 +-
 tools/objtool/{ => include/objtool}/elf.h     |   0
 tools/objtool/include/objtool/endianness.h    |  38 +++++++
 tools/objtool/{ => include/objtool}/objtool.h |   2 +-
 tools/objtool/{ => include/objtool}/special.h |   4 +-
 tools/objtool/{ => include/objtool}/warn.h    |   2 +-
 tools/objtool/objtool.c                       |   6 +-
 tools/objtool/orc_dump.c                      |   9 +-
 tools/objtool/orc_gen.c                       |   7 +-
 tools/objtool/special.c                       |  14 +--
 tools/objtool/weak.c                          |   2 +-
 34 files changed, 306 insertions(+), 179 deletions(-)
 rename tools/objtool/arch/x86/include/{ => arch}/cfi_regs.h (100%)
 rename tools/objtool/arch/x86/include/{arch_elf.h => arch/elf.h} (100%)
 create mode 100644 tools/objtool/arch/x86/include/arch/endianness.h
 rename tools/objtool/arch/x86/include/{arch_special.h => arch/special.h} (100%)
 rename tools/objtool/{ => include/objtool}/arch.h (96%)
 rename tools/objtool/{ => include/objtool}/builtin.h (100%)
 rename tools/objtool/{ => include/objtool}/cfi.h (96%)
 rename tools/objtool/{ => include/objtool}/check.h (96%)
 rename tools/objtool/{ => include/objtool}/elf.h (100%)
 create mode 100644 tools/objtool/include/objtool/endianness.h
 rename tools/objtool/{ => include/objtool}/objtool.h (96%)
 rename tools/objtool/{ => include/objtool}/special.h (94%)
 rename tools/objtool/{ => include/objtool}/warn.h (98%)

-- 
2.25.4
