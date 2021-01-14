Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6572F6B68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbhANTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730144AbhANTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MO5+aHEvQnO0J+ro3Uo1USrRPuwjQ/gVxzqgfgSfuj8=;
        b=fzMloXmMADd5NoJZnqIh4kfY6gCxiG3+8JXNuwd7iy8ZmUppmT1gZaFugumWjZg3lSfASU
        Vj5z8o4d9MhH02ZVZi7RO8cxl0wFPv6YdBLWOlVii1r1rdJHb/Iwrl9pBu+o4/aspQw3yM
        KPRBSBTsIhddhBT1f8dB+Cb0U6AJ8ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-PAtxtlmzPpSngjCyIYLpcw-1; Thu, 14 Jan 2021 14:41:31 -0500
X-MC-Unique: PAtxtlmzPpSngjCyIYLpcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2711B10766BE;
        Thu, 14 Jan 2021 19:41:29 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1A95100AE40;
        Thu, 14 Jan 2021 19:41:24 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 15/21] x86/xen/pvh: Convert indirect jump to retpoline
Date:   Thu, 14 Jan 2021 13:40:11 -0600
Message-Id: <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's kernel policy to not have (unannotated) indirect jumps because of
Spectre v2.  This one's probably harmless, but better safe than sorry.
Convert it to a retpoline.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/platform/pvh/head.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 43b4d864817e..d87cebd08d32 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -16,6 +16,7 @@
 #include <asm/boot.h>
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
+#include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
 	__HEAD
@@ -105,7 +106,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
 	mov $_pa(startup_64), %rax
-	jmp *%rax
+	JMP_NOSPEC rax
 
 #else /* CONFIG_X86_64 */
 
-- 
2.29.2

