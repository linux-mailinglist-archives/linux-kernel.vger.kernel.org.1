Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563922B35EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKOPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 10:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgKOPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 10:53:47 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1595C0613D1;
        Sun, 15 Nov 2020 07:53:46 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o21so20890018ejb.3;
        Sun, 15 Nov 2020 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NTft69T1mTYtzyZd5VE9D1Un4kdVXkHnJCMEwBJBmSI=;
        b=F0EMpZtga98i9/iiFSmb5KqSEzHXWLzMZHMBI8AfVbqw1qHHfw8RJTHhmB1hYWYust
         E0C6pCV4/h9ngcw90qE9G1zzWRFnuorYVHuRhuJCrf/S24eJpCQ7cvqFcXVvqUMe/JmO
         onGO1xq8cDOa+PEM6r70WJtC7ZRhMLGd9KGD2QF9wyqCItVXPrqoIw1x/ybqoVstXZZY
         m6Lfw9/Epa3OH/Z437QPmSg0Hc2uVROZbDYz/JoFk13OdfkhWOBr0u+HvUiQz38jIwr6
         WJwNWam2rETffmdxilllNhjd1+lzTBynMhdSL/SjgatQE+2gPH0LB40rkELay2PiNgVM
         cuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NTft69T1mTYtzyZd5VE9D1Un4kdVXkHnJCMEwBJBmSI=;
        b=IFB4YQRsZgCf1cv+/P1axTkbYYNJ3MCcw1Eur6zEnIIhZ/FuMG7z2jY/hV6+TBUqri
         Xk95NYDVHJeNhLMzj+PWHTbtGRDNw9wFqLdQ8OQQ+BrPKFCSEZWJcW8lJ44FW2MOs46g
         sD2i7UHdLUjP7wXyBloG8ZhiOK3ZlcI0BkQz+7qB2EUd3UKZQhtdNYaSKNJEOmvg0Q5p
         QcgMHjq6J6X8A0J/j4Y+/btE19Icjo+uyX3f5ulmfbgehFO1EnmbaThaMdNV3Ls95HxR
         nJfcLAU+tKWkAhdzDTA7HU7oesPs5l114MhqhN0LmM2Dmjt8QpOYxoGPCgKuvjDpD7ac
         mXUQ==
X-Gm-Message-State: AOAM532ZGOh1+xJqD4hEncMOgJtVhhJJ5+UPWRyX2/MLBLAg5+zh6BQM
        DDxKYKqVPLpYjY5vIDtsLfw=
X-Google-Smtp-Source: ABdhPJwuhMG+sbuJ507a138Ti8PEM5hZ1DOdh2lcH/0ZFCoRfiaJV6YUK7+Uf8P7Nf7P6zeOFZUMCg==
X-Received: by 2002:a17:906:3294:: with SMTP id 20mr10909244ejw.239.1605455625353;
        Sun, 15 Nov 2020 07:53:45 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d94:6d00:cd54:3781:b4ab:7953])
        by smtp.gmail.com with ESMTPSA id k23sm9205537edv.97.2020.11.15.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 07:53:44 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] tracing: clean up after filter logic rewriting
Date:   Sun, 15 Nov 2020 16:53:36 +0100
Message-Id: <20201115155336.20248-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions event_{set,clear,}_no_set_filter_flag were only used in
replace_system_preds() [now, renamed to process_system_preds()].

Commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler and
faster") removed the use of those functions in replace_system_preds().

Since then, the functions event_{set,clear,}_no_set_filter_flag were
unused. Fortunately, make CC=clang W=1 indicates this with
-Wunused-function warnings on those three functions.

So, clean up these obsolete unused functions.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201113

Steven, please pick this minor non-urgent clean-up patch.

It possible that there is even more clean up possible, e.g., removing
some values from the whole enum, but I will keep that Steven to decide.

 kernel/trace/trace_events_filter.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 78a678eeb140..c4fb3ffe018f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1561,27 +1561,6 @@ static inline void event_clear_filter(struct trace_event_file *file)
 	RCU_INIT_POINTER(file->filter, NULL);
 }
 
-static inline void
-event_set_no_set_filter_flag(struct trace_event_file *file)
-{
-	file->flags |= EVENT_FILE_FL_NO_SET_FILTER;
-}
-
-static inline void
-event_clear_no_set_filter_flag(struct trace_event_file *file)
-{
-	file->flags &= ~EVENT_FILE_FL_NO_SET_FILTER;
-}
-
-static inline bool
-event_no_set_filter_flag(struct trace_event_file *file)
-{
-	if (file->flags & EVENT_FILE_FL_NO_SET_FILTER)
-		return true;
-
-	return false;
-}
-
 struct filter_list {
 	struct list_head	list;
 	struct event_filter	*filter;
-- 
2.17.1

