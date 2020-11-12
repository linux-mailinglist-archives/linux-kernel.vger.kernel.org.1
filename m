Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B482B1265
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKLXEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:04:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgKLXEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:04:41 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACN4L5X071699;
        Thu, 12 Nov 2020 18:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0ojxC/4ixhoD6PbJjPSOL8NOec9xQLw5b5/Yq1C+61A=;
 b=P77OAA4c5FcCwcjSYUI0/Q9AM+ERKUWqZVBecDEQMBpA1nyWqrZTX+62BV9xjFDpphGl
 aH5sQrzZTM+nm0oaaZzGu7hm5SqrYugNduQGJswSwj9zDe+2kmpO28YmKdeOGJ3v39Yb
 99kglhCmN4ZQl85JIDqY+PtFbyH1X7TgTZXZJ7hAI8m4sB6Xqn9Ub9s87BQYztjRk8IW
 YbxHRq6Vyzb1RLwf2r9ndrpVBwV0rMmeSXY66Y8ZOry9LnqzvszsRcu6bZzEKmOf/9cT
 pI+Yfo3YRKGxYmwmQl2PEQD84zoT8Tl0YGZKznIdgbbzTgHGvU+tFlP9bE2SBbKg/Psu xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34schj2pdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:04:26 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACN4OKb071904;
        Thu, 12 Nov 2020 18:04:24 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34schj2p0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:04:24 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMrubt020177;
        Thu, 12 Nov 2020 23:03:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 34q08428hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 23:03:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACN3S0462390570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 23:03:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 410444C044;
        Thu, 12 Nov 2020 23:03:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4D4F4C046;
        Thu, 12 Nov 2020 23:03:27 +0000 (GMT)
Received: from localhost (unknown [9.171.90.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Nov 2020 23:03:27 +0000 (GMT)
Date:   Fri, 13 Nov 2020 00:03:26 +0100
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
Subject: [PATCH v5 3/5] objtool: Fix reloc generation on big endian cross
 compiles
Message-ID: <patch-3.thread-1e2854.git-44a7767ae87e.your-ad-here.call-01605220128-ext-6070@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Currently relocations generated in elf_rebuild_rel_reloc_section/
elf_rebuild_rela_reloc_section functions are broken if the objtool is
built and run on big endian system. E.g. the following errors pop up
during x86 cross compilation:
x86_64-9.1.0-ld: fs/efivarfs/inode.o: bad reloc symbol index (0x2000000 >=
		0x22) for offset 0 in section `.orc_unwind_ip'
x86_64-9.1.0-ld: final link failed: bad value

To address that convert those functions to do things similar to
elf_write_reloc(), reuse gelf_update_rel/gelf_update_rela libelf library
functions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 tools/objtool/elf.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d7460574b..5c0341b0cde3 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -829,25 +829,27 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rel *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rel);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_REL;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rel.r_offset = reloc->offset;
+		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rel(sec->data, idx, &reloc->rel);
 		idx++;
 	}
 
@@ -858,26 +860,28 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rela *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rela);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_RELA;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_addend = reloc->addend;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rela.r_offset = reloc->offset;
+		reloc->rela.r_addend = reloc->addend;
+		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rela(sec->data, idx, &reloc->rela);
 		idx++;
 	}
 
-- 
2.25.4

