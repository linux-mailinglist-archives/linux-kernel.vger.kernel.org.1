Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECA269E21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIOF7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIOF7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:59:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF187C06174A;
        Mon, 14 Sep 2020 22:59:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r19so766856pls.1;
        Mon, 14 Sep 2020 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80dyWmvHWuITVoGd0/hpzmpaiUjUGGpcwY0W1M3yBhY=;
        b=SaPKVsHGkl90RbD8Xpi4LaeE3f+V9MdkOjX1jJIbPZkuAOp5X+GaTkh/hdanEv3vPC
         Q8073tP0s2zXDeSD/4k0HO9OhlhrfmPQew77q6XHu5y/aBBCRLPFycCS9HXAxKlTuxOs
         0Ws/8LZw/PBs9cQFNwfXz3Rar2uuP1V2H4+4/l4kv48Zso4nwYnGUdRqIigkISVGhfcy
         GcNTDg2u/VKxQzJImwi4QOIYbBlhp8+X/5jtg19DXmtD6SqrsfJAUDMUlraKaV0BtiMi
         ilfMNxiWJrdl2PYoc4lOGJP2fwBai0pi0I6zAl5ppmLRvl4wB/XYr21ajhIc9/KMmKGL
         LDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80dyWmvHWuITVoGd0/hpzmpaiUjUGGpcwY0W1M3yBhY=;
        b=ilVeSuBFW1WsJSMlfnlntBu3AJ6tT2bygCGyxxc13dYmxEb+8K6+m2yZofMJURrQ78
         6trOL1zb614cQFFCGoUiI6eA64gJ+SDvYYLpfoYAXV2AXNIhoCtpLusvIYB66OwA/Wm9
         jGjuOFtsB1EZ9rJ8kIwfNHIUu5ged1dFZ/qVTqv6t4noAh6n2J6+ISCvNWOsF9AiGeVr
         6LbhKhrMhD4r/8EglOgU3tuqyTZj7saNE1MnwwvVuM/HBDAEgAIImvtKzvGowI31wzok
         XO7de2Y8pAoij8VcAr8psyfCW0FLWYq0qH/xyhLfipm8We9A2GVuB+7MHRqBHgPKcc9s
         LU+Q==
X-Gm-Message-State: AOAM531fdf78i461g4rrZeMtY/SFwGB0iYYAiq5bHX7y0zjbYi/rBk7B
        p//SVN1TCDlvZQenjHBBvXI=
X-Google-Smtp-Source: ABdhPJyXnOG0Io0DbezHggbJP4mcuxEPE0swZzKbWGyV6QDS3mvG4xnjS7f1w3qozxpkPWAaCixmHw==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr2807489pjb.118.1600149582546;
        Mon, 14 Sep 2020 22:59:42 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id q18sm12230143pfg.158.2020.09.14.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:59:41 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v2] docs: fb: Remove scrollback related lines
Date:   Tue, 15 Sep 2020 11:27:12 +0530
Message-Id: <20200915055712.968-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed the framebuffer scrollback related lines.

This is the effect of this commmit  50145474f6ef ("fbcon: remove soft scrollback code")

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Following Greg's suggestions,fix the subject line and include the commit Subject

 Documentation/fb/vesafb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index 6821c87b7893..f890a4f5623b 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -135,8 +135,6 @@ ypan	  enable display panning using the VESA protected mode
 
                 * scrolling (fullscreen) is fast, because there is
 		  no need to copy around data.
-		* You'll get scrollback (the Shift-PgUp thing),
-		  the video memory can be used as scrollback buffer
 
           kontra:
 
-- 
2.26.2

