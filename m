Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFEC2E8E91
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbhACVoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbhACVoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:44:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79570207FB;
        Sun,  3 Jan 2021 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710224;
        bh=Ge39luDM854fXY9ZGcVEffZJp6kHxicqbvRBsJ3y/Gk=;
        h=From:To:Cc:Subject:Date:From;
        b=XArNpHaly7WeCgyBAxLEM40cH4twtbhEMu8wxYbASRwdXgDE4ruvzVKPb0OUAWaeW
         7iEgKZaxyrTQJsmRWfOT+K9Q2mx3rVuScGXKkVW4sTHwuhSrOwvFAsDisiBQYL5V3n
         gXEYhst4Ln9wT/A1CsZpyOlEgZoC5qY0huX9AMmnapPO8sBMQDOHBgaJsj0s57vLOW
         CxJvf+tC7slX9j1YpOQw2KI+BzevtXY+GG9vkH79VHKO0MUdu2e+1jUFPeL5hIPr05
         doeNUMAl9QCV2g0uFeFBgK6BvOzyxONjjEr6iQMpS3qYbXgKV6Je3oeFr9plZvaouH
         yYsJboyEoBsPA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pldmfw: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:43:28 +0100
Message-Id: <20210103214339.1997223-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CRC32, pldmfw fails to link:

arm-linux-gnueabi-ld: lib/pldmfw/pldmfw.o: in function `pldmfw_flash_image':
(.text+0x1028): undefined reference to `crc32_le'

Fixes: b8265621f488 ("Add pldmfw library for PLDM firmware update")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 46806332a8cc..86dc0dcd6e0b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -691,4 +691,5 @@ config GENERIC_LIB_DEVMEM_IS_ALLOWED
 
 config PLDMFW
 	bool
+	select CRC32
 	default n
-- 
2.29.2

