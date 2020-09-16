Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2126B93D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIPBNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIPBNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:13:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E91C06174A;
        Tue, 15 Sep 2020 18:13:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gf14so665462pjb.5;
        Tue, 15 Sep 2020 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phx4PXb0zuSXgskpcI5JN8X2D625+29rCnggRE/ElQA=;
        b=I6MQ6kDnjnZXnsi3OxLG52sK9oRPUU3M0UchAHdj+YxFPg36TfVFIsYoKfek2NVMs6
         5jmkllhOOeApZc+Y+qQ0zpJuuTwbhjDr3AM61dyqg93KhY/Sf8D2Ok7mu0QFRzg9JNEo
         bYYUBObQBUlZqoxjHKDxyEFkg2KS7g+0mX15WHn8u2YXOVVLw7iuT1992Yj4JZUTh3Gr
         HvI14vbr2NohnpWIaNJ0DzuFgRHoBxw2SgYjnugO0TYRm13N/jLUbyi893o8YyY6sSWh
         dLwsYI53RyhYGgn8x2ZWnI63qDW43Nc1Rv6qCB0EVmVDxBU4WcUGa16YrLdJLMnHD7BX
         O9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phx4PXb0zuSXgskpcI5JN8X2D625+29rCnggRE/ElQA=;
        b=UCDZXz70vlyy6/eEhyNE0+v9JmDwgdtNv5edthfeBw9Mrits5DVwHlO5SBZxGZSVSm
         urqEyoqB7uUJexlfI8XrlTug3WXZcBA7jA0G7cceHzdx2GLvIwEWP4nemBIjzr4fULql
         I67h9+2l59nn0i6zRiwi90q03P18xrEAx387IYmWPL8a8i9QM78+7/6KYhdAeJSU3avt
         2JWcb4On5e6b7N1CHSoEZDePzHP4Rw8EsWzxEEQqYfQTZa10bjqleNUB/NU8zAOI7QVb
         xqx4+ses5jIbUZzLL/fRvCaWNThmdYpBiDe/XZgY/1eDpUSK+fNs9oMQsIypIyJ42oCA
         vBYQ==
X-Gm-Message-State: AOAM531Y6VKsXFKL1wfom84Ma044BoQpUt7+hLtQzt+fOZbHQtm+7Hym
        69JgPwM2+wTujrhJRiYjGb7euTyMenwtxA==
X-Google-Smtp-Source: ABdhPJxWZE6XK1FbYAWU5Zj0ADxkblqRskktQCQDM2T+nGYOCg1ngmFZUAZj3+trYTg9FNcrzLa69g==
X-Received: by 2002:a17:90b:f83:: with SMTP id ft3mr1754798pjb.234.1600218799535;
        Tue, 15 Sep 2020 18:13:19 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id gl17sm612582pjb.49.2020.09.15.18.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 18:13:18 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: fb: Remove scrollback related stanza
Date:   Wed, 16 Sep 2020 06:40:00 +0530
Message-Id: <20200916011000.18286-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the stanza related to framebuffer scrollback effect.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/fb/sstfb.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fb/sstfb.rst b/Documentation/fb/sstfb.rst
index 8e8c1b940359..42466ff49c58 100644
--- a/Documentation/fb/sstfb.rst
+++ b/Documentation/fb/sstfb.rst
@@ -185,9 +185,6 @@ Bugs
   contact me.
 - The 24/32 is not likely to work anytime soon, knowing that the
   hardware does ... unusual things in 24/32 bpp.
-- When used with another video board, current limitations of the linux
-  console subsystem can cause some troubles, specifically, you should
-  disable software scrollback, as it can oops badly ...
 
 Todo
 ====
-- 
2.26.2

