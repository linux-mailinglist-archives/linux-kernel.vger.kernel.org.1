Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE252AC9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgKJBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKJBBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:01:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:01:21 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id a18so9659733pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHCi4Tquwss85wqRJ3mOu6UhLZdJZsJlvCLd0/Ck3sY=;
        b=jBKACBVfmaUdYHvuEx8v7Eh2gyHv8AYshuUUBc0bMOj77JWMsjTKTXCuaHTp2otRF5
         2SxhlwXt9zAAr8oH+4+5/ozSWE+rRS8cyBGUQzYv3BocGy4mxbuc/86qiHh1xOeuABpx
         PVBnmJJKgY8bvVxQekXsMfKgXV/H9mv3yROs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHCi4Tquwss85wqRJ3mOu6UhLZdJZsJlvCLd0/Ck3sY=;
        b=hUL1LOP4oIo5PZSMIEpmxRcv4+OyXN9x3vck3pEBMvqWlW97XEUHL+Vx7rLJ+wgjys
         t+Hiv5765/9kpF7olsF4KiQUZLZqLsJeCLAieBw8/T++BpeKdVdDmpbbuEy54HbpDo9Q
         Vm/0NvTMlrUJ7TrHhwByd+DSzzANQbqE+Q+MtZmTL9KDj+KSomZspD6wuqs+thZfRWQr
         cHgcnTlAba3sM2HMxwh3CIFtGou6PESYGhmznW5wmX1/Jr0vbHcfmhDRYMmnakuSEWxL
         gMYiLmEpgSXnUYtzYiqdLO5/qSiigyLqC7zUuCG4aLTodoHe3Sh7X/6Jwx0UXAvutjp4
         3aTQ==
X-Gm-Message-State: AOAM532bCMpcAEYJpnxmE5Pnaih1M3K771w479J2NyYacr1MO7/lqIsK
        ZZM66CUUuRYd4PzL95jPD066cn5WTiVFhA==
X-Google-Smtp-Source: ABdhPJxUqY2gGHGRfsunj8lilTT95dFw0XRxavx7ePhqQwfi/Gzf/CQvlyeDCZebkTFKY5ET7ItzEw==
X-Received: by 2002:a62:17c8:0:b029:18b:5a97:a8d1 with SMTP id 191-20020a6217c80000b029018b5a97a8d1mr15856003pfx.15.1604970080793;
        Mon, 09 Nov 2020 17:01:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id u197sm7283233pfc.127.2020.11.09.17.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:01:20 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] drm: panel: simple: Fixup the struct panel_desc kernel doc
Date:   Mon,  9 Nov 2020 17:00:55 -0800
Message-Id: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I run:
  scripts/kernel-doc -rst drivers/gpu/drm/panel/panel-simple.c

I see that several of the kernel-doc entries aren't showing up because
they don't specify the full path down the hierarchy.  Let's fix that
and also move to inline kernel docs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("drm: panel: simple: Fixup the struct panel_desc kernel doc") new for v4.

 drivers/gpu/drm/panel/panel-simple.c | 59 ++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 597f676a6591..813c90274631 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -64,33 +64,58 @@ struct panel_desc {
 
 	unsigned int bpc;
 
-	/**
-	 * @width: width (in millimeters) of the panel's active display area
-	 * @height: height (in millimeters) of the panel's active display area
-	 */
 	struct {
+		/**
+		 * @size.width: Width (in mm) of the active display area.
+		 */
 		unsigned int width;
+
+		/**
+		 * @size.height: Height (in mm) of the active display area.
+		 */
 		unsigned int height;
 	} size;
 
-	/**
-	 * @prepare: the time (in milliseconds) that it takes for the panel to
-	 *           become ready and start receiving video data
-	 * @hpd_absent_delay: Add this to the prepare delay if we know Hot
-	 *                    Plug Detect isn't used.
-	 * @enable: the time (in milliseconds) that it takes for the panel to
-	 *          display the first valid frame after starting to receive
-	 *          video data
-	 * @disable: the time (in milliseconds) that it takes for the panel to
-	 *           turn the display off (no content is visible)
-	 * @unprepare: the time (in milliseconds) that it takes for the panel
-	 *             to power itself down completely
-	 */
 	struct {
+		/**
+		 * @delay.prepare: Time for the panel to become ready.
+		 *
+		 * The time (in milliseconds) that it takes for the panel to
+		 * become ready and start receiving video data
+		 */
 		unsigned int prepare;
+
+		/**
+		 * @delay.hpd_absent_delay: Time to wait if HPD isn't hooked up.
+		 *
+		 * Add this to the prepare delay if we know Hot Plug Detect
+		 * isn't used.
+		 */
 		unsigned int hpd_absent_delay;
+
+		/**
+		 * @delay.enable: Time for the panel to display a valid frame.
+		 *
+		 * The time (in milliseconds) that it takes for the panel to
+		 * display the first valid frame after starting to receive
+		 * video data.
+		 */
 		unsigned int enable;
+
+		/**
+		 * @delay.disable: Time for the panel to turn the display off.
+		 *
+		 * The time (in milliseconds) that it takes for the panel to
+		 * turn the display off (no content is visible).
+		 */
 		unsigned int disable;
+
+		/**
+		 * @delay.unprepare: Time to power down completely.
+		 *
+		 * The time (in milliseconds) that it takes for the panel
+		 * to power itself down completely.
+		 */
 		unsigned int unprepare;
 	} delay;
 
-- 
2.29.2.222.g5d2a92d10f8-goog

