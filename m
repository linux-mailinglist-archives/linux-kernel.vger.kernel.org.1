Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C796B283BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgJEPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:51:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16390 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgJEPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:51:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095FWoYf151536;
        Mon, 5 Oct 2020 11:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=FLwIBWTFwt6e5Q7I/5VE5X42wqEQ5jCnim2fhXjcaNI=;
 b=NB/7yM1NP/CyIPoGotlz4cqFueqSYNmJB3JAHcill3JZaecNGyy8oU6BpzpLfJLAvifL
 qqXoZwly0OedxVikFEolCWbdYUl0D4D9afTLulsmDzvwsKnMA40WfF6JvZflAAYo+BnY
 S2NAEWE2/EY6FOHuazM52Kxck6GI1a1mjoFaWkdwv9RXkgX2cLapl9pdz9PvpmkobPPS
 ZjbPFK/81c373nchj1akIVTZ4ZDXCoOYacb1Jel5bl1dKzDUMnxBjK8MeAQ8pa9smSCL
 LLuVusV6d5OM5ipTTtru95tU9pVu0KyyZM8G5qrzwzcFOIFBZUNFdGRk7QVgYgIJw9LZ 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340527u8wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:31 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 095FXEf4154080;
        Mon, 5 Oct 2020 11:50:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340527u8vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095FmRfS014971;
        Mon, 5 Oct 2020 15:50:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 33xgx8aav3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 15:50:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095FoRqw29622718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Oct 2020 15:50:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5078A42042;
        Mon,  5 Oct 2020 15:50:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 834204204C;
        Mon,  5 Oct 2020 15:50:26 +0000 (GMT)
Received: from localhost (unknown [9.145.67.211])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Oct 2020 15:50:26 +0000 (GMT)
Date:   Mon, 5 Oct 2020 17:50:25 +0200
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
Subject: [RFC PATCH RESEND v4 0/4] objtool and cross compilation
Message-ID: <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
References: <20201005140328.hpbpkfpx3hmpuapt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005140328.hpbpkfpx3hmpuapt@treble>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_10:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the extra noise. Patches has been resent because one of them
has been corrupted. That's what you get for post-editing mailbox in vim,
few wrong extra strokes and your wife wants to divorce you because you
just copied and pretty-formatted her threatening message to your internet
service provider from another buffer.

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
