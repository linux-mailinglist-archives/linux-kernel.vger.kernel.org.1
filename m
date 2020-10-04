Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2E282B40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJDObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:31:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17210 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgJDObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:31:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 094EHZkI176278;
        Sun, 4 Oct 2020 10:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=htf3ZFZTFc43oZsdk+rj012T/nrrxDiA3It92Up/jwo=;
 b=dZSIKQFJVRVl+oH1fXqiy6joKCu6gwz1I3typqvj1kp04w1Uzi/HUSSSE2iIprBu86ut
 LOf28F/Y0f9A3IqurJ4lTBjyMZOySccrFcswpDt03aTSYNwns2yr1jzTzgisjAK6DNpA
 BLT+WzzghX9+Pp4vWmo9JL9LYRIpTj1YAYkJ9A+NCGqQ0xmpv/4N7xqDLmN4hGbiATo3
 Np2tRutOH96sWx0Ze3Pd4hstDcKydTeVWXZlnzgI3CtAlVU/T8+tpr2YdeY6B944YZ61
 tTme7n/1sxO8rpKcX74cd54oepF0DzstHgKjoIF942pFpbLGalbjdbwZCsFLAZ73ertk 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33yg1f85mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 10:30:46 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 094EJFle179793;
        Sun, 4 Oct 2020 10:30:46 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33yg1f85m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 10:30:46 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 094EEUiH006106;
        Sun, 4 Oct 2020 14:30:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx80mhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 14:30:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 094EUgiZ33096162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Oct 2020 14:30:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B6342042;
        Sun,  4 Oct 2020 14:30:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68EAA42041;
        Sun,  4 Oct 2020 14:30:41 +0000 (GMT)
Received: from localhost (unknown [9.145.42.132])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Oct 2020 14:30:41 +0000 (GMT)
Date:   Sun, 4 Oct 2020 16:30:39 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/4] objtool and cross compilation
Message-ID: <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
References: <20201002160114.7yb7z7aeijhchpwl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002160114.7yb7z7aeijhchpwl@treble>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-04_12:2020-10-02,2020-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010040104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rfc v1 - rfc v2:
 - rebased onto tip/objtool/core
 - reformatted couple of lines

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

rfc v3 - rfc v4:
 - patch 4: objtool: fix x86 orc generation on big endian cross compiles
   - introduced "bswap_if_needed()" macro for multi-byte values
     conversion, which are read from / about to be written to a target
     native endianness ELF file.
 - patch 2: x86/insn: instruction decoder and big endian cross compiles
   - changed subject prefix from objtool to x86/insn
   - reformated leXX_to_cpu macro make it easier to read

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

Any suggestions how to make patches more acceptable are welcome.

Martin Schwidefsky (2):
  x86/insn: instruction decoder and big endian cross compiles
  objtool: correct rebuilding of reloc sections

Vasily Gorbik (2):
  objtool: allow nested externs to enable BUILD_BUG()
  objtool: fix x86 orc generation on big endian cross compiles

 arch/x86/include/asm/insn.h                   |  33 ++++++
 arch/x86/include/asm/orc_types.h              |  10 ++
 arch/x86/lib/insn.c                           | 101 ++++++++----------
 tools/arch/x86/include/asm/insn.h             |  33 ++++++
 tools/arch/x86/include/asm/orc_types.h        |  10 ++
 tools/arch/x86/lib/insn.c                     | 101 ++++++++----------
 tools/objtool/Makefile                        |   2 +-
 .../arch/x86/include/arch_endianness.h        |   9 ++
 tools/objtool/check.c                         |   5 +-
 tools/objtool/elf.c                           |  34 +++---
 tools/objtool/endianness.h                    |  38 +++++++
 tools/objtool/orc_dump.c                      |   5 +-
 tools/objtool/orc_gen.c                       |   3 +
 tools/objtool/special.c                       |   6 +-
 14 files changed, 260 insertions(+), 130 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_endianness.h
 create mode 100644 tools/objtool/endianness.h

-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
