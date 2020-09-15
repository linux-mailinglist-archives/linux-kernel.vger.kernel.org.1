Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E472269D99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 06:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIOEvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 00:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOEvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 00:51:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E03C06174A;
        Mon, 14 Sep 2020 21:51:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y1so1320779pgk.8;
        Mon, 14 Sep 2020 21:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLNWemVfKcv6NwHlI6ZoWHdmTBf8Q4rdL3Qvy2WNH/Y=;
        b=nGtBR4XhL/Ozw8iKcung7tuEF3T43aB+0BlsGjjxvw4UfbyFJ6CRH3LQOeQzEVT7ez
         iPbw7Abjylep5NMPG3gcfWZhQl9g2hCj3Bn1YsYmLcz1POE03fPcFxw2yzuyRXLyxtqE
         6efilpU6rGCKrrHuDAGW25KCHbCjHeZ1wuFbcGSQCJXxmmqRoFClnGDU/HgCeJMVl1hh
         02gpJokpkLi82sMdMv76nvMvJ8zRmrQ+RM2/mSmOBdW3X4+AypRE4kJGTBRGpHW9Vs0u
         ULlg3OEetUKR4HYzJ+i4Mui1hYFox0ZHd9d6dgWwh6xsPDQNAzPnYn7uFtUkrEWd7eB/
         UFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLNWemVfKcv6NwHlI6ZoWHdmTBf8Q4rdL3Qvy2WNH/Y=;
        b=ru/Qn1XDfgHP16IwV7SOuoPuqDvTQb+m++CLJ1lg2vs6LsD7yHaALvn0DT600if3Yo
         re2Y4BRxKRiadXFkpyUS41NfiLT7Kyf3cLN4Btn/moJ66IMcZe6FLwCmwiUzKW30lsBw
         nT4FiwUcX92aLjMiy1Uydmfy0L4qHkJ4m8ivrPumuRggHur1FyfgEggncWOidOD9sN8j
         kQgBLD3rE/jf0mtMhnaOYa87IlGAnj9lIpDiPGe8X2cvBTvq8yAu6ObnBcVEiwGcohmE
         ucmelt/kkUq5Wno9xZisNyJRFxnaJxSEcjWbpcdiKhVJXoZDO44wiEH0Jq9ixU02fTS9
         egaQ==
X-Gm-Message-State: AOAM532dI/M2nqZ+cRYhlQS8AjOaNVIAGnxcw8j+ZUFZa2gS1MiC40Ff
        mGLoKtNE0KLLlV0KcjtQsJc=
X-Google-Smtp-Source: ABdhPJxp6I6ygJtMSULDn8mFYabF+zMDu7LjbrBlK0biLBmUMTpGE/n5zq1GIHoTMSOZJwdSzlEJWA==
X-Received: by 2002:a63:d918:: with SMTP id r24mr13002162pgg.158.1600145462056;
        Mon, 14 Sep 2020 21:51:02 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id j20sm11816794pfh.146.2020.09.14.21.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 21:51:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs : fb: sstfb.rst : Remove the scrollback related stanza
Date:   Tue, 15 Sep 2020 10:18:17 +0530
Message-Id: <20200915044817.29172-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the stanza related to framebuffer scrollback effect.

It is the the effect of commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489 
and 973c096f6a85e5b5f2a295126ba6928d9a6afd45


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

