Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9C1AF936
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDSKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 06:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgDSKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:08:56 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB00C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 03:08:56 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id v9so1225277wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x4Jf9OoxVu57scXjQnvCCYWih0l2+dbJzXSbsRXxgIM=;
        b=kcP7+KilBa7sG3vcdVd4D8AEvObD4rH5WrNB/oiGTKhdUEq4khUD/ZiKKw5dCSCXQb
         bwvxhlHYDTdCAxs3M/3+jfMZGtGw6t4xthTlGtsrkUKI44c7ol9KkbGYNL0FM2TpgOlq
         AymMh+gnuqABTrk0n/Sz5ivAhOI8HpWqYr32Ags6Flzj/iknuM0LqIkyGpesVw6lTj3U
         Qwgnjn6peyTHioblgFMcxcQdeleUUgIuU0o1fKDs3rMHAqadTz7PQLwv4awoxYkyCLrP
         upVRl00XpCNfjV/sK7g0mxOM7aNPFZR1I1kC22YmtkoXvFSEx2BeXmHwTzK+yCFzvTvJ
         kcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x4Jf9OoxVu57scXjQnvCCYWih0l2+dbJzXSbsRXxgIM=;
        b=rNm9QRTt++A81ph436fKALN5iMjVfLBZiscj8PkHeX+8Hac8x4LQW/8QiWjRGgiyjt
         AdT5K3wMM0Uexu+MC0PsUUVFz+vOnN2s6Gp4M/XgxOp/ka19MY/P596Tf8Utywi0vOlC
         uCeCsnxnFtlHjsFqILJDOKIyHZqJF4PPUOetx1KemkvgUGkzoAYRCh1OTOeALOALyiW7
         OIOVTT+oHQjI9rp28AcEOXH7LyzlCxSWjTc3uXGa7C3cJnFz+YkhMMj44rX5d/unT4bq
         q4cwzZj3ytRrX1tfh8OQ82PH2sMcE/T+hYd3nsa/pPPCzUrwFsjuCR7opS6Sap/wq5Ai
         07og==
X-Gm-Message-State: AGi0PuZKrPGba//7C0BwxtL310q3XtvnIyu/F2aKtaykEQ+/GqBK73xI
        jcO+33JZoBFANlKVxwqaI7jqjkIMw8Q=
X-Google-Smtp-Source: APiQypJzb4jAH6/hnvA/J/izSVFGaHDo+5xwxvg6y5r3gpk40DTENHyCQ2KfTN2q1Dlnl9oRuIllu8Udmkk=
X-Received: by 2002:a5d:5304:: with SMTP id e4mr12407894wrv.87.1587290934113;
 Sun, 19 Apr 2020 03:08:54 -0700 (PDT)
Date:   Sun, 19 Apr 2020 12:08:48 +0200
Message-Id: <20200419100848.63472-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
From:   glider@google.com
To:     adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, sunhaoyl@outlook.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported uninitialized data being written to disk when dumping
core. As a result, several kilobytes of kmalloc memory may be written to
the core file and then read by a non-privileged user.

Reported-by: sam <sunhaoyl@outlook.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---

Note: Reported-by: line is subject to change
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..25d489bc9453 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset_size(t->task, regset);
-			void *data = kmalloc(size, GFP_KERNEL);
+			void *data = kzalloc(size, GFP_KERNEL);
 			if (unlikely(!data))
 				return 0;
 			ret = regset->get(t->task, regset,
-- 
2.26.1.301.g55bc3eb7cb9-goog

