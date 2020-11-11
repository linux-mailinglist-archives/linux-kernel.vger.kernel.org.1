Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB492AE67C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKCl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgKKCl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:41:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DCC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:41:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so858874ybi.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OUUVYD1R785BEy2RCsP0C8sEZy7udFaGjiORPSK5eA4=;
        b=YkAD55+oueldtZYQsqMA0UPxz4pQzg/Nc9P3I8Le4/s6jHsNf9FI2vYpk2PbpbG0bT
         rCWhl4Oyi/1mHNQLYHe8jhYtGwtIF4Cse58JYRutkrEUbsxCxzSlnq3+eqhu4DqNwvDU
         DS7tZEHYdv8fJN8dZODfbshQurMulab5UuHpbEDX9XTBPehxv5UUUGs1h1hX9XwNsF95
         4NBkxwyX003WwNDxOgvGN2hFdDhmDleJzruh9op4yMvMMcl3UlESO6K2Xul+eTGJV9Vv
         N+z36xrs/6pdtefVwGI4LWQgL0cJ5p/rqo7FPTZ7QGDxvOcbObFXRReNvcRZNoFah6cN
         B9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OUUVYD1R785BEy2RCsP0C8sEZy7udFaGjiORPSK5eA4=;
        b=lO6DATlSemdKzsdtBalcOYVCBuaEzOK7yGLbL+HRHSDhzuIUugcDdVaf5YYGxWmvKl
         7p3MuuJ9NAI4MsbAa8N9gCTUHloPDuScqnnSU5PCDJJB5PFCDRNGQRtmTvSp49ZRP25Y
         hy/w5u4r489dxcP/sSFdXJ81VdnPLl1Ef8KxQ3U03s3uCFmtnVpI5YzxF5Y8J8hN8flO
         mqTEaAzEocMsmuJu1hHV3Uc1zVj+0/lWqrfGw4RpsQOpeTa7bxOVjyvzpjZnAXcKjhmo
         YccSL2QdH6i0PLpt0divUK7TbmGc5xS2EbtupPxaWP+/5gLrlRbvsv1gY+GB5jRsedRW
         e3tw==
X-Gm-Message-State: AOAM5328epeg5WGx5ZT2OlWXrwKZvCjjPjlQN6Chhi9RiWXL0yRFM933
        1SHH1PwoptAFG11PQAMgzQyhjjp1hwNgCxUQPCo=
X-Google-Smtp-Source: ABdhPJwPg4i8FsskSCpJr28arcLUIKNAAIxC1mde4fbI6yBQbYaURLDP3XHyTL2hLmSLv+hmkyMSeZn/bUQxuAxxMPg=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:b445:: with SMTP id
 c5mr29391620ybg.355.1605062518302; Tue, 10 Nov 2020 18:41:58 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:41:40 -0800
Message-Id: <20201111024140.1483879-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] Revert "dm cache: fix arm link errors with inline"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     Rob Herring <robherring2@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 43aeaa29573924df76f44eda2bbd94ca36e407b5.

Since
commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
the minimum supported version of GCC is gcc-4.9. It's now safe to remove
this code.

Link: https://github.com/ClangBuiltLinux/linux/issues/427
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/md/dm-cache-target.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 9644424591da..4bc453f5bbaa 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -712,10 +712,6 @@ static bool block_size_is_power_of_two(struct cache *cache)
 	return cache->sectors_per_block_shift >= 0;
 }
 
-/* gcc on ARM generates spurious references to __udivdi3 and __umoddi3 */
-#if defined(CONFIG_ARM) && __GNUC__ == 4 && __GNUC_MINOR__ <= 6
-__always_inline
-#endif
 static dm_block_t block_div(dm_block_t b, uint32_t n)
 {
 	do_div(b, n);
-- 
2.29.2.222.g5d2a92d10f8-goog

