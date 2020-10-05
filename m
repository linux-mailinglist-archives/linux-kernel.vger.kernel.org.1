Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DC283940
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgJEPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:12:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40601 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgJEPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:12:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id w16so12300974qkj.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWbAPyxGUb0dWcObj6X1wrdeXXLKyVuPRAnghyBdZkU=;
        b=dFQdprZTplxFoOcZyHEgEbLTuBoR8fdmqSjd+uhFkaKkW5pi3T5MAsUdKNh2EVsZx9
         mAQ6behYeykIcCeFmXwe44qwNL+7tIJcyQ9voYxlJxUQI8yyp25a+7OFqsvS6KJHi+AJ
         mIm+9usOCVl/soMW9ZRgA4ID2cZs8uUQ0Kr1MTHPfz1E72XhjuVFGflyKbzfTeL/Yujc
         abglI3eLES9rdk5dGXDRc4o/1fffM8ihrYzVsUKSMovFU3i4tih15paS+uRcA3KRD+wi
         nbEFSjyZbkQ6wd6yS/0wl+DXd1OQek1qWe7giyTlNwEyPxxAuF31hHt/x/CG7Eg3y8gH
         efHA==
X-Gm-Message-State: AOAM531vyxscr1OUrNTvAojdhvP/1KgWiwCT02iWplN3ACOhvargQLSf
        DUnY0M/pLMN5HiRgFD/wgZk=
X-Google-Smtp-Source: ABdhPJyDgy4yZxOxP1+xcxFccGqNlRLn1PlUdpJ1yjCaZQ60b1Tp7I1x1seb2tellnLbQ2M1ZhxOUA==
X-Received: by 2002:a37:5145:: with SMTP id f66mr385252qkb.299.1601910730943;
        Mon, 05 Oct 2020 08:12:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g7sm36975qtc.19.2020.10.05.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:12:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/boot: Remove unused finalize_identity_maps()
Date:   Mon,  5 Oct 2020 11:12:07 -0400
Message-Id: <20201005151208.2212886-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005151208.2212886-1-nivedita@alum.mit.edu>
References: <20201005151208.2212886-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit [in tip/master]
  8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in KASLR code")
removed all the references to finalize_identity_maps(), but neglected to
delete the actual function.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/ident_map_64.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 063a60edcf99..be97bf868638 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -156,16 +156,6 @@ void initialize_identity_maps(void)
 	write_cr3(top_level_pgt);
 }
 
-/*
- * This switches the page tables to the new level4 that has been built
- * via calls to add_identity_map() above. If booted via startup_32(),
- * this is effectively a no-op.
- */
-void finalize_identity_maps(void)
-{
-	write_cr3(top_level_pgt);
-}
-
 static pte_t *split_large_pmd(struct x86_mapping_info *info,
 			      pmd_t *pmdp, unsigned long __address)
 {
-- 
2.26.2

