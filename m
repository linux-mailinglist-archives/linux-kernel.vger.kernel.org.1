Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E521D1A0F90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 16:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgDGOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 10:47:17 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56062 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgDGOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:12 -0400
Received: by mail-pj1-f66.google.com with SMTP id fh8so850472pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9zl9wdVM8GEYtYil3Mhwjs87sA3d02fBbOSD/V/2Io=;
        b=Dr3sAdrvWqwbVgYRG3xI41G3QomvAew/Asd8fOt+Hzih8GAcGLY990zl5lzEDEUFfS
         rFz2r8PiTez4vQkSHyG6i66D37p45zDTF7mKWyqHS2KRTSW4HsCHenibJ08i0FlY9LCA
         RJATz1HEkSwg5S/VSgSpr6RXXPaavBo70UMlSGPI82JH1ercjcbnGTpTe132ZKGMZHAw
         nZksYVqpBq42d5GPn0kG3A1mMxp6m9j2bb+5m8WvKb6oXTdpyGm/tEZMU0avt92C3PwW
         WXhNzRtLZimrbB/nPTEE/DL7MZON4cRniYmXRoW32mBWz7TA80gs7IJIuu/Jwx1bBX1v
         bT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9zl9wdVM8GEYtYil3Mhwjs87sA3d02fBbOSD/V/2Io=;
        b=JeBElMuEXzfsY6Npne6uuELV2sBy6Ou/MHPbKumpHgjIw9Zh0rhF2W9y9hQ4fw5auf
         ycBnRgS6LvqFy6r3oWUy2dMWFlY8ijMvRRj3C8nmWF052T75NBV6V+s83X8g8iwrQv8c
         68dxndqBJSIk9nJV8+BfoBtuTb/5a1VuOtV0Ix0E/sKI3xOTEXTu3XOPR39V7yCsutuD
         Lfo+8HPa0RSm/NIOJ1RSSyOmzrqE1bNesYoUljjf4fLzNnvwLQOO9c0yHnjfRZ0l/y5z
         x2Wz2x1O63tHu39TSIDDAsnphLW3noK3RPCY5+cpqu9WuyzLJNT10niSIRui0SKmOynA
         Pxug==
X-Gm-Message-State: AGi0PuYQpSnx7Gc9J3lHdQ+SQ1v+ERZZk/A04InaBKkV+zVV358FO77X
        x2V++lT3I4fFFEjrcCcDKfJFSQ==
X-Google-Smtp-Source: APiQypIxfe67P6X0LmkT8qgkBuwk7TGkhTTBndI07oSrQhzlvJyC2RaWNfS88nZVZw4Jjgn0w6QRAw==
X-Received: by 2002:a17:902:aa94:: with SMTP id d20mr2788910plr.313.1586270831007;
        Tue, 07 Apr 2020 07:47:11 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:10 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 6/9] riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
Date:   Tue,  7 Apr 2020 22:46:51 +0800
Message-Id: <9a9f8ff6d9ea84628511def8bacce8f8247945d1.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
pages for debugging purposes. Implement the __kernel_map_pages
functions to fill the poison pattern.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig       |  3 +++
 arch/riscv/mm/pageattr.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a94d0f064d9c..1e1efc998baf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,9 @@ config ARCH_SELECT_MEMORY_MODEL
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 7be6cd67e2ef..728759eb530a 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -172,3 +172,16 @@ int set_direct_map_default_noflush(struct page *page)
 
 	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
 }
+
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+
+	if (enable)
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(_PAGE_PRESENT), __pgprot(0));
+	else
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+}
-- 
2.26.0

