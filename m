Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706526CFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 01:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgIPX3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 19:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgIPX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:29:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22AC061756;
        Wed, 16 Sep 2020 16:29:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so255046pjb.2;
        Wed, 16 Sep 2020 16:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuUWLJEBodzYyAEVXki7mrsbF9tCcBb6YY03Mkqze7c=;
        b=CYblctxPRdoz/n3QXAcmm2DKINKZv4X01IObYhEn+Oe1+Au/Gn5WgCVLKMbKKhorMM
         QGkAqu/GhZ5Jhs8z//bxyuMFQItM8PgizbnEWETjehh27zTtmpfWe+Sa68o/UA71Oo96
         SsG3Is+uGY50woklfE0ZZjJLOYo60x6HdB2MJwkqV64rL6NUhEOuXXM3+/tQcyoV2jfZ
         xvxE3Njn46gXcYPlBK8liWdCtYOQjaL2pqnqoLoBi0RGa5Osj+NirFoOYgy4bQ2DUWDf
         PjSwG5YurEoWQTQZ0ERWJFSLZOchR1NGwc+ie2YZjRFWiIuxS18Nw1acZ4iFZ011FKMz
         0m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuUWLJEBodzYyAEVXki7mrsbF9tCcBb6YY03Mkqze7c=;
        b=I87QjYQx770697vtvqhPPXqGCjyXyLFd+e90CDKqFEEJcrIw0nRO6ozX434lYI7i+c
         +iJV4TWMkfqvyt19doqI9dKyIMs8+eXshLjRb6h+uU1dc8uZrKhG7ABTcKwp5Uw1sqXb
         iIUxNQghq+13SCmrXCxJ+vyOyzp0l898RMVkVynNwR6IKlDl/FwdO2ZUHXZ/Kc5erAjb
         h7Fn58hok1Lv3gQ8etABKEdq1zsyJZxCPsqd4bQYpu2LLhCSB3JnwklXTc80Apkl8PXR
         Nud9QtElbUoZjiCYAuF+zeTy44Cclmb3s2H6N7tZlsFtfk2e2/ooj47T6LoGLUMlWQAN
         cJcA==
X-Gm-Message-State: AOAM530VZEo32jGm0Gpx2tmHAesgPmKSXebHihdF2yXNnd2Vd5g8BJIa
        eThdkP4C4SqJb2sQ3sCduQ3CXYKQwv3VlcUU
X-Google-Smtp-Source: ABdhPJxNBVuDFVhKSTTFI7L9sfLTHC8yZgMtbiqinUiXm/Byu3HTHLh1h5J3mm5VXUGSn48iM50q3A==
X-Received: by 2002:a17:902:59ce:b029:d1:e5e7:bde8 with SMTP id d14-20020a17090259ceb02900d1e5e7bde8mr8221612plj.72.1600298988110;
        Wed, 16 Sep 2020 16:29:48 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id p11sm17898701pfq.130.2020.09.16.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 16:29:47 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v3] docs: fb: Remove vesafb scrollback boot option
Date:   Thu, 17 Sep 2020 04:59:00 +0530
Message-Id: <20200916232900.23502-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch remove the reference of scrollback from this file. This is 
related to these below commits.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Correcting the previous versions errors. Proper changelog and subject text.
Trying to incorporate Willy's and Greg's suggestions.

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
2.28.0

