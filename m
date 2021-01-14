Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02322F6B67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbhANTm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730147AbhANTmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axUKwbuJbpMTW0cDijBLuv8oTee090AGD4KYen63vTg=;
        b=Y71uz65B8pOAmE0JkOMe9PmPNG1CxrzL9B4AFQgcykjv7Rzb08Ube3288pLEEozbEw8+PZ
        Xc+LiG9KX0fLLNT1tV0igEzaUnKATtD6SNEzBC63VOokW2+6eG+PDNhn1GIIQ9/2rAy4zj
        Ne6yvQgLArqizsEgGxRaDrskgejJbG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-as2hiQYDMVqgBK03XNXB-Q-1; Thu, 14 Jan 2021 14:41:26 -0500
X-MC-Unique: as2hiQYDMVqgBK03XNXB-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750FD190B2A0;
        Thu, 14 Jan 2021 19:41:24 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C26AD10023B3;
        Thu, 14 Jan 2021 19:41:21 +0000 (UTC)
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
Subject: [PATCH 14/21] x86/xen: Support objtool vmlinux.o validation in xen-head.S
Date:   Thu, 14 Jan 2021 13:40:10 -0600
Message-Id: <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen hypercall page is filled with zeros, causing objtool to fall
through all the empty hypercall functions until it reaches a real
function, resulting in a stack state mismatch.

The build-time contents of the hypercall page don't matter, since it
gets mapped to the hypervisor.  Make it more palatable to objtool by
making each hypervisor function a true empty function, with nops and a
return.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/xen/xen-head.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 2d7c8f34f56c..cb6538ae2fe0 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -68,8 +68,9 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 	.balign PAGE_SIZE
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_EMPTY
-		.skip 32
+		UNWIND_HINT_FUNC
+		.skip 31, 0x90
+		ret
 	.endr
 
 #define HYPERCALL(n) \
-- 
2.29.2

