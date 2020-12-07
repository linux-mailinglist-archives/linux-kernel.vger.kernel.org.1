Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3952D0AD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 07:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLGGoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 01:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:44:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25513C0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 22:43:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t3so8063374pgi.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 22:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTCFo1psICK76O3jlTgVwC+qqgFVNzRJMD15/MFmEXU=;
        b=KUlqcBUkfTfoQA6Gf5V60W+KndKC9YB0nfbveaRvFN9BY5Hp+5x8XZGTmy0J4t4cOr
         nLSBsWNbZ9aS2WFVxw8Vy+Y7Ek4AmyNY6yTXOOFM1m/a3kT1ymISp7DRLwLq066CckSU
         v1Q5ixdMGbGF/CARhCXven0qU6pT8EhohJMFYtMvdLlqpdL9xxVL0ZEXW6rFH7dQM7kZ
         kzaFNOzSOi0579z5jNlrWiQ+nBUk+mGc0f2E9CHhquboDmmv0DxdMfQ2hQWRPH3oIi6M
         XDOeASpd2e/jt2bJWAt/Rr4bEfUwh56palWQZxqxs47xQnCqoNB60v91UZJA9Lcv/UWK
         CXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTCFo1psICK76O3jlTgVwC+qqgFVNzRJMD15/MFmEXU=;
        b=RRQBml/QBt60UeDJcax64wUtlaXjmwKEMlD4XNuwNqGFD4gScryC91zgwX64nq5CIF
         5012z8FE2xAlUg8SCYlql5EXEG9Gr1ls9VR0SM1z6GsezZCp32p3CZzwKLQWizoO7wyx
         Xjc3g7Ido1GjGFt07N4VT26Q7gZp3b5P+EqS5LGxS0JMxDfu/IF+5KNQe5/ar5ALRXSe
         Q7ZzMxEKOD4qo6mXBxXnpkRO6sKTqrog0AmI/CSedAe/eGTDQsjpekv93SG3IpxFpJCk
         uYdCcn7wmfZz8oWgyabBa6Sy4IiTLtTSgXXJKz8IH5lHxYUxG2hgczU4TF8mLCtySPpT
         sgXg==
X-Gm-Message-State: AOAM531XGd1wLQlOv+5YxjLFkNiG0vDoWnTB7ARWbMluAiEa9EooTlu3
        gie8+zosrpU0xKPxZerXYrk=
X-Google-Smtp-Source: ABdhPJwZ+Lw8B9E1ooTt8TvtEBSpREUdNxzXcXVMzRfRqP+zb69cahYrJW4xPn/sBsTLYsCwxqu3Ng==
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id s17-20020a1709029891b02900d8fdf67c04mr14700381plp.54.1607323413740;
        Sun, 06 Dec 2020 22:43:33 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id o9sm9079984pjl.11.2020.12.06.22.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 22:43:32 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v2 0/3] f2fs-tools: sload compression support
Date:   Mon,  7 Dec 2020 14:42:47 +0800
Message-Id: <20201207064250.272240-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

* 3 patch set:
  #1: added some #ifdef for easier support
  #2: main code change
  #3: automake changes

v2 fix (from v1): fixed a bug and a more elegant error handling flow.

Robin Hsu (3):
  f2fs-tools: Added #ifdef WITH_func
  f2fs-tools:sload.f2fs compression support
  f2fs-tools:sload.f2fs compress: Fixed automake

 configure.ac            |  32 +++++++
 fsck/Makefile.am        |   9 +-
 fsck/compress_wrapper.c | 102 ++++++++++++++++++++
 fsck/compress_wrapper.h |  22 +++++
 fsck/fsck.h             |  15 +++
 fsck/main.c             | 157 ++++++++++++++++++++++++++++++-
 fsck/segment.c          | 202 +++++++++++++++++++++++++++++++++++++---
 fsck/sload.c            |  67 +++++++++++++
 include/f2fs_fs.h       |  76 ++++++++++++++-
 lib/libf2fs_io.c        |  33 +++++++
 10 files changed, 698 insertions(+), 17 deletions(-)
 create mode 100644 fsck/compress_wrapper.c
 create mode 100644 fsck/compress_wrapper.h

-- 
2.29.2.576.ga3fc446d84-goog

