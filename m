Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246E027E5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgI3J6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:58:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15090 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgI3J6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:58:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U9gJ1s146595;
        Wed, 30 Sep 2020 05:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=YebIZqAwRDWi2AaUfQSF/in38mYGDN6RV5MXcQluT/A=;
 b=pK2wAAmPAK4aTSgofB0CWaE5EJOnoUd5qXKZfevcTU+jdx4BPR/qlW0fH0sk/Cpe/yFc
 PMzTbUqP7cC+Bt8h2Aoq/P/S1TXo1ktTpcZmDkgvXJ1WvrBlBdeo4uKqAzUnMoxW04Gw
 YM+6+OXoBPO0hYO3IxvrcqSKEKB9mG3Qd0KgLsKMe7N2pIAWZBMtxT5dkOtb+XZ6yS2d
 YNAJl0Qm4oB2FqO9mlSEHKzQ/qkVmQhbljIcqYGqWtRUDEDJhzSSeU4J03qxJRacKeVJ
 2DH1ezfEgvJ30hwOxldagWDkyHEu2G+WDQBOfUYAd8M5KGjKm6XNr5RvTZfdoMeVUtnL lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqm9ret1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 05:58:32 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08U9qrnJ181186;
        Wed, 30 Sep 2020 05:58:31 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqm9rert-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 05:58:31 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08U9voDF001342;
        Wed, 30 Sep 2020 09:58:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 33v5kg0g13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 09:58:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08U9wQ2O17498562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 09:58:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9A5AA4054;
        Wed, 30 Sep 2020 09:58:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C948A4060;
        Wed, 30 Sep 2020 09:58:26 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 09:58:26 +0000 (GMT)
Date:   Wed, 30 Sep 2020 11:58:24 +0200
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
Subject: [RFC PATCH 0/2] objtool and cross compilation
Message-ID: <cover.thread-e6a24b.your-ad-here.call-01601459756-ext-4914@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 suspectscore=1 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on v5.9-rc7, before "other architectures support" patches
starting pouring in.

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

 arch/x86/include/asm/insn.h            | 43 ++++++++++++
 arch/x86/include/asm/orc_types.h       | 24 +++++++
 arch/x86/lib/insn.c                    | 95 +++++++++++---------------
 tools/arch/x86/include/asm/insn.h      | 43 ++++++++++++
 tools/arch/x86/include/asm/orc_types.h | 24 +++++++
 tools/arch/x86/lib/insn.c              | 95 +++++++++++---------------
 tools/objtool/check.c                  |  4 +-
 tools/objtool/elf.c                    | 34 +++++----
 tools/objtool/orc_dump.c               |  4 +-
 tools/objtool/orc_gen.c                |  2 +
 tools/objtool/special.c                |  4 +-
 11 files changed, 243 insertions(+), 129 deletions(-)

-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
