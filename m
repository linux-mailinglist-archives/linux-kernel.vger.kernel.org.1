Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE463030D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbhAZAGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 19:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbhAZAFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 19:05:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB62C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:04:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l12so14701948wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRYVyuzvuVyh4190xnwuzvCfi7Cer/qgV+2vZgdDXDo=;
        b=kzzb/jPp0eRVHjprsmVkguv/uZGTRmOnOz0aGT3N5L8MTTx6ck5o/Q/LwGDmPAX3DK
         rbSQQO8nEGXmeZvY2wwdjwj8HX8q5jB7Yq5xIeJ2hb5OrOu4rwpJANbAoWnAT/N80bsU
         hGqCdIkDktMpkQKuE3dlvfgU6ImC00hp0nOR7fXQm2hMB1wnTAmH5fe1/uDuo0Vp96nu
         437rTHUw+I6lcUyO4v3u0hnewTA17bgPPpL500U/S4CLgGszx3bSgaHbr3ku4ReO5l7F
         zjTwdKo8oK5LWgYNtRTjGra5bKYes+ZSBlYucSV9j1Bb3A/1rT3MHUsMcVbxBoQ4V5OU
         TuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRYVyuzvuVyh4190xnwuzvCfi7Cer/qgV+2vZgdDXDo=;
        b=a0ar7HoU8D91H33eJm1SUQshymhDvVx+zg9NRQx28nDUQN3H7OAbL9p8fISPFMKGOB
         Kv7AaT0wI5tKuxDM3TJHxaP++qCE/OFmfA7IKUf3EA74PYf/7JjY+nRiXmCioWohzWIL
         VH4FR7pbyLDAMtChazd7Evcf27CqWaRDxZfMtpiUMG68ICTJHvEDWqQEryvycGIm5TYs
         U+hwnhvnBfHh0QJb48pYaYOn8m6UMzqfc8mSE9D3SzY7A4VFB7KNUUgxXLQgVe4Qe/Ze
         T3Cvcnc8LKoXe2YwQysGAfdyvue03IwIpntQfZTGDjY3+fK3QgTnIP5Cp0gPdQHrzaQH
         EiQQ==
X-Gm-Message-State: AOAM532EJMi7fZzSq2ijxr2vjxtwYL5bqiURE4R9iSbST4uv69g8wz4f
        iEt+sabzIZmVuw7YS/yoYcxsGDb+XInbJA==
X-Google-Smtp-Source: ABdhPJx+PBvcg9lRJNsgGOBrSuKz9OAT34ff4XVXcTEezHMNNigW0Wwy8QCwwM10zEE4bJtsJXMIrA==
X-Received: by 2002:a5d:4882:: with SMTP id g2mr3269677wrq.273.1611619496763;
        Mon, 25 Jan 2021 16:04:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o9sm25743749wrw.81.2021.01.25.16.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 16:04:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] mailmap: remove the "repo-abbrev" comment
Date:   Tue, 26 Jan 2021 01:04:38 +0100
Message-Id: <20210126000438.15014-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAHk-=wixHyBKZVUcxq+NCWMbkrX0xnppb7UCopRWw1+oExYpYw@mail.gmail.com>
References: <CAHk-=wixHyBKZVUcxq+NCWMbkrX0xnppb7UCopRWw1+oExYpYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the magical "repo-abbrev" comment added when this file was
introduced in e0ab1ec9fcd3 ([PATCH] add .mailmap for proper
git-shortlog output, 2007-02-14).

It's been an undocumented feature of git-shortlog(1), originally added
to git for Linus's use. Since then he's no longer using it[1], and
I've removed the feature in git.git's 4e168333a87 (shortlog: remove
unused(?) "repo-abbrev" feature, 2021-01-12). It's on the "master"
branch, but not yet in a release version.

Let's also remove it from linux.git, both as a heads-up to any
potential users of it in linux.git whose use would be broken sooner
than later by git itself, and because it'll eventually be entirely
redundant.

1. https://lore.kernel.org/git/CAHk-=wixHyBKZVUcxq+NCWMbkrX0xnppb7UCopRWw1+oExYpYw@mail.gmail.com/

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .mailmap | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index b1ab0129c7d6..cc4e91d3075e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -9,9 +9,6 @@
 #
 # Please keep this list dictionary sorted.
 #
-# This comment is parsed by git-shortlog:
-# repo-abbrev: /pub/scm/linux/kernel/git/
-#
 Aaron Durbin <adurbin@google.com>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
-- 
2.29.2.222.g5d2a92d10f8

