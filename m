Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83532991C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784766AbgJZQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784723AbgJZQEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:04:30 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187C522400;
        Mon, 26 Oct 2020 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728269;
        bh=uDS6EQ6XDAVPqHq9l70I5qJ+Qtzdx02DvVj8gxWSjlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lK0ui8/k74N6LlTKJKTH9VBlF/ADoG3nreEBmHnKzRashCQLKzA4naQxKPCMvD6wn
         5KE7IDI4AKeOEdfOG17exXhyIw4w82pWOHNVttYbg406XSBLGeYAcToCx1/Vzbs9jb
         pF8mfypTas5uYKYjVL6aSeEPWin7X9Ae3UVChRTU=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: traps: fix -Woverride-init warnings
Date:   Mon, 26 Oct 2020 17:03:31 +0100
Message-Id: <20201026160342.3705327-4-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026160342.3705327-1-arnd@kernel.org>
References: <20201026160342.3705327-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are many warnings in this file when we re-enable the
Woverride-init flag:

arch/arm64/kernel/traps.c:704:26: warning: initialized field overwritten [-Woverride-init]
  704 |  [ESR_ELx_EC_UNKNOWN]  = "Unknown/Uncategorized",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/traps.c:704:26: note: (near initialization for 'esr_class_str[0]')
arch/arm64/kernel/traps.c:705:22: warning: initialized field overwritten [-Woverride-init]
  705 |  [ESR_ELx_EC_WFx]  = "WFI/WFE",
      |                      ^~~~~~~~~

This is harmless since they are only informational strings,
but it's easy to change the code to ignore missing initialization
and instead warn about possible duplicate initializers.

Fixes: 60a1f02c9e91 ("arm64: decode ESR_ELx.EC when reporting exceptions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8af4e0e85736..d21cb25f9e1f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -700,7 +700,6 @@ void do_sysinstr(unsigned int esr, struct pt_regs *regs)
 NOKPROBE_SYMBOL(do_sysinstr);
 
 static const char *esr_class_str[] = {
-	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
 	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
 	[ESR_ELx_EC_WFx]		= "WFI/WFE",
 	[ESR_ELx_EC_CP15_32]		= "CP15 MCR/MRC",
@@ -746,7 +745,7 @@ static const char *esr_class_str[] = {
 
 const char *esr_get_class_string(u32 esr)
 {
-	return esr_class_str[ESR_ELx_EC(esr)];
+	return esr_class_str[ESR_ELx_EC(esr)] ?: "UNRECOGNIZED EC";
 }
 
 /*
-- 
2.27.0

