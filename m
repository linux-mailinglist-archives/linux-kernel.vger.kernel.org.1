Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF52426B92D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIPBBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIPBBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:01:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E307C06174A;
        Tue, 15 Sep 2020 18:01:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so664010pjb.2;
        Tue, 15 Sep 2020 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wITajPSCBLoqobOPTGL+SAZRblTaRzROs/f+N/Pzv50=;
        b=sfb8GVjIXhBYqCP/gweotfF05jPmcYpZaAo36Id4Jz8J6Dlm2Hm2b4IhpJ6JxdWVbr
         jDibBdisK5n/5ubSJZj4RxO0yhVi3DBhupOu7XKm0BSiyoMcu5nXXOOBNenIRn1IwbIR
         o2cDVKLWESoXgGoRAQIXKt36wSgkiH06DCrIchvj6GdDJH4YLVhDalRPC6PiPlGHqv3D
         /vvJkt0XFbwNFzIUTYsvIi9ie/ZTfPtfLxcOoiRf/ueZUVisHer8twbUUOHhXeltHLAF
         7mRY8TIHRU+tPPmBgaOHD9YThTCVZlosoEJizNk+gNFSHbvSKRO1sqLSimFx6zFxzChy
         pLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wITajPSCBLoqobOPTGL+SAZRblTaRzROs/f+N/Pzv50=;
        b=LHLNfpRem3Y6U2NPsQMclAV3qBkV2Z6yXc/C6hw75YMR0lELvVbuRW2pqktw2Pc4xP
         hXJgscQXgAIROW/OlYIIbo1kyQ3YIAt85xROvojddbhkn7Xzk8tU8IvskjupY/y+aNTn
         A5svFVd5AA0ypzZT835Ze3OZLZl5luwpig0AiRBWZEH1Ps0YVNWr/8gtR9O1BLpbWMK1
         G1DJ9PwFELioT+3B+FpUghc+LWxyVEvS+6tFsd6I144QhtJrSt8YQxg3KIaZ7PprJowW
         ZezovSapSegnms39tC/VLSxkwfLTdH5PU89627562+6DWlovjttr8GMnlrfF9r2YhhbO
         KvQg==
X-Gm-Message-State: AOAM533wpiDFNdG64g3WTLnB7CaoffG8l/sqNSUfQZXG5fVc1BKpFeft
        Dm7MY6PrBSgHXierWKLCcFI=
X-Google-Smtp-Source: ABdhPJyi7rEglFyyG7mhUIO4MDOPiolO0k4xGzbTRBEP81fsqc3Uj4QYl1zzaWCJX69JPZXDq3VSzQ==
X-Received: by 2002:a17:90a:7487:: with SMTP id p7mr1737694pjk.189.1600218104755;
        Tue, 15 Sep 2020 18:01:44 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id q11sm12382178pgj.92.2020.09.15.18.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 18:01:43 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: fb: Remove scrollback related lines
Date:   Wed, 16 Sep 2020 06:25:45 +0530
Message-Id: <20200916005544.20365-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove stale information lines.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

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

