Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14541B1BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgDUCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgDUCPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:07 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D88C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id e139so10770048pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=chILL6A5g4aA5f1fWto46CThp2yfStYETCAmL1RMQR4=;
        b=FmbqKiChqGpkp7mVwH6RFzTsVlVqHYQQpqQ7pW0pLrRaC2Ru0yCFj82r7t/qZnbYej
         4pVpm6O1YzifzjuC6rbMYVCKAWTAJ5HErc2PHzzSO+iD6PnTi6rS7XUg9ycwQrSQQLQQ
         ND7+8s2Y1SMLvhAJamF74aon6b6OHu9mJn9EbZuDqA8BHaUr7uGNaTByHDCO9IytlKwY
         MQ9KdMjG2L8dqTRb6ANbp5hdV2IWgX2vwzab9ZK1FH/9A0JgPXvTJoi8gE9gU8Kyl7by
         jBeEkntsU3JSArQRllzZ9ebW5OTJ+2LJX8QopJZNNtGu/WfXT/dDSDj5dfzUSvVRYDBy
         X4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=chILL6A5g4aA5f1fWto46CThp2yfStYETCAmL1RMQR4=;
        b=Hg0MDZy079b2ijXoeT5LV8zk1QuKusEBdvtcaSo6FZWEac2OSPMWXcGnElQ8lPuVLw
         JP05bJG8vemzid/DPsii05NUkOyp8ZYUrIY3AjeZU4hUqR104QSAfEGP932uqIpQaCVa
         iEGvDs3bcc0T3x8cBAXsVt6qH6J0AsKm8qXoI2nyI4QVRmRAjhFP/B/GAUgPFtPy8/p2
         2HPN8IVhbk9wDJ2CWOWFkQ26KRjQiqF6CZt82eZuiBclNkJkUAMdnvWLKjhy3uTsSrgN
         6Nak+SwC3uHLfiDh/gYgcTHhoUKReYx+kuiBvjapD/wctzJffONmhlcu4D0DR6SSFdUe
         pglQ==
X-Gm-Message-State: AGi0Pua902d4c+6Hs9ENrAgjA2eB7D403pEUzVqFSQB/QEH+ogcQatbX
        aCHlWSzhtEPePs3iAAYYOcFqtNeIH4ScUBU0m8U=
X-Google-Smtp-Source: APiQypLYcihTy4679nWhWr1jx8yXtyK0gFknH1f8iXpU4amQyXsWX903EmOoZKJwRccLf9I1nihp4p5DT1MKNo054ug=
X-Received: by 2002:a17:90a:714b:: with SMTP id g11mr2691672pjs.17.1587435306926;
 Mon, 20 Apr 2020 19:15:06 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:45 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 04/12] scs: disable when function graph tracing is enabled
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The graph tracer hooks returns by modifying frame records on the
(regular) stack, but with SCS the return address is taken from the
shadow stack, and the value in the frame record has no effect. As we
don't currently have a mechanism to determine the corresponding slot
on the shadow stack (and to pass this through the ftrace
infrastructure), for now let's disable SCS when the graph tracer is
enabled.

With SCS the return address is taken from the shadow stack and the
value in the frame record has no effect. The mcount based graph tracer
hooks returns by modifying frame records on the (regular) stack, and
thus is not compatible. The patchable-function-entry graph tracer
used for DYNAMIC_FTRACE_WITH_REGS modifies the LR before it is saved
to the shadow stack, and is compatible.

Modifying the mcount based graph tracer to work with SCS would require
a mechanism to determine the corresponding slot on the shadow stack
(and to pass this through the ftrace infrastructure), and we expect
that everyone will eventually move to the patchable-function-entry
based graph tracer anyway, so for now let's disable SCS when the
mcount-based graph tracer is enabled.

SCS and patchable-function-entry are both supported from LLVM 10.x.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8450d56e6af6..b52929f38cf7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -543,6 +543,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
 	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
 	  shadow stack to protect function return addresses from being
-- 
2.26.1.301.g55bc3eb7cb9-goog

