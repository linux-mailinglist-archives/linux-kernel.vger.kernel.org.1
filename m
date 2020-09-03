Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333E425B8CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgICCbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 22:31:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46414 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICCbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:31:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id b3so809634qtg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 19:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=My1dWVOZNO8rUxT8hVhscsPzF5firvUgKMy4MK/wYWE=;
        b=GyqlYpPZ3pPWQaAFNCTlbQbPmiFHOmQqvYPi5a3onBQhTtS7MlRcoQppCf3RlHB2xp
         rcT8KZyFR66+SO1Nik+k6CTM0Hwuq2NHsr/AAVqpph3SLVWYvUhflFVAw0wAYbED3D4v
         sj4bIc2Z2pI1MFLmtNnXPOf+G3YQ/jVY1k/JdLoCVt4gzvmMWXKv21kTzRosW5eKm3WR
         zNc8jkOFgrS8qyE1vIzhQtR4TPcHp83aH1TJ0aXmKEILic1yyG60rBMf+C6owLW4kquE
         tyE63VjOpGlNeCkxMlApMxMlY2cENYtt48rd6yejE56GvyeozmD1JoAPup9uZWTs199M
         JQTA==
X-Gm-Message-State: AOAM530uBZ16OUGRpFLLSolJ64cFjdRlZuTLiXsNz0u6RY1o3KVwXYgd
        HJPkv1ucDLwyZeR6YnsbRM4=
X-Google-Smtp-Source: ABdhPJzSMPT/p43QSCRwZ3C4o6JmndllnLvY/yvCSM0khmYY2cpVQ8jkoXM92UMwpkybRKA2LTlSsQ==
X-Received: by 2002:ac8:3aa3:: with SMTP id x32mr1236626qte.327.1599100259054;
        Wed, 02 Sep 2020 19:30:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g18sm977664qtu.69.2020.09.02.19.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 19:30:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux@googlegroups.com
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cmdline: Disable jump tables for cmdline.c
Date:   Wed,  2 Sep 2020 22:30:56 -0400
Message-Id: <20200903023056.3914690-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RETPOLINE is disabled, Clang uses a jump table for the
switch statement in cmdline_find_option (jump tables are disabled when
CONFIG_RETPOLINE is enabled). This function is called very early in boot
from sme_enable() if CONFIG_AMD_MEM_ENCRYPT is enabled. At this time,
the kernel is still executing out of the identity mapping, but the jump
table will contain virtual addresses.

Fix this by disabling jump tables for cmdline.c when AMD_MEM_ENCRYPT is
enabled.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index d46fff11f06f..aa067859a70b 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -24,7 +24,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
 endif
 
-CFLAGS_cmdline.o := -fno-stack-protector
+CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
 endif
 
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
-- 
2.26.2

