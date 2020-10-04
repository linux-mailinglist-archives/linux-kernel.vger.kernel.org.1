Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8674282B41
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJDObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:31:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgJDObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:31:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 094E3tl4185989;
        Sun, 4 Oct 2020 10:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=GfxFwLg0Ssg9lP6e/wJ4Z7cmWSufHa/RbkGYhekKtgo=;
 b=fzAnurW+2juWmgyktBkT76YFowOZolJRLxnHtaINx/c4dbPIFq1eRq1mRLJMCBtYYNvb
 bURar5fJr1TWe9Sw3uoiSYqYl567HXH1aQZMTEy5XqfuXKRRCXIp3Bg26KRjIzdoyGuB
 Vak8hfBq5HyW4tPd4jdveAzPRxeL8cE/dTt4x42P2D+gAyutehrAkbDcKB3AG1pQWHhe
 4v3nzBCplfsZGxmPa/DGXUvYA5IAn+92/y5YMAQQ2/fIbgDxkUsvv21wmoODCIUHY6+O
 3VOmqGEsRaAR7Z4nhLTCQPpOhi+4wJpexVTRu0gE4BuPPNhwV9AeVPalsJSeEGhZjjWc Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33yfbqrsrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 10:30:51 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 094EP7Tv063202;
        Sun, 4 Oct 2020 10:30:50 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33yfbqrsr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 10:30:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 094ECYtT026077;
        Sun, 4 Oct 2020 14:30:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh183w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 14:30:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 094EUj9432965076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Oct 2020 14:30:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E1111C04A;
        Sun,  4 Oct 2020 14:30:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB39011C04C;
        Sun,  4 Oct 2020 14:30:44 +0000 (GMT)
Received: from localhost (unknown [9.145.42.132])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Oct 2020 14:30:44 +0000 (GMT)
Date:   Sun, 4 Oct 2020 16:30:43 +0200
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
Subject: [RFC PATCH v4 1/4] objtool: allow nested externs to enable
 BUILD_BUG()
Message-ID: <patch-1.thread-a8def4.git-71a9d5e14a6c.your-ad-here.call-01601818410-ext-7687@work.hours>
References: <20201002160114.7yb7z7aeijhchpwl@treble>
 <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-04_13:2020-10-02,2020-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=924 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010040099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently BUILD_BUG() macro is expanded to smth like the following:
   do {
           extern void __compiletime_assert_0(void)
                   __attribute__((error("BUILD_BUG failed")));
           if (!(!(1)))
                   __compiletime_assert_0();
   } while (0);

If used in a function body this obviously would produce build errors
with -Wnested-externs and -Werror.

Build objtool with -Wno-nested-externs to enable BUILD_BUG() usage.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 33d1e3ca8efd..4ea9a833dde7 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -37,7 +37,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
-WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
+WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿

