Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B61BA998
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgD0QBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:01:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57161C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:01:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so20921816ybj.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aF2klQa9rRamHf/M4CeCxFGtvwc1mZVJXnokoniINw4=;
        b=ijnQ0fnOBOZz8ohYGbprOcWD6bXoahdyQ/EdPHNcahHH1UNi6yI4DR5R2vlPmVt+MA
         4ppIwntZ2J5xzVAeqXwe8sImyb647bo4hHg8kf1yP8EUjew4IgKXlLT+cyN+LZsy9Bq6
         UC/DmCNG2YyUikRIYaXEhti+n0bf2Uk+eSvlUyy0VkRfNHrV9zVYezDs+dHfFwKCE9hw
         sMB0tZWkO4naa4enGnEraDahmtXjGEJ9z7j4fYeSXhaXwN3tRENHyK+EQjCXHOgGEjXH
         LRUwN4NXMSq2HIBjq6AGd84jx2T6eVKALaDwXc+kFG7UvOg+1/Elzk8FlgUN6WR5CVNf
         +rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aF2klQa9rRamHf/M4CeCxFGtvwc1mZVJXnokoniINw4=;
        b=VpacfUFeq3bBRvM8GlWIs2MlS8iQPZLGn7S+EFK5W8N0vhe8JOFrj+Q2vynS4KAhCv
         G/oUtXyShveniB6q7inSgeGpzzSUpRuKzrRwFxQV8dblMDnxzBztjkzV/foaoUWLvEr0
         whggPrDUFZ5VZR+RSVSD1X/hUkvOLdZE+cPDjYmpNg73tYhAR9C08gxG7/hUCkgYxpgG
         VtZ973DYaILkwV6lwegqLrDSWYxSFBJZXiu+bgt1amRZFSUMC1OcbXx9cqBb58LT3reE
         LJQCEQDq0hh9D/6IAKkkZx9+/lKJceKzYunkm9GeDlJIL30fwU8RKv7l5CrBbsqKugRI
         7euQ==
X-Gm-Message-State: AGi0PuYsJ+DAUHZCyVikwStCTpZAdfaOngC47c4O6/WriwfDAw999PhM
        WlUkJfswyWGPoW9ivAYxCZWBBxF/0Y70wNVHy/M=
X-Google-Smtp-Source: APiQypKOsjWQ+jO+l4BxG62MWOPRhB/PQQHwz7wCFC1Vfqvf4Ou89RrbjPCh/lsRauohpj0Cl1hSrISC+Brb9ZNFufc=
X-Received: by 2002:a25:23d4:: with SMTP id j203mr35345989ybj.97.1588003260531;
 Mon, 27 Apr 2020 09:01:00 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:18 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 12/12] efi/libstub: disable SCS
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
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow stacks are not available in the EFI stub, filter out SCS flags.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 094eabdecfe6..b52ae8c29560 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -32,6 +32,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   $(call cc-option,-fno-stack-protector) \
 				   -D__DISABLE_EXPORTS
 
+# remove SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.26.2.303.gf8c07b1a785-goog

