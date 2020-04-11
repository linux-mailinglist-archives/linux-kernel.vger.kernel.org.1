Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23D21A53DF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgDKWEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 18:04:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52833 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDKWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:04:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id o81so322785wmo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HloapMrTBbqZ+nTqkRH5KhOauRgcgw6WdiZ5Tk8uSNs=;
        b=chgPPt02lSLt2BSMGRU0pTejdXcwcYFgZCIwRwJqXMuTbCkswQSP3glvvzx18CJZBI
         Uasjm6ZXZ8ikkX56wWvNiYc+758d4+uWZ/OqH0T7v5eazJC/F3VFvrr2f7BCEdTQQ9/z
         XCbfd3dhzlYdE7tb9fyWpM4g2LxsmqF656/FvqLssOF5wO5/F08jckFwQoN7MeBNLL1O
         ea9PClEMoqSqWO9NFsxj/IEYmH4mXoTvywNOLcgI1WEy2ViWB2l1SZ0LtlS+sr/tpgGM
         Z5FsGuLQh8l5+0EFbXIX8CTMVyRgGSHGY7yV+qUHC5NnVJA2c4lVzSE+kTsUkRhzqrXQ
         KXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HloapMrTBbqZ+nTqkRH5KhOauRgcgw6WdiZ5Tk8uSNs=;
        b=iKgNGaQfolncQAOUVgdpQ+hX6uCcZM5UNU6qqWrQQe5PYkI877c63pVPStb+9XjcOO
         hyQzC+hBLViBQiZqOGsJ8O8SyGARnLBEE8KYOcUf4bcKObaZkMBJtUgP1uIzDOaFYY7S
         sxpKMtpv4K0vSiUS2ZRcT+AezIF1yLefoC6xg8UT0gy/DmMvtp/6sfjF4zb/M4jOz/wC
         fYUPBYXzlhStjhXbg/p63HMenEJcUb/o7KJDzSyGm7urYW9+PMpYXaZS1xmvKHjrenIf
         TRIYMMhhsKwx+FBhU2ctePKuIshq1qM7ZcCDpCA6932eFWuwkDAvXyQhZbOnXumAotih
         pDig==
X-Gm-Message-State: AGi0PubVWSutPkViLQvHzUGiJuc5MmOrn1j3v5IrwFHqxYVjyuo5ih7/
        uyd8/VUxyxVZZyhZ41VVjP/c3jUTbjI=
X-Google-Smtp-Source: APiQypKEKVP/CHvgZum2u6S6RrESZKdY7U9o9KPcFWC9g7fhISobWofHL0gNM4tnu1NTuibz8eh/FA==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr11168293wmf.166.1586642666074;
        Sat, 11 Apr 2020 15:04:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e11sm9307275wrs.82.2020.04.11.15.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:04:25 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, anshuman.khandual@arm.com, david@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 3/5] mm/page_alloc.c: rename free_pages_check_bad() to check_free_page_bad()
Date:   Sat, 11 Apr 2020 22:03:55 +0000
Message-Id: <20200411220357.9636-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200411220357.9636-1-richard.weiyang@gmail.com>
References: <20200411220357.9636-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function free_pages_check_bad() is the counterpart of
check_new_page_bad(). Rename it to use the same name convention.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0648127af872..85d7aec5fb45 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1013,7 +1013,7 @@ static inline bool page_expected_state(struct page *page,
 	return true;
 }
 
-static void free_pages_check_bad(struct page *page)
+static void check_free_page_bad(struct page *page)
 {
 	const char *bad_reason = NULL;
 
@@ -1038,7 +1038,7 @@ static inline int free_pages_check(struct page *page)
 		return 0;
 
 	/* Something has gone sideways, find it */
-	free_pages_check_bad(page);
+	check_free_page_bad(page);
 	return 1;
 }
 
-- 
2.23.0

