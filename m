Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23D2FF765
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbhAUVhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbhAUVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YP6hG/dCxU2e+tBOQgk43FobH/+ECz4yMlrprzfqBqo=;
        b=hpW9Xap8uuzyKEBykO24kItSFGXdvgF+xVIZBtNSjnbf2srn8/Lgr7XgFKWVAB9r5fQ8Df
        GMHboK1ek4cABkmgPPHhiw42ylYLwP/czIi5rL8d89Pqj/vh2eL1Y97UJBhzdaKSPcA3t2
        bh/hmRVZPODB6EYj24Bn3s7Umats148=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-J9TGQBVWPV6Jnb9h8gkU5Q-1; Thu, 21 Jan 2021 16:30:05 -0500
X-MC-Unique: J9TGQBVWPV6Jnb9h8gkU5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D71DB107ACE6;
        Thu, 21 Jan 2021 21:30:03 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE40E19C59;
        Thu, 21 Jan 2021 21:30:01 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 07/20] objtool: Add asm version of STACK_FRAME_NON_STANDARD
Date:   Thu, 21 Jan 2021 15:29:23 -0600
Message-Id: <8faa476f9a5ac89af27944ec184c89f95f3c6c49.1611263462.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be used for adding asm functions to the ignore list.  The "aw" is
needed to help the ELF section metadata match GCC-created sections.
Otherwise the linker creates duplicate sections instead of combining
them.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/objtool.h       | 8 ++++++++
 tools/include/linux/objtool.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 577f51436cf9..add1c6eb157e 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -109,6 +109,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD func:req
+	.pushsection .discard.func_stack_frame_non_standard, "aw"
+		.long \func - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -122,6 +128,8 @@ struct unwind_hint {
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
 .endm
+.macro STACK_FRAME_NON_STANDARD func:req
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 577f51436cf9..add1c6eb157e 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -109,6 +109,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD func:req
+	.pushsection .discard.func_stack_frame_non_standard, "aw"
+		.long \func - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -122,6 +128,8 @@ struct unwind_hint {
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
 .endm
+.macro STACK_FRAME_NON_STANDARD func:req
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
-- 
2.29.2

