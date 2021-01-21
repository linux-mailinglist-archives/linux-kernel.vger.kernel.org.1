Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886CD2FF767
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbhAUVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbhAUVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbPyBNaZWOcYzEOJ+JRoeVR6FopIWpC5tf/Fdam/5D8=;
        b=cdlzdee709UEMfezzKZO4DinS7WaRlrFzYI6W7JOJWlfz+zYv1ji+aE+Y7puXDeprkoK4w
        iRdEeFwqwaxj6K001PgsrYc41kPAe3EjhAu2aW9R9Ut4q4HpgXZY4F4A4QUgkRUnRj6S9f
        B903wNlUX0tVU3rpTgaoHGfjrQkGzYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-21-m7bb-O2uDVgNvdaeSyA-1; Thu, 21 Jan 2021 16:30:17 -0500
X-MC-Unique: 21-m7bb-O2uDVgNvdaeSyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A562C1005513;
        Thu, 21 Jan 2021 21:30:15 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80C9D19C59;
        Thu, 21 Jan 2021 21:30:13 +0000 (UTC)
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
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v2 13/20] x86/xen: Support objtool vmlinux.o validation in xen-head.S
Date:   Thu, 21 Jan 2021 15:29:29 -0600
Message-Id: <0883bde1d7a1fb3b6a4c952bc0200e873752f609.1611263462.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen hypercall page is filled with zeros, causing objtool to fall
through all the empty hypercall functions until it reaches a real
function, resulting in a stack state mismatch.

The build-time contents of the hypercall page don't matter because the
page gets rewritten by the hypervisor.  Make it more palatable to
objtool by making each hypervisor function a true empty function, with
nops and a return.

Cc: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

