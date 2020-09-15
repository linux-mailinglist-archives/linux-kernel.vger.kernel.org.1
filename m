Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E72269D79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 06:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIOE2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 00:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOE17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 00:27:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910EDC06174A;
        Mon, 14 Sep 2020 21:27:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so1105185pjr.2;
        Mon, 14 Sep 2020 21:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2xAFfZO9faQ850NCjP3QR4K5y7DMG5mMFIU0Ld9H64=;
        b=nssX0P1bZZxN5KkeWNrkhQuXfHMrZMaKSZzmQAq3h3BZGvfucG2LOki4GDARygm7E+
         TI87gIJUj+9A6xuzrmtsmFJJdpYDV/zBSYcoe4zSsyjtqMMPeO9oOoU/u2ElxKtgBFv7
         AvufAnCfnb9QyayJYDuPRt9RIPibDaC6eQkoxumFa0nMUdhdS27BLIweqU/4Agk7beiY
         /JclK3N03cPjh2j7D769Yaj3CH4CZtq2P0lZf5N6EhmhUIsX1rUF5FL81GEXOBTGaaHU
         dopk+puW4KU19s79XJEPboEC0JEWQV1FjA4cMmkX9Rnq1D5pTmphY73AjLyZTORQz26i
         w/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2xAFfZO9faQ850NCjP3QR4K5y7DMG5mMFIU0Ld9H64=;
        b=aWlhnfd9XzGH1df0CSy7pXZpziNvPGRD6R81Bmbf9nvWOjdYUedjAQp3VKJ1hNOa7A
         vGvMupVtPOJqkNjLiApwSE8cATpWKdvdOFXVF177SfdCkkrpF4QHf9Ip6JDarYd6iR2L
         nIEB7+XWM/F0D5QQU4ssYxnKebfQPkK+XEJPfUDj19V0RViS9/kuU9CTDu9OyTFQPKdu
         AF9ffXsbXCZvoh2iKm2HKIG1DO7kyepLG1YOa07VBLXVY/jwpUK/cfjDuk/PXWmXvv7E
         vuBrF9+Cj00bnmAB5/oMI7HVpTpaFjVCJcLlArvOVAwKVjZ9FVfwrJ//xzWAZVHM8OIT
         /T2A==
X-Gm-Message-State: AOAM532TFgqAlW4EvC8acMC5e5+ok9QAQjS/qUMe7UEIIoMqR/wGB8jl
        PHUPOYRrPG9dmUq4W2t7DTI=
X-Google-Smtp-Source: ABdhPJyy3XjMKNT25MhUrDfQnFQj6LLYuJ9UbswDx3I0tqWLwdd7VWKSPMhZDScdymEfE7ZGfWiBZg==
X-Received: by 2002:a17:902:d88c:b029:d1:e5ec:5ef5 with SMTP id b12-20020a170902d88cb02900d1e5ec5ef5mr18857plz.43.1600144079107;
        Mon, 14 Sep 2020 21:27:59 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id jz6sm10750244pjb.22.2020.09.14.21.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 21:27:58 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs : fb :  matroxfb.rst : Remove the stale information lines i.e framebuffer scrollback
Date:   Tue, 15 Sep 2020 09:49:55 +0530
Message-Id: <20200915041954.5110-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove stale information lines from this file :  matroxfb.rst

In effect of the the commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489  and
973c096f6a85e5b5f2a295126ba6928d9a6afd45


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/fb/matroxfb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
index f1859d98606e..6158c49c8571 100644
--- a/Documentation/fb/matroxfb.rst
+++ b/Documentation/fb/matroxfb.rst
@@ -317,8 +317,6 @@ Currently there are following known bugs:
  - interlaced text mode is not supported; it looks like hardware limitation,
    but I'm not sure.
  - Gxx0 SGRAM/SDRAM is not autodetected.
- - If you are using more than one framebuffer device, you must boot kernel
-   with 'video=scrollback:0'.
  - maybe more...
 
 And following misfeatures:
-- 
2.26.2

