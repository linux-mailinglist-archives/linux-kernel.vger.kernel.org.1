Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FC2716BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgITSIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgITSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B2C0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:08:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so10445391wrn.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jdb8rNlgdaYdlOtpwYROQRJjIMp1V2pKHg7RvkIdLgA=;
        b=fntqLc4FE77wsWxLxgN8PtMnLGVlZPRr85VUC0OeCUPx8ti2ANbEV26e/+iKX/3u8n
         Ia7nCLbTMviPEaSJQbuYnNG7NKKHHZp2yNZT043B6eN8AbGjEn4JDrdenLW3555+ZT0E
         OU1O/Hgca4XHd9qbSGxIKe10ntoHi0fSqouqGNI5BmZuvNZTQdXYhZew0aujpCVjbjQs
         K7SDlHclK94lJuLY61AsnbEfFt9TegGYr12ZLeqNYfmFE5vfCikofItnlK+//FTvOwhS
         4RNHYRYmZzAOBAJhLeNBQK9G7IyvfWjc6oY2NwvlFg6FeMbSzgAKKZokwVB3pg7pN644
         H5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jdb8rNlgdaYdlOtpwYROQRJjIMp1V2pKHg7RvkIdLgA=;
        b=ZbP+ByaJHPVmBcYGECFTVb7Qh2WBvj3xIocjydzruBZgWLOK663fjsAQeuI4Z7QVEY
         Poy3DvE947l6kIPj9Div423mseeYJAsT6M/GXiCRm+UlxVKCqXkiIHfiQhgXOWClAnPJ
         ivC0CqcLyVoLoqr3lss7IbnGoTzERfIiqCvkcpjLSA9p0unqboRuuFRJ5jCW++fJkgYH
         ZpNeadvSoAltNWXAdx3Nok4npf/nZ5GD0zQRwevu4m2iuMvXmiijPgpqCGw7tPRyJ3mH
         Uxl+5pd8AGzRx5wuvTX2PzulF8g6cryXMhpe5Iwv2LIQu2gYz5nND+OQvcrVH9b2DpYR
         Y7Hg==
X-Gm-Message-State: AOAM531atvgKvLJ8/a7vhDfRbv8wqBhFZI4Fux7xvOahwtv7QuIN161X
        Fj/+dH8VDD0EaqEfoCPf218=
X-Google-Smtp-Source: ABdhPJyxkCNmogUp5h7cktZid4CijgctSQHntglWMmQIEO5tUJKwDurtAnpiKE36tyVRyJNUqBop3A==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr50554672wru.90.1600625317909;
        Sun, 20 Sep 2020 11:08:37 -0700 (PDT)
Received: from localhost.localdomain (ip-109-40-66-120.web.vodafone.de. [109.40.66.120])
        by smtp.gmail.com with ESMTPSA id k5sm15510214wmb.19.2020.09.20.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:37 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] mm: Fix typos in page-lock unfairness text
Date:   Sun, 20 Sep 2020 20:08:19 +0200
Message-Id: <20200920180822.4940-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some small typos I have seen (for details see Link).

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 5ef64cc8987a ("mm: allow a controlled amount of unfairness in the page lock")
Link: https://marc.info/?t=159978288400003&r=1&w=2
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6aa08e7714ce..5202e38ab79e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -990,7 +990,7 @@ void __init pagecache_init(void)
 
 /*
  * The page wait code treats the "wait->flags" somewhat unusually, because
- * we have multiple different kinds of waits, not just he usual "exclusive"
+ * we have multiple different kinds of waits, not just the usual "exclusive"
  * one.
  *
  * We have:
@@ -1011,7 +1011,7 @@ void __init pagecache_init(void)
  *
  *	This is the traditional exclusive wait.
  *
- *  (b) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:
+ *  (c) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:
  *
  *	The waiter is waiting to get the bit, and additionally wants the
  *	lock to be transferred to it for fair lock behavior. If the lock
-- 
2.28.0

