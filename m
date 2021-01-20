Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F302FD246
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbhATODe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbhATN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:27:41 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E085C061757;
        Wed, 20 Jan 2021 05:26:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j18so2850930wmi.3;
        Wed, 20 Jan 2021 05:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHRRPO4wN/P2q0ZLR4beYWp9qHKpPaj73nkxOvC3Ers=;
        b=hXowP4uHpXXcPcKaGfaFquwDcKjxidGKe+vFD4paTTcRmYyL05vpBiH8LYfiavVZlg
         mkT2XU02Q1xjXQsAX9ocJea7gEP6RUv6+WMfxqbR1ItPX08wlJIxvA/P5Lp+NOE6Iw8Y
         FCOPCusYR60KRK0SYgIPtIaAcBjMIdhrnFI1nNVzdYN9T0irhaN+ytcbCULfYzdx6wWv
         f+dbTAfmn8K2L1JgMI3+p3YqFfKy7HgyLSjJrCalIlidH5OAlEihOEQJDdFNAJZvq13h
         4/zJ8PVu1oZLAZP6bp6hlwiXl39CP33kgzbd+jfii6YT297ouGlhW4nuhaE6RqOdRj2f
         j++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHRRPO4wN/P2q0ZLR4beYWp9qHKpPaj73nkxOvC3Ers=;
        b=o1SXJXg2Dk98BOu3vUhHXLXVbODIlMtLHuHihvxzJGq9HkiwwFfwQZn3RBOc5/K1YH
         a946BzgR6jyvKpW4FhD/18XfRf8AJwERQZzUvCFMqcpbsht5jpHVmby9KLc9YaCA8F2Z
         sR72jXqdfs0IR5FEiBNxf9Z1aEODrXlg/HCkJFypiR9urtM7adUaToe0KJL0g+4XtPNq
         VuzpfZ+Oec/qqKgzsqIeH7GA3rr2m27nDKvYLNo7/bUGtzsH/qMtMwuPSs9+WR1uKG8o
         yGtGzrjDyyn7VpI31/NMGE4TM01mWJt2JMYMadchHClRYaPjY8vP9uumOuTX5+9WAvku
         QfJQ==
X-Gm-Message-State: AOAM5311bE0LrvopUL1GB7o4nnCmVqkQsKjw8ev6wf7s9qgISlcMDSbO
        pejKB0WSu2AuWl4ba7Z2o2I=
X-Google-Smtp-Source: ABdhPJxx3yjb/mA8dgiHvOr4zSfQ6yicEnTRahPNc764k7lsk8TMu/AQCVMJ37YDKGFYVMLGHDN1Cw==
X-Received: by 2002:a1c:6089:: with SMTP id u131mr4328541wmb.99.1611149217330;
        Wed, 20 Jan 2021 05:26:57 -0800 (PST)
Received: from curtine-Aspire-A515-55.lan ([2001:818:e279:2100:6955:745:9baf:484e])
        by smtp.googlemail.com with ESMTPSA id a12sm4572619wrh.71.2021.01.20.05.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:26:56 -0800 (PST)
From:   Eric Curtin <ericcurtin17@gmail.com>
Cc:     ericcurtin17@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Update Documentation/admin-guide/sysctl/fs.rst
Date:   Wed, 20 Jan 2021 13:26:47 +0000
Message-Id: <20210120132648.19046-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_user_watches for epoll should say 1/25, rather than 1/32

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index f48277a0a850..2a501c9ddc55 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -380,5 +380,5 @@ This configuration option sets the maximum number of "watches" that are
 allowed for each user.
 Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
 on a 64bit one.
-The current default value for  max_user_watches  is the 1/32 of the available
-low memory, divided for the "watch" cost in bytes.
+The current default value for  max_user_watches  is the 1/25 (4%) of the
+available low memory, divided for the "watch" cost in bytes.
-- 
2.25.1

