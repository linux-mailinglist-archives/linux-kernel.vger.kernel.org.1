Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A052497E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSIAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 04:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgHSIAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:00:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6892067C;
        Wed, 19 Aug 2020 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597824031;
        bh=UKcRSGUs9osnVCmOgLuXwzMZc326OMLm9uylAeaY14c=;
        h=From:To:Cc:Subject:Date:From;
        b=bbDsZCFr7dFcolGF9dkSwppOc+T9hVMu9eYsofS/IysNbLT/0P9uah6LP8JJklxbz
         XKiIKwvfR1XwyNP133DmpZdYrJNK6IbxsPOZYrx4N1pRCmjkDexfxlrsXnIAKSfxsz
         Ul7zh0bap4pwhoRfdH0NmnvO8294WmXka7xKjHLE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix missing function declaration
Date:   Wed, 19 Aug 2020 11:00:26 +0300
Message-Id: <20200819080026.918134-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The compilation with CONFIG_DEBUG_RODATA_TEST set produces the following
warning due to the missing include.

 mm/rodata_test.c:15:6: warning: no previous prototype for 'rodata_test' [-Wmissing-prototypes]
    15 | void rodata_test(void)
      |      ^~~~~~~~~~~

Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 mm/rodata_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 2a99df7beeb3..2613371945b7 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt) "rodata_test: " fmt

+#include <linux/rodata_test.h>
 #include <linux/uaccess.h>
 #include <asm/sections.h>

--
2.26.2

