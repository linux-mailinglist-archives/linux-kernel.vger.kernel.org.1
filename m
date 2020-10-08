Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2050E287C4A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgJHTQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37660 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgJHTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id s47so6070550qth.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDhp551uHTD1519amMkGglxR3RM4R3VbLmm+cJeHR7g=;
        b=SLcXQR/qPj6jcKDaScRkuFsMzCl6kARRPmdFtPMZ9bmwgw3/ZISMayvC9QCz1nYu3z
         /srBodHVmMumerI6o0P4ybAws2pSXWce+GbhACbpCaG6JBfB6mHUsSysdbsw4K2FLCM8
         a/ByyUwf9Deal6Bh/sDnCbhCvyfMDSvZa98qeKSKRz3750Ks20xp8skmJ6VueUzPzvhm
         uYMKJcZloIyTVZmUxxKDY/ZD2xitwZ3HUOeYhsUdk7fTxkgxeQpsfD1GGLbHZqAZrKNw
         zlI0I2z76wZg2OlQ73AFbqksB5hc8GVoXivLWbUDu2W5HLT6Mm7mpQXQoFQBu5iQTCzm
         YyHQ==
X-Gm-Message-State: AOAM531BdR4nwBZNl0BL5fFOHFkBmsDcWlIMv9ZV7TSRt/8HLPv9yked
        gyJhFLeognYbWjqZyPjoKPTiWti4NiEDVA==
X-Google-Smtp-Source: ABdhPJxint8tuUQ0oSxBuoUbjUVQUUPGafG/9nD3Wp+slemYgq7dIqdgWoHdtwcRNVUsA8wVpI22aw==
X-Received: by 2002:ac8:22a1:: with SMTP id f30mr10253397qta.33.1602184588151;
        Thu, 08 Oct 2020 12:16:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z37sm4726759qtz.67.2020.10.08.12.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:16:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] x86/boot/64: Show original faulting address in case of error
Date:   Thu,  8 Oct 2020 15:16:21 -0400
Message-Id: <20201008191623.2881677-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008191623.2881677-1-nivedita@alum.mit.edu>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the #PF handler print the original CR2 value in case of
error, instead of after aligning to PMD_SIZE.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/ident_map_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 063a60edcf99..fd957b2625e9 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -327,9 +327,6 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
-	address   &= PMD_MASK;
-	end        = address + PMD_SIZE;
-
 	/*
 	 * Check for unexpected error codes. Unexpected are:
 	 *	- Faults on present pages
@@ -345,5 +342,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 * Error code is sane - now identity map the 2M region around
 	 * the faulting address.
 	 */
+	address   &= PMD_MASK;
+	end        = address + PMD_SIZE;
+
 	add_identity_map(address, end);
 }
-- 
2.26.2

