Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81C2E2D99
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 08:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgLZHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 02:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgLZHaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 02:30:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20BC061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 23:29:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f14so3359714pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 23:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PzHOmqPammOF2MuNhpTyx66yMY3XUA9xo83g3YEoVpE=;
        b=iPhcLSaMPxQrkQJRsxB6n6dUFL3oxUYvgd19FWdQ0GSm/Ma6uD4D/TFfEJYW+h0TVQ
         bjGnPLLbaARz00OJPNIAOpVBs5X2COoy1c2g816Om0K8kVgqZShs7l5KGXw7JvmtdNS6
         EquNq0EhOeglRQS58PpDWM+92yR4hHkZIkVTygXDQKjgr/sBL1EbAHbP7s6bJmKPK2Jn
         hbwIrEyKDuoy9EF2KwyqXAWWG/O8ljZHeozyH6W/jD76NLSK3E6u4ojqsiDreZMHP+3w
         gXKD742XSwpaPhCHAIk+02vQZUt7LUTXzKnjNOHFqaDcvQJ1b5Wjhh8J62vxwzI/2Hoa
         xh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PzHOmqPammOF2MuNhpTyx66yMY3XUA9xo83g3YEoVpE=;
        b=h6nMC1K49HEqvj1zNUdjAZfxwW9TDZTZIGVWgoxPNecVWIa0o1rS6lG37m1ip6fUAy
         deSJOMLCq1ync/qB5Xv+UpNeunizSzJ66xz3hZXOrcL3pgtEZq9sj03nST4/LbpgFpan
         IcCVZdJmuI7BKvOAbuHrroZrN5r5X2zn86XJ0UFhq5QDqyopZR4eBX2pqEPzBAxgdach
         Xyx9OsQZnKO65bNbEMwAo8dRvUHHr4LuWchPawEn1/G+h3yP6gjkWo9IdC4Qxf2yV1CB
         v1BvTkI48KHA73em2HtCS//aeeD9scI4J01xBjQLxvITGWleQEXMtGYyYXrFRJ1O3GC4
         iPEA==
X-Gm-Message-State: AOAM530fmcP5t7B6XBSPcqNf/F3RMBo6e8rAJHOXSF9eJKqWetySp0ME
        dCgK60DvRgMfH/AldOXaehY=
X-Google-Smtp-Source: ABdhPJxaUq8YBA2k33sC2H0xcx2iLBpgRrSahHdtZq9LTUqoNfFqCDsxoCzMAJ67vWvtt7ceZo0KYQ==
X-Received: by 2002:a17:90a:e507:: with SMTP id t7mr11740247pjy.26.1608967775790;
        Fri, 25 Dec 2020 23:29:35 -0800 (PST)
Received: from macbook.local (ae142046.dynamic.ppp.asahi-net.or.jp. [14.3.142.46])
        by smtp.gmail.com with ESMTPSA id 84sm30959306pfy.9.2020.12.25.23.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 23:29:35 -0800 (PST)
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Millikin <john@john-millikin.com>
From:   John Millikin <jmillikin@gmail.com>
Subject: [PATCH] arch/x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
Message-ID: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
Date:   Sat, 26 Dec 2020 16:29:30 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with Clang, the `$(CLANG_FLAGS)' variable contains
additional flags needed to cross-compile C and Assembly sources:

* `-no-integrated-as' tells clang to assemble with GNU Assembler
  instead of its built-in LLVM assembler. This flag is set by default
  unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
  parse certain GNU extensions.

* `--target' sets the target architecture when cross-compiling. This
  flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
  to support architecture-specific assembler directives.

Signed-off-by: John Millikin <john@john-millikin.com>
---
 arch/x86/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7116da3980be..725c65532482 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -33,6 +33,11 @@ REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
+
+ifdef CONFIG_CC_IS_CLANG
+REALMODE_CFLAGS += $(CLANG_FLAGS)
+endif
+
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
-- 
2.29.2


