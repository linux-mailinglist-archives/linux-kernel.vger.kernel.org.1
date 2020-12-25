Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2622E2C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgLYUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgLYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:39 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13ADC061799
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:23 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w17so4590011ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9r4ema29WgCyFSs5DlQj1Zph3S6YfT4iwmEVNm0zS4=;
        b=CTALSobxER6L+gsCQiR8Fwny4bYJsBNR7g1rfTp/Oad0pDU9PAfZR7R/PnX7gEhp5i
         dPGsiXy6+LtA5ENmcOv96DEa9Tj8HMNOVC4sWMnx7UBMQfIeY+oY9YJY4xF7DQzIEgZo
         7BbWUcpliywyQJBNs8vp0taaI6gzoN+mB1NLfWucnqKy/jgJRqAL7kQvV548HpOcPY4B
         4RaqdRrK45phtS/uD15FRGBIqfRnyYIwIgsQ6rHjoKQaoQQTfJhPgVTnkzOpUgNNQZj6
         Vi2n5CHTGwRmgmWxaB7VlOJ/0n/qF6NP6UjFaz8OmbvPa43MbBgoHcHLxN6BAsPKbCQm
         pFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9r4ema29WgCyFSs5DlQj1Zph3S6YfT4iwmEVNm0zS4=;
        b=RbODDk1Bg9zfW0LYAftZn3cIgeaCVzplbmZF3JvxzxkpTpvfPllQFoGKqTwuOOTzHk
         nNxXDL1xUZ/NqOzLm71tlQj4MFNy6SeOSGKDyVXp4duy2nWyRJTVuVuWuJj2jjXdeSDW
         VsJ6y0GCDXp918wCVXrA8eU0AYiHrRn4ShbV1k7pUhM957z7UUEjWH39gsSpZmxYNv8I
         gsmjDtf+3CQkw9pbXdywhycM6Exy84Jj0C4qvTtxmZYeN2PsTnf+BaEVFtS/zBkKgv6z
         J0LGDrkr3iw8sdw5wILUJ3+gJtJeL5wLYKOaoX2wS5+jGUe5Fa4J6+YGco/u7RAO7+nH
         Kzug==
X-Gm-Message-State: AOAM531J0Fvf49Br3RCfzjROYSH0xiSk4yuUu/7K+8x2eVrb2INXbl10
        jg+5fXKELO445XVz1nuyN7w=
X-Google-Smtp-Source: ABdhPJwKSR595GmBkPnzY5siFjzPEuMIU/G9pKCRD491wdusmIhbgBmLX1Kv0z0Y16IQyENfb87drA==
X-Received: by 2002:a92:ba82:: with SMTP id t2mr33602691ill.139.1608927623348;
        Fri, 25 Dec 2020 12:20:23 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:22 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 09/19] dyndbg: optimize ddebug_emit_prefix
Date:   Fri, 25 Dec 2020 13:19:34 -0700
Message-Id: <20201225201944.3701590-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early return if no callsite info is specified in site-flags.
This avoids fetching site info that isn't going to be printed.
RFC: is this a proper place to use likely()?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 9 +++++++++
 lib/dynamic_debug.c           | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e155dfafc4d9..ea07a91a43bc 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,6 +40,15 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+
+#define _DPRINTK_FLAGS_INCL_ANYSITE		\
+	(_DPRINTK_FLAGS_INCL_MODNAME		\
+	 | _DPRINTK_FLAGS_INCL_FUNCNAME		\
+	 | _DPRINTK_FLAGS_INCL_LINENO)
+#define _DPRINTK_FLAGS_INCL_ANY			\
+	(_DPRINTK_FLAGS_INCL_ANYSITE		\
+	 | _DPRINTK_FLAGS_INCL_TID)
+
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f6d8137e4a46..8e81ce58c1bd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -629,6 +629,9 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	}
 	pos_after_tid = pos;
 
+	if (!(dp->flags & _DPRINTK_FLAGS_INCL_ANYSITE))
+		return buf;
+
 	if (desc) {
 		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 			pos += snprintf(buf + pos, remaining(pos), "%s:",
-- 
2.29.2

