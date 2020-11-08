Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93562AA93C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgKHFRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgKHFRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427FC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so5346713wrp.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8eUZkgk4tfOiGDueVMFQI+2nSJO5SxyiULtIGNoGNM=;
        b=LY21/GHufj224XYRedrmJGM11Tpgrjy/6mlw4a0eRxcXXWk/5Xrpr5yjHVUB6gEnvI
         z1zoAqWUIjKMDwMT0cNG4W7g+5ENWrVo80yUXVS5INEu2s84Nry1WvZRQIF3YhiJC5St
         jzpFJU0TsiX+v65Ucous11vvpVf5pTa18qhfMd97zPYncefk+UwNiBh4eAgN/04zVP95
         AK6D5JjmAKzIVugOUx4OdP8yXHetFmAoT/EBAu1gnYLlhCsIOl64DmTPDKplwY2v4Y8Y
         vzcGB5SvMeOl31VmUnzmjxa/vh7R0Kxlx/6zRv0vIdGN+HRvm7PNS9AqIIIO67JAZyG6
         nUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8eUZkgk4tfOiGDueVMFQI+2nSJO5SxyiULtIGNoGNM=;
        b=J3x81FixuexVbI+QBW+R4jSvzzs+qqtNGrTzUAx5BQVYuUiH1HvBnK0cx9nkt7ypwm
         O77alG+mo8hUjWe/pfioCSEA3n5RiPnbwH+Ll4fultTZnRMh/tpNhcEKRmPqUbEmu+/W
         KJ5dlg3V9Db8Je9CJ1g2OWcPSxmUreL9Ukd2CoNp8ttfkmW7SMj1JPfBRp1MvAMzPU0h
         dV+hLMSpY3wQoDysjR8jCkbnGHXNq94R910cWnzRA0N7Z0oULRQvO5kiNMiFT3L8YQua
         6L06L4ESRc6SBI+YaveovXTCKGo2YGt8800P/oJxYqjgDsAE9t5T0NBwGa32wMBUcKTT
         Vp7g==
X-Gm-Message-State: AOAM531Fqc7N7L8NcigVaMGySSYrmuS7yPfgeMn0ebXwMBT06DhwzBfm
        x4caQ24HMh3bbM8HEwoS68ZodogYgJYJlrxh
X-Google-Smtp-Source: ABdhPJyejhIh8qHlXmqQxgnVdY6iur48g/bwvTFq9J6zxCyWEaQi6reH1vA+da+SyQcM6oOMI2lZiA==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr11670054wrs.178.1604812659499;
        Sat, 07 Nov 2020 21:17:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH 05/19] elf: Remove compat_arch_setup_additional_pages()
Date:   Sun,  8 Nov 2020 05:17:15 +0000
Message-Id: <20201108051730.2042693-6-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users rely on detecting bitness of new-born task checking
personality, remove compat_arch_setup_additional_pages() macro,
simplifying the code.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/compat_binfmt_elf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 3606dd3a32f5..da8ee4d6e451 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -115,11 +115,6 @@
 #define START_THREAD		COMPAT_START_THREAD
 #endif
 
-#ifdef	compat_arch_setup_additional_pages
-#undef	arch_setup_additional_pages
-#define	arch_setup_additional_pages compat_arch_setup_additional_pages
-#endif
-
 #ifdef	compat_elf_read_implies_exec
 #undef	elf_read_implies_exec
 #define	elf_read_implies_exec compat_elf_read_implies_exec
-- 
2.28.0

