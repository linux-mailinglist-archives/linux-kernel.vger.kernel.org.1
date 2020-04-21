Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB861B1BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgDUCPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbgDUCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B88BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w15so13939632ybp.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0RQ1N542RT3QYdW6h+S0B1gn+F6MhyfTNdXGmDt/FSM=;
        b=rprfLeuLS2/09QHh/+y7xWTflZnqrv4ouAc/OGi0JspjqJm6eS46yKUFVvDRBA7xrD
         IsViCxyeg1EAE5/s87qdzXUUiSf8TnxPVsuAIEAzrr3sqXBZqrbtjCRgovWji//XWbZQ
         xcpiVJbVBTm7m/L4++NSnlJY0nFfQmhsqhI7X6papIZyD9mnE6qKALG0X6wbzmG68IwR
         NV/C9sJ2akeM/VxVHXv1UPXM8tN6ST0/kppmOPac277uAdAe7X5IMbeLQ3XxJTYzxblF
         bzhvQzjWFL0p41IeJx5ZGURPl6ZqYdcPqRjHl+2oWSLxp524C0oH+hXSgGEVR7rzQoiC
         gbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0RQ1N542RT3QYdW6h+S0B1gn+F6MhyfTNdXGmDt/FSM=;
        b=RNGbDXsGj8LFnhdQr6cP2XIznGcyUX1QX759q59emHifHDbAZHlT4T81NRzyjojt01
         idlb724ZN3NIZsB4yxDu/38IiJiw5GEopr0JGQ/5a/bAD1vCsITw6lo4TTOpupQ5gxXi
         lqL4H0S0qNeISl418qMgLZ8IibRnoA4cJuNmY8uECBfjRRt1jQZ57DKZ1nAPM9/0lkPl
         Y6X6mQjQAv8TKhRlT/hlMIXOgVOzl/5UvdTZevuF5kvowkJ+Cu6hcxOLLzGsPRUUD4YF
         OWjo/jobJP2Ckbqd0nQwTKGV7POR8URe+w3Qz0KL1ErBPK5VOZrOxmwYQ4WvhyYwf5f8
         jmxA==
X-Gm-Message-State: AGi0Pua/F1ELyH1lxqvP5ncW6p4OfpPsJkCDY8V0amaufS12+RpjePOG
        aJxi7WONmaLsjqvtd2ygDZegQIztEB8/xl0TORs=
X-Google-Smtp-Source: APiQypKVaa6EVfAXEUsgkxuszfVQpEqhSdTwtpRewqbIvj3iqtNn3hSJPBlIieXNvYTQbT7aDUwDMoQW4Qa/HRJl/w4=
X-Received: by 2002:a5b:112:: with SMTP id 18mr24192885ybx.103.1587435326655;
 Mon, 20 Apr 2020 19:15:26 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:53 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 12/12] efi/libstub: disable SCS
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
2.26.1.301.g55bc3eb7cb9-goog

