Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576F02F5667
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbhANBri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbhANAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:41:51 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:41:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c1so2497471qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXIGwza+eRGXsahFU/+e0gxGzLpturMRd+ajguSF/Mo=;
        b=oWeKM/1R75GxiUXHH8f0MlEoPx5Up/rkSPATa3aVUhZnyWxw0l5AWaUvR23C7YEXxX
         oHxzxB9KEFgf/jXlxWJ7THfdFzZVvGTJqHq/diyiFHe+OZqjS852XM+xAfKtug8fLBle
         Enk41zwKAY9e9lrURfmtZo2KZid+JmQni4znOVdEoauadGgJsWonlFEe7OQHzgoAPVb3
         xjktpK2Pry0v2IFwXOs1PNTWdv4au9TSP823+xa3DiwYvRwpINfYQmHbQxOPb3SJCdts
         pvfHlCHzU5rMw4TnVw5hF3zP6oRBtvVM+/5ddU2QKacpIK21NJUVeDg1aMsHFrBsaTz0
         NHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXIGwza+eRGXsahFU/+e0gxGzLpturMRd+ajguSF/Mo=;
        b=HQOMog9eiSN9iP+o0P6H7BTZWqGbxrb5fK9S8n6X3JN2ZrBljM0COdyj44aGts3y1F
         3Il+8KRRVTBsggCOwCtuSkBXq31u0eoLeeGXCI0AexAmESc2sjhonkzxiXR9q8zr8UAx
         N47kJOWNtY7XXR8Nusd/XYpgexy2Wyjn8FLzjZrXnt1SdxTIBzVxOH6S9Og7Rv4/ERSr
         w8tnOKODpPVv0T+ZMBVwQRbF7f0OtHt3Sq5vQFMK5E5CcT1jbMaUOpSqC7bFJXZiFf9j
         Nj/WFu3bvQy15Pnp7ZBTiwVRoj2BKVRplsCG9RHeGqanxCpHe9ElrMAEZy7w1xaXSnkm
         2mHg==
X-Gm-Message-State: AOAM530r96l/SFel7rY+SoENSsLGqJ6HR7Te16RxkCsNISCUVu401NFm
        hNY59NKKANPoyEd9IOxHO7j5huSpOBkhsQ==
X-Google-Smtp-Source: ABdhPJwqfikwdFKpaZgHA7x+7sj32BkFPYFmXf95ctr6XGmuosVqxvC/GYPWBQtRC3fzKg8bJPQh2A==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr4890479qtr.102.1610584870385;
        Wed, 13 Jan 2021 16:41:10 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id h26sm2146958qtc.81.2021.01.13.16.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 16:41:09 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] MAINTAINERS: Add a couple more files to the Clang/LLVM section
Date:   Wed, 13 Jan 2021 17:40:59 -0700
Message-Id: <20210114004059.2129921-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The K: entry should ensure that Nick and I always get CC'd on patches
that touch these files but it is better to be explicit rather than
implicit.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1e6a5ee6e6..9127456b7eb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4313,7 +4313,9 @@ W:	https://clangbuiltlinux.github.io/
 B:	https://github.com/ClangBuiltLinux/linux/issues
 C:	irc://chat.freenode.net/clangbuiltlinux
 F:	Documentation/kbuild/llvm.rst
+F:	include/linux/compiler-clang.h
 F:	scripts/clang-tools/
+F:	scripts/clang-version.sh
 F:	scripts/lld-version.sh
 K:	\b(?i:clang|llvm)\b
 

base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.30.0

