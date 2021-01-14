Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82BC2F6B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbhANTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730078AbhANTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYkZwLEakyQWNsUUGSlTGkNMjxvpcQvs0BRzsoFBHrM=;
        b=dIl5uNETjP0ij2v5SOIoua75AwavEw4MsHmbnG1zsFm6jzka9tGSZQC5mscC0YMU1Zc2iL
        /kHM3JzCmi+zD6I5x8x9TbjRXdNykeTlJ6BkkzWPo4f/v0Fh1XBcZ68k/eMIPK/cQsxApZ
        1wZfT5Sq3v+MoAs4+64w+5RcZqEV3gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-p2AMX6uSNhaUR7PoLwGjpA-1; Thu, 14 Jan 2021 14:40:44 -0500
X-MC-Unique: p2AMX6uSNhaUR7PoLwGjpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1289A806661;
        Thu, 14 Jan 2021 19:40:43 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F9861001E73;
        Thu, 14 Jan 2021 19:40:37 +0000 (UTC)
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
Subject: [PATCH 06/21] x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub
Date:   Thu, 14 Jan 2021 13:40:02 -0600
Message-Id: <8c06a9137fb88d62d0af7d9d358317919ba8a001.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent an unreachable objtool warning after the sibling call detection
gets improved.  ftrace_stub() is basically a function, annotate it as
such.

Cc: Steven Rostedt <rostedt@goodmis.org>
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

