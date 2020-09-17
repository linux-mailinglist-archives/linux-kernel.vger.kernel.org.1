Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B78026D91D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIQKcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIQKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:32:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B480C06174A;
        Thu, 17 Sep 2020 03:32:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so1055561pjr.2;
        Thu, 17 Sep 2020 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pw15Iej6GtMMX4VkU8LPW05YuUKJrEm+RMxEBpVxWF8=;
        b=kjwSexOqhLbRMsnWFa2CjmvNUyDvMyGdL2a9dLjpvF2Bn8SX8EmqVM6OEuHJGYTCOh
         9WQ8ulcxY3oPtRXZw6w60jPi2U7R+R8uXU77MZ25gFUHKHuxYcF5uoGVDEItR63T3g7+
         nyPLc4ls7JULLnYaAXXo2purTxNyJgNY5QDFJ3DbEdB/99by705z93Yvty0pP5MWtuj7
         jsUXGk5y/hWxZou5/CwmfXk4X9J1FnB6FkiqK7t2ZXVy82GUJh9PUpRYfWotWrqdlPc+
         39rQL/KwbgvLNy/IDY25PasQFAOFjc6sQI0EZzoYHcc0dtOuky940LkZWAkVwTMW7Tsq
         r3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pw15Iej6GtMMX4VkU8LPW05YuUKJrEm+RMxEBpVxWF8=;
        b=BjUzDIuhHCcdFgz4pCl+oUi/g0TWisJuGnI724EROSqJfLpwW5rsYcwBbtRc4ta7PP
         qlH9+EednSrtHpvfakqTazjVp8RDA+2goD7gsT3TArhntZBqAnt9v7GHZVxKTP/4i3Wd
         /mIPj1aDwYqg6HRmtdweicP3BiQXec7giIieG+C5nMwf2moaNDExvUgs2Y2SidxUqZ3X
         YT88kqn7dfmIHbpNqg/LDjP+KPqF3zp81vzPiZM6z/v03dpR8tGzXUuAW92JfJanUuZw
         5hvF676Js3XHkFBCk/0fWxpwuUAkGhUVmykt///xX3IKbEZM6fw3y22tDE+Ido7NfKxf
         IQIA==
X-Gm-Message-State: AOAM533+/fys44bBz+jsv22njRK5JyTfyVIJGoDgg9n8zi6fkDk8Rsj4
        nVwgpXcy25JxFlm34pswoR9XWJ7nw9D0cA==
X-Google-Smtp-Source: ABdhPJxtrFAOPOBqoIg5KBXnY5JPH2gPBDZT0z8MoOZ78U7GC7w5phJ2QUBmyqfJxpG4GeieZygUaQ==
X-Received: by 2002:a17:90b:384c:: with SMTP id nl12mr7274873pjb.205.1600338743025;
        Thu, 17 Sep 2020 03:32:23 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id e207sm21781927pfh.171.2020.09.17.03.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:32:22 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 3/4] docs: fb: Remove sstfb scrollback boot option
Date:   Thu, 17 Sep 2020 15:56:14 +0530
Message-Id: <d7e3e91ca0282d7e33a29476e51c1dd75aa1675f.1600333774.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer present i.e remove a stanza related to scrollback.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changesince V3:
Following Willy's and Greg's suggestion remove the not relevant
commit hash and message from the changelog and put a correct one.
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
2.28.0

