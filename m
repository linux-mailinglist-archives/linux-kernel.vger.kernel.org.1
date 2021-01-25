Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FCD304A49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbhAZFH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbhAYJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:31:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08194C061788;
        Mon, 25 Jan 2021 00:18:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y187so9889228wmd.3;
        Mon, 25 Jan 2021 00:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L0W9wzZk2KHjHBqzXgEillis1FzBzYM0WKoWJPRNyc0=;
        b=uT80n4EuuiPnr573jqlyrWg4gtgjyZltb26yudbKIK9JjhPrZynPr7Y6XNRcCMARTN
         5tIOlWEXkhrgvvANF9iiUrMNtVM1kDWaSe1SBOJkjBYYJtE4CcXCQ+kzDA/SJ0uE0kIW
         qWEUbfpW3S8gCHAlBwRakCSBzDlZZY4JrWmJpxzfwbKJHK4PRZwVgWwVwOsRXzb35049
         iqkyJHDcKvRTf8388GCUp3Q5jP7w1peIQIyHPi5kH+LIKYbjoK75AoLj2d/exIoeVVvf
         VmSr8uBUpSE+LUi9ejMv9mU6/A0bacI2MPYBIhyzJUAPfLmXjvhBK8xrF0OstrPf+Yk0
         ZUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L0W9wzZk2KHjHBqzXgEillis1FzBzYM0WKoWJPRNyc0=;
        b=cB1jT+mPZWHwodQ/wxx8hlnBjL0AYuiCTeA9wry5QS13goSEfWvDe9/i3ObB0cDiNX
         9soFLGjkDNM5wtz/n1HqEpsk/JHLKgVG5Q4+czJ7TKo2Ba/bKp4uRy68dc7UJiJ4r0tE
         JqoocQ/BK/YnnO/dTpBrj1cHgCmFsncJcNJqyOvlrYhhz/RUm6tHkdgUY0DeE7RSd1+z
         ZcY6Gqu5e+U6ZKecjFfVMMHiFzuXNmou6Mw55TAxLI/7gn2D6TtDixKlhb8ZxLn69KKv
         5U7fQcENBb8bM2skc8MNE/XdxlgOxZC5XgqWIUa6c3uThEj2NukFu6RFdl3gKQjfFApY
         1czA==
X-Gm-Message-State: AOAM5308DX31zu/8MouzmSeT/HsMU5JPISwRTF5/vU+H51lbtFigKIdL
        CBldFXkY+09fJDElENi3RKE=
X-Google-Smtp-Source: ABdhPJwEfP+Mgrdx9WUqHhmI4d/faaRuR7bmvVT6RogtYoEwA2G4GhvbxRdjZ7k/stx8O1SdulvCow==
X-Received: by 2002:a7b:c1c6:: with SMTP id a6mr342079wmj.23.1611562690743;
        Mon, 25 Jan 2021 00:18:10 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4b:4500:649e:f82b:bf2d:2571])
        by smtp.gmail.com with ESMTPSA id b2sm5559333wmd.41.2021.01.25.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:18:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] printk: rectify kernel-doc for prb_rec_init_wr()
Date:   Mon, 25 Jan 2021 09:17:48 +0100
Message-Id: <20210125081748.19903-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command 'find ./kernel/printk/ | xargs ./scripts/kernel-doc -none'
reported a mismatch with the kernel-doc of prb_rec_init_wr().

Rectify the kernel-doc, such that no issues remain for ./kernel/printk/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.11-rc5 and next-20210122

John, please ack.
Petr, please pick this minor typo fixup.

 kernel/printk/printk_ringbuffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 5dc9d022db07..73cc80e01cef 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -287,7 +287,7 @@ _DEFINE_PRINTKRB(name, descbits, avgtextbits, &_##name##_text[0])
 /* Writer Interface */
 
 /**
- * prb_rec_init_wd() - Initialize a buffer for writing records.
+ * prb_rec_init_wr() - Initialize a buffer for writing records.
  *
  * @r:             The record to initialize.
  * @text_buf_size: The needed text buffer size.
-- 
2.17.1

