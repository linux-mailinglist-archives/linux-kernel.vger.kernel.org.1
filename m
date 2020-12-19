Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6792DF208
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 23:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgLSWog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 17:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgLSWof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 17:44:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB4C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 14:43:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v3so3392637plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 14:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7xAXTq6oLbMMb4o4VTUrJwgMbwIvvfYtXcld/9daYw=;
        b=W5XOrx7MV7X7mAciJ5Ggx747j7pcafuxRqe4ePHnrHA49kQ+bWJ2zJUmb68Nygvzqx
         yjj0jcxpLbwY85fBJv0Mdsgj09uh5wfBfAfXPLriju6UW63g7IBo0TaAk9NgqahZOy3V
         xBIbmYK+PSqs8VoAjgKi1PAJgU8BxWO9hrzK6xFOV0iKtsVWl1yQJ1NSzddLRIwTFirr
         0r/Cy2tRZgaI+1Ynghl8llYglJr7lNE6p69Z3V+dobl1EJrJM5xFn5yU9IH4KCwjzeIt
         wv1p/Fo7nJQDdBaCB9iQ6fDecVf8vP7dRnoUQIHk+lk9MBgtyrRWijw/OzJyOJoFsNjX
         8wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7xAXTq6oLbMMb4o4VTUrJwgMbwIvvfYtXcld/9daYw=;
        b=Ob4Rjt5bYTCIU6AQotjjcFNbaT+4vTYXEcoWZAtDa0wM6E0yA9eg8TBrJvsQ3QFsv2
         EUdx9lf8xByfMvGwuM6ZZdpcFwKpKOWKq+T7ElbuBVmtQiLuPm0dmuH6S9oGilfbTV+u
         8aKlrKxs3ZqzajuVUHu7y0WLUoUXZh2jmer3X1DKmU7WnSaGHn0NQ4budE9IGVKi0r/B
         F5xcv57RhbjCFJjjYz2TubjLVQIED7XWWOMZKqe1fPhtbsPa/yoQc9ZrZJ98uKh7vmHT
         VlrwhC1aAFQzAKg6P78MmuWG7V6J8hVmVFB7k8QTonlYgPPoGKqiNzYbRURHzFTWTx01
         8vog==
X-Gm-Message-State: AOAM5328/7wsILrnOpwClNMkWhNvtLrgHOiwuxyNcjedalCqetMayap8
        Xz9la6dk9F73Tb55yb1TQWw=
X-Google-Smtp-Source: ABdhPJz4l6IFPztYnmDHirOvj4UledmMCdc2lDgJ/roUSS6sJMS9j41xK6Bg8tIHWM7UlYGjAFEyfA==
X-Received: by 2002:a17:90b:fd5:: with SMTP id gd21mr11083670pjb.139.1608417835230;
        Sat, 19 Dec 2020 14:43:55 -0800 (PST)
Received: from localhost.localdomain (c-24-16-167-223.hsd1.wa.comcast.net. [24.16.167.223])
        by smtp.gmail.com with ESMTPSA id c6sm12813346pgl.38.2020.12.19.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 14:43:54 -0800 (PST)
From:   Daniel West <daniel.west.dev@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, insafonov@gmail.com,
        daniel.west.dev@gmail.com, gustavoars@kernel.org,
        andrealmeidap1996@gmail.com, yepeilin.cs@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8455/8455] staging: rtl8188eu: core: fixed a comment format issue.
Date:   Sat, 19 Dec 2020 14:43:12 -0800
Message-Id: <20201219224312.380126-1-daniel.west.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a checkpatch warning:

WARNING: Block comments use * on subsequent lines
 #4595: FILE: drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4595:
+/****************************************************************************
+

The code is full of comments like this. Should the coding style
be inforced here, even when there is a logic to the way the code
was broken up?

Signed-off-by: Daniel West <daniel.west.dev@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 8794907a39f4..adf2788a416f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -4591,11 +4591,10 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 	}
 }
 
-/****************************************************************************
-
-Following are the functions for the timer handlers
-
-*****************************************************************************/
+/*
+ *
+ *Following are the functions for the timer handlers
+ */
 
 static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 {
-- 
2.25.1

