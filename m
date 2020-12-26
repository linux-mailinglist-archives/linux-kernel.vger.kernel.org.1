Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46A2E2DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgLZImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 03:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgLZImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 03:42:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DACEC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 00:41:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hk16so3773253pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 00:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wbBgrh9YXj1oYs+3ziSMhnsZvXPX6Ut40pbshlURT4s=;
        b=biHmQLNElgj2ahMLmOI8z1TvQpgTG39Rh4qemhUiPBIGWio0PwPaUTw/RpbN18Vrx/
         wl5LEdEsK1UD5oBSK0MorWcPwPeJdPgb35fw/4ThpSyADlj9X9wjklUCAVIY6pm/jR6u
         WmhDOJfumsSJq5P6DaiRfWA0GeKZK+o69tdoLrwfraqs3HHRZ3bvGo5hypQoADrmvqLz
         h1VrD+efemcjoeEBmrf/3baR/2NvRa3/FeSy+DQ50/aS+J91WnDWYBaeeIfWLMRxv+k3
         NpzRTh9H8Wo0TmBcUm6JUAGU3WOCXqpVw08VMlXj/z3fOLs8YNOmopWtmoJiLWP/Y1Qx
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wbBgrh9YXj1oYs+3ziSMhnsZvXPX6Ut40pbshlURT4s=;
        b=F1ki3+LjxeDPDasZGqhyJlHQ0YMsxuDlAO40Xc1t4EY+owsYgHGOAAVo2A/mDWOBM4
         +rBScKtz3UF7r/4+dER4nSuhb0xG5UevghE2axYvlxSb1N8cBbOMJn748NMoIZNF+fOh
         8FCxTcmGlgNpMmA6NL1HtB4JiDBDwTULOOvl+3I4ksZSXwXP0/KbrD4Wds0ng3E5cT0H
         vOlrMPgXbjYRlc6z/ps2Ddo2nMfy+uiVSQXLlkH5akT5egKFBuBOyUUf3BEL9jP795Nz
         zTPy+FqcJF7qm8cdk0YcdzrgO6qwyTAbPOwtSY6KZB4g9Do0OFZ4jy+Gbp3lg9gddftI
         O4Xw==
X-Gm-Message-State: AOAM532NtPG9KEWEaOA5FYmVQm/V6AhA6r9P11xWl8MZ3t+5BPf+oXwt
        VNYexF7sPg/pfeQrpvPWgnA=
X-Google-Smtp-Source: ABdhPJxxkpjkCppLUURS1fHe+xzBEmV+A51b1CbAFL13GuCh0ZJEZd4mVHSowzUHgo/VHnBhn7bzbQ==
X-Received: by 2002:a17:90a:dc18:: with SMTP id i24mr12057078pjv.118.1608972090883;
        Sat, 26 Dec 2020 00:41:30 -0800 (PST)
Received: from macbook.local (ae142046.dynamic.ppp.asahi-net.or.jp. [14.3.142.46])
        by smtp.gmail.com with ESMTPSA id z20sm7058263pjq.16.2020.12.26.00.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 00:41:30 -0800 (PST)
Subject: [PATCH v2] arch/x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
To:     Nathan Chancellor <natechancellor@gmail.com>, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        John Millikin <john@john-millikin.com>
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
 <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
 <20201226075347.GA1977841@ubuntu-m3-large-x86>
From:   John Millikin <jmillikin@gmail.com>
Message-ID: <3b793c42-8983-4502-1f9e-729cc0ebec47@gmail.com>
Date:   Sat, 26 Dec 2020 17:41:25 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201226075347.GA1977841@ubuntu-m3-large-x86>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
contains additional flags needed to build C and assembly sources
for the target platform. Normally this variable is automatically
included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.

The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
plain assignment and therefore drops the Clang flags. This causes
Clang to not recognize x86-specific assembler directives:

  arch/x86/realmode/rm/header.S:36:1: error: unknown directive
  .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
  ^

Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
which is inherited by real-mode make rules, fixes cross-compilation
with Clang for x86 targets.

Relevant flags:

* `--target' sets the target architecture when cross-compiling. This
  flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
  to support architecture-specific assembler directives.

* `-no-integrated-as' tells clang to assemble with GNU Assembler
  instead of its built-in LLVM assembler. This flag is set by default
  unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
  parse certain GNU extensions.

Signed-off-by: John Millikin <john@john-millikin.com>
---
Changes in v2:
  - Reworded the commit message to highlight that this is for
    cross-compilation.
  - Removed the `ifdef CONFIG_CC_IS_CLANG' guard.

 arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7116da3980be..412b849063ec 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
+REALMODE_CFLAGS += $(CLANG_FLAGS)
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
-- 
2.29.2


