Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89507280CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 06:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgJBEbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgJBEbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 00:31:49 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E3C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 21:31:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so254628qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 21:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67QkTaK15BUfYresy1TVjsxU85DKCqPslJxQaWBmDqo=;
        b=WOXSa3KNsSGI2PwcEc+jkyPoE+qlMfylR7slXy5E0/XErqtokmZQjJjUFnKbZFadaE
         RV6XS3/5HBprwTNOux9YdH4ALxgZE0CTz63UEnPgs9q/om8237/vuwnWOe6mwhZUKXFt
         8nOJrMP0r7lyMLyYo0UNpJQleyl5cEsb8TzUYrsD0NQ+evFEBJ69y9V9lzbwz3GrS8LQ
         UJhrQtujPuLB/BXmcMy8bzhtuhAuIT85Bbozg84zIEbWgTzcj7o0JS0Brg+lXS4iYEaA
         h4DcjyMRWpEjaTCj5Cop3/JVKRLot4FrVhQ6zyETTrAhEwFrVamcFfjEUO1zrlNqTYKz
         alug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67QkTaK15BUfYresy1TVjsxU85DKCqPslJxQaWBmDqo=;
        b=uoSHridABtpkPFmyFUgC4GrJrgTcSO+GIGTxLv/ls5yoHLuZqLyIG7UCeEeRm34bnd
         i6SrO/RLI6pRO9ZqFJnvhkR6pgJbDKUYehMW6/mcfYOwRHvcvdfnWDeUS75T6/IJQXQI
         5j6wxFrZLSgpVKwVOWB4xHPUloNa2GrBpK+rnru/LyoZ6AFfGRPvYXn+PEdJa4rVGzg2
         zz8NlWUMsKbUWZHlJ7KN1KGS7m2na98Uw/edZSWg76J5xhr22Q5RRXlk8MUbZ5JugEYv
         g9hHwjpBIPZM3IS6YOvNzktmlTDo6BRxWNC5OKRTXiAkXNnEbwGhljjiJc48CCacu4DI
         j1SA==
X-Gm-Message-State: AOAM533wpwFJyGKhfZlNFXmSkztXMSHYTNh9SPsCrHu4fnMOOpqo353L
        yUzCQP1NCCMfaA6rG2GE/sg=
X-Google-Smtp-Source: ABdhPJx0+ta5NGLoHQOXc6ltRF6CDwJVRlQ3vRWEXVfnYaOjty2ZAY2gVMDvYHEQradIBnI8u5BERA==
X-Received: by 2002:aed:3e0e:: with SMTP id l14mr651237qtf.150.1601613106518;
        Thu, 01 Oct 2020 21:31:46 -0700 (PDT)
Received: from localhost.localdomain ([68.183.97.120])
        by smtp.gmail.com with ESMTPSA id t43sm262707qtc.54.2020.10.01.21.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 21:31:45 -0700 (PDT)
From:   Mark Mossberg <mark.mossberg@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hpa@zytor.com, jannh@google.com,
        Mark Mossberg <mark.mossberg@gmail.com>
Subject: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer error message
Date:   Fri,  2 Oct 2020 04:29:16 +0000
Message-Id: <20201002042915.403558-1-mark.mossberg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing "Bad RIP value" if copy_code() fails can be misleading for
userspace pointers, since copy_code() can fail if the instruction
pointer is valid, but the code is paged out. This is because copy_code()
calls copy_from_user_nmi() for userspace pointers, which disables page
fault handling.

This is reproducible in OOM situations, where it's plausible that the
code may be reclaimed in the time between entry into the kernel and when
this message is printed. This leaves a misleading log in dmesg that
suggests instruction pointer corruption has occurred, which may alarm
users.

This patch changes the message to state the error condition more
precisely.

Thanks to Jann Horn for help with understanding OOM reclamation.

Signed-off-by: Mark Mossberg <mark.mossberg@gmail.com>
---
 arch/x86/kernel/dumpstack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 48ce44576947..ea8d51ec251b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -115,7 +115,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 
 	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
-		printk("%sCode: Bad RIP value.\n", loglvl);
+		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		       loglvl, prologue);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
 		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
-- 
2.25.1

