Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC13C283BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgJEPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:51:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48348 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgJEPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:51:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095FWoUr151511;
        Mon, 5 Oct 2020 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=vFMZTjfglZghT+DVaeJGAUx1EnEkxjAxPyqdKGGrdvI=;
 b=Qqpgc+5Xp/DeZplKQP93Ea9809fr7zs9U3BWnyClvirQfh8CgbPDqngQHgdc06ABkgWv
 fHWnmPapuAh7zsSL3HCrs90nYD0rT1OvF9HKrf+RPWuucuvn24k0k+6r/HYStNakm8Gr
 zSY3LcMjdy3FntlhrLjlp1jgoPVyJn9O+Q6rA+/i6QVh9Kv/aa/Mhx+KlKSSabQ7FWop
 13bcII/clj36RoAOnFgK3T9lw3ILl+PwL5vbaLVH0HQhvJyACRTZmcou6DThMfSttwmV
 2nnrapijNcY4mqFbZvTGL5lb58cE9THpwm34jHcQhZC5n0pq54QOeOrhZl80+fF29GJc AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340527u93j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:42 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 095FX9il153391;
        Mon, 5 Oct 2020 11:50:41 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340527u92s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:41 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095FlMG3005274;
        Mon, 5 Oct 2020 15:50:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx816sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 15:50:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095FobTs28574182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Oct 2020 15:50:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B3F2A405B;
        Mon,  5 Oct 2020 15:50:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0CBA4054;
        Mon,  5 Oct 2020 15:50:36 +0000 (GMT)
Received: from localhost (unknown [9.145.67.211])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Oct 2020 15:50:36 +0000 (GMT)
Date:   Mon, 5 Oct 2020 17:50:34 +0200
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
Subject: [RFC PATCH RESEND v4 3/4] objtool: correct rebuilding of reloc
 sections
Message-ID: <patch-3.thread-b2a547.git-2ef676be9306.your-ad-here.call-01601912612-ext-9766@work.hours>
References: <20201005140328.hpbpkfpx3hmpuapt@treble>
 <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
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
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿

