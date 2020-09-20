Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A82717B0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgITT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITT60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:58:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37962AD39;
        Sun, 20 Sep 2020 19:59:01 +0000 (UTC)
Date:   Sun, 20 Sep 2020 21:58:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v5.9-rc6
Message-ID: <20200920195823.GF13044@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single objtool fix.

Thx.

---
The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.9_rc6

for you to fetch changes up to db6c6a0df840e3f52c84cc302cc1a08ba11a4416:

  objtool: Fix noreturn detection for ignored functions (2020-09-18 19:37:51 +0200)

----------------------------------------------------------------
Fix noreturn detection for ignored sibling functions, from Josh
Poimboeuf.

----------------------------------------------------------------
Josh Poimboeuf (1):
      objtool: Fix noreturn detection for ignored functions

 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f24f46..90a66891441a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -619,7 +619,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (!is_static_jump(insn))
 			continue;
 
-		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
+		if (insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
 		reloc = find_reloc_by_dest_range(file->elf, insn->sec,

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
