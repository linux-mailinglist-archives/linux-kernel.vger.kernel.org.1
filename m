Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2818E2FF75A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhAUVdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbhAUVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSBrdFLH1aTW1XcCXI87tsAr9GhvHUzfa+3/IIIy7xE=;
        b=PA0DuqRJ+QM4AX5u0G5zQi1yT8ExRDchXUUnJorCJStzwAl2LS2Xr6HXSNhPKz5owdv5iH
        YRniNYRk7Eyd5XKcngZKgvxF8Ptml/wcm8CwUAqA9X3FwW30MQ0Q5wyN0dOp0UiH/CItGa
        DTYLX9OZlA5bFhUkyK1xFk6B1NfJeiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-eZWr8JnFOcOgzhGLoIR4pw-1; Thu, 21 Jan 2021 16:29:56 -0500
X-MC-Unique: eZWr8JnFOcOgzhGLoIR4pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366CD802B40;
        Thu, 21 Jan 2021 21:29:55 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D30919C59;
        Thu, 21 Jan 2021 21:29:53 +0000 (UTC)
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
Subject: [PATCH v2 05/20] x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub
Date:   Thu, 21 Jan 2021 15:29:21 -0600
Message-Id: <6845e1b2fb0723a95740c6674e548ba38c5ea489.1611263461.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent an unreachable objtool warning after the sibling call detection
gets improved.  ftrace_stub() is basically a function, annotate it as
such.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/ftrace_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 0d54099c2a3a..58d125ed9d1a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -184,6 +184,7 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  * It is also used to copy the retq for trampolines.
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
+	UNWIND_HINT_FUNC
 	retq
 SYM_FUNC_END(ftrace_epilogue)
 
-- 
2.29.2

