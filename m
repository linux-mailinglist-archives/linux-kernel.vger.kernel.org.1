Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A407E227D08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgGUKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgGUKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:30:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA39C0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d202so25089950ybh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cPjmWgpWaY+rWzHjnAp20s8iFiM+s5JoLN5MYOTYnFA=;
        b=aftcNk8G6lu8fp6r5Y9h/eIuz+ESZ+QLzM95HKYPu/yD3X2lSvc9rOwiS7ZKhAing4
         yWp6omCuSFKxvk9F/F2V+0kpOCtCZqpDNonEFobTdTCwxCvTd/iKYAfClTBxOO3ukwvI
         puoGl4ZhkEpWNKr0YYQYrfO9Ej6kldPpIZx1BURFXJhJH0yT7oDSyrcyDQ5WES7/sq5m
         +jgb/bDUVdoByDvVqKTQH7jqFyjJYhOAoEU0onxFfDouwvAp+ZzJxoFKYcxFhWPNITpQ
         pGh/hZOFElKkGtGavdtJ+hcnhIqEW2vqFqzKklLa2WS1+R6pprVkk1eueJlX3o4ct3Zo
         Pw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cPjmWgpWaY+rWzHjnAp20s8iFiM+s5JoLN5MYOTYnFA=;
        b=GPIRUIQrOqnRnfud6EgA7cnoqbXuTih4yjpvU09b17egXaLWSt0E+Przx3qkTuBcIF
         taiuZEFzNGOHs0+Us+/xSChYlE/565QPLm1v14wzIybT5aMPYgiP+xkXmAMZTedN92QR
         Ue/4MeLzuiAW9p2FuMFV+5zfysYjp3TUrCLxS9VrGxC0fKT/aY8Zan4OqElhtTNykPDH
         OjR0x3XfGy9FPN8zsh+wANBKYuYt8juhwuEK2GSO02EkekCQCoQE+bsTCsp3R8MyOyrJ
         QzmCHzLwqrNiWnFyOellQ4viYdild5TbcMXpWFn9h+PTLL15/Mkh8hVQTA6+Lzr8Ul4Z
         zNxw==
X-Gm-Message-State: AOAM530lr86wF4mNGtxyw0VcceUAHmTVrmPisS2p9po9gks+HdL/gaDv
        FBqvA94atXa0AOC6khY4duemzyqGoQ==
X-Google-Smtp-Source: ABdhPJycd+24DGl11kCvcTJxpCv+cod2nuTGCYXZlnMMqzBV6OdnBQaaHt2pvLcJWUMkw/5HJwrTrZv2dA==
X-Received: by 2002:a25:a088:: with SMTP id y8mr29898149ybh.253.1595327435352;
 Tue, 21 Jul 2020 03:30:35 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:10 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-3-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 2/8] objtool, kcsan: Add __tsan_read_write to uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the new __tsan_read_write compound instrumentation to objtool's
uaccess whitelist.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 63d8b630c67a..38d82e705c93 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_read_write1",
+	"__tsan_read_write2",
+	"__tsan_read_write4",
+	"__tsan_read_write8",
+	"__tsan_read_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.28.0.rc0.105.gf9edc3c819-goog

