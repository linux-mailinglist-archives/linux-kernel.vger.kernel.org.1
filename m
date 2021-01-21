Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7344C2FED1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbhAUOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbhAUOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:40:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F87AC001F71
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:30:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z9so1610443qtv.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrfGRc7CW6tu17+KtxNBL32EE4e4XqnIIXltT7Ly+iU=;
        b=sXBFJXyDk+85Q9WFtd0K2G12isVb4r6YN0q91mPfKTByepJzhRyXaG6kpdfuCLqSaQ
         KqZR6alE2Rnk2r3u2ECXG75U9s8o2k0/UhF9clejJZbe8HozzVB2+BR3ahqlZA6AVnNx
         pQ7i6jfYTI0rldjfhJ8omN6FmZ/qzNDXeFMz2ZMH5C4GWA70sqmgIUHGYl2ADLhpubds
         I0IA3AHTRtHeXJh7VGzdO0lV8pE5gpWfJrExU3yoMeFWwzmWA2IDRRUvNy7oE1GIAs2l
         4SiDdu/qRuGx7WFSjHnMAq3oJ9YRHOYPq0mjbE8A5+v756gULmF7eCwLdgxERRl3jQmG
         yU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrfGRc7CW6tu17+KtxNBL32EE4e4XqnIIXltT7Ly+iU=;
        b=PBx79QF69oqc1nKGwoVyVOCr8lZD66sH7lMJkPyt8TTEZNaqTt6ItdG+5ATxWBhrVd
         xs2HU9yuuJeS6tYbXKeuqkYJS5j3xA/Qzy9oiPsgQN8zUejPfryviIIZ8L+vkPCzQ3K7
         CbU31BwUQoBfw5oJwzp1xRKroQVUrqf0lDukAQXx9Gl9f/A140AodZoc8BIexiOYp98I
         1bpdREQwpsQS40HlnhiISp1qdUmgRGPGn6BzcheF0MzGsqwBhc6dckKok5srBBOzYyo5
         e+szcWlBUamcuN9zrv9qMP3bMjOryWKyPxTrHwFLLOucImAk2SlNZNlPOkyKPk6LBwed
         HhxA==
X-Gm-Message-State: AOAM5316+wZfmMCy0WUbxGirVyKtBbpiPk+zYD7sylZ6EALXZ5ISOHp3
        XlxY8p1aR5v7TDo3yz+V/xHcD8xu4Ft3gg6C
X-Google-Smtp-Source: ABdhPJzwt8lesfl9F4SORsZ3vDFqCVEY5TD8q7k6EqsTuTzU/4jou6XC467823HxM7ydawee/he+mw==
X-Received: by 2002:ac8:2adb:: with SMTP id c27mr10899879qta.145.1611239431874;
        Thu, 21 Jan 2021 06:30:31 -0800 (PST)
Received: from localhost.localdomain ([156.146.58.64])
        by smtp.gmail.com with ESMTPSA id o5sm3570373qti.47.2021.01.21.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 06:30:30 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     torvalds@linux-foundation.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts: LOL what a patch! change Linus to Linux
Date:   Thu, 21 Jan 2021 20:00:14 +0530
Message-Id: <20210121143014.8913-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Linus/Linux/

...how dare I?? :)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/patch-kernel | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/patch-kernel b/scripts/patch-kernel
index 033d5916797d..314e80c252c0 100755
--- a/scripts/patch-kernel
+++ b/scripts/patch-kernel
@@ -7,7 +7,7 @@
 # e.g.
 #   scripts/patch-kernel . ..
 #      Update the kernel tree in the current directory using patches in the
-#      directory above to the latest Linus kernel
+#      directory above to the latest Linux kernel
 #   scripts/patch-kernel . .. -ac
 #      Get the latest Linux kernel and patch it with the latest ac patch
 #   scripts/patch-kernel . .. 2.4.9
--
2.30.0

