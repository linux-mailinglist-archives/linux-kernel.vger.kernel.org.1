Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC092F6E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbhANW0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728563AbhANW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610663117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LGpFlJGSVR1hP37dBeomfMm+jKU/Sspz4e2JR6Dw5mQ=;
        b=HndssyqSg759SdAdmeN2Tals1cM2F4uPW0FNL/2rJF/6+52ZLVHkaCLfXfeI24kXfn/KSz
        dwJoHej7kvhdQb6df9F0rnXa71/eoKaVcB2+pF/xQHuTnNEkst3DZRSlw34q7s0wqwxSKk
        XdL6wDGj47CBMmpg9ZKGBGgZgBeCorc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-RcD-CRHJMpmAv-h7btU2NQ-1; Thu, 14 Jan 2021 17:25:13 -0500
X-MC-Unique: RcD-CRHJMpmAv-h7btU2NQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3737801FCC;
        Thu, 14 Jan 2021 22:25:11 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08F1619C45;
        Thu, 14 Jan 2021 22:25:09 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] objtool: Don't fail on missing symbol table
Date:   Thu, 14 Jan 2021 16:24:15 -0600
Message-Id: <a96c3f76173c7021a2298bd73362313736e674b6.1610663051.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to a recent binutils change which doesn't generate unused
symbols, it's now possible for thunk_64.o be completely empty with
CONFIG_PREEMPTION: no text, no data, no symbols.

We could edit the Makefile to only build that file when
CONFIG_PREEMPTION is enabled, but that will likely create confusion
if/when the thunks end up getting used by some other code again.

Just ignore it and move on.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be89c741ba9a..2b0f4f52f7b5 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -380,8 +380,11 @@ static int read_symbols(struct elf *elf)
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
-		WARN("missing symbol table");
-		return -1;
+		/*
+		 * A missing symbol table is actually possible if it's an empty
+		 * .o file.  This can happen for thunk_64.o.
+		 */
+		return 0;
 	}
 
 	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
-- 
2.29.2

