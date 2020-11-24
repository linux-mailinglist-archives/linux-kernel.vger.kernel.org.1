Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47D2C19FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgKXA3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgKXA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8FC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so20554052wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qh3EZu1XQYzX+YifokNmTsbWH7O1LP88Fdyjp5kGG4Q=;
        b=Dpf6N0JhvFSfH0LD1IWCS2w+gILYcLM6aRfCDZ5lKABzUT0pGGbZVUmeV4T8ctIKxI
         8qtzBC5fcQCeF/lTomrumXRvVTOo9OZB2sb96umQVgT3myZYzak14dVtxiZZJp29HdXA
         fDQnzVZRI0ExxE3250M92FtITIpjNWeLa2V3QnPO99rd6Qdk+MuM1X4OZfagP+BZaBQq
         chc/iTP+PIEYu0H/h8qsRusTg0dJ7TkXevvqUheanKnWsm37R0ihri24CRb5b/ycFC5b
         ZJcLRa5XA6Lf6O6xXqYHHAGqHrP1FHk1/x3kMwOy0sHrJOOl5fTXmqZe5U1+EIQuRmry
         88hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qh3EZu1XQYzX+YifokNmTsbWH7O1LP88Fdyjp5kGG4Q=;
        b=gLzidXTRnVy1yaF32EJSwAW53EsaaoYXJVIZskpMsVHHlqsmAdaxLgOxupBNOTlGdk
         T+rdGAOWV5mNiR1fTIpRAxUGtV8ltEX9BIv6A+jfY2h+WUi6SB3rQhetuy8Z/HzFBnl6
         BmTL3DkScN1mReFjW85UfFbym9/g6/8lbAaiZnzWVTeJziKeZgGjNzpJYWONVv+gXhRp
         cgiDpdbEWTp2+d3OaoggSAbCtpWUZDpsra6BJ9lTr10+2STZg22GcHPPPKahiODjeh0q
         z9KOIiUSPlpZ9qKbw/6VM61f10CYaK56Lo+V1uKKxUVBboXBnyc4I69n9awGC+RBsd+o
         YjwQ==
X-Gm-Message-State: AOAM530Bbjobm3z/SV2GRMxSo4t9k6vS3KGUyIWykNH+rveJZwrR6ALo
        rASYURcrLrv7hFfL2hvzWoEL6s1e991/9GER
X-Google-Smtp-Source: ABdhPJwZ0W9iVi98u9mvXagP4IFego2OGfk4makWo9LeiMuMS4oA1fcqupbdGSTsFg30Ou/b5uSlhQ==
X-Received: by 2002:adf:e912:: with SMTP id f18mr2185648wrm.79.1606177782040;
        Mon, 23 Nov 2020 16:29:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:41 -0800 (PST)
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
Subject: [PATCH v2 05/19] elf: Remove compat_arch_setup_additional_pages()
Date:   Tue, 24 Nov 2020 00:29:18 +0000
Message-Id: <20201124002932.1220517-6-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
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
2.29.2

