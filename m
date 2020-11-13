Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7011D2B1C95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgKMNwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgKMNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:08 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504CC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:07 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so9960998wrf.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ly2vy0YXlYaSPJSVrw6dCp9MyYzaUlBE3q9eSYRtTE=;
        b=GQ2nGnd7ei9cM5vD1JEPCD7VBWcLAZDk9tid5K2m1xB+49husnSK/V/fuJKikI0pJ2
         jy1I+r7PYWoJlfHHSwpCmz3O8VIJer6bYuPQrIfusLAwvQd/dr+NFAd03BYUpLjj1HCn
         o/CNud2pA03ra46Eoojnh3roIyHaeUuTCXnuWocrauXB4AjYHI3mBdr2crnYp+ZIRoeW
         I991Y4euR9IKVcPE3mLFtSxlrrst7X5qViXjT0nOamfVU9oPzPNq3ISGr7T41vitiSGG
         VxopJOVPIXrdplhprsaLEkD1NXrt1bxBB9Ey97Amfw2JrdELeLoJcp5z3bu8vH6QF04l
         wQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ly2vy0YXlYaSPJSVrw6dCp9MyYzaUlBE3q9eSYRtTE=;
        b=ZNtSHGcH4Q+c48v/kp/PPZsGI3UbhhHKMqaYUG28vyI67tq//O9iDmSbKdrFZWpc6E
         GF69vwyj5sciEdtxd3hanPTzGqTtBKbxfsjBPFojERejQ2QVyY4bDyh5pm/e2D6HDEVe
         AfCABjOoBg+GZiNnBa0rw8ahD4ku46XM6Nj67naZ8o56uN41ZZbdhDmKpnBio0RtoYJW
         Q8eFrAknRKN0pK7KMzhYZAGBWQtlMZxfHi4x74Gh9nBlXwLv6zQL2njUU1edOEoMtd94
         18MP6en1FyIyY4aX+baVZV03XqP9NHorFtIMYgRnLqqZMVgZIj21zVocNopa7RMmwzde
         qXKA==
X-Gm-Message-State: AOAM5320cgG3zva72apaHWsXbOLDR0H2zvqfPcxkLEMcExJ5z4CiP2Nv
        KMOLJSiQbTsaAfz/Q0BU4I5NwQ==
X-Google-Smtp-Source: ABdhPJxkktgUMZ93Vt2pOU9eROULFhMoiiN6/Qcg7QUfTEQlsQNZFV9mcp77LfG1pzYLuY40XOCt/Q==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr3566282wrq.151.1605275406578;
        Fri, 13 Nov 2020 05:50:06 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/40] drm/pl111/pl111_debugfs: Make local function 'pl111_debugfs_regs()' static
Date:   Fri, 13 Nov 2020 13:49:18 +0000
Message-Id: <20201113134938.4004947-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/pl111/pl111_debugfs.c:33:5: warning: no previous prototype for ‘pl111_debugfs_regs’ [-Wmissing-prototypes]

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_debugfs.c b/drivers/gpu/drm/pl111/pl111_debugfs.c
index 317f68abf18b0..6744fa16f4644 100644
--- a/drivers/gpu/drm/pl111/pl111_debugfs.c
+++ b/drivers/gpu/drm/pl111/pl111_debugfs.c
@@ -30,7 +30,7 @@ static const struct {
 	REGDEF(CLCD_PL111_LCUR),
 };
 
-int pl111_debugfs_regs(struct seq_file *m, void *unused)
+static int pl111_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-- 
2.25.1

