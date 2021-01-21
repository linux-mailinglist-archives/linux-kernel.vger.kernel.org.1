Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572382FF774
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAUViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbhAUVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWVlmQnnLAZPay8Iz+zWMT6CoT4fmpbJ6j9gtoJeVF8=;
        b=hLR9nvOucaq+9IPBQUbUM+tke1eYOEF83pd1L7S8sxKm2uiI2iNHruwzNnt7lGzYmaLK2i
        6uFvnyEr2nLH745AkXanoLoJysOtfP8D9Zo9RiCLjSFYWaJLed6x/KZ4mCaea5ODtnvXhs
        4SqSZAhTYq2UWSBgqlFWJz+CZgX0rfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-4_JPhvGCO7yypZu3gWCRZg-1; Thu, 21 Jan 2021 16:30:24 -0500
X-MC-Unique: 4_JPhvGCO7yypZu3gWCRZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F3F61842140;
        Thu, 21 Jan 2021 21:30:22 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30ED119C59;
        Thu, 21 Jan 2021 21:30:21 +0000 (UTC)
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 15/20] x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
Date:   Thu, 21 Jan 2021 15:29:31 -0600
Message-Id: <14f48e623f61dbdcd84cf27a56ed8ccae73199ef.1611263462.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With objtool vmlinux.o validation of return_to_handler(), now that
objtool has visibility inside the retpoline, jumping from EMPTY state to
a proper function state results in a stack state mismatch.

return_to_handler() is actually quite normal despite the underlying
magic.  Just annotate it as a normal function.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/ftrace_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1bf568d901b1..7c273846c687 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -334,8 +334,7 @@ SYM_FUNC_START(ftrace_graph_caller)
 	retq
 SYM_FUNC_END(ftrace_graph_caller)
 
-SYM_CODE_START(return_to_handler)
-	UNWIND_HINT_EMPTY
+SYM_FUNC_START(return_to_handler)
 	subq  $24, %rsp
 
 	/* Save the return values */
@@ -350,5 +349,5 @@ SYM_CODE_START(return_to_handler)
 	movq (%rsp), %rax
 	addq $24, %rsp
 	JMP_NOSPEC rdi
-SYM_CODE_END(return_to_handler)
+SYM_FUNC_END(return_to_handler)
 #endif
-- 
2.29.2

