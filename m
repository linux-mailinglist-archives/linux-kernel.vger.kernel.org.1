Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAD220177
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 02:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGOAl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 20:41:59 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42459 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgGOAlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:41:40 -0400
Received: by mail-qv1-f65.google.com with SMTP id dm12so156209qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypmaqJCaWru1//3r1Y8vm/BttJnmALbhqbmJfGQPjbM=;
        b=GT/FHlKSokTj6DewCoe+8g2EIOKkMSv0g2SdPzXtGcJQKOsUIaT46x3nulJeFCRsAs
         45PA0IiXDXjVDe5b4mtvDfNluIMqn699GgkNjBRe4aePfNIZIdmg6OQSuqSbWlrfd/iR
         JNZWs9Ms3sVDGVjE/wyRO9eB3MoAFas1IAgVuzUkV5SO9Cg/zZjQnvpXrJ12BycIAMX3
         yflN5seQqxcaMSTQ7/T5L17nPoGlTGUdVCKjcf4IS1wYxmnOCo61jWPKz3NZ788LOygl
         CWmW1Ce5zaNvWyUE7Mxqe/suBtPkeIBtWcpCYLBEULWkUrddDFyNuWM9kK36RBGFMAkH
         7cvg==
X-Gm-Message-State: AOAM5321Ejpid9/Jyf1RrF15aI2MBOhw1JZ8Y+27ir0fu0SEgEBosWRk
        F8t+J1k5VdKoIA8kP9UntO0=
X-Google-Smtp-Source: ABdhPJyg3qQqXHPYN6XUuEaS1U97O0cTeEfAaCIz4HLjdmqJS5ISyRwES+8ykZwtP906CXmkyD0i3A==
X-Received: by 2002:a0c:b284:: with SMTP id r4mr7167816qve.141.1594773699140;
        Tue, 14 Jul 2020 17:41:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm524776qko.24.2020.07.14.17.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:41:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] x86/boot: Add .text.* to setup.ld
Date:   Tue, 14 Jul 2020 20:41:30 -0400
Message-Id: <20200715004133.1430068-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714023836.2310569-1-nivedita@alum.mit.edu>
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc puts the main function into .text.startup when compiled with -Os (or
-O2). This results in arch/x86/boot/main.c having a .text.startup
section which is currently not included explicitly in the linker script
setup.ld in the same directory.

The BFD linker places this orphan section immediately after .text, so
this still works. However, LLD git, since [1], is choosing to place it
immediately after the .bstext section instead (this is the first code
section). This plays havoc with the section layout that setup.elf
requires to create the setup header, for eg on 64-bit:

    LD      arch/x86/boot/setup.elf
  ld.lld: error: section .text.startup file range overlaps with .header
  >>> .text.startup range is [0x200040, 0x2001FE]
  >>> .header range is [0x2001EF, 0x20026B]

  ld.lld: error: section .header file range overlaps with .bsdata
  >>> .header range is [0x2001EF, 0x20026B]
  >>> .bsdata range is [0x2001FF, 0x200398]

  ld.lld: error: section .bsdata file range overlaps with .entrytext
  >>> .bsdata range is [0x2001FF, 0x200398]
  >>> .entrytext range is [0x20026C, 0x2002D3]

  ld.lld: error: section .text.startup virtual address range overlaps
  with .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header virtual address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata virtual address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

  ld.lld: error: section .text.startup load address range overlaps with
  .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header load address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata load address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

Add .text.* to the .text output section to fix this, and also prevent
any future surprises if the compiler decides to create other such
sections.

[1] https://reviews.llvm.org/D75225

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/setup.ld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 24c95522f231..49546c247ae2 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -20,7 +20,7 @@ SECTIONS
 	.initdata	: { *(.initdata) }
 	__end_init = .;
 
-	.text		: { *(.text) }
+	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
 	. = ALIGN(16);
-- 
2.26.2

