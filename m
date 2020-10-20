Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26F62852C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgJFT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJFT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:59:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D296CC061755;
        Tue,  6 Oct 2020 12:59:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so9687484pfk.2;
        Tue, 06 Oct 2020 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYjJmEzfZrC6Hihw3ID6mMFuzIxUBipJdm+pO3rrqoY=;
        b=i3iGk2ZX1himIdLPkto0elmDN6PMTmLq7WiGsSUdW9WdrFLn4YFHlgRfL0VMoacqlS
         DXpk+AoHyNNKWiFTaHqixzdd69Mu3zAMGnH2msxkUpXOJkBcTiL0A0MAhTu0yfl89UBE
         YxcJ92Adjx5ckMyqQ2wTXe5dJgkWkBw/7wbE+ruml7E/G4kz2vKTk8tjY1s0VgPmLDmT
         pRuIQ6FJGtFNcXyeZ/hs5GpJbBhY/FiKpIHRF9IL7T4HacNBincGSrkbF8oFU+DoEAjf
         PZpP+VH92MINfUc8TO4kX3+8TR0IufUaQf+HBflWaqwPRlsEnQZiHmK7+f9SrPmx98PF
         qqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYjJmEzfZrC6Hihw3ID6mMFuzIxUBipJdm+pO3rrqoY=;
        b=AEjy3P7FZEtKc3EUrrwr39rvKfnkUNkuJ/HqSGhSKN6OlUuQe7hGtkpS2LrxEJU9Gs
         JfTx35SXi/Xs/2mflRCY/dyHJYRt34NU30TabqvO7Bxd7n9qpm7wG231YdfPqSP9mo18
         bF6F6oF/S0vExbz9aKME7JbiIY/YQtwuOHY7qvyV24C9ROt+QXD3hw7T1lctS/nBH31R
         XrvQfL0iuVnL3UKdnpwiwcPJXHOT+FZKR2oY/Rt3P+rg4+ECKPg2NtwWVTcWiI5T52vq
         8pLElQMKa5S62qnjfx06E0GeIdc7Ed+7KkJ2AksiZA7QIU9iubwQFDFXh11zuKC/oMzg
         VRiQ==
X-Gm-Message-State: AOAM533lVGeAV3D4qNgiWxTF3TiYyhnzdGU2pp/PoEz3n6qLwYT8J8CD
        U0WMzrwbz/jbXrEIFAT0Rn0=
X-Google-Smtp-Source: ABdhPJyMGvLRP5VoA5b32DWBiERlsyISvHJjQfLqGqsvjGM6UzGYbTWWrh++/+RMyN8OJ9sxaAuqUg==
X-Received: by 2002:a63:1542:: with SMTP id 2mr2204654pgv.248.1602014359196;
        Tue, 06 Oct 2020 12:59:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id t10sm1901423pjr.37.2020.10.06.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:59:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] crypto: xor - Remove unused variable count in do_xor_speed
Date:   Tue,  6 Oct 2020 12:58:48 -0700
Message-Id: <20201006195848.707504-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

crypto/xor.c:101:4: warning: variable 'count' is uninitialized when used
here [-Wuninitialized]
                        count++;
                        ^~~~~
crypto/xor.c:86:17: note: initialize the variable 'count' to silence
this warning
        int i, j, count;
                       ^
                        = 0
1 warning generated.

After the refactoring to use ktime that happened in this function, count
is only assigned, never read. Just remove the variable to get rid of the
warning.

Fixes: c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
Link: https://github.com/ClangBuiltLinux/linux/issues/1171
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 crypto/xor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/xor.c b/crypto/xor.c
index a0badbc03577..eacbf4f93990 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -83,7 +83,7 @@ static void __init
 do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 {
 	int speed;
-	int i, j, count;
+	int i, j;
 	ktime_t min, start, diff;
 
 	tmpl->next = template_list;
@@ -98,8 +98,6 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 			mb(); /* prevent loop optimzation */
 			tmpl->do_2(BENCH_SIZE, b1, b2);
 			mb();
-			count++;
-			mb();
 		}
 		diff = ktime_sub(ktime_get(), start);
 		if (diff < min)

base-commit: ed4424f2fb02497b0ea92bf58c533c598c0da1d3
-- 
2.29.0.rc0

