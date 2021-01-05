Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2553A2EB021
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbhAEQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbhAEQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:34:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95EC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 08:33:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 18so24383178pgp.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 08:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=h9nooU4y2umqpQHwzDyh6ncEi4+PL0Yb57ks4DCKnsU=;
        b=GssujOQ9Z0hclY8CppqmEJhGfGszyJErCY21B9LWvzcDK5iIJTK1V5QjXi9rr/OhD3
         EnsI0ZRueg2+dVJfNt6t+y00rDyRc/QqwIzPBVzvNtBwPtXzagft6e2fCga8i6zqqw1s
         Lr2Q4zzxVIg41pSitUhWDx0DNOpMl3rSlBQaZkaKqkJGNootxf+1yyE8ypKHrVee1ij8
         KLmIQCZd1XjViaCuz3/mRP3p9kT9s5t75tnBB0y1X/k3yjuouL9g+8tYzL8gKwapGLAM
         oj77x9PQ/RFdf4NVsBKuaxv/zB6z9DWUDWUi3xkPHZyLlsBYKPhc9uz8HQQRw6ukV75a
         VfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=h9nooU4y2umqpQHwzDyh6ncEi4+PL0Yb57ks4DCKnsU=;
        b=I4MPhOeFOE81YQwNTWh89kYUVEBa7D2cghDhFheMHdVMvQDzw4JBuRrGc18zBEXTLb
         ZfdHqJqOMhIZiyrTQVTZLq88Sbk6dnhO1Yz9Gyz5IWFkCd64l2AWxcFU/7gJGXGvXFXW
         4OOCcgO0MMZc/Lb4jTxVwdsCiw4ffXdzA6POZGm8fIqk6qFVEy0qN2R5fGjLMG1W/JFk
         ptvVchynmwGtFQsPkVycw9Os8HGAYyrm7je8qXuGjq5pyWpzsFu8eaalmHcKJuESvTZh
         tw2PLSQELNMUYVVIqH0uIMmVzmArl5Q4eVO2//ptxC6kRVnVHT3N515Frygz7wXAyquO
         8rJw==
X-Gm-Message-State: AOAM533O0sJkkArggxiWjWpeHKXMR+quprhvEgTO+8L3a3Ih994U6Ngm
        Br7q34cYHeJ8Z7krLChbd2aTj8obY30=
X-Google-Smtp-Source: ABdhPJx1mqidWB/2LzAPZKJX1xbAhEcbTHzl844I/iYke7s84yPyG4YpLnSMuevQvuG8DoSV1OBnBM+Htlk=
Sender: "pgonda via sendgmr" <pgonda@pgonda1.kir.corp.google.com>
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:f693:9fff:fef4:e3a2])
 (user=pgonda job=sendgmr) by 2002:a17:902:8bc8:b029:dc:36d4:fba8 with SMTP id
 r8-20020a1709028bc8b02900dc36d4fba8mr445842plo.82.1609864401667; Tue, 05 Jan
 2021 08:33:21 -0800 (PST)
Date:   Tue,  5 Jan 2021 08:33:11 -0800
Message-Id: <20210105163311.221490-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH V2] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc handling
From:   Peter Gonda <pgonda@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Peter Gonda <pgonda@google.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The IN and OUT immediate instructions only use an 8-bit immediate. The
current VC handler uses the entire 32-bit immediate value. These
instructions only set the first bytes.

Tested with a loop back port with "outb %0,$0xe0". Before the port seen
by KVM was 0xffffffffffffffe0 instead of 0xe0. After the correct port
was seen by KVM and the guests loop back OUT then IN were equal.


Fixes: 25189d08e5168 ("x86/sev-es: Add support for handling IOIO exceptions")
Signed-off-by: Peter Gonda <pgonda@google.com>
Acked-by: David Rientjes <rientjes@google.com>


---
 arch/x86/kernel/sev-es-shared.c | 8 ++++++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 7d04b356d44d..6c790377c55c 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -305,14 +305,14 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0xe4:
 	case 0xe5:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u64)insn->immediate.value << 16;
+		*exitinfo |= (u8)insn->immediate.value << 16;
 		break;
 
 	/* OUT immediate opcodes */
 	case 0xe6:
 	case 0xe7:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u64)insn->immediate.value << 16;
+		*exitinfo |= (u8)insn->immediate.value << 16;
 		break;
