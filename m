Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2359626CFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 01:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIPX3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgIPX3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:29:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4CC06174A;
        Wed, 16 Sep 2020 16:29:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v196so33911pfc.1;
        Wed, 16 Sep 2020 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOYtEk8KZWrcvtZ12wbyiXgSHJ3z1+Q3xen139w9qgI=;
        b=eDzevpvUUV9bEk0cwG0ugKmwO4ounBKbrfuwPGHApNmNVoZ01y0p5LlDHKxm3SDUBD
         CdfVk5xlKwro9dEUSneOJMpyQ1uL92YA82BwA3rOJQF0XmZDvJqrJ99zdD/KCesNEeW1
         6zdajBngeO/tFvI7E1M/9FOoParvQpPcZIaVveq3RAcq8Gbied9xmjaVVd4Nhfdtfcwh
         ybI2LzlPz5sE8YS/D9wPCN9bY1OwyUDnRy2ln0udYkLmyJ0AckuHvL11knQUE1EtqWDq
         hPI8j8CSJRG+3SMSGSsqb8lDmRHM65BK8XLJahcBwVmJyX1TaQXvks7bZQxOEFKGboGh
         22HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOYtEk8KZWrcvtZ12wbyiXgSHJ3z1+Q3xen139w9qgI=;
        b=Pbu7fyReidox7JJWF2W1tapDpt5rBsl3B0z8OkHfDsIQaEGlHqxmIqqUpaT/tNMXFQ
         OLbkoZ/+W4IU46VSoouICfx+J+UtIUFD5QfSK2PvhDpZXGsYAkVCPEaSnhP2nyFWuOZx
         jeYFZtz/EanGTCm9PlCQ+uGuxW+VhL5y+Vc5zUDsUpMMWCPzVvTsogno5jD3HWaW5qWx
         n2St1c5En8FjIpPSk4i1jHiIZ6GCkNL4AfHlGBaCi9FLatJY4ilKhVe9BQvl/CLp09Eu
         qNVpYRjIJ2a1tBX0mRxI8B9QxkZmnazFFicB8Uug0qq+oGu5WJ2Tn//8wTT6esHqnjCm
         Kf4g==
X-Gm-Message-State: AOAM530u6XCH5fA9a8KVSNhGXRulahEAg/eLkw0PlSUbRoIrgFqAJ5Bv
        Jc8t8c6Cczj/6s9kcpGsdX8=
X-Google-Smtp-Source: ABdhPJwa+2NAh4mm3To4oBtqglSVETowI3JwufWM839p7L74VFz6f98xoG3dt76WbkwZjmZiYC3eig==
X-Received: by 2002:a63:5d07:: with SMTP id r7mr7505957pgb.440.1600298980041;
        Wed, 16 Sep 2020 16:29:40 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id u14sm18366213pfm.80.2020.09.16.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 16:29:39 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v3] docs: fb: Remove matroxfb scrollback boot option
Date:   Thu, 17 Sep 2020 04:43:01 +0530
Message-Id: <20200916231301.32066-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch remove the reference of scrollback option from this file. This
is related to the below commits.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Correcting the previous versions errors. Proper changelog, subject text.
Trying to incorporate Willy's and Greg's suggestions.

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
2.28.0

