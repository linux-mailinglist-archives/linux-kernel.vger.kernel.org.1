Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8C2D8F47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 19:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgLMSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 13:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgLMSgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:36:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B17C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 10:36:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so14243533wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tRMxD6v/l4OYj8cB5TYdPB+UxT0+Cs8k23OwIsOoa6w=;
        b=qaaBc6mL2Q1PG70ICvG9frD4YhqrsocLR/cM/kFR3jGKnrG+fif/zDFAmQi9hFcQlC
         Fytf+ZR/DEiH3A1Fj9bz1jElvbtYdQXhnDssenZ+ra82JclYBGMEUdD/zCCDG55uTmvo
         BgWtGXBs26X+tVaBS9MMwa9km2VNmHBhsIIU8azZPxIvArNNJptjjHghci2r91QhDERY
         efM59ssYeoxIVCTZ9GTgwjpqUkclGCFifQsmI6tK7gLZttB8eU8UwK/qomJLDt3jUpiv
         dIQJKrjfE/t9UnLwT8lAKn0vm08nuQve5+tmICg5MZv7uFKwqgEL4NW5/KAJWVNyLBdh
         99qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tRMxD6v/l4OYj8cB5TYdPB+UxT0+Cs8k23OwIsOoa6w=;
        b=Sh3Y4Sr9p9wU2KbgcfRjNYWej996YwvoheYKIIZEL/Ljr/LMnYp0dRVsCRZ0QqKZtQ
         k7qB9P6PeTwO80beaLIGEdv619bAPAONwCtBENwdCe6bm11YKUHySzQM/sIUrRgkqEW6
         aLmRB4GKvhSnNel8bOd8r7a79oFHXRwmONLIeRjRUyUz4rOT/KpJqq4V3NYlR1snpQZY
         hUtETPDo3OH1LIXhTRJ0n2q6WCtsFdb0KT21thuYhNxbfC74hWMq+VKFL3tnvXOsRIpJ
         7+U71YsJQe40ocCZzglvbWtkIb56dKsyNwSI+m+hrQlk7brE4j2Yrp7ppSkizTrZdcCX
         3eWg==
X-Gm-Message-State: AOAM533NdpOZfUBp5Qi3pqYH+6t0CfzzMRsyiTDtv8PEDQOgo8+GUpaT
        Fs2K0i9VcfLaX4hz4RlVTmJbvSg6UVwdaeSJ
X-Google-Smtp-Source: ABdhPJyCOGMk3hxPAqiAu4T7D/5s0amN+QVqbFuXJL6qvZltKjCzWpjAxNbfC0BKZvhdXjlJ78TPDg==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr25371535wre.101.1607884569599;
        Sun, 13 Dec 2020 10:36:09 -0800 (PST)
Received: from localhost.localdomain (bzq-109-64-2-78.red.bezeqint.net. [109.64.2.78])
        by smtp.gmail.com with ESMTPSA id x7sm19125928wmi.11.2020.12.13.10.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 10:36:09 -0800 (PST)
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
X-Google-Original-From: Ariel Marcovitch <ariel.marcovitch@gmail.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ariel Marcovitch <ariel.marcovitch@gmail.com>
Subject: [PATCH] powerpc: fix alignment bug whithin the init sections
Date:   Sun, 13 Dec 2020 20:35:56 +0200
Message-Id: <20201213183556.16976-1-ariel.marcovitch@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bug that can cause early crashes in configurations with a
.exit.text section smaller than a page and a .init.text section that
ends in the beginning of a physical page (this is kinda random, which
might explain why this wasn't really encountered before).

The init sections are ordered like this:
	.init.text
	.exit.text
	.init.data

Currently, these sections aren't page aligned.

Because the init code is mapped read-only at runtime and because the
.init.text section can potentially reside on the same physical page as
.init.data, the beginning of .init.data might be mapped read-only along
with .init.text.

Then when the kernel tries to modify a variable in .init.data (like
kthreadd_done, used in kernel_init()) the kernel panics.

To avoid this, I made these sections page aligned.

Fixes: 060ef9d89d18 ("powerpc32: PAGE_EXEC required for inittext")
Signed-off-by: Ariel Marcovitch <ariel.marcovitch@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 326e113d2e45..e3a7c90c03f4 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -179,6 +179,11 @@ SECTIONS
 #endif
 	} :text
 
+	/* .init.text is made RO and .exit.text is not, so we must
+	 * ensure these sections reside in separate physical pages.
+	 */
+	. = ALIGN(PAGE_SIZE);
+
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
 	 */
@@ -186,6 +191,8 @@ SECTIONS
 		EXIT_TEXT
 	}
 
+	. = ALIGN(PAGE_SIZE);
+
 	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 		INIT_DATA
 	}

base-commit: 1398820fee515873379809a6415930ad0764b2f6
-- 
2.17.1

