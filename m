Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE841EC318
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgFBTvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 15:51:18 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728363AbgFBTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:02 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:58 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1255140BEE;
        Tue,  2 Jun 2020 12:50:59 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 16/32] objtool: mcount: Restrict using ehdr in append_func()
Date:   Tue, 2 Jun 2020 12:50:09 -0700
Message-ID: <735691b9308adaa3cc1e4b15506459e4c9e8ad57.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ehdr parameter to append_func() to write the
ELF file's header but use the objtool ELF header data
as the basis for making changes. The makes it clearer
when we can switch from using the old recordmcount
wrapper to write the ELF file because ehdr will only
be passed on to uwrite() calls and those will get
replaced later.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 98cf9eea6074..7ebc617fb3a6 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -99,8 +99,8 @@ static int append_func(Elf_Ehdr *const ehdr,
 	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
 		? ".rela__mcount_loc"
 		:  ".rel__mcount_loc";
-	unsigned const old_shnum = w2(ehdr->e_shnum);
-	uint_t const old_shoff = _w(ehdr->e_shoff);
+	unsigned const old_shnum = lf->ehdr.e_shnum;
+	uint_t const old_shoff = lf->ehdr.e_shoff;
 	uint_t const old_shstr_sh_size   = _w(shstr->sh_size);
 	uint_t const old_shstr_sh_offset = _w(shstr->sh_offset);
 	uint_t t = 1 + strlen(mc_name) + _w(shstr->sh_size);
@@ -167,7 +167,7 @@ static int append_func(Elf_Ehdr *const ehdr,
 		return -1;
 
 	ehdr->e_shoff = _w(new_e_shoff);
-	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
+	ehdr->e_shnum = w2(2 + lf->ehdr.e_shnum);  /* {.rel,}__mcount_loc */
 	if (ulseek(0, SEEK_SET) < 0)
 		return -1;
 	if (uwrite(ehdr, sizeof(*ehdr)) < 0)
-- 
2.20.1

