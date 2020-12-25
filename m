Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F42E2C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgLYUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgLYUWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:22:02 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B764C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:31 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x15so4627121ilq.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afjBfOqfJEtjnDWE/FVJOXOjmMKiM/IJ7gHMV5Ridwg=;
        b=pFHJyGgQrYfnoHIKu68zBd4Ip1MziZwCjTON2qTl7aope4URir7D5P001VQ6P5nAhN
         ceg3BbWq4WkXsmvjmVHPKyVabj3ad0FztHpqqNkHF25KTop4xHItMvenIdCYRAFMT+Io
         rrKnLXG3tBLay5T9EoH5pDQLeAv18g3q39zApIJ7udvfE3NWzl/fYAFtKnmUWYp7t6VO
         LHx0R+pnnhAuiOKZ87U3XG+wmiB7OkdrirssewxtjnF9g1fuA53EpKgZzQuKHJ5tkd6o
         fcMIm2IHNPT9rxAVVnuNb1fb/z2QrqaaIuvMY9E3swZHjgTgHVAjer58A4yDlMRUzuiF
         WS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afjBfOqfJEtjnDWE/FVJOXOjmMKiM/IJ7gHMV5Ridwg=;
        b=rhZUfuvGOonWQ8JJl/vOx/SK5JNKhBEJbdBYxFHd61uIbpUkEXmcn8jyUVZa9f8mgS
         PbRWGC7Th9CZ31vcUE8pkOGNLgMPSEAMBQ7vdU+XF7/Oq0pDXB+iktIpb5ymPf/vosD7
         RYsx+6z5//dqfw3Xg3q8y2c5gIMOBK+f0yY9bYfHqLH+76pcAul4YKmOU8NqFCYwRRkv
         vNDC7a2udXft5VuokhyvHXJUVcH6sQwe4tZJ+mtd4JrfQ53Dy+5IZEGHG8HoCZHSjrAK
         Twhjl06OF4AgcVqHxKM7iQMZFO9O7Ua1DGeRLQPivoCVnLX2URUv3xPPkKHXAPSH8C6V
         BTMQ==
X-Gm-Message-State: AOAM530PqQpK1+8WynBr92oBhr05cYoNEQkysCvo3utkywD5DuVj3F9C
        fhougnMGZ3Tz/mkKvqsMKvY=
X-Google-Smtp-Source: ABdhPJxnJcvW4Pl35hGnJhk6iFG8h4at+J14CDKRT7E3g3ny+QJ/gti8mfbJ0/ALrA0FsGtMqmmxww==
X-Received: by 2002:a05:6e02:104b:: with SMTP id p11mr35230093ilj.241.1608927630448;
        Fri, 25 Dec 2020 12:20:30 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:29 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 17/19] dyndbg: rearrange struct ddebug_callsites
Date:   Fri, 25 Dec 2020 13:19:42 -0700
Message-Id: <20201225201944.3701590-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move static-key field to top of struct.  It is the biggest field, and
most alignment constrained (I believe), so this improves ambient
pahole conditions.

It doesn't actually improve the packing, it only simplifies and
shrinks the pahole reporting.

probably drop during rebase, cleanup.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0fcbe96736f3..e7b5e7664e51 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -25,7 +25,14 @@ struct _ddebug_callsite {
 };
 
 struct _ddebug {
+#ifdef CONFIG_JUMP_LABEL
+	union {
+		struct static_key_true dd_key_true;
+		struct static_key_false dd_key_false;
+	} key;
+#endif
 	struct _ddebug_callsite *site;
+
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
 	const unsigned lineno:18;
@@ -56,12 +63,6 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
-#ifdef CONFIG_JUMP_LABEL
-	union {
-		struct static_key_true dd_key_true;
-		struct static_key_false dd_key_false;
-	} key;
-#endif
 } __aligned(8);
 
 
-- 
2.29.2

