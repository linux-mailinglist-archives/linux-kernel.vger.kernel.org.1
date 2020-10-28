Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02B29D889
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbgJ1WdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbgJ1Wco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107BC0613CF;
        Wed, 28 Oct 2020 15:32:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so737477wrs.5;
        Wed, 28 Oct 2020 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5BWRuAigFz9km9p6yXg2RqfU876ueFRRadA3U73oXM0=;
        b=mg0c3Trr7UnelD/TS7jZb3IcNYeg9PUNHKBgqgm2EOd5jhChVWzR7Apqj6AK9Q1KcM
         tMxe2Td1CttKGmKE3XNu4yHzvYGc2d/3FPBr1E7Y33kuY17IGo9E+HePbnXDW1qhbzZf
         Mo2K88bcLPkj3qUuqSOJ62RsHUgRuZDO1xsh0Op1D/JeaiG4MEZ+W4Rm513htVXedB0b
         /NHjMeVlr8JNFxof3gbATzlE+7fDvqAm0BEIS8KcqBQ+MXPy4XkLAtJHm74dq5PgUmbr
         T5a2ETgU0vHk9mdGPq6gyauAO/i7Z60Hxli1OIslYELpFfZqe5XIgX2ZOsYacCET9rfi
         xfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5BWRuAigFz9km9p6yXg2RqfU876ueFRRadA3U73oXM0=;
        b=GNWxlFEM3hN4lTz5FQBeTd5YAwqTQxNwUVZ/ANw5brqc4AYoJizXW/QErqiBAbnvUL
         TShvR9cAgZR0IzEiwWPJZVAysO6W0rACyZG3Ue6ptWprufzN7qr7ZEPLxzAQ31WP4IA3
         DP2i4jonvtc4a0G8SSHTwKMfRPn/E28uFFEaTTdSTyCw+21lWpBVpKc7yybA62UT0Qk/
         HVlB7FfQEYc9DpmaUC4KS6lOJ9wKN7YsSb2W85ST427V2HDzPvC/Rwi8usDKnirn4HoI
         dXVViHEYhZhF5QVer4IqstYWs+CIGpsXXruOAGqwIPIn3626qkJXWLfCzG1AGZfrsAKa
         3YMA==
X-Gm-Message-State: AOAM531FW7Mo6HB1+sPo6RQ12yV/j70bv5oKtuOKGUYnpgxvxVzz2jHR
        woeKxLGqR7FNyIa+n9n7LyQz5qNxotJvBP3b
X-Google-Smtp-Source: ABdhPJxxUMVps4Zr+8JbLjrzekWhd1FMxqWLG6CU91v4PGo6av3pY1PrmLW11eVHAE269DrpgpOWBw==
X-Received: by 2002:a17:906:3a55:: with SMTP id a21mr7365323ejf.357.1603891879235;
        Wed, 28 Oct 2020 06:31:19 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d7a:200:a915:6596:e9b0:4f60])
        by smtp.gmail.com with ESMTPSA id ce15sm3186691ejc.39.2020.10.28.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:31:18 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Airlie <airlied@linux.ie>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] agp: amd64: remove unneeded initialization
Date:   Wed, 28 Oct 2020 14:31:06 +0100
Message-Id: <20201028133106.5420-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

  drivers/char/agp/amd64-agp.c:336:2: warning: \
  Value stored to 'i' is never read [clang-analyzer-deadcode.DeadStores]
          i = 0;
          ^

Remove this unneeded initialization to make clang-analyzer happy.

Commit a32073bffc65 ("x86_64: Clean and enhance up K8 northbridge access
code") refactored cache_nbs() and introduced this unneeded dead-store
initialization.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting binary is identical before and after this change.

No functional change. No change in binary code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201028

David, please pick this minor non-urgent clean-up patch.

 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index b40edae32817..0413b3136541 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.17.1

