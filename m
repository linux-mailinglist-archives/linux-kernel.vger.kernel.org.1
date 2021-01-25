Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1F302806
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbhAYQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbhAYQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:35:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4712C061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:34:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id kx7so8739434pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlAqhwi52CDU/L4m2USiDoxymFbBrES3zkm124j7yww=;
        b=azJBVZof+Bo0JQhKnLMSTNVQnisOfk9ZBPdqLgoZ/t0ky/rNjs1+iNHZEzTCeJ8ARK
         FiCb1SHm000KhY2e3bz17K+2zSR8gCU36hTBVg7krPh7/3LAHVCUE5p1G2Tt9/lS3hek
         IsvPH6PTsG4OUBk07DchP9n2dxpSgrBxV6xRQmqZvtsL3IJRj8dCNrrEOjPmQrdNS1TE
         wQ7+mmVZhJxQ2yaQyKDmIiQP8RFVkuVzVDVJ3bZ07WUeMA0Uzha04KqxSH0rENVGrz6Z
         ylBBDoUBiqMpIEPmJuYOHBDSiRkoxNJYTbUQ8FLbYYWs8D8LQCok2s9r/9wN4C6nDId8
         ZuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlAqhwi52CDU/L4m2USiDoxymFbBrES3zkm124j7yww=;
        b=P9+EUqozKbInMnyUlesO5nAhYStG7Su1lzbMO5SyPbcz49y4pGlG0R2XmJsWUCpekW
         0nLRQ9snuPJYtEoNLOw70xXk+1+wwhjtZ5Ijtfshe2PqJs1bUPPFqp+oCgSgxV3GVfG7
         SeTei/336JtslGJOZLv0DHV4t/ppYyZ7XP7UazHYiWFxqs1abjmj06KaQXGLlkgQsbH8
         U42XP2Z0ff1VyY/SVFAH25NaiRi0n3E/GVZ3m/bxjMr61QkIy9VMEohDj42phpbVRUud
         S8yCOhiUBzlYQgXB5aQSZgnKy+1DT6YJ/4hGu7wp/tMvxHGS+acSBB+HbIRwtp0LDWNp
         zcYA==
X-Gm-Message-State: AOAM530xIM44KSc5mfJElXldNEaa8yLoEe5MTLHsp+j9vw2KDhKzupy/
        Z4xm2KSzSrjYeqqpmKBWgasTfIc+ZBJjzg==
X-Google-Smtp-Source: ABdhPJxQXahYLKFH6H7xDfwGTcp/CLUoifyx6hYuQoRRBbr3LpdgiU3YgS9Bsbtsivi1lpk6I8ZqLA==
X-Received: by 2002:a17:90b:e86:: with SMTP id fv6mr1042956pjb.118.1611592489206;
        Mon, 25 Jan 2021 08:34:49 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id x21sm17278070pgi.75.2021.01.25.08.34.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:34:48 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V2 2/6] x86_32: use percpu instead of offset-calculation to get thread.sp0 when SWITCH_TO_KERNEL_STACK
Date:   Tue, 26 Jan 2021 01:34:30 +0800
Message-Id: <20210125173444.22696-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210125173444.22696-1-jiangshanlai@gmail.com>
References: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
 <20210125173444.22696-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS_entry2task_stack is used to refer to tss.sp1 which is stored the value
of thread.sp0.

At the code where TSS_entry2task_stack is used in SWITCH_TO_KERNEL_STACK,
the CR3 is already kernel CR3 and kernel segments is loaded.

So we can directly use the percpu to get tss.sp1(thread.sp0) instead of
the complex offset-calculation.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017e6161..3b4d1a63d1f0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -465,16 +465,11 @@
 	cmpl	$SIZEOF_entry_stack, %ecx
 	jae	.Lend_\@
 
-	/* Load stack pointer into %esi and %edi */
+	/* Load stack pointer into %esi */
 	movl	%esp, %esi
-	movl	%esi, %edi
-
-	/* Move %edi to the top of the entry stack */
-	andl	$(MASK_entry_stack), %edi
-	addl	$(SIZEOF_entry_stack), %edi
 
 	/* Load top of task-stack into %edi */
-	movl	TSS_entry2task_stack(%edi), %edi
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %edi
 
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
-- 
2.19.1.6.gb485710b

