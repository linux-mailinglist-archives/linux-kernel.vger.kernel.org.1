Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6744D2F6B59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbhANTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbhANTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tcE2k2XGm5FCaTXfp9k/QKHT8dSba+C3K9SORkf8GI=;
        b=P22SV607rPBua0RLqtGh49l8/+c6ntS2NXxN78yZLd+tKikCqc8/DjhYFfEcCpfrUlRAcV
        gPOl1wu3aZt48HsrR+VUmaSONXuMiZ6c5AihOhhJbmkYc+H/ZH09gGkzsOrRgWPyfT2/Y5
        Xcho4ZLX+3BCPel3LPlDQFFy86ryEzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-FDhqXBKFPSu7IS9eNJNOEw-1; Thu, 14 Jan 2021 14:40:26 -0500
X-MC-Unique: FDhqXBKFPSu7IS9eNJNOEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C45B15720;
        Thu, 14 Jan 2021 19:40:24 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFE821001E73;
        Thu, 14 Jan 2021 19:40:22 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 01/21] objtool: Fix seg fault in BT_FUNC() with fake jump
Date:   Thu, 14 Jan 2021 13:39:57 -0600
Message-Id: <c6bd154e55739c332c21ca4a91a66787cc3e104c.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool appends a temporary fake jump at the end of alternative
replacement instructions.  If the replacement code is empty -- resulting
in patched nops -- the fake jump doesn't have a section.  When running
objtool with '--backtrace', the fake jump's missing section can cause
BT_FUNC() to trigger a seg fault when the NULL insn->sec is passed to
offstr().

Fix it by ensuring fake jumps always have a section.

Fixes: 7697eee3ddd7 ("objtool: Add --backtrace support")
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f8d3eed78a1..ed26c22c8244 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1017,7 +1017,7 @@ static int handle_group_alt(struct objtool_file *file,
 		INIT_LIST_HEAD(&fake_jump->stack_ops);
 		init_cfi_state(&fake_jump->cfi);
 
-		fake_jump->sec = special_alt->new_sec;
+		fake_jump->sec = special_alt->new_sec ? : orig_insn->sec;
 		fake_jump->offset = FAKE_JUMP_OFFSET;
 		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
 		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-- 
2.29.2

