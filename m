Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91362CD357
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgLCKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLCKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:23:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46665C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:22:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c137so2040542ybf.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=vsqjzCG97dcihSHBib7qbR9auIczQ/SwW03OgCf6BLA=;
        b=KO9gk6ofgaQ/Jly7j0A1VuJ6WlC1hiy7I+SkR3CY5r4rxRyKJeUQJmvfI/EQno6COp
         Pd5OebmmiB9NnixUYZFdzXYXFPucr2NFVCJ7nsQLg4JEgZ8uM3j6/SLlKg6hm1FJVOBu
         vGKFcN2JlhWOB/MmW4n59K6e6vFmIyzDiqEVKgJN+4MitUUEpIXYlefxLkirm+Ji95+9
         kWj/WrWvm0TWkh91QmiTAY7BkkiwOMsXCHkbtaPOLWd+z8GpWdK56UOyIDk3JCvz9Wl8
         9cKrvOom8gi+fx+rfKBTzI4qnYw3HlJm7SXwg3gonwaCZzLeSdMV/qKKn9pa8x8WNwTZ
         2ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=vsqjzCG97dcihSHBib7qbR9auIczQ/SwW03OgCf6BLA=;
        b=qDkK2w1jc7FlmZlgq2OS08y+4SayVPXmcE7BJORjgz6nV3fCfKlC5J6Ck7TJpfdp46
         0bP3IrjEEL1N2bVZhTIBWMSgApplOHdndFbiH5o3Znj+nRrgrvoBY1Dql32xYHMMIyJt
         TA+jC4Taiae3hMjeraXaXqA2MiAWzABF1+DBBmGGcitgA5piKcxkGNuH+Bp2+xTlIg6W
         xnhfZVGvO7q5DWAR/9I7E3Volia+oP8i0ulkkkWYZvGT+bSIXiUFNVQCXLRZx9IjNP/p
         sq32oJUxWoy77YmyAvdStfQsTE7baMQtCC0VOy9ELbQTaVVAJhgRadX+ypVeAMc8AhLR
         7hKA==
X-Gm-Message-State: AOAM533Hj7aNDm0khkb8Hu4i27+NT4VGOb5RYj6k6G1wArXgSkIbPKIK
        eE/6AgQbs/4vD2XE7l2fdQoJoPEw1tEIBw==
X-Google-Smtp-Source: ABdhPJwtpbLRCdwh6CxXu9InNBnq8+upXgOOu++rmsLwSfcBgI9lS5mLYW0FM3hQKqkKOC18S/foZathvHFdPw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:38d2:: with SMTP id
 f201mr3520867yba.103.1606990958512; Thu, 03 Dec 2020 02:22:38 -0800 (PST)
Date:   Thu,  3 Dec 2020 10:22:34 +0000
Message-Id: <20201203102234.648540-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next] tools/resolve_btfids: Fix some error messages
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing newlines and fix polarity of strerror argument.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/bpf/resolve_btfids/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index dfa540d8a02d..e3ea569ee125 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -454,7 +454,7 @@ static int symbols_collect(struct object *obj)
 			return -ENOMEM;
 
 		if (id->addr_cnt >= ADDR_CNT) {
-			pr_err("FAILED symbol %s crossed the number of allowed lists",
+			pr_err("FAILED symbol %s crossed the number of allowed lists\n",
 				id->name);
 			return -1;
 		}
@@ -477,8 +477,8 @@ static int symbols_resolve(struct object *obj)
 	btf = btf__parse(obj->btf ?: obj->path, NULL);
 	err = libbpf_get_error(btf);
 	if (err) {
-		pr_err("FAILED: load BTF from %s: %s",
-			obj->path, strerror(err));
+		pr_err("FAILED: load BTF from %s: %s\n",
+			obj->path, strerror(-err));
 		return -1;
 	}
 

base-commit: 97306be45fbe7a02461c3c2a57e666cf662b1aaf
-- 
2.29.2.454.gaff20da3a2-goog

