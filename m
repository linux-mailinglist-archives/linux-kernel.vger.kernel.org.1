Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048212AC651
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgKIUwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:52:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:52:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y11so12363504ybm.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ItIyVy5KO5WuT6gZSHv+tWX1C0qVtRdRVgajUctR89w=;
        b=OpbZWml0IoEtfaXE5dwayDjaDOyELvWYVSInQFtIn1S1FT9sFBhOITetVwnQszxMsn
         024yRrMs+UjL9ds3ZMEiyAduvj7NeYjhThcc2XnZY8D0FwYgVMfaTeryKxJlACA9xgYi
         LGpaLXvqYy1Y1HLWgxGGoCvI/8CZan/03OxLwj4yLvnnVUYThEw62yPqf2haft5qAKko
         d17+PhXCjszC728nLT3M5kwxkhaRUfKzu6N3VDxI1DB5K3+qE6Tahif3FySRoblDRaSd
         4/bPxqUPGrbsw4Y4WfUiR9m/pGW8E+1RrzTYelQdChuNk5JUJUSyyopcukvhqNb0oQyf
         guGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ItIyVy5KO5WuT6gZSHv+tWX1C0qVtRdRVgajUctR89w=;
        b=Chk5xtdRrfN3cvAXgdbiQCWUAn7JBiaFirIyAtkHtFPP3Gfk/TvLZrgMF4JmdKL+mF
         Wshz02aCqBvj/V6YxDU1G/3F72VK0lsfkYjKhBXbgz2/er75ycq6fVYlr4EyWqb6DMfe
         Va5AZe/EJxoEE5mjAe8d/hQsTnDNZlMB3BJTKIOz2YwYDgfu0gJKZdVPoWfHNomcyfdK
         wkAU8a5rK6wPxQqlaZ8XpxvdR6xQZbYTzB4TlLQZH5bQ+0BFXAzmOkra+QP+vKcPiKaO
         Gjy2mRjDAYffLAj0ZT+sRel4IitABtuonvqJp9oUOKBzrIQGTEw5fh86Pb++ZGiH87DR
         U+kw==
X-Gm-Message-State: AOAM530Q+B2r/znmrXdd7hy/w3Zn1iBKvj3MKxOhBMMqGUcHZhnbrCec
        T5gVOY3HrnrNcbUA3gIuSTYOieN5JSSXHAtyoIY=
X-Google-Smtp-Source: ABdhPJwknzqYYBgKOcdvOJ/pt9vXu7LTweCfxuf2OAuzIktrFA2MFb7PvHTPce+fPn/9JvlJ/uFKTUQmu9FDcO8UCXk=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d981:: with SMTP id
 q123mr14118805ybg.50.1604955127041; Mon, 09 Nov 2020 12:52:07 -0800 (PST)
Date:   Mon,  9 Nov 2020 12:51:54 -0800
Message-Id: <20201109205155.1207545-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] ARM: decompressor: avoid ADRL pseudo-instruction
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Ard notes in
commit 54781938ec34 ("crypto: arm/sha256-neon - avoid ADRL pseudo
instruction")
commit 0f5e8323777b ("crypto: arm/sha512-neon - avoid ADRL pseudo
instruction")

  The ADRL pseudo instruction is not an architectural construct, but a
  convenience macro that was supported by the ARM proprietary assembler
  and adopted by binutils GAS as well, but only when assembling in 32-bit
  ARM mode. Therefore, it can only be used in assembler code that is known
  to assemble in ARM mode only, but as it turns out, the Clang assembler
  does not implement ADRL at all, and so it is better to get rid of it
  entirely.

  So replace the ADRL instruction with a ADR instruction that refers to
  a nearer symbol, and apply the delta explicitly using an additional
  instruction.

We can use the same technique to generate the same offset. It looks like
the ADRL pseudo instruction assembles to two SUB instructions in this
case. Because the largest immediate operand that can be specified for
this instruction is 0x400, and the distance between the reference and
the symbol are larger than that, we need to use an intermediary symbol
(cache_off in this case) to calculate the full range.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Suggested-by: Jian Cai <jiancai@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/boot/compressed/head.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 2e04ec5b5446..b3eac6f9a709 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1440,7 +1440,9 @@ ENTRY(efi_enter_kernel)
 		mov	r4, r0			@ preserve image base
 		mov	r8, r1			@ preserve DT pointer
 
- ARM(		adrl	r0, call_cache_fn	)
+ ARM(		sub	r0, pc, #.L__efi_enter_kernel-cache_off	)
+ ARM(		sub	r0, r0, #cache_off-call_cache_fn	)
+.L__efi_enter_kernel:
  THUMB(		adr	r0, call_cache_fn	)
 		adr	r1, 0f			@ clean the region of code we
 		bl	cache_clean_flush	@ may run with the MMU off
-- 
2.29.2.222.g5d2a92d10f8-goog

