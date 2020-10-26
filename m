Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC380299960
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392270AbgJZWMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392255AbgJZWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:12:49 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5327C20715;
        Mon, 26 Oct 2020 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603750368;
        bh=jHjuUqHbO532naDYNNftzhWQSwHF9iXilHeIxyM1iRI=;
        h=From:To:Cc:Subject:Date:From;
        b=WKgN1lMWYDfGzuT0LngOU57PkYtkWQ5ISC4GmJQZSes9mpbvg0/DZwuAi4CXTS/Ly
         GwGtlTzXc+cV7iAW+CJ6v8Idlgz1MyYImQMJwPu/AcWKUPutG9T1Y9h2tHBpHYlZQr
         obY1ypz7Uxf+sQPYrhl0QKM7uyl8/2b36xAf3i40=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kprobes: fix arch_init_kprobes() prototype
Date:   Mon, 26 Oct 2020 23:12:00 +0100
Message-Id: <20201026221241.3897396-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With extra warnings enabled, gcc complains about this function
definition:

arch/arm/probes/kprobes/core.c: In function 'arch_init_kprobes':
arch/arm/probes/kprobes/core.c:465:12: warning: old-style function definition [-Wold-style-definition]
  465 | int __init arch_init_kprobes()

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/probes/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index a9653117ca0d..e513d8a46776 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -462,7 +462,7 @@ static struct undef_hook kprobes_arm_break_hook = {
 
 #endif /* !CONFIG_THUMB2_KERNEL */
 
-int __init arch_init_kprobes()
+int __init arch_init_kprobes(void)
 {
 	arm_probes_decode_init();
 #ifdef CONFIG_THUMB2_KERNEL
-- 
2.27.0

