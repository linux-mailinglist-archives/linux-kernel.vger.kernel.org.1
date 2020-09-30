Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E842127F4F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgI3WRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:17:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730258AbgI3WRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:17:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UM2rcA141596;
        Wed, 30 Sep 2020 18:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=RPID6nDqz5YL8qrkZmiJU5uCwJ07iotV4+4+6zp7Xug=;
 b=lbHSa0JoYJSLg/iXLmKjZsDyMN+bolJGxCAyt1n3X9m0D05ducSZksRAfcFk+NJIxCjU
 VGIzpcd8Hj4XyaK4PFu5mIgYyILyNsD+2SuVMrOHlDNgMMm86rdiAxJ42jWgWurBPjDj
 VTjBa4BF6xfcSRmnFZxf3VddOYZYbo/Nt8K34sFyQORLQANow/WamNTVqB5PdnfElVHs
 Bx5thItCPva/dOl/kYE8J8mF5FJN7wyVFCPCg5lAdPTml0xAQeM0pxlB2ln8fiohtoeB
 Chtl4gfcun2q4Zqq2MiGXdH9S8RczXiWqBvNPWvKgLvyqn8Qs9JriPUVJi+wO7sI4yNr Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33w1ra1dgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 18:17:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UMBsf3025900;
        Wed, 30 Sep 2020 18:17:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33w1ra1dfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 18:17:26 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UMHNO0008296;
        Wed, 30 Sep 2020 22:17:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 33sw97vv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 22:17:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UMHLOw27394398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 22:17:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B0F2A404D;
        Wed, 30 Sep 2020 22:17:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBBFDA4040;
        Wed, 30 Sep 2020 22:17:20 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 22:17:20 +0000 (GMT)
Date:   Thu, 1 Oct 2020 00:17:19 +0200
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
Subject: [RFC PATCH v3 0/4] objtool and cross compilation
Message-ID: <cover.thread-6ec90b.your-ad-here.call-01601502173-ext-7769@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_13:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300176
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
  objtool: x86 instruction decoder and big endian cross compiles
  objtool: correct rebuilding of reloc sections

Vasily Gorbik (2):
  objtool: allow nested externs to enable BUILD_BUG()
  objtool: fix x86 orc generation on big endian cross compiles

 arch/x86/include/asm/insn.h            |  35 ++++++++
 arch/x86/include/asm/orc_types.h       |  10 +++
 arch/x86/lib/insn.c                    | 108 ++++++++++++-------------
 tools/arch/x86/include/asm/insn.h      |  35 ++++++++
 tools/arch/x86/include/asm/orc_types.h |  10 +++
 tools/arch/x86/lib/insn.c              | 108 ++++++++++++-------------
 tools/objtool/Makefile                 |   2 +-
 tools/objtool/arch/x86/special.c       |   2 +-
 tools/objtool/check.c                  |   4 +-
 tools/objtool/elf.c                    |  34 ++++----
 tools/objtool/orc_dump.c               |   4 +-
 tools/objtool/orc_gen.c                |   2 +
 12 files changed, 225 insertions(+), 129 deletions(-)

-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
