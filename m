Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F3290C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393328AbgJPUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:04:14 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43938 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393319AbgJPUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:04:10 -0400
Received: by mail-il1-f193.google.com with SMTP id k1so3987101ilc.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7ICFpG/vF+mjWn1X6zF08pqv3+nejZ5629oGhlFoZc=;
        b=rDN/4DmUI5lwcVTGLM6JivFyUVhopCnuUsHqlqVWA45jTDUcLdDdWchsspmB9RhJoL
         vRcRPPn2a9akMxwCR+eKBcT9s9zjS7xGsd53qFFHeIkWWWS8Yk+8pu+UJsRLxS8CUGKd
         dv/71P7us3zJRCd/vAcsw23keGXMJk6zPUVJK/oZsSEBXTlrmAuLFb0wOocWPWjOI0qc
         hiqW2WccElMVJwO8ZBZky3RnBfwxU9iX+MhGH1yVuElI2AyevQGV/+2cJ+/Ug/NLyMoo
         ci8VLkGJ6UH3oAS2Bgw/gbxO4huWxWNkYjsIp/YBL+8ENSfN0n3TJ3HvaBSbRpNrRlH+
         wwbQ==
X-Gm-Message-State: AOAM530jTSSkUa+Q+OqITGNgrq5m6qvlHPgPp69BK6ZJ5TsUOjM6O8jg
        uYOZUAju+To5ptz15bMxT9vcw0O0GylS9g==
X-Google-Smtp-Source: ABdhPJwmy0Mav3SlvDWHkZXaC+Kk9WrzEg3PYUDfGDueCzCPjOUSuTe7JCpD0WTEugEoCyfPvkSEKQ==
X-Received: by 2002:a92:d383:: with SMTP id o3mr4298350ilo.83.1602878649186;
        Fri, 16 Oct 2020 13:04:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r2sm2886961ile.1.2020.10.16.13.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:04:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] x86/boot/64: Show original faulting address in case of error
Date:   Fri, 16 Oct 2020 16:04:04 -0400
Message-Id: <20201016200404.1615994-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016200404.1615994-1-nivedita@alum.mit.edu>
References: <20201016173232.GI8483@zn.tnic>
 <20201016200404.1615994-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the #PF handler print the original CR2 value in case of
error, instead of after aligning to PMD_SIZE.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/ident_map_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 06ebe5e3e489..505d6299b76e 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -333,9 +333,6 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
-	address   &= PMD_MASK;
-	end        = address + PMD_SIZE;
-
 	/*
 	 * Check for unexpected error codes. Unexpected are:
 	 *	- Faults on present pages
@@ -351,5 +348,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
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

