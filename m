Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F91E4A96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391385AbgE0Qmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:42:55 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:11383 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391358AbgE0Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:42:48 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 May 2020 09:42:44 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id AA5714046A;
        Wed, 27 May 2020 09:42:46 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 2/3] objtool: Find relocation base section using sh_info
Date:   Wed, 27 May 2020 09:42:32 -0700
Message-ID: <d848189dac6c41193a6c55c3588b78114bbcb0f8.1590597288.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1590597288.git.mhelsley@vmware.com>
References: <cover.1590597288.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool uses a naming heuristic to find the "base"
section to apply the relocation(s) to. The standard defines
the SHF_INFO_LINK flag (SHF => in the section header flags)
which indicates when the section header's sh_info field can
be used to find the necessary section.

Warns when the heuristic is used as a fallback and changes
the name heuristic calculation to handle rela (explicit
addend) and now rel (implicit addend) relocations.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6fb9f83f7f66..a162bc383945 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -502,7 +502,13 @@ static int read_relocs(struct elf *elf)
 		if (sec->sh.sh_type != SHT_RELA)
 			continue;
 
-		sec->base = find_section_by_name(elf, sec->name + 5);
+		if (sec->sh.sh_flags & SHF_INFO_LINK) {
+			sec->base = find_section_by_index(elf, sec->sh.sh_info);
+		} else if (strncmp(sec->name, ".rel", 4) == 0) {
+			WARN("Using naming heuristic to find base of reloc section %s",
+			     sec->name);
+			sec->base = find_section_by_name(elf, sec->name + 5);
+		}
 		if (!sec->base) {
 			WARN("can't find base section for reloc section %s",
 			     sec->name);
-- 
2.20.1

