Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CBC20C8B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgF1PZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgF1PZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 11:25:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3064BC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 08:25:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so14142638wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUWSFKmiKbn7NS6OS++L4vNIhvchWhWVxfAVBsgRvRE=;
        b=uF+l4g7eUNlWJ3g5WmrOEMnhcwWVa+xZl7IwNA9S2Bg5iUkR2rDYNtjUy3eIE2f2/6
         KFLJ0GTunExzOw6SpmBVM6pSpS3g3BiLRXzvm6dR2v4lOjiLzvlIeamGob4/oMgR8cCg
         guj7Au0NLqNG7W1DVnlTBAF12v9lXkU+N7YU7Ea/vC58uqqG5EyY+2yMgWyUvvP7LBbc
         EDKTtnciLEksujlmrzb4GB6MWCNQqrU4pTGLr5BuopZ06+D9oGeFsKHxpcqiQV8szXkG
         OtSjGO/UDT6FR3OY9dsXOFFGxcg7VgX/JlOIxUowWVJMuy8jNFuDb2FGqW8iPTqLjxLH
         ttsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUWSFKmiKbn7NS6OS++L4vNIhvchWhWVxfAVBsgRvRE=;
        b=ULx1VVcnVAjC3yA7wCBVFWX16TgkFTob/b9rITL8KFm6jcc764EEkQBVzCcQ4/XD/T
         uZzjx9w00Pq2MOIw5aS3XpOODqRFhPb+PrzFvQCqohUugOFbYb1YcNcdHKS2pLEWcww5
         DV1fKafuZ1zjFO8EDenqLgEqNc2FOldIUSec9AgffhIt/aleInwRfn3M1NWGKuugJJUT
         9iY8ALZ3y1dU7iOZdL7p7byJZwQH89wudkdMJQSjVjz3sCzISd2zCmt+yyYX63hET3oX
         +7xYdm77JL2nKr/BZEH3BILtEru+xTFXbcuJo2Ki7ZYx5uxsDH0+xseG62ZL4lExRKJP
         +9AA==
X-Gm-Message-State: AOAM5319vcQ0GXb+zB5sYN+4OUn/NmoQuud9MwQ+o0VMm3EeVm6vEti/
        jnlXQyjC7KK70ykZ5P5m4Lyr2AIAhKs=
X-Google-Smtp-Source: ABdhPJwsY9WWwujK5rvyBWdi7WdxbRQX7uQ9XLKMYiFWAnji8xfXQ5NwhNH5gYtRT/Hlvoq0AAmIGQ==
X-Received: by 2002:adf:ab4a:: with SMTP id r10mr14254106wrc.103.1593357906969;
        Sun, 28 Jun 2020 08:25:06 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id f17sm26929450wrq.3.2020.06.28.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 08:25:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] mm: util: update the kerneldoc for kstrdup_const()
Date:   Sun, 28 Jun 2020 17:25:00 +0200
Message-Id: <20200628152500.17916-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Memory allocated with kstrdup_const() must not be passed to regular
krealloc() as it is not aware of the possibility of the chunk residing
in .rodata. Since there are no potential users of krealloc_const()
at the moment, let's just update the doc to make it explicit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 mm/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index c63c8e47be57..27d6155edb8f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -69,7 +69,8 @@ EXPORT_SYMBOL(kstrdup);
  * @s: the string to duplicate
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  *
- * Note: Strings allocated by kstrdup_const should be freed by kfree_const.
+ * Note: Strings allocated by kstrdup_const should be freed by kfree_const and
+ * must not be passed to krealloc().
  *
  * Return: source string if it is in .rodata section otherwise
  * fallback to kstrdup.
-- 
2.26.1

