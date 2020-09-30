Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1603E27E874
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgI3MYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:24:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgI3MYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UC4bFZ172696;
        Wed, 30 Sep 2020 08:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=EhXUprzlfh/Y0khfBPpxT03eBLRVmg2xP/3X6vV5QpA=;
 b=bRy3Km0PMwJ3R6mTrG+HkLcHQ4iAgxvDr3sTJffoJGFr60zbWoTAn1qRsZFbqWTGUwhE
 cMIPLM5d6mJzs3gq2GzUfaRigmGGD5WONe/grpY5+TsoBl5Sgm4giBhuJvI26hEG0oda
 9KpslTbGJXTZfOZezZzjVDzwDqsm0jT99ixjkQKdBrqKLMPjkXDPwQrvDRr1XV7xNrM1
 aoAPbc/pkCo5kDQ61b0S370cB7vZRo90o+3jXdyGXqQFZYLdtNfVUK+kOu2zgoE1bOGJ
 hmwN9f7RVgjKeqWPFw1S0Iyar6+y1IYbsXiaq2UJddHYz6V0T2/I5WvbyXq40HXrPFlV Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33vq8ndqkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:24:23 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UC4ub5174049;
        Wed, 30 Sep 2020 08:24:23 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33vq8ndqjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:24:23 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UCCSxn005107;
        Wed, 30 Sep 2020 12:24:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgrybm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 12:24:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UCOIlu31654176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 12:24:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D648B42041;
        Wed, 30 Sep 2020 12:24:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C44342042;
        Wed, 30 Sep 2020 12:24:18 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 12:24:18 +0000 (GMT)
Date:   Wed, 30 Sep 2020 14:24:16 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] objtool and cross compilation
Message-ID: <cover.thread-ca645c.your-ad-here.call-01601468251-ext-3723@work.hours>
References: <20200930101251.GX2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930101251.GX2628@hirez.programming.kicks-ass.net>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_07:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rfc v1 - rfc v2:
 - rebased onto tip/objtool/core
 - reformatted couple of lines

Currently objtool seems to be the only tool from build tools needed
which breaks x86 cross compilation on big endian systems.

But besides x86 cross compilation, endianness awareness is also needed
for big endian architectures objtool support in general.

We have working prototype of objtool support and orc unwinder for s390
made originally by Martin Schwidefsky. I'm trying to bring it in shape
again and refactor to share more code with "generic" part.

But first things first. These 2 patches point to endianness problems
which should be addressed. And I'd be glad to get any ideas how to make
them less ugly.

New "other architectures support" patches currently move only some
problematic parts into x86 arch specific folder. But the main problem
is that arch/x86/lib/insn.c and arch/x86/include/asm/insn.h are shared
across the kernel source and the tools, and there is no common way to
address endianness problems.

Since big endian stuff is only needed for the objtool and not for the
kernel I can try to hide alternative big endian definitions in tools
only header which is included only if __KERNEL__ is not defined. But
that kind of defeats the idea of sharing those files 1 to 1 with tools.

Thoughts? Any suggestions are welcome.

Martin Schwidefsky (1):
  objtool: x86 instruction decoder and big endian cross compiles

Vasily Gorbik (1):
  objtool: fix x86 orc generation on big endian cross compiles

 arch/x86/include/asm/insn.h            | 42 ++++++++++++
 arch/x86/include/asm/orc_types.h       | 24 +++++++
 arch/x86/lib/insn.c                    | 95 +++++++++++---------------
 tools/arch/x86/include/asm/insn.h      | 42 ++++++++++++
 tools/arch/x86/include/asm/orc_types.h | 24 +++++++
 tools/arch/x86/lib/insn.c              | 95 +++++++++++---------------
 tools/objtool/arch/x86/special.c       |  2 +-
 tools/objtool/check.c                  |  4 +-
 tools/objtool/elf.c                    | 34 +++++----
 tools/objtool/orc_dump.c               |  4 +-
 tools/objtool/orc_gen.c                |  2 +
 11 files changed, 240 insertions(+), 128 deletions(-)

-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
