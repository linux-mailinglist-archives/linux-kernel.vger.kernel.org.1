Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437402315E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 00:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgG1W6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 18:58:35 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41566 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbgG1W50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:26 -0400
Received: by mail-qv1-f65.google.com with SMTP id x6so4149810qvr.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2N/EFsv8ebmKwtE6yt28wdXhzSyxHvM6js1gle2k/jU=;
        b=i5WzmtjH67YP4peV4XLgtb+ynNpAfdEELOcRPKb+RQe8emRSpo+aJYXgWg7kj4D1iU
         S4Dw7F7AO89BjUMXCfhTOtLo0MJKXnEBSq9+rEMAPQ1jEaX/9t/MRMoS/6U+FkhGy0Jt
         vR82AmEY2vUV7BNxYkGTxMFewcMM7yZVVjuKN1QomZKFI7Ft+kIG4trWY4QGSgWUt13h
         OxCDYGNFx1Pf+/5X2744ReSlKq2dQdY6cdZblUHinfr7sF9jK99Xja38Gahd3feTOfhS
         C6yEg8iU2SYGaByYoTtFsIGmZqDA+xCPrDbHuoPaAnzTu1/hi9f0Q5frCNkT7bdJ7h5H
         WG9Q==
X-Gm-Message-State: AOAM531UEhzHTBW9LcLG7V5En2P9Kcxp4tpsRvw7eS2dy/VuQbttYLZg
        PblCpZzEJUSLggLYqX56ZZ8=
X-Google-Smtp-Source: ABdhPJx9/niFs0DLCpUK/WtHkp66WWUTcgLwez9cF8fbTu6ynPdJcgSnR4idzhldj1gsRg4/unQTtA==
X-Received: by 2002:ad4:452c:: with SMTP id l12mr29492667qvu.198.1595977045298;
        Tue, 28 Jul 2020 15:57:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/21] x86/kaslr: Remove bogus warning and unnecessary goto
Date:   Tue, 28 Jul 2020 18:57:03 -0400
Message-Id: <20200728225722.67457-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the warning on seeing "--" in handle_mem_options. This will trigger
whenever one of the memory options is present in the command line
together with "--", but there's no problem if that is the case.

Replace goto with break.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e0f69f3625ae..c31f3a5ab9e4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -295,10 +295,8 @@ static void handle_mem_options(void)
 	while (*args) {
 		args = next_arg(args, &param, &val);
 		/* Stop at -- */
-		if (!val && strcmp(param, "--") == 0) {
-			warn("Only '--' specified in cmdline");
-			goto out;
-		}
+		if (!val && strcmp(param, "--") == 0)
+			break;
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(PARSE_MEMMAP, val);
@@ -311,7 +309,7 @@ static void handle_mem_options(void)
 				continue;
 			mem_size = memparse(p, &p);
 			if (mem_size == 0)
-				goto out;
+				break;
 
 			mem_limit = mem_size;
 		} else if (!strcmp(param, "efi_fake_mem")) {
@@ -319,7 +317,6 @@ static void handle_mem_options(void)
 		}
 	}
 
-out:
 	free(tmp_cmdline);
 	return;
 }
-- 
2.26.2

